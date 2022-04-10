package com.uni.report.model.dto;

import java.sql.Date;


import lombok.Data;
@Data
public class Report {
	private int reportNo;
	private String reportUserId;
	private String reportContent;
	private int tgbNo;
	private Date createDate;
	public Report() {}

	public Report(int reportNo, String reportUserId, String reportContent, int tgbNo, Date createDate) {
		super();
		this.reportNo = reportNo;
		this.reportUserId = reportUserId;
		this.reportContent = reportContent;
		this.tgbNo = tgbNo;
		this.createDate = createDate;
	}
	
	public Report(String reportContent, int tgbNo) {
		super();
		this.reportContent = reportContent;
		this.tgbNo = tgbNo;
	}

}
