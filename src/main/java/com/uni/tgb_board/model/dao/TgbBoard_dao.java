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
			close(stmt);
			close(rset);
		}
		
		return listCount;
	}


//	B.BOARD_NO NUMBER //번호
//	B.BOARD_TITLE VARCHAR2(100 BYTE) //제목
//	B.BOARD_CONTENT VARCHAR2(4000 BYTE) //내용
//	B.COUNT NUMBER //조회
//	B.CREATE_DATE DATE//작성일
//	M.USER_ID VARCHAR2(30 BYTE)//작성자
//  C.BOARD_CATEGORY_NAME VARCHAR2(30 BYTE)//카테고리
	

	public TgbBoard_dto selectBoard(Connection conn, int bno) {
		TgbBoard_dto b = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("detailTgbBoard");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				b = new TgbBoard_dto(
						rset.getInt("BOARD_NO"),
						rset.getString("BOARD_CATEGORY_NAME"),
						rset.getString("USER_ID"),
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
			close(pstmt);
			close(rset);
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
		
		System.out.println(category);
		System.out.println(title);
		System.out.println(content);
		System.out.println(writer);
		
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
	
	
	
	
}
