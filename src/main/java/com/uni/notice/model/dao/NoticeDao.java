package com.uni.notice.model.dao;

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

import com.uni.common.PageInfo;
import com.uni.notice.model.dto.NoticeDto;

public class NoticeDao {
	
	private Properties prop = new Properties();
	
	public NoticeDao() {
		String fileName = NoticeDao.class.getResource("/sql/notice_wook/notice_query.properties").getPath();
		System.out.println("fileName   " + fileName);
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<NoticeDto> selectList(Connection conn, PageInfo pi) {

		ArrayList<NoticeDto> list = new ArrayList<NoticeDto>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		//selectList=SELECT * FROM(SELECT ROWNUM RNUM, A.* FROM(SELECT NOTICE_NO, NOTICE_TITLE, USER_ID, COUNT, CREATE_DATE FROM NOTICE_EVENT Q JOIN MEMBER ON (NOTICE_WRITER=USER_NO) WHERE Q.STATUS='Y' AND NOTICE_TYPE = 1 ORDER BY NOTICE_NO DESC)A) WHERE RNUM BETWEEN ? AND ?
		String sql = prop.getProperty("selectList");
		int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
		int endRow = startRow + pi.getBoardLimit() - 1;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(new NoticeDto(
									rset.getInt("NOTICE_NO"),
									rset.getString("NOTICE_TITLE"),
									rset.getString("USER_ID"),
									rset.getInt("COUNT"),
									rset.getDate("CREATE_DATE")
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

	public int insertNotice(Connection conn, NoticeDto n) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertNotice");
		
		//insertNotice=INSERT INTO NOTICE VALUES(SEQ_NNO.NEXTVAL, ?, ?, ?, DEFAULT, SYSDATE, DEFAULT)
		try {
			pstmt = conn.prepareStatement(sql);
			
//			pstmt.setString(1, n.get()); 
//			pstmt.setString(2, n.getNoticeTitle());
//			pstmt.setString(3, n.getNoticeContent());
			System.out.println("1 : " + n.getNoticeTitle() );
			System.out.println("2 : " + n.getNoticeContent() );
			System.out.println("3 : " + Integer.parseInt(n.getNoticeWriter()));
			
			pstmt.setInt(1, Integer.parseInt(n.getNoticeWriter()) );
			pstmt.setString(2, n.getNoticeTitle());
			pstmt.setString(3, n.getNoticeContent());
			
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int increaseCount(Connection conn, int nno) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("increaseCount");
		
		//increaseCount=UPDATE NOTICE SET COUNT = COUNT+1 WHERE NOTICE_NO=? AND STATUS='Y'
		
		
		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, nno);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public NoticeDto selectNotice(Connection conn, int nno) {
		NoticeDto n = null; //조회 못해오면 0으로 리턴?
		//selectNotice=SELECT NOTICE_NO, NOTICE_TITLE, NOTICE_CONTENT, USER_ID, COUNT, CREATE_DATE FROM NOTICE N JOIN MEMBER ON (NOTICE_WRITER=USER_NO) WHERE NOTICE_NO=? AND N.STATUS='Y'
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectNotice");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, nno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				n = new NoticeDto(rset.getInt("NOTICE_NO"),
								rset.getString("NOTICE_TITLE"),
								rset.getString("NOTICE_CONTENT"),
								rset.getString("USER_ID"),
								rset.getInt("COUNT"),
								rset.getDate("CREATE_DATE")
							);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return n;
	}

	public int deleteNotice(Connection conn, String nno) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		//deleteNotice
		//=UPDATE NOTICE SET STATUS='N' WHERE NOTICE_NO=?
		String sql = prop.getProperty("deleteNotice");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, nno);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public int updateNotice(Connection conn, NoticeDto n) {
		
		
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("updateNotice");
		//updateNotice=
		//UPDATE NOTICE_EVENT 
		//SET NOTICE_TITLE=?, NOTICE_CONTENT=? 
		//WHERE NOTICE_NO=?
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, n.getNoticeTitle());
			pstmt.setString(2, n.getNoticeContent());
			pstmt.setInt(3, n.getNoticeNo());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		
		return result;
	}

	public int getListCount(Connection conn) {
		
		int listCount = 0;
		
		Statement stmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("getListCount");
		
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

}
