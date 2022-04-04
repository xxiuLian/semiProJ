package com.uni.tgb_board.model.service;

import static com.uni.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import com.uni.tgb_board.model.dao.TgbBoard_dao;
import com.uni.tgb_board.model.dto.TgbBoard_dto;

public class TGBBoard_service {

	//페이지별 게시글
	public ArrayList<TgbBoard_dto> getBoardList(int currentPage){
		Connection conn = getConnection();
		ArrayList<TgbBoard_dto> list = new TgbBoard_dao().getBoardList(conn, currentPage);
		
		close(conn);
		
		return list;
	}
	
	
}
