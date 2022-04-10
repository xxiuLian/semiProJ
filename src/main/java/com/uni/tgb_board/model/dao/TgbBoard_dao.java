package com.uni.tgb_board.model.dao;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import static com.uni.common.JDBCTemplate.*;

import com.uni.common.Attachment;
import com.uni.tgb_board.model.dto.TgbBoardReply;
import com.uni.tgb_board.model.dto.TgbBoard_dto;


public class TgbBoard_dao {
	
	private Properties prop = new Properties();
	
	public TgbBoard_dao() {
		String fileName = TgbBoard_dao.class.getResource("/sql/tgb_wook/tgb_board_query.properties").getPath();
		
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	

	//게시판 조회수 증가
	public int increaseCount(Connection conn, int bno) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("increaseCount");
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;	
	}

	
	//페이지별 게시글 
	public ArrayList<TgbBoard_dto> getBoardList(Connection conn, int currentPage, int listPageCount){
		
		//currentPage 1 이면 1  ~ 10
		//currentPage 2 이면 11 ~ 20
		//currentPage 3 이면 21 ~ 30
		
		//공차무슨?공식 : a + (n-1)d  => (a는 시작,d는 차이)
		// 첫   페이지 : 1 + (n-1)10 = NoStart
		//마지막 페이지 : 10+ (n-1)10 = NoEnd
		
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		ArrayList<TgbBoard_dto> list = new ArrayList<TgbBoard_dto>();
		String sql = prop.getProperty("selectTGBBoard");
		
		
		//a + (n-1)d
		int startRow =  1 + (currentPage-1) * listPageCount;
		int endRow = listPageCount + (currentPage-1) * listPageCount;


//		BOARD_NO	NUMBER
//		BOARD_CATEGORY_NO	NUMBER
//		BOARD_WRITER	NUMBER
//		BOARD_TITLE	VARCHAR2(100 BYTE)
//		BOARD_CONTENT	VARCHAR2(4000 BYTE)
//		COUNT	NUMBER
//		CREATE_DATE	DATE
//		STATUS	VARCHAR2(1 BYTE)
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(new TgbBoard_dto(
					rset.getInt("BOARD_NO"),
					rset.getString("BOARD_CATEGORY_NAME"),
					rset.getString("USER_ID"),
					rset.getString("BOARD_TITLE"),
					rset.getString("BOARD_CONTENT"),
					rset.getInt("COUNT"),
					rset.getDate("CREATE_DATE"),
					rset.getString("STATUS")
					));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return list;
		
	}


	//전체 글 수
	public int getTgbBoard_listCount(Connection conn) {
		
		int listCount = 0;
		
		Statement stmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("getListCountTGBBoard");
		//getListCount=SELECT COUNT(BOARD_NO) FROM TGB_BOARD;
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			
			if(rset.next()) {
				listCount = rset.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(stmt);
		}
		
		return listCount;
	}

