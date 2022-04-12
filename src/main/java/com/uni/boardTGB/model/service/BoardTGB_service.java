package com.uni.boardTGB.model.service;

import static com.uni.common.JDBCTemplate.*;


import java.sql.Connection;
import java.util.ArrayList;

import com.uni.boardTGB.model.dao.BoardTGB_dao;
import com.uni.boardTGB.model.dto.BoardTGB_dto;
import com.uni.notice.model.dao.NoticeDao;
import com.uni.notice.model.dto.NoticeDto;


public class BoardTGB_service {

	public ArrayList<BoardTGB_dto> selectList() {
		Connection conn = getConnection();
		ArrayList<BoardTGB_dto> list = new BoardTGB_dao().selectList(conn);
		
		close(conn);
		return list;
	}

	public int insertBoardTGB(BoardTGB_dto n) {
		Connection conn = getConnection();
		
		int result = new BoardTGB_dao().insertBoardTGB(conn,n);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public BoardTGB_dto detailBoardTGB(int nno) {
		Connection conn = getConnection();
		int result = new BoardTGB_dao().increaseCount(conn,nno); //조회수 증가
		BoardTGB_dto n = null;
		
		if(result > 0) {
			commit(conn);
			n = new BoardTGB_dao().detailBaordTGB(conn, nno);
			
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return n;
	}

	public int deleteBoardTGB(int nno) {
		Connection conn = getConnection();
		
		int result = new BoardTGB_dao().deleteBoardTGB(conn, nno);
		
		if(result > 0 ) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public BoardTGB_dto selectUpdateBoardTGB(int nno) {
		Connection conn = getConnection();
		
		BoardTGB_dto n = new BoardTGB_dao().selectUpdateBoardTGB(conn, nno);
		
		close(conn);
		return n;
	}

	public int updateBoardTGB(BoardTGB_dto n) {
		Connection conn = getConnection();
		
		int result = new BoardTGB_dao().updateBoardTGB(conn, n);
		
		if(result > 0 ) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
	

}
