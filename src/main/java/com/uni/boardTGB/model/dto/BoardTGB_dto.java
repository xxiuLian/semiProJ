package com.uni.boardTGB.model.dto;

import java.sql.Date;

public class BoardTGB_dto {

	private int boardTgbNo;
	private int boardTGBCategory;
	private String boardTgbTitle;
	private String boardTgbContent;
	private String boardTgbWriter;		
	private int count;
	private Date createDate;
	private String status;
	
	public BoardTGB_dto() {
		
	}

	
	public BoardTGB_dto(int boardTgbNo, String boardTgbTitle, String boardTgbWriter, int count, Date createDate) {
		super();
		this.boardTgbNo = boardTgbNo;
		this.boardTgbTitle = boardTgbTitle;
		this.boardTgbWriter = boardTgbWriter;
		this.count = count;
		this.createDate = createDate;
	}
	

	public BoardTGB_dto(int boardTGBCategory, String boardTgbTitle, String boardTgbWriter, String boardTgbContent) {
		super();
		this.boardTGBCategory = boardTGBCategory;
		this.boardTgbTitle = boardTgbTitle;
		this.boardTgbWriter = boardTgbWriter;
		this.boardTgbContent = boardTgbContent;
		
	}

	




	public BoardTGB_dto(int boardTgbNo, String boardTgbTitle, String boardTgbContent, String boardTgbWriter, int count,
			Date createDate) {
		super();
		this.boardTgbNo = boardTgbNo;
		this.boardTgbTitle = boardTgbTitle;
		this.boardTgbContent = boardTgbContent;
		this.boardTgbWriter = boardTgbWriter;
		this.count = count;
		this.createDate = createDate;
	}


	public int getBoardTGBCategory() {
		return boardTGBCategory;
	}


	public void setBoardTGBCategory(int boardTGBCategory) {
		this.boardTGBCategory = boardTGBCategory;
	}


	public int getBoardTgbNo() {
		return boardTgbNo;
	}

	public void setBoardTgbNo(int boardTgbNo) {
		this.boardTgbNo = boardTgbNo;
	}

	public String getBoardTgbTitle() {
		return boardTgbTitle;
	}

	public void setBoardTgbTitle(String boardTgbTitle) {
		this.boardTgbTitle = boardTgbTitle;
	}

	public String getBoardTgbContent() {
		return boardTgbContent;
	}

	public void setBoardTgbContent(String boardTgbContent) {
		this.boardTgbContent = boardTgbContent;
	}

	public String getBoardTgbWriter() {
		return boardTgbWriter;
	}

	public void setBoardTgbWriter(String boardTgbWriter) {
		this.boardTgbWriter = boardTgbWriter;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
