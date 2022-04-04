package com.uni.tgb_board.model.dto;

import java.sql.Date;

public class TgbBoard_dto {
	private int tgbBoardNo;
	private int tgbBoardCategory;
	private int tgbBoardWriter;
	private String tgbBoardTitle;
	private String tgbBoardContent;
	private int tgbBoardCount;
	private Date tgbBoardDate;
	private String tgbBoardStatus;
	
	public TgbBoard_dto() {
		// TODO Auto-generated constructor stub
	}
	
	

	public TgbBoard_dto(int tgbBoardNo, int tgbBoardCategory, int tgbBoardWriter, String tgbBoardTitle,
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



	public int getTgbBoardCategory() {
		return tgbBoardCategory;
	}



	public void setTgbBoardCategory(int tgbBoardCategory) {
		this.tgbBoardCategory = tgbBoardCategory;
	}



	public int getTgbBoardWriter() {
		return tgbBoardWriter;
	}



	public void setTgbBoardWriter(int tgbBoardWriter) {
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

	