	public TgbBoard_dto selectDetailTgbBoard(Connection conn, int bno) {
		TgbBoard_dto b = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectDetailTgbBoard");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				b = new TgbBoard_dto(
						rset.getInt("BOARD_NO"),
						rset.getString("BOARD_CATEGORY_NO"),
						rset.getString("BOARD_WRITER"),
						rset.getString("BOARD_TITLE"),
						rset.getString("BOARD_CONTENT"),
						rset.getInt("COUNT"),
						rset.getDate("CREATE_DATE"),
						rset.getString("STATUS")
						);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return b;
	}


	public int insertTgbBoard(Connection conn, TgbBoard_dto b) {
		int result = 0 ;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertTgbBoard");
		
		int category = Integer.parseInt(b.getTgbBoardCategory());
		String title = b.getTgbBoardTitle();
		String content = b.getTgbBoardContent();
		int writer = Integer.parseInt(b.getTgbBoardWriter());
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, category);
			pstmt.setInt(2, writer);
			pstmt.setString(3, title);
			pstmt.setString(4, content);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public int insertTgbAttachment(Connection conn, Attachment at) {
		
		System.out.println("5 : " + at.getFilePath());
		System.out.println("6 : " + at.getOriginName());
		System.out.println("7 : " + at.getChangeName());

		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertTgbBoardAttachment");
	
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, at.getOriginName());
			pstmt.setString(2, at.getChangeName());
			pstmt.setString(3, at.getFilePath());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}
	
	
	public Attachment selectTgbAttachment(Connection conn, int bno) {
		System.out.println("test============================= ");
		
		Attachment at = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		System.out.println("selectUpdate_bno : " + bno );
		String sql = prop.getProperty("selectTgbAttachment");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				at = new Attachment();
				at.setFileNo(rset.getInt("FILE_NO"));
				at.setOriginName(rset.getString("ORIGIN_NAME"));
				at.setChangeName(rset.getString("CHANGE_NAME"));	
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return at;
	}
	
	public int updateTgbBoard(Connection conn, TgbBoard_dto b) {
		int result = 0;
		PreparedStatement pstmt = null;

		String sql = prop.getProperty("updatetgbBoard");
		

		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, Integer.parseInt(b.getTgbBoardCategory()));
			pstmt.setString(2, b.getTgbBoardTitle());
			pstmt.setString(3, b.getTgbBoardContent());
			pstmt.setInt(4, b.getTgbBoardNo());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}
	
	public int updateTgbAttachment(Connection conn, Attachment at) {
		int result = 0;
		PreparedStatement pstmt = null;

		// updateAttachment=UPDATE ATTACHMENT SET CHANGE_NAME=?, ORIGIN_NAME=?,
		// FILE_PATH=? WHERE FILE_NO=?
		String sql = prop.getProperty("updateTgbAttachment");

		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, at.getChangeName());
			pstmt.setString(2, at.getOriginName());
			pstmt.setString(3, at.getFilePath());
			pstmt.setInt(4, at.getFileNo());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}
	
	public int insertTgbNewAttachment(Connection conn, Attachment at, TgbBoard_dto b) {
		int result = 0;
		PreparedStatement pstmt = null;


		String sql = prop.getProperty("insertTgbNewAttachment");

		try {
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, at.getOriginName());
			pstmt.setString(2, at.getChangeName());
			pstmt.setString(3, at.getFilePath());
			pstmt.setInt(4, b.getTgbBoardNo());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}
	
	public int deletetgbBoard(Connection conn, int bno) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("deleteTgbBoard");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public int deleteTgbAttachment(Connection conn, int bno) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("deleteTgbAttachment");
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bno);

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}


	public Attachment selectAttachment(Connection conn, int bno) {
		
		Attachment at = null;

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		System.out.println("bno : " + bno);
		
		String sql = prop.getProperty("selectTgbAttachment");
		
		System.out.println("sql : " + sql);
		
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);

			rset = pstmt.executeQuery();
      
			if (rset.next()) {
				at = new Attachment();
				at.setFileNo(rset.getInt("FILE_NO"));
				at.setOriginName(rset.getString("ORIGIN_NAME"));
				at.setChangeName(rset.getString("CHANGE_NAME"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		System.out.println("첨부파일 조회2 : " + at);

		return at;
	}


	public TgbBoard_dto selectUpdateTgbBoard(Connection conn, int bno) {
		TgbBoard_dto b = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectDetailTgbBoard");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				b = new TgbBoard_dto(
						rset.getInt("BOARD_NO"),
						rset.getString("BOARD_CATEGORY_NO"),
						rset.getString("BOARD_WRITER"),
						rset.getString("BOARD_TITLE"),
						rset.getString("BOARD_CONTENT"),
						rset.getInt("COUNT"),
						rset.getDate("CREATE_DATE"),
						rset.getString("STATUS")
						);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return b;
	}


	public ArrayList<TgbBoardReply> selectRList(Connection conn, int bno) {
		

		System.out.println("확인확인확인 : " + bno);
		ArrayList<TgbBoardReply> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("tgbBoardSelectRlist");

		//tgbBoardSelectRlist=selectRlist=SELECT REPLY_NO, REPLY_CONTENT, REPLY_WRITER, CREATE_DATE FROM REPLY R JOIN MEMBER ON(REPLY_WRITER = USER_NO) WHERE REF_BNO=? AND R.STATUS='Y' ORDER BY REPLY_NO DESC
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			rset = pstmt.executeQuery();
			
			list = new ArrayList<TgbBoardReply>();
			
			while(rset.next()) {
				TgbBoardReply r = new TgbBoardReply(
									rset.getInt("REPLY_NO"),
									rset.getString("REPLY_CONTENT"),
									rset.getString("REPLY_WRITER"),
									rset.getDate("CREATE_DATE"));
						
					list.add(r);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		System.out.println("확인확인확인2 : " + bno);
		return list;
	}


	public int insertReply(Connection conn, TgbBoardReply r) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		System.out.println(r.getReplyContent()); //String
		System.out.println(r.getRefBoardId()); //int
		System.out.println(Integer.parseInt(r.getReplyWriter())); //String
		
//		REPLY_NO	NUMBER
		
//		BOARD_NO	NUMBER
//		REPLY_WRITER	NUMBER
//		REPLY_CONTENT	VARCHAR2(400 BYTE)
		
//		CREATE_DATE	DATE
//		STATUS	VARCHAR2(1 BYTE)
		
		String sql = prop.getProperty("tgbBoardinsertReply");
		//INSERT INTO BOARD_REPLY VALUES
		//	(SEQ_RNO.NEXTVAL, ?, ?, ?, SYSDATE, DEFAULT)
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, r.getRefBoardId());
			pstmt.setInt(2, Integer.parseInt(r.getReplyWriter()));
			pstmt.setString(3, r.getReplyContent());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
			
			
		return result;
	}




	


}
