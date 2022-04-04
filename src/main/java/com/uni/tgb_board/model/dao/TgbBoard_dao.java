package com.uni.tgb_board.model.dao;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import static com.uni.common.JDBCTemplate.*;

import com.uni.tgb_board.model.dto.TgbBoard_dto;


public class TgbBoard_dao {
	
	private Properties prop = new Properties();
	
	public TgbBoard_dao() {
		String fileName = TgbBoard_dao.class.getResource("/sql/tgb_wook/tgb_board_query.properties").getPath();
		System.out.println("fileName ? : " + fileName);
		
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	
	//페이지별 게시글
	public ArrayList<TgbBoard_dto> getBoardList(Connection conn, int currentPage){
		
		//currentPage 1 이면 1  ~ 10
		//currentPage 2 이면 11 ~ 20
		//currentPage 3 이면 21 ~ 30
		
		//공차무슨?공식 : a + (n-1)d  => (a는 시작,d는 차이)
		// 첫   페이지 : 1 + (n-1)10 = NoStart
		//마지막 페이지 : 10+ (n-1)10 = NoEnd
		
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		ArrayList<TgbBoard_dto> list = new ArrayList<TgbBoard_dto>();
		String sql = prop.getProperty("selectTGBBoard");
		
		int startRow =  1 + (currentPage-1) * 10;
		int endRow = 10 + (currentPage-1) * 10;
		
//		selectTGBBoard=SELECT * FROM TGB_BOARD\
//				( \
//				SELECT BOARD_NO, BOARD_CATEGORY_NO, BOARD_WRITER \
//				,BOARD_TITLE,BOARD_CONTENT \
//				,COUNT,CREATE_DATE,STATUS \
//				FROM TGB_BOARD \
//				ORDER BY BOARD_NO \
//				) A \
//				WHERE BOARD_NO BETWEEN ? AND ?;


//		BOARD_NO	NUMBER
//		BOARD_CATEGORY_NO	NUMBER
//		BOARD_WRITER	NUMBER
//		BOARD_TITLE	VARCHAR2(100 BYTE)
//		BOARD_CONTENT	VARCHAR2(4000 BYTE)
//		COUNT	NUMBER
//		CREATE_DATE	DATE
//		STATUS	VARCHAR2(1 BYTE)
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(new TgbBoard_dto(
						rset.getInt("BOARD_NO"),
						rset.getInt("BOARD_CATEGORY_NO"),
						rset.getInt("BOARD_WRITER"),
						rset.getString("BOARD_TITLE"),
						rset.getString("BOARD_CONTENT"),
						rset.getInt("COUNT"),
						rset.getDate("CREATE_DATE"),
						rset.getString("STATUS")
						));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		System.out.println(list.size());
		return list;
		
	}
	
	
	
	
}
