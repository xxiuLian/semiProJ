package com.uni.report.model.service;

import static com.uni.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import com.uni.common.PageInfo;
import com.uni.report.model.dao.ReportDao;
import com.uni.report.model.dto.Report;


public class ReportService {

	public int insertReport(Report r, int reportUser) {
		Connection conn = getConnection();
		int result = new ReportDao().insertReport(conn, r, reportUser);
		
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		
		return result;
		
	}

	public ArrayList<Report> selectReportList(PageInfo pi) {
		Connection conn = getConnection();
		
		ArrayList<Report> report = new ReportDao().selectReportList(conn, pi);
		
		close(conn);
		
		return report;
	}

	public int getListCount() {
		Connection conn = getConnection();
		
		int listCount = new ReportDao().getListCount(conn);
		
		close(conn);
		
		return listCount;
	}

	public Report selectReport(int rno) {
		Connection conn = getConnection();
		
		Report report = new ReportDao().selectReport(conn, rno);
		
		close(conn);
		
		return report;
	}

	public int deleteReport(int rno) {
		Connection conn = getConnection();
		
		int result = new ReportDao().deleteReport(conn, rno);
		
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}

}
