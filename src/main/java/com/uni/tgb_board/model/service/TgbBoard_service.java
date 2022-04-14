package com.uni.tgb_board.model.service;

import static com.uni.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import com.uni.admin.model.dto.Category;
import com.uni.common.Attachment;
import com.uni.common.PageInfo;
import com.uni.member.model.dto.Member;
import com.uni.notice.model.dto.NoticeDto;
import com.uni.qna.model.dao.QnaDao;
import com.uni.qna.model.dto.Qna;
import com.uni.tgb_board.model.dao.TgbBoard_dao;
import com.uni.tgb_board.model.dto.TgbBoardReply;
import com.uni.tgb_board.model.dto.TgbBoard_dto;

public class TgbBoard_service {

	/*
	//페이지별 게시글
	public ArrayList<TgbBoard_dto> getBoardList(int currentPage, int listPageCount){
		Connection conn = getConnection();
		
		ArrayList<TgbBoard_dto> list = new TgbBoard_dao().getBoardList(conn, currentPage, listPageCount);
		
		close(conn);	
		return list;
	}
	*/

	//총 글 수
	public int getTgbBoard_listCount() {
		Connection conn = getConnection();
		
		int listCount = new TgbBoard_dao().getTgbBoard_listCount(conn);
		
		close(conn);
		return listCount;
	}

	public TgbBoard_dto selectDetailTgbBoard(int bno) {
		Connection conn = getConnection();

		int result = new TgbBoard_dao().increaseCount(conn, bno);
		
		TgbBoard_dto b = null;

		//조회수증가
		if(result > 0 ) {
			commit(conn);
			b = new TgbBoard_dao().selectDetailTgbBoard(conn, bno);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return b;
	}

	public int insertTgbBoard(TgbBoard_dto b, Attachment fileList) {
		Connection conn = getConnection();
		
		int result1 = new TgbBoard_dao().insertTgbBoard(conn, b);	
		
		int result2 = 1;
		
		if(fileList != null) {
			result2 = new TgbBoard_dao().insertTgbAttachment(conn, fileList);
		}
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
		
		System.out.println("at2 : " + at);
		if(at != null) {
			if(at.getFileNo() != 0) {
				result2 = new TgbBoard_dao().updateTgbAttachment(conn, at);
			}else {
				System.out.println("2이냐");
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

	public TgbBoard_dto selectUpdateTgbBoard(int bno) {
		Connection conn = getConnection();
		TgbBoard_dto b = new TgbBoard_dao().selectUpdateTgbBoard(conn, bno);
		close(conn);
		return b;
	}

	public ArrayList<TgbBoardReply> selectRlist(int bno) {
		Connection conn = getConnection();
		
		ArrayList<TgbBoardReply> list = new TgbBoard_dao().selectRList(conn, bno);
				
		close(conn);
		
		return list;
	}

	public int insertReply(TgbBoardReply r) {
		Connection conn = getConnection();
		
		int result = new TgbBoard_dao().insertReply(conn, r);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);		
		
		return result;
	}

	public int deleteFile(int bno) {
		Connection conn = getConnection();
		
		int	result = new TgbBoard_dao().deleteTgbAttachment(conn, bno);
		
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}

	public int deleteBoards(int[] bno) {
		Connection conn = getConnection();
		
		int result = new TgbBoard_dao().deleteBoards(conn, bno);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}

	public ArrayList<TgbBoard_dto> CHECKSelectList(int writer) {
		Connection conn = getConnection();
		ArrayList<TgbBoard_dto> list = new TgbBoard_dao().CHECKselectList(conn, writer);
		
		close(conn);
		return list;
	}

	public ArrayList<Category> getCategoryList() {
		
		Connection conn = getConnection();
		
		ArrayList<Category> list = new TgbBoard_dao().getCategoryList(conn);
		
		close(conn);
		
		return list;
	}

	public ArrayList<TgbBoard_dto> getBoardList(PageInfo pi) {
		Connection conn = getConnection();
		ArrayList<TgbBoard_dto> list = new TgbBoard_dao().selectList(conn, pi);
		
		close(conn);
		
		return list;
	}

	public int getListCount() {
		Connection conn = getConnection();
		
		int listCount = new TgbBoard_dao().getTgbBoard_listCount(conn);
		
		close(conn);
		return listCount;
	}

	public ArrayList<TgbBoard_dto> getCheckBoardList(PageInfo pi, String userId) {
		Connection conn = getConnection();
		ArrayList<TgbBoard_dto> list = new TgbBoard_dao().CheckselectList(conn, pi, userId);
		
		close(conn);
		
		return list;
	}

	public int CheckgetListCount(int userId) {
		Connection conn = getConnection();
		
		int listCount = new TgbBoard_dao().CheckgetListCount(conn, userId);
		
		close(conn);
		return listCount;
	}

	
	
}