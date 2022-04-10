package com.uni.report.model.dao;

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
import com.uni.report.model.dto.Report;

public class ReportDao {
	private Properties prop = new Properties();

	public ReportDao() {
		String fileName = ReportDao.class.getResource("/sql/report_kwon/report-query.properties").getPath();
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
	public int insertReport(Connection conn, Report r) {
		int result = 0;
		PreparedStatement pstmt = null;
		//insertReport=INSERT INTO REPORT VALUES(SEQ_RNO.NEXTVAL, ?, ?, ?,SYSDATE)
		String sql = prop.getProperty("insertReport");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, r.getReportUserNo());
			pstmt.setString(2, r.getReportContent());
			pstmt.setInt(3, r.getTgbNo());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}
	public ArrayList<Report> selectReportList(Connection conn, PageInfo pi) {
		ArrayList<Report> list = new ArrayList<Report>();

		PreparedStatement pstmt = null;
		ResultSet rset = null;
//		SELECT C.*, B.REPORT_NO, B.CREATE_DATE, B.REPORT_WRITER FROM 
//		(SELECT ROWNUM RNUM, A.* FROM
//		(SELECT TGB_NO, TGB_TITLE, USER_ID, CREATE_DATE AS TGB_CREATE_DATE, CHANGE_NAME
//		FROM TGB JOIN MEMBER ON TGB_WRITER=USER_NO 
//		JOIN TGB_CATEGORY USING(TGB_CATEGORY_NO) 
//		JOIN (SELECT * FROM ATTACHMENT
//		WHERE FILE_NO IN(SELECT MIN(FILE_NO) FROM ATTACHMENT 
//		WHERE TYPE LIKE 'TGB' GROUP BY B_NO)) 
//		ON TGB_NO = B_NO
//		WHERE STATUS = 'Y' ORDER BY TGB_NO DESC)A 
//		)C JOIN REPORT B ON C.TGB_NO=B.TGB_NO WHERE RNUM BETWEEN ? AND ? ORDER BY REPORT_NO DESC
		String sql = prop.getProperty("selectReportList");

//		board 게시글 currentPage = 1 startRow = 1 endRow = 10; currentPage = 2 
//		startRow = 11 endRow = 20; currentPage = 3 startRow = 21 endRow = 30;
		int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
		int endRow = startRow + pi.getBoardLimit() - 1;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rset = pstmt.executeQuery();
			while (rset.next()) {
				Report r = new Report();
				r.setTgbNo(rset.getInt("TGB_NO")); //신고된 상품 번호
				r.setTgbTitle(rset.getString("TGB_TITLE")); // 신고된 상품 제목
				r.setTgbWriter(rset.getString("USER_ID")); // 신고된 상품 작성자
				r.setTgbCreateDate(rset.getDate("TGB_CREATE_DATE")); // 신고된 상품 게시일
				r.setThumnail(rset.getString("CHANGE_NAME")); // 신고된 상품 썸네일
				r.setReportNo(rset.getInt("REPORT_NO")); //신고 번호
				r.setReportUserNo(rset.getInt("REPORT_WRITER")); //신고 작성자
				r.setCreateDate(rset.getDate("CREATE_DATE")); // 신고일
				list.add(r);
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

		//getListCount=SELECT COUNT(*) FROM REPORT
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
	public Report selectReport(Connection conn, int rno) {
		Report r = null;

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		//selectReport=SELECT REPORT_NO, USER_ID, REPORT_CONTENT, TGB_NO, CREATE_DATE FROM REPORT JOIN MEMBER ON REPORT_WRITER=USER_NO WHERE REPORT_NO=?
		String sql = prop.getProperty("selectReport");


		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rno);

			rset = pstmt.executeQuery();
			if (rset.next()) {
				r = new Report();
				r.setReportNo(rset.getInt("REPORT_NO")); //신고 번호
				r.setReportUserId(rset.getString("USER_ID")); //신고 작성자
				r.setReportContent(rset.getString("REPORT_CONTENT"));//신고 내용
				r.setTgbNo(rset.getInt("TGB_NO"));
				r.setCreateDate(rset.getDate("CREATE_DATE")); // 신고일
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return r;
	}
	public int deleteReport(Connection conn, int rno) {
		int result = 0;
		PreparedStatement pstmt = null;

		//deleteReport=DELETE REPORT WHERE REPORT_NO=?
		String sql = prop.getProperty("deleteReport");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rno);

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
