package com.uni.tgb.model.service;

import static com.uni.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import com.uni.common.Attachment;
import com.uni.common.PageInfo;
import com.uni.tgb.model.dao.TgbDao;
import com.uni.tgb.model.dto.Tgb;

public class TgbService {

	public ArrayList<Tgb> selectList(PageInfo pi) {
		Connection conn = getConnection();
		
		ArrayList<Tgb> list = new TgbDao().selectList(conn, pi);
		
		close(conn);
		
		return list;
	}

	public int insertTgb(Tgb t, ArrayList<Attachment> fileList) {
		Connection conn = getConnection();
		int result1 =  new TgbDao().insertTgb(conn, t);
		int result2 = new TgbDao().insertAttachment(conn, fileList);
		
		if(result1*result2 > 0) {
			
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result1*result2;
	}

	public int getlistCount() {
		Connection conn = getConnection();
		int result = new TgbDao().getlistCount(conn);
		
		close(conn);
		
		
		return result;
	}

	public Tgb selectTgb(int bno) {
		Connection conn = getConnection();
		Tgb t = new TgbDao().selectTgb(conn, bno);
		
		close(conn);
		
		return t;
	}

	public ArrayList<Attachment> selectAttachment(int bno) {
		Connection conn = getConnection();
		
		ArrayList<Attachment> list = new TgbDao().selectAttachment(conn, bno);
		
		close(conn);
		
		return list;
	}

	public Tgb updateFormTgb(int bno) {
		Connection conn = getConnection();
		Tgb t = new TgbDao().selectTgb(conn, bno);
		
		close(conn);
		
		return t;
		
	}

	public ArrayList<Attachment> updateFormAttachment(int bno) {
		Connection conn = getConnection();
		
		ArrayList<Attachment> list = new TgbDao().selectAttachment(conn, bno);
		
		close(conn);
		
		return list;
	}

	public int deleteTgb(int bno) {
		Connection conn = getConnection();
		
		int result = new TgbDao().deleteTgb(conn, bno);
		
		if(result >0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		return result;
	}

	public int deleteTgbAttachment(int bno) {
		Connection conn = getConnection();
		
		int result = new TgbDao().deleteTgbAttachment(conn, bno);
		
		if(result >0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		return result;
	
	}

	public ArrayList<Tgb> searchTgb(PageInfo pi, String keyword) {
		Connection conn = getConnection();
		
		ArrayList<Tgb> list = new TgbDao().searchTgb(conn, pi, keyword);
		
		close(conn);
		
		return list;
	}

}
