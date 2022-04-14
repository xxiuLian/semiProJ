package com.uni.tgb_board.model.dto;

import java.sql.Date;

public class TgbBoard_dto {
	private int tgbBoardNo;
	private String tgbBoardCategory;
	private String tgbBoardWriter;
	private String tgbBoardTitle;
	private String tgbBoardContent;
	private int tgbBoardCount;
	private Date tgbBoardDate;
	private String tgbBoardStatus;
	
	
	
	public TgbBoard_dto() {
		// TODO Auto-generated constructor stub
	}
	
	public TgbBoard_dto(int tgbBoardNo, String tgbBoardTitle, String tgbBoardWriter, int tgbBoardCount, Date tgbBoardDate) {
		super();
		this.tgbBoardNo = tgbBoardNo;
		this.tgbBoardTitle = tgbBoardTitle;
		this.tgbBoardWriter = tgbBoardWriter;
		this.tgbBoardCount = tgbBoardCount;
		this.tgbBoardDate = tgbBoardDate;
	}

	public TgbBoard_dto(int tgbBoardNo, String tgbBoardCategory, String tgbBoardWriter, String tgbBoardTitle,
			String tgbBoardContent, int tgbBoardCount, Date tgbBoardDate, String tgbBoardStatus) {
		super();
		this.tgbBoardNo = tgbBoardNo;
		this.tgbBoardCategory = tgbBoardCategory;
		this.tgbBoardWriter = tgbBoardWriter;
		this.tgbBoardTitle = tgbBoardTitle;
		this.tgbBoardContent = tgbBoardContent;
		this.tgbBoardCount = tgbBoardCount;
		this.tgbBoardDate = tgbBoardDate;
		this.tgbBoardStatus = tgbBoardStatus;
	}



	public int getTgbBoardNo() {
		return tgbBoardNo;
	}



	public void setTgbBoardNo(int tgbBoardNo) {
		this.tgbBoardNo = tgbBoardNo;
	}



	public String getTgbBoardCategory() {
		return tgbBoardCategory;
	}



	public void setTgbBoardCategory(String tgbBoardCategory) {
		this.tgbBoardCategory = tgbBoardCategory;
	}



	public String getTgbBoardWriter() {
		return tgbBoardWriter;
	}



	public void setTgbBoardWriter(String tgbBoardWriter) {
		this.tgbBoardWriter = tgbBoardWriter;
	}



	public String getTgbBoardTitle() {
		return tgbBoardTitle;
	}



	public void setTgbBoardTitle(String tgbBoardTitle) {
		this.tgbBoardTitle = tgbBoardTitle;
	}



	public String getTgbBoardContent() {
		return tgbBoardContent;
	}



	public void setTgbBoardContent(String tgbBoardContent) {
		this.tgbBoardContent = tgbBoardContent;
	}



	public int getTgbBoardCount() {
		return tgbBoardCount;
	}



	public void setTgbBoardCount(int tgbBoardCount) {
		this.tgbBoardCount = tgbBoardCount;
	}



	public Date getTgbBoardDate() {
		return tgbBoardDate;
	}



	public void setTgbBoardDate(Date tgbBoardDate) {
		this.tgbBoardDate = tgbBoardDate;
	}



	public String getTgbBoardStatus() {
		return tgbBoardStatus;
	}



	public void setTgbBoardStatus(String tgbBoardStatus) {
		this.tgbBoardStatus = tgbBoardStatus;
	}
	
}

	
