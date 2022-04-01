package com.uni.tgb.model.service;

import static com.uni.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import com.uni.tgb.model.dao.TgbDao;
import com.uni.tgb.model.dto.Tgb;

public class TgbService {

	public ArrayList<Tgb> selectList() {
		Connection conn = getConnection();
		
		ArrayList<Tgb> list = new TgbDao().selectList(conn);
		
		close(conn);
		
		return null;
	}

}
