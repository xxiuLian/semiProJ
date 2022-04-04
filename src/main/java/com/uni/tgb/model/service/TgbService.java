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

}
