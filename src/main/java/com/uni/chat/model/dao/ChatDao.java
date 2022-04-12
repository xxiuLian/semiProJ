package com.uni.chat.model.dao;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
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
		
		//insertChat=INSERT INTO CHAT VALUES(SEQ_CHAT, ?, ?, ?, SYSDATE)
		String sql = prop.getProperty("insertChat");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, c.getFromId());
			pstmt.setString(2, c.getToId());
			pstmt.setString(3, c.getChatContent());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

}
