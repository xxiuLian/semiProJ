package com.uni.tgb_board.model.dto;

import lombok.Data;

public class TgbBoard_pageInfo {
	
	private int listCount; //총 글 수
	
	private int currentPage; //페이징바에 따른 현재 페이지
	private int listPageCount; //한 페이지 내의 글 수
	
	private int barStart; //페이징바 시작
	private int barEnd; //페이징바 끝(한 페이지 내)
	private int barCount; //페이징바 수(한 페이지 내)
	private int barMax; //전체 페이징 마지막

	public TgbBoard_pageInfo() {
		// TODO Auto-generated constructor stub
	}
	
	
	public TgbBoard_pageInfo(int listSum, int currentPage, int barStart, int barEnd, int barCount, int listPageCount, int barMax) {
		super();
		this.listCount = listSum;
		this.currentPage = currentPage;
		this.barStart = barStart;
		this.barEnd = barEnd;
		this.barCount = barCount;
		this.listPageCount = listPageCount;
		this.barMax = barMax;
	}
	
	public int getBarMax() {
		return barMax;
	}


	public void setBarMax(int barMax) {
		this.barMax = barMax;
	}


	public int getListPageCount() {
		return listPageCount;
	}


	public void setListPageCount(int listPageCount) {
		this.listPageCount = listPageCount;
	}


	public int getBarCount() {
		return barCount;
	}


	public void setBarCount(int barCount) {
		this.barCount = barCount;
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

