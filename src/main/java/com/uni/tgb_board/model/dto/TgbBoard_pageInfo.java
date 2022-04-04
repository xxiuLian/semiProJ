package com.uni.tgb_board.model.dto;

import lombok.Data;

public class TgbBoard_pageInfo {
	
	private int listStart; //데이터 행 시작(글번호)
	private int listEnd; //데이터 행 끝(글번호)
	private int listCount; //총 글 수
	
	private int currentPage; //페이징바에 따른 현재 페이지
	
	private int barStart; //페이징바 시작
	private int barEnd; //페이징바 끝
	private int barCount; //페이징바 수

	public TgbBoard_pageInfo() {
		// TODO Auto-generated constructor stub
	}
	
	
	public TgbBoard_pageInfo(int listStart, int listEnd, int listSum, int currentPage, int barStart, int barEnd, int barCount) {
		super();
		this.listStart = listStart;
		this.listEnd = listEnd;
		this.listCount = listSum;
		this.currentPage = currentPage;
		this.barStart = barStart;
		this.barEnd = barEnd;
		this.barCount = barCount;
	}
	
	public int getBarCount() {
		return barCount;
	}


	public void setBarCount(int barCount) {
		this.barCount = barCount;
	}


	public int getListStart() {
		return listStart;
	}
	public void setListStart(int listStart) {
		this.listStart = listStart;
	}
	public int getListEnd() {
		return listEnd;
	}
	public void setListEnd(int listEnd) {
		this.listEnd = listEnd;
	}
	public int getListCount() {
		return listCount;
	}
	public void setListCount(int listCount) {
		this.listCount = listCount;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getBarStart() {
		return barStart;
	}
	public void setBarStart(int barStart) {
		this.barStart = barStart;
	}
	public int getBarEnd() {
		return barEnd;
	}
	public void setBarEnd(int barEnd) {
		this.barEnd = barEnd;
	}
	
	





	
	
}

