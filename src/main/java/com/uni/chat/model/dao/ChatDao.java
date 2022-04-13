package com.uni.chat.model.dao;

import static com.uni.common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.uni.chat.model.dto.Chat;

public class ChatDao {
	private Properties prop = new Properties();

	public ChatDao() {
		String fileName = ChatDao.class.getResource("/sql/chat_kwon/chat-query.properties").getPath();
		System.out.println("fileName   " + fileName);
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public int insertChat(Connection conn, Chat c) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		//insertChat=INSERT INTO CHAT VALUES(SEQ_CHAT.NEXTVAL,? ,?, ?, ?, SYSDATE)
		String sql = prop.getProperty("insertChat");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, c.getTgbNo());
			pstmt.setString(2, c.getFromId());
			pstmt.setString(3, c.getToId());
			pstmt.setString(4, c.getChatContent());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public ArrayList<Chat> getChatListByRecent(Connection conn, String fromId, String toId, int bno) {
		ArrayList<Chat> list = new ArrayList<Chat>();
		System.out.println(fromId);
		System.out.println(toId);
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		//getChatListByRecent=SELECT * FROM(SELECT ROWNUM RNUM, A.* FROM (SELECT * FROM CHAT WHERE ((FROM_ID=? AND TO_ID=?) OR (FROM_ID=? AND TO_ID=?)) AND TGB_NO=? ORDER BY CHAT_TIME DESC)A) WHERE RNUM <=10 ORDER BY RNUM DESC
		String sql = prop.getProperty("getChatListByRecent");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fromId);
			pstmt.setString(2, toId);
			pstmt.setString(3, toId);
			pstmt.setString(4, fromId);
			pstmt.setInt(5, bno);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Chat chat = new Chat();
				chat.setChatId(rset.getInt("CHAT_NO"));
				chat.setFromId(rset.getString("FROM_ID"));
				chat.setToId(rset.getString("TO_ID"));
				chat.setChatContent(rset.getString("CONTENT"));
				chat.setChatTime(rset.getDate("CHAT_TIME"));
				list.add(chat);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}
	
	public ArrayList<Chat> getChatListById(Connection conn, String fromId, String toId, int num, int bno) {
		ArrayList<Chat> list = new ArrayList<Chat>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		//getChatListById=SELECT * FROM CHAT WHERE ((FROM_ID=? AND TO_ID=?) OR (FROM_ID=? AND TO_ID=?)) AND CHAT_NO > ? AND TGB_NO=? ORDER BY CHAT_TIME
		String sql = prop.getProperty("getChatListById");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fromId);
			pstmt.setString(2, toId);
			pstmt.setString(3, toId);
			pstmt.setString(4, fromId);
			pstmt.setInt(5, num);
			pstmt.setInt(6, bno);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Chat chat = new Chat();
				chat.setChatId(rset.getInt("CHAT_NO"));
				chat.setFromId(rset.getString("FROM_ID"));
				chat.setToId(rset.getString("TO_ID"));
				chat.setChatContent(rset.getString("CONTENT"));
				chat.setChatTime(rset.getDate("CHAT_TIME"));
				list.add(chat);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public ArrayList<String> selectBuyer(Connection conn, int tno) {
		ArrayList<String> list = new ArrayList<String>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		//selectBuyer=SELECT USER_ID FROM PAY JOIN MEMBER USING(USER_NO) WHERE TGB_NO=?
		String sql = prop.getProperty("selectBuyer");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, tno);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(rset.getString("USER_ID"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}
}