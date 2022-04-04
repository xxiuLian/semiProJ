package com.uni.tgb_board.model.dto;

import lombok.Data;

public class TgbBoard_pageInfo {
	private int NoStart; //데이터 행 시작(글번호)
	private int NoEnd; //데이터 행 끝(글번호)
	private int currentPage; //페이징바에 따른 현재 페이지


	public TgbBoard_pageInfo(int noStart, int noEnd, int currentPage) {
		super();
		NoStart = noStart;
		NoEnd = noEnd;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}


	public int getNoStart() {
		return NoStart;
	}

	public void setNoStart(int noStart) {
		NoStart = noStart;
	}

	public int getNoEnd() {
		return NoEnd;
	}

	public void setNoEnd(int noEnd) {
		NoEnd = noEnd;
	}

	
	
	
}

