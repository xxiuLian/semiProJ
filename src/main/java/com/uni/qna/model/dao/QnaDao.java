package com.uni.qna.model.dao;

import static com.uni.common.JDBCTemplate.*;

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

import com.uni.admin.model.dto.Category;
import com.uni.common.PageInfo;
import com.uni.qna.model.dto.Qna;

public class QnaDao {
	private Properties prop = new Properties();

	public QnaDao() {
		String fileName = QnaDao.class.getResource("/sql/qna_kwon/qna-query.properties").getPath();
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
			// QNA_NO, QNA_CATEGORY_NAME, QNA_TITLE, USER_ID, COUNT, CREATE_DATE, QNA_REPLY
			while (rset.next()) {
				Qna q = new Qna();
				q.setQnaNo(rset.getInt("QNA_NO"));
				q.setCategory(rset.getString("QNA_CATEGORY_NAME"));
				q.setQnaTitle(rset.getString("QNA_TITLE"));
				q.setQnaWriter(rset.getString("USER_ID"));
				q.setCount(rset.getInt("COUNT"));
				q.setCreateDate(rset.getDate("CREATE_DATE"));

				if (rset.getString("QNA_REPLY") != null) {
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

		// getListCount=SELECT COUNT(*) FROM QNA_BOARD WHERE STATUS='Y'
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

		// selectQna=SELECT QNA_NO, QNA_CATEGORY_NAME, QNA_TITLE, QNA_CONTENT, USER_ID,
		// COUNT, CREATE_DATE FROM QNA_BOARD B JOIN MEMBER ON(QNA_WRITER = USER_NO) LEFT
		// JOIN QNA_CATEGORY USING(QNA_CATEGORY_NO) WHERE B.STATUS = 'Y' AND QNA_NO=?
		String sql = prop.getProperty("selectQna");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qno);

			rset = pstmt.executeQuery();
			// QNA_NO, QNA_CATEGORY_NAME, QNA_TITLE, QNA_CONTENT, USER_ID, COUNT,
			// CREATE_DATE
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

		// deleteQna=UPDATE QNA_BOARD SET STATUS='N' WHERE QNA_NO=?
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


	public int insertQna(Connection conn, Qna q) {
		int result = 0;
		PreparedStatement pstmt = null;
		// insertQna=INSERT INTO QNA_BOARD VALUES(SEQ_QNO.NEXTVAL, ?, ?, ?, ?, DEFAULT,
		// SYSDATE, DEFAULT, NULL, NULL)
		String sql = prop.getProperty("insertQna");
//		QNA_NO	NUMBER
//		QNA_CATEGORY_NO	NUMBER 1 
//		QNA_TITLE	VARCHAR2(100 BYTE) 2
//		QNA_CONTENT	VARCHAR2(4000 BYTE) 3
//		QNA_WRITER	NUMBER 4
//		COUNT	NUMBER
//		CREATE_DATE	DATE
//		STATUS	VARCHAR2(1 BYTE)
//		QNA_REPLY	VARCHAR2(400 BYTE)
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(q.getCategory()));
			pstmt.setString(2, q.getQnaTitle());
			pstmt.setString(3, q.getQnaContent());
			pstmt.setInt(4, Integer.parseInt(q.getQnaWriter()));
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public int updateQna(Connection conn, Qna q) {
		int result = 0;
		PreparedStatement pstmt = null;

		// updateQna=UPDATE QNA_BOARD SET QNA_CATEGORY_NO=?, QNA_TITLE=?, QNA_CONTENT=?
		// WHERE QNA_NO=?
		String sql = prop.getProperty("updateQna");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(q.getCategory()));
			pstmt.setString(2, q.getQnaTitle());
			pstmt.setString(3, q.getQnaContent());
			pstmt.setInt(4, q.getQnaNo());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}


	public int insertReply(Connection conn, Qna q) {
		int result = 0;
		PreparedStatement pstmt = null;

		// insertQnaReply=UPDATE QNA_BOARD SET QNA_REPLY=?, REPLY_DATE=SYSDATE WHERE
		// QNA_NO=?
		String sql = prop.getProperty("insertQnaReply");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, q.getQnaReply());
			pstmt.setInt(2, q.getQnaNo());

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public Qna selectRList(Connection conn, int qId) {
		Qna reply = null;

		PreparedStatement pstmt = null;
		ResultSet rset = null;

		// selectQnaReply=SELECT QNA_REPLY, REPLY_DATE FROM QNA_BOARD WHERE QNA_NO=? AND
		// STATUS = 'Y'
		String sql = prop.getProperty("selectQnaReply");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qId);

			rset = pstmt.executeQuery();

			if (rset.next()) {
				reply = new Qna();
				reply.setQnaReply(rset.getString("QNA_REPLY"));
				reply.setReplyDate(rset.getDate("REPLY_DATE"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return reply;
	}

	public ArrayList<Qna> categoryList(Connection conn, PageInfo pi, int category) {
		ArrayList<Qna> list = new ArrayList<Qna>();

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		// selectCategoryList=SELECT * FROM (SELECT ROWNUM RNUM, A.*
		// FROM (SELECT QNA_NO, QNA_CATEGORY_NAME, QNA_TITLE, USER_ID, COUNT,
		// CREATE_DATE, QNA_REPLY FROM QNA_BOARD Q JOIN QNA_CATEGORY
		// USING(QNA_CATEGORY_NO) JOIN MEMBER ON (QNA_WRITER=USER_NO)
		// WHERE Q.STATUS='Y' AND QNA_CATEGORY_NO=? ORDER BY QNA_NO DESC) A) WHERE RNUM BETWEEN ? AND ?
		
		String sql = prop.getProperty("selectCategoryList");
//		board 게시글 currentPage = 1 startRow = 1 endRow = 10; currentPage = 2 
//		startRow = 11 endRow = 20; currentPage = 3 startRow = 21 endRow = 30;
		int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
		int endRow = startRow + pi.getBoardLimit() - 1;

		try {
			System.out.println(sql);
			System.out.println(category);
			System.out.println(startRow);
			System.out.println(endRow);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, category);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rset = pstmt.executeQuery();
			// QNA_NO, QNA_CATEGORY_NAME, QNA_TITLE, USER_ID, COUNT, CREATE_DATE, QNA_REPLY
			while (rset.next()) {
				Qna q = new Qna();
				q.setQnaNo(rset.getInt("QNA_NO"));
				q.setCategory(rset.getString("QNA_CATEGORY_NAME"));
				q.setQnaTitle(rset.getString("QNA_TITLE"));
				q.setQnaWriter(rset.getString("USER_ID"));
				q.setCount(rset.getInt("COUNT"));
				q.setCreateDate(rset.getDate("CREATE_DATE"));
				if (rset.getString("QNA_REPLY") != null) {
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

	public int deleteQnas(Connection conn, int[] qno) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		//deleteQnas=UPDATE QNA_BOARD SET STATUS='N' WHERE QNA_NO=?
		String sql = prop.getProperty("deleteQnas");
		
		try {
			pstmt = conn.prepareStatement(sql);
			if(qno != null) {
				for(int i = 0; i < qno.length; i++) {
					pstmt.setInt(1, qno[i]);
					result += pstmt.executeUpdate();
				}
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public ArrayList<Qna> CheckSelectList(Connection conn, PageInfo pi, int writer) {
		//추가해줌_재욱
		ArrayList<Qna> list = new ArrayList<Qna>();

		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String sql = prop.getProperty("CheckSelectQnaList");

		int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
		int endRow = startRow + pi.getBoardLimit() - 1;

		try {
			pstmt = conn.prepareStatement(sql);
			
			//수정해줌_재욱
			pstmt.setInt(1, writer);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);

			rset = pstmt.executeQuery();
			
			while (rset.next()) {
				Qna q = new Qna();
				q.setQnaNo(rset.getInt("QNA_NO"));
				q.setCategory(rset.getString("QNA_CATEGORY_NAME"));
				q.setQnaTitle(rset.getString("QNA_TITLE"));
				q.setQnaWriter(rset.getString("USER_ID"));
				q.setCount(rset.getInt("COUNT"));
				q.setCreateDate(rset.getDate("CREATE_DATE"));

				if (rset.getString("QNA_REPLY") != null) {
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

	public int getSearchListCount(Connection conn, String keyword) {
		int listCount = 0;
		String afterKeyword = "%"+keyword+"%";
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		// getSearchListCount=SELECT COUNT(*) FROM QNA_BOARD WHERE STATUS='Y' AND (QNA_TITLE LIKE ? OR QNA_CONTENT LIKE ?)
		String sql = prop.getProperty("getSearchListCount");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, afterKeyword);
			pstmt.setString(2, afterKeyword);
			rset = pstmt.executeQuery();

			if (rset.next()) {
				listCount = rset.getInt(1);
				
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return listCount;
	}

	public ArrayList<Qna> selectSearchList(Connection conn, PageInfo pi, String keyword) {
		ArrayList<Qna> list = new ArrayList<Qna>();
		System.out.println("서치리스트 키워드 " + keyword);
		String afterKeyword = "%"+keyword+"%";
		PreparedStatement pstmt = null;
		ResultSet rset = null;
//		selectQnaSearchList=
//				SELECT * FROM 
//				(SELECT ROWNUM RNUM, A.* FROM 
//				(SELECT QNA_NO, QNA_CATEGORY_NAME, QNA_TITLE, USER_ID, COUNT, CREATE_DATE, QNA_REPLY
//				FROM QNA_BOARD Q JOIN QNA_CATEGORY USING(QNA_CATEGORY_NO) 
//				JOIN MEMBER ON (QNA_WRITER=USER_NO) 
//				WHERE Q.STATUS='Y' AND (QNA_TITLE LIKE ? OR QNA_CONTENT LIKE ?)
//				ORDER BY QNA_NO DESC) A) 
//				WHERE RNUM BETWEEN ? AND ?
		String sql = prop.getProperty("selectQnaSearchList");

//		board 게시글 currentPage = 1 startRow = 1 endRow = 10; currentPage = 2 
//		startRow = 11 endRow = 20; currentPage = 3 startRow = 21 endRow = 30;
		int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
		int endRow = startRow + pi.getBoardLimit() - 1;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, afterKeyword);
			pstmt.setString(2, afterKeyword);
			pstmt.setInt(3, startRow);
			pstmt.setInt(4, endRow);
			

			rset = pstmt.executeQuery();
			// QNA_NO, QNA_CATEGORY_NAME, QNA_TITLE, USER_ID, COUNT, CREATE_DATE, QNA_REPLY
			while (rset.next()) {
				Qna q = new Qna();
				q.setQnaNo(rset.getInt("QNA_NO"));
				q.setCategory(rset.getString("QNA_CATEGORY_NAME"));
				q.setQnaTitle(rset.getString("QNA_TITLE"));
				q.setQnaWriter(rset.getString("USER_ID"));
				q.setCount(rset.getInt("COUNT"));
				q.setCreateDate(rset.getDate("CREATE_DATE"));

				if (rset.getString("QNA_REPLY") != null) {
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

	public ArrayList<Category> getCategoryList(Connection conn) {
		ArrayList<Category> list = new ArrayList<Category>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		//getCategoryList=SELECT * FROM QNA_CATEGORY ORDER BY QNA_CATEGORY_NO
		String sql = prop.getProperty("getCategoryList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			rset = pstmt.executeQuery();
//			QNA_CATEGORY_NO	NUMBER
//			QNA_CATEGORY_NAME	VARCHAR2(30 BYTE)
			
			while(rset.next()) {
				list.add(new Category(rset.getInt("QNA_CATEGORY_NO"), rset.getString("QNA_CATEGORY_NAME")));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public int getCategoryListCount(Connection conn, int category) {
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		// getCategoryListCount=SELECT COUNT(*) FROM QNA_BOARD WHERE STATUS='Y' AND QNA_CATEGORY_NO=?
		String sql = prop.getProperty("getCategoryListCount");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, category);
			rset = pstmt.executeQuery();

			if (rset.next()) {
				listCount = rset.getInt(1);
				
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return listCount;
	}

	public ArrayList<Qna> selectCategoryList(Connection conn, PageInfo pi, int categoryNo) {
		ArrayList<Qna> list = new ArrayList<Qna>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
//		selectCategoryList=
//				SELECT * FROM 
//				(SELECT ROWNUM RNUM, A.* FROM 
//				(SELECT QNA_NO, QNA_CATEGORY_NAME, QNA_TITLE, USER_ID, COUNT, CREATE_DATE, QNA_REPLY
//				FROM QNA_BOARD Q JOIN QNA_CATEGORY USING(QNA_CATEGORY_NO) 
//				JOIN MEMBER ON (QNA_WRITER=USER_NO) 
//				WHERE Q.STATUS='Y' AND QNA_CATEGORY_NO=?
//				ORDER BY QNA_NO DESC) A) 
//				WHERE RNUM BETWEEN ? AND ?
		String sql = prop.getProperty("selectCategoryList");

//		board 게시글 currentPage = 1 startRow = 1 endRow = 10; currentPage = 2 
//		startRow = 11 endRow = 20; currentPage = 3 startRow = 21 endRow = 30;
		int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
		int endRow = startRow + pi.getBoardLimit() - 1;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, categoryNo);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			

			rset = pstmt.executeQuery();
			// QNA_NO, QNA_CATEGORY_NAME, QNA_TITLE, USER_ID, COUNT, CREATE_DATE, QNA_REPLY
			while (rset.next()) {
				Qna q = new Qna();
				q.setQnaNo(rset.getInt("QNA_NO"));
				q.setCategory(rset.getString("QNA_CATEGORY_NAME"));
				q.setQnaTitle(rset.getString("QNA_TITLE"));
				q.setQnaWriter(rset.getString("USER_ID"));
				q.setCount(rset.getInt("COUNT"));
				q.setCreateDate(rset.getDate("CREATE_DATE"));

				if (rset.getString("QNA_REPLY") != null) {
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

	public int deleteReply(Connection conn, int qId) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		//deleteReply=UPDATE QNA_BOARD SET QNA_REPLY=NULL WHERE QNA_NO=?
		String sql = prop.getProperty("deleteReply");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qId);
			
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