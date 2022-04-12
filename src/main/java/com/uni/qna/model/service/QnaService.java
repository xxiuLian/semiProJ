package com.uni.qna.model.service;

import static com.uni.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import com.uni.common.PageInfo;
import com.uni.qna.model.dao.QnaDao;
import com.uni.qna.model.dto.Qna;

public class QnaService {

	public ArrayList<Qna> selectList(PageInfo pi) {
		Connection conn = getConnection();
		ArrayList<Qna> list = new QnaDao().selectList(conn, pi);
		
		close(conn);
		
		return list;
	}

	public int getListCount() {
		Connection conn = getConnection();
		
		int listCount = new QnaDao().getListCount(conn);
		
		close(conn);
		
		return listCount;
	}

	public Qna selectQna(int qno) {
		Connection conn = getConnection();
		
		int result = new QnaDao().increaseCount(conn, qno);
		
		Qna q = null;
		
		if(result > 0) {
			commit(conn);
			q = new QnaDao().selectQna(conn, qno);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return q;
	}


	public int deleteQna(int qno) {
		Connection conn = getConnection();
		
		int result = new QnaDao().deleteQna(conn, qno);
		
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}

	public int insertQna(Qna q) {
		Connection conn = getConnection();
		int result = new QnaDao().insertQna(conn, q);
		
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		
		return result;
		
	}

	public Qna selectUpdateQna(int qno) {
		Connection conn = getConnection();
		Qna q = new QnaDao().selectQna(conn, qno);
		close(conn);
		return q;
	}

	public int updateQna(Qna q) {
		Connection conn = getConnection();
		
		int result = new QnaDao().updateQna(conn ,q);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}

	public int insertReply(Qna q) {
		Connection conn = getConnection();
		int result = new QnaDao().insertReply(conn, q);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}

	public Qna selectRList(int qId) {
		Connection conn = getConnection();
		
		Qna reply = new QnaDao().selectRList(conn ,qId);
		
		close(conn);
		
		return reply;
	}

	public ArrayList<Qna> categoryList(int category, PageInfo pi) {
		Connection conn = getConnection();
		
		ArrayList<Qna> list = new QnaDao().categoryList(conn, pi, category);
		
		close(conn);
		
		return list;
	}

	public int deleteQnas(int[] qno) {
		Connection conn = getConnection();
		
		int result = new QnaDao().deleteQnas(conn, qno);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}

	public ArrayList<Qna> CheckSelectList(PageInfo pi, int writer) {
		//추가해줌_재욱
		
		Connection conn = getConnection();
		ArrayList<Qna> list = new QnaDao().CheckSelectList(conn, pi, writer);
		
		close(conn);
		
		return list;
	}


}