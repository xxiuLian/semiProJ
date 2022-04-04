package com.uni.qna.model.service;

import static com.uni.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import com.uni.common.Attachment;
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

	public Attachment selectAttachment(int qno) {
		// TODO Auto-generated method stub
		return null;
	}

	public int deleteQna(int qno) {
		Connection conn = getConnection();
		
		int result1 = new QnaDao().deleteQna(conn, qno);
		int result2 = 1;
		
		Attachment at = new QnaDao().selectAttachment(conn, qno);
		if(at != null) {
			result2 = new QnaDao().deleteAttachment(conn, qno);
		}
		
		if(result1 > 0 && result2 > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result1 * result2;
	}

	public int insertQna(Qna q, Attachment at) {
		Connection conn = getConnection();
		int result1 = new QnaDao().insertQna(conn, q);
		
		int result2 = 1;
		
		if(at != null) {
			result2 = new QnaDao().insertAttachment(conn, at);
		}
		
		if(result1 * result2 > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		
		return result1 * result2;
		
	}

}
