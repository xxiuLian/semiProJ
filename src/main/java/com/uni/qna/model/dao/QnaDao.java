package com.uni.qna.model.dao;

import static com.uni.common.JDBCTemplate.close;

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

import com.uni.common.Attachment;
import com.uni.common.PageInfo;
import com.uni.qna.model.dto.Qna;
import com.uni.tgb_board.model.dao.BoardDao;

public class QnaDao {
	private Properties prop = new Properties();

	public QnaDao() {
		String fileName = BoardDao.class.getResource("/sql/qna_kwon/qna-query.properties").getPath();
		System.out.println("fileName   " + fileName);
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public ArrayList<Qna> selectList(Connection conn, PageInfo pi) {
		ArrayList<Qna> list = new ArrayList<Qna>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
//		selectQnaList=
//				SELECT * FROM 
//				(SELECT ROWNUM RNUM, A.* FROM 
//				(SELECT QNA_NO, QNA_CATEGORY_NAME, QNA_TITLE, USER_ID, COUNT, CREATE_DATE, QNA_REPLY
//				FROM QNA_BOARD Q JOIN QNA_CATEGORY USING(QNA_CATEGORY_NO) 
//				JOIN MEMBER ON (QNA_WRITER=USER_NO) 
//				WHERE Q.STATUS='Y' 
//				ORDER BY QNA_NO DESC) A) 
//				WHERE RNUM BETWEEN ? AND ?
		String sql = prop.getProperty("selectQnaList");
		
		
//		board 게시글 currentPage = 1 startRow = 1 endRow = 10; currentPage = 2 
//		startRow = 11 endRow = 20; currentPage = 3 startRow = 21 endRow = 30;
		int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
		int endRow = startRow + pi.getBoardLimit() - 1;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			//QNA_NO, QNA_CATEGORY_NAME, QNA_TITLE, USER_ID, COUNT, CREATE_DATE, QNA_REPLY
			while(rset.next()) {
				Qna q = new Qna();
				q.setQnaNo(rset.getInt("QNA_NO"));
				q.setCategory(rset.getString("QNA_CATEGORY_NAME"));
				q.setQnaTitle(rset.getString("QNA_TITLE"));
				q.setQnaWriter(rset.getString("USER_ID"));
				q.setCount(rset.getInt("COUNT"));
				q.setCreateDate(rset.getDate("CREATE_DATE"));
				
				if(rset.getString("QNA_REPLY") != null) {
					q.setQnaReply(rset.getString("QNA_REPLY"));
				}
				
				list.add(q);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public int getListCount(Connection conn) {
		int listCount = 0;
		
		Statement stmt = null;
		ResultSet rset = null;
		
		//getListCount=SELECT COUNT(*) FROM QNA_BOARD WHERE STATUS='Y'
		String sql = prop.getProperty("getListCount");
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			
			if (rset.next()) {
				listCount = rset.getInt(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
	
		
		return listCount;
	}

	public int increaseCount(Connection conn, int qno) {
		int result = 0;

		PreparedStatement pstmt = null;

		// increaseCount=UPDATE QNA_BOARD SET COUNT=COUNT+1 WHERE BOARD_NO=?
		String sql = prop.getProperty("increaseCount");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qno);

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public Qna selectQna(Connection conn, int qno) {
		Qna q = null;

		PreparedStatement pstmt = null;
		ResultSet rset = null;

		
		//selectQna=SELECT QNA_NO, QNA_CATEGORY_NAME, QNA_TITLE, QNA_CONTENT, USER_ID, COUNT, CREATE_DATE FROM QNA_BOARD B JOIN MEMBER ON(QNA_WRITER = USER_NO) LEFT JOIN QNA_CATEGORY USING(QNA_CATEGORY_NO) WHERE B.STATUS = 'Y' AND QNA_NO=?
		String sql = prop.getProperty("selectQna");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qno);

			rset = pstmt.executeQuery();
			//QNA_NO, QNA_CATEGORY_NAME, QNA_TITLE, QNA_CONTENT, USER_ID, COUNT, CREATE_DATE
			if (rset.next()) {
				q = new Qna();
				q.setQnaNo(rset.getInt("QNA_NO"));
				q.setCategory(rset.getString("QNA_CATEGORY_NAME"));
				q.setQnaTitle(rset.getString("QNA_TITLE"));
				q.setQnaContent(rset.getString("QNA_CONTENT"));
				q.setQnaWriter(rset.getString("USER_ID"));
				q.setCount(rset.getInt("COUNT"));
				q.setCreateDate(rset.getDate("CREATE_DATE"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return q;
	}

	public int deleteQna(Connection conn, int qno) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		//deleteQna=UPDATE QNA_BOARD SET STATUS='N' WHERE QNA_NO=?
		String sql = prop.getProperty("deleteQna");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qno);

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public Attachment selectAttachment(Connection conn, int qno) {
		Attachment at = null;

		PreparedStatement pstmt = null;
		ResultSet rset = null;

		// selectAttachment=SELECT FILE_NO, ORIGIN_NAME, CHANGE_NAME FROM ATTACHMENT
		// WHERE REF_BNO=? AND STATUS='Y'
		String sql = prop.getProperty("selectAttachment");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qno);

			rset = pstmt.executeQuery();

			if (rset.next()) {
//				at = new Attachment();
//				at.setFileNo(rset.getInt("FILE_NO"));
//				at.setOriginName(rset.getString("ORIGIN_NAME"));
//				at.setChangeName(rset.getString("CHANGE_NAME"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return at;
	}

	public int deleteAttachment(Connection conn, int qno) {
		int result = 0;

		PreparedStatement pstmt = null;

		// deleteAttachment=UPDATE ATTACHMENT SET STATUS='N' WHERE REF_BNO=?
		String sql = prop.getProperty("deleteAttachment");
		System.out.println("deleteAttachment : " + sql);
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qno);

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

}
