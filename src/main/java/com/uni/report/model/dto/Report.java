package com.uni.report.model.dto;

import java.sql.Date;


import lombok.Data;
@Data
public class Report {
	private int reportNo;
	private int reportUserNo;
	private String reportUserId;
	private String reportContent;
	private int tgbNo;
	private Date tgbCreateDate;
	private Date createDate;
	private String tgbTitle;     // 공구 글 제목
	private String tgbWriter;    // 공구 진행자
	private String thumnail;    //썸네일
	public Report() {}

	public Report(int reportNo, int reportUserNo, String reportContent, int tgbNo, Date createDate) {
		super();
		this.reportNo = reportNo;
		this.reportUserNo = reportUserNo;
		this.reportContent = reportContent;
		this.tgbNo = tgbNo;
		this.createDate = createDate;
	}
	
	public Report(int reportUserNo, String reportContent, int tgbNo) {
		super();
		this.reportUserNo = reportUserNo;
		this.reportContent = reportContent;
		this.tgbNo = tgbNo;
	}

}
