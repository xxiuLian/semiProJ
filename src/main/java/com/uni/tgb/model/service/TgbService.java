package com.uni.tgb.model.service;

import static com.uni.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import com.uni.common.Attachment;
import com.uni.tgb.model.dao.TgbDao;
import com.uni.tgb.model.dto.Tgb;

public class TgbService {

	public ArrayList<Tgb> selectList() {
		Connection conn = getConnection();
		
		ArrayList<Tgb> list = new TgbDao().selectList(conn);
		
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
		
		
		
		return result1*result2;
	}

}
