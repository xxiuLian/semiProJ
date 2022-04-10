package com.uni.report.model.service;

import static com.uni.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import com.uni.report.model.dao.ReportDao;
import com.uni.report.model.dto.Report;


public class ReportService {

	public int insertReport(Report r) {
		Connection conn = getConnection();
		int result = new ReportDao().insertReport(conn, r);
		
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		
		return result;
		
	}

	public ArrayList<Report> selectReportTgb() {
		Connection conn = getConnection();
		
		ArrayList<Report> report = new ReportDao().selectReportTgb(conn);
		
		close(conn);
		
		return report;
	}

}
