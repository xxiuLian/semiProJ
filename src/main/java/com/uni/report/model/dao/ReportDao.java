package com.uni.report.model.dao;

import static com.uni.common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;

import com.uni.qna.model.dao.QnaDao;
import com.uni.report.model.dto.Report;

public class ReportDao {
	private Properties prop = new Properties();

	public ReportDao() {
		String fileName = QnaDao.class.getResource("/sql/report_kwon/report-query.properties").getPath();
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

}
