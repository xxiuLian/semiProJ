package com.uni.chat.service;

import static com.uni.common.JDBCTemplate.close;
import static com.uni.common.JDBCTemplate.commit;
import static com.uni.common.JDBCTemplate.getConnection;
import static com.uni.common.JDBCTemplate.rollback;

import java.sql.Connection;

import com.uni.chat.model.dao.ChatDao;
import com.uni.chat.model.dto.Chat;

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

}
