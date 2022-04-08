package com.uni.tgb.model.dao;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.uni.common.Attachment;
import com.uni.common.PageInfo;
import com.uni.tgb.model.dto.Tgb;
import static com.uni.common.JDBCTemplate.*;


public class TgbDao {
	private Properties prop = new Properties();
	
	public TgbDao() {

		String fileName = TgbDao.class.getResource("/sql/TGB_choi/TGB-query.properties").getPath();
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

	public ArrayList<Tgb> selectList(Connection conn, PageInfo pi) {
		ArrayList<Tgb> list = new ArrayList<>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectList");
		
		int startRow = (pi.getCurrentPage() -1)*pi.getBoardLimit()+1;
		int endRow = startRow+pi.getBoardLimit() -1;
//tgbselectlist=SELECT * FROM (SELECT ROWNUM RNUM, A.* FROM(SELECT TGB_NO, TGB_CATEGORY_NAME, TGB_TITLE, USER_ID, TGB_COUNT, TGB_TERM, TGB_PRICE, CREATE_DATE, CHANGE_NAME \
//FROM TGB JOIN MEMBER ON TGB_WRITER=USER_NO JOIN TGB_CATEGORY USING(TGB_CATEGORY_NO) JOIN (SELECT * FROM ATTACHMENT \
//WHERE FILE_NO IN(SELECT MIN(FILE_NO) FROM ATTACHMENT WHERE TYPE LIKE 'TGB' GROUP BY B_NO)) ON TGB_NO = B_NO \
//WHERE STATUS = 'Y' ORDER BY TGB_NO DESC)A) WHERE RNUM BETWEEN ? AND ?
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();

			while(rset.next()) {
				list.add(new Tgb(rset.getInt("TGB_NO"),
								rset.getString("TGB_CATEGORY_NAME"),
								rset.getString("TGB_TITLE"), 
								rset.getString("USER_ID"), 
								rset.getInt("TGB_COUNT"), 
								rset.getDate("TGB_TERM"), 
								rset.getInt("TGB_PRICE"), 
								rset.getDate("CREATE_DATE"),
								rset.getString("CHANGE_NAME")));
				
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

	public int insertTgb(Connection conn, Tgb t) {
		
		
		int result = 0;
		//tgbInsert=INSERT INTO TGB VALUES
		//(SEQ.TGB.NEXTVAL, ?, ?, ?, ?, ?, 0, ?, ?, SYSDATE, DEFAULT)

//		TGB_CATEGORY_NO
//		TGB_TITLE
//		TGB_CONTENT
//		TGB_GUIDE
//		TGB_WRITER
//		TGB_COUNT
//		TGB_TERM
//		TGB_PRICE
//		CREATE_DATE
//		STATUS
		
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertTgb");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(t.getTgbCategory()));
			pstmt.setString(2, t.getTgbTitle());
			pstmt.setString(3, t.getTgbContent());
			pstmt.setString(4, t.getTgbGuide());
			pstmt.setInt(5, Integer.parseInt(t.getTgbWriter()));
			pstmt.setDate(6, t.getTgbTerm());
			pstmt.setInt(7, t.getTgb_Price());
			
			result = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}

		return result;
	}

	public int insertAttachment(Connection conn, ArrayList<Attachment> fileList) {
		//insertAttachment=INSERT INTO ATTACHMENT VALUES(SEQ_ANO.NEXTVAL, ?, ?, ?, SYSDATE, DEFAULT, SEQ_TGB.CURRVAL, ?)
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertAttachment");
		
		try {
			for(Attachment f : fileList) {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, f.getOriginName());
			pstmt.setString(2, f.getChangeName());
			pstmt.setString(3, f.getFilePath());
			pstmt.setString(4, f.getType());
			
			result = pstmt.executeUpdate();
			
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		
		return result;
	}

	public int getlistCount(Connection conn) {
		
		//listCount=SELECT COUNT(*) FROM TGB WHERE STATUS='Y'
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getlistCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				result = rset.getInt(1);
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		
		return result;
	}

	public Tgb selectTgb(Connection conn, int bno) {
		Tgb t = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
//		selectTgb=SELECT TGB_NO, TGB_CATEGORY_NAME, TGB_TITLE, TGB_CONTENT, TGB_GUIDE, USER_ID, TGB_COUNT, TGB_TERM, TGB_PRICE, CREATE_DATE FROM TGB \
//				JOIN MEMBER ON TGB_WRITER = USER_NO JOIN TGB_CATEGORY USING(TGB_CATEGORY_NO) WHERE TGB_NO = ?
		String sql = prop.getProperty("selectTgb");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				t = new Tgb(rset.getInt("TGB_NO"), 
							rset.getString("TGB_CATEGORY_NAME"), 
							rset.getString("TGB_TITLE"), 
							rset.getString("TGB_CONTENT"), 
							rset.getString("TGB_GUIDE"), 
							rset.getString("USER_ID"), 
							rset.getInt("TGB_COUNT"), 
							rset.getDate("TGB_TERM"), 
							rset.getInt("TGB_PRICE"), 
							rset.getDate("CREATE_DATE"));
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
			
		}
		
		
		return t;
	}

	public Attachment selectAttachment(Connection conn, int bno) {
		Attachment at = null;

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		// selectAttachment=SELECT FILE_NO, ORIGIN_NAME, CHANGE_NAME FROM ATTACHMENT
		// WHERE B_NO=? AND STATUS='Y' AND TYPE='QNA'
		String sql = prop.getProperty("selectTgbAttachment");

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
		System.out.println("첨부파일 조회 : " + at);
		return at;
	}

}
