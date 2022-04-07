package com.uni.tgb_board.model.service;

import static com.uni.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import com.uni.tgb_board.model.dao.TgbBoard_dao;
import com.uni.tgb_board.model.dto.TgbBoard_dto;

public class TGBBoard_service {

	//페이지별 게시글
	public ArrayList<TgbBoard_dto> getBoardList(int currentPage, int listPageCount){
		Connection conn = getConnection();
		
		ArrayList<TgbBoard_dto> list = new TgbBoard_dao().getBoardList(conn, currentPage, listPageCount);
		
		close(conn);	
		return list;
	}

	//총 글 수
	public int getTgbBoard_listCount() {
		Connection conn = getConnection();
		
		int listCount = new TgbBoard_dao().getTgbBoard_listCount(conn);
		
		close(conn);
		return listCount;
	}

	public TgbBoard_dto selectTgbBoard(int bno) {
		Connection conn = getConnection();

		int result = new TgbBoard_dao().increaseCount(conn, bno);
		
		TgbBoard_dto b = null;

		//조회수증가
		if(result > 0 ) {
			//DB자체를 바꾸는 거니깐 commit 해주네.
			commit(conn);
			b = new TgbBoard_dao().selectBoard(conn, bno);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return b;
	}

	public int insertTgbBoard(TgbBoard_dto b) {
		Connection conn = getConnection();
		
		int result1 = new TgbBoard_dao().insertTgbBoard(conn, b);
		
		if(result1 > 0 ) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result1;
	}

	
}
