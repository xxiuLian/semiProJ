package com.uni.tgb_board.model.service;

import static com.uni.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import com.uni.common.Attachment;
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

	public int insertTgbBoard(TgbBoard_dto b, Attachment fileList) {
		Connection conn = getConnection();
		
		int result1 = new TgbBoard_dao().insertTgbBoard(conn, b);	
		int result2 = new TgbBoard_dao().insertTgbAttachment(conn, fileList);
		
		System.out.println("result1 : " + result1);
		System.out.println("result2 : " + result2);
		

		if(result1*result2 > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result1*result2;
	}
	
	public Attachment selectAttachment(int bno) {
		Connection conn = getConnection();
		Attachment at = new TgbBoard_dao().selectTgbAttachment(conn, bno);
		close(conn);
		return at;
	}

	public int deletetgbBoard(int bno) {
		Connection conn = getConnection();
		
		int result1 = new TgbBoard_dao().deletetgbBoard(conn, bno);
		int result2 = 1;
		
		Attachment at = new TgbBoard_dao().selectTgbAttachment(conn, bno);
		if(at != null) {
			result2 = new TgbBoard_dao().deleteTgbAttachment(conn, bno);
		}
		
		if(result1 > 0 && result2 > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result1 * result2;
	}
	
	public int updateTgbBoard(TgbBoard_dto b, Attachment at) {
		Connection conn = getConnection();
		
		int result1 = new TgbBoard_dao().updateTgbBoard(conn ,b);
		
		int result2 = 1;
		
		if(at != null) {
			if(at.getFileNo() != 0) {
				result2 = new TgbBoard_dao().updateTgbAttachment(conn, at);
			}else {
				result2 = new TgbBoard_dao().insertTgbNewAttachment(conn, at, b);
			}
		}
		
		if(result1 > 0 && result2 > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result1 * result2;
	}
	
}
