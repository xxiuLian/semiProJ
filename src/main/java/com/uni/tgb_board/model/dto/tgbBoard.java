package com.uni.tgb_board.model.dto;

import lombok.Data;

public class tgbBoard {
	private int tgbBoardNo;
	private int tgbBoardCategory;
	private int tgbBoardWriter;
	private int tgbBoardTitle;
	private int tgbBoardContent;
	private int tgbBoardCount;
	private int tgbBoardDate;
	private int tgbBoardStatus;
	
	public tgbBoard() {
		// TODO Auto-generated constructor stub
	}
	
	public tgbBoard(int tgbBoardNo, int tgbBoardCategory, int tgbBoardWriter, int tgbBoardTitle, int tgbBoardContent,
			int tgbBoardCount, int tgbBoardDate, int tgbBoardStatus) {
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

	public int getTgbBoardTitle() {
		return tgbBoardTitle;
	}

	public void setTgbBoardTitle(int tgbBoardTitle) {
		this.tgbBoardTitle = tgbBoardTitle;
	}

	public int getTgbBoardContent() {
		return tgbBoardContent;
	}

	public void setTgbBoardContent(int tgbBoardContent) {
		this.tgbBoardContent = tgbBoardContent;
	}

	public int getTgbBoardCount() {
		return tgbBoardCount;
	}

	public void setTgbBoardCount(int tgbBoardCount) {
		this.tgbBoardCount = tgbBoardCount;
	}

	public int getTgbBoardDate() {
		return tgbBoardDate;
	}

	public void setTgbBoardDate(int tgbBoardDate) {
		this.tgbBoardDate = tgbBoardDate;
	}

	public int getTgbBoardStatus() {
		return tgbBoardStatus;
	}

	public void setTgbBoardStatus(int tgbBoardStatus) {
		this.tgbBoardStatus = tgbBoardStatus;
	}
	
	
}


