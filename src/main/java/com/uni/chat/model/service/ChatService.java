package com.uni.chat.model.service;

import static com.uni.common.JDBCTemplate.close;
import static com.uni.common.JDBCTemplate.commit;
import static com.uni.common.JDBCTemplate.getConnection;
import static com.uni.common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import com.uni.chat.model.dao.ChatDao;
import com.uni.chat.model.dto.Chat;
import com.uni.member.model.dto.Member;

public class ChatService {

	public int insertChat(Chat c) {
		Connection conn = getConnection();
		
		int result = new ChatDao().insertChat(conn, c);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}

	public ArrayList<Chat> getChatListByRecent(String fromId, String toId, int bno) {
		Connection conn = getConnection();
		
		ArrayList<Chat> chat = new ChatDao().getChatListByRecent(conn, fromId, toId, bno);
		
		close(conn);
		
		return chat;
	}

	public ArrayList<Chat> getChatListById(String fromId, String toId, int chatNo, int bno) {
		Connection conn = getConnection();
		
		ArrayList<Chat> chat = new ChatDao().getChatListById(conn, fromId, toId, chatNo, bno);
		
		close(conn);
		
		return chat;
	}

	public ArrayList<String> selectBuyer(int tno) {
		Connection conn = getConnection();
		
		ArrayList<String> buyer = new ChatDao().selectBuyer(conn, tno);
		
		close(conn);
		
		return buyer;
	}
}
