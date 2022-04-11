package com.uni.boardTGB.model.dao;

import static com.uni.common.JDBCTemplate.*;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.uni.boardTGB.model.dto.BoardTGB_dto;
import com.uni.notice.model.dto.NoticeDto;


public class BoardTGB_dao {
	
	private Properties prop = new Properties();
	
	public BoardTGB_dao() {
		String fileName = BoardTGB_dao.class.getResource("/sql/boardTGB_wook/boardTGB_query.properties").getPath();
		System.out.println("fileName   " + fileName);
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public ArrayList<BoardTGB_dto> selectList(Connection conn) {
		ArrayList<BoardTGB_dto> list = new ArrayList<BoardTGB_dto>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String sql = prop.getProperty("selectList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			
			while(rset.next()) {
				list.add(new BoardTGB_dto(rset.getInt("BOARD_NO"),
									rset.getString("BOARD_TITLE"),
									rset.getString("USER_ID"),
									rset.getInt("COUNT"),
									rset.getDate("CREATE_DATE")
									
						));
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public int insertBoardTGB(Connection conn, BoardTGB_dto n) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertBoardTGB");
		//		BOARD_CATEGORY_NO	NUMBER
		//		BOARD_WRITER	NUMBER
		//		BOARD_TITLE	VARCHAR2(100 BYTE)
		//		BOARD_CONTENT	VARCHAR2(4000 BYTE)
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, n.getBoardTGBCategory());
			pstmt.setInt(2, Integer.parseInt(n.getBoardTgbWriter()) );
			pstmt.setString(3, n.getBoardTgbTitle());
			pstmt.setString(4, n.getBoardTgbContent());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}

	public int increaseCount(Connection conn, int nno) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("increaseBoardTGB");
		
		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, nno);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public BoardTGB_dto detailBaordTGB(Connection conn, int nno) {
		BoardTGB_dto n = null;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("detailBoardTGB");
		//detailBoardTGB=SELECT BOARD_NO, BOARD_TITLE, BOARD_CONTENT, USER_ID, COUNT, CREATE_DATE 
		//FROM TGB_BOARD N 
		//JOIN MEMBER ON (BOARD_WRITER=USER_NO) 
		//WHERE BOARD_NO=? AND N.STATUS='Y'
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, nno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				n = new BoardTGB_dto(
						rset.getInt("BOARD_NO"),
						rset.getString("BOARD_TITLE"),
						rset.getString("BOARD_CONTENT"),
						rset.getString("USER_ID"),
						rset.getInt("COUNT"),
						rset.getDate("CREATE_DATE")
						);
			}
			
		}catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return n;
		
	}
	
	
}
