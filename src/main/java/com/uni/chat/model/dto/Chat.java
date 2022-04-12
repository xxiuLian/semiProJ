package com.uni.chat.model.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class Chat {
	private int chatId;
	private String fromId;
	private String toId;
	private String chatContent;
	private Date chatTime;
	
	public Chat() {
	}
	
	public Chat(String fromId, String toId, String chatContent) {
		super();
		this.fromId = fromId;
		this.toId = toId;
		this.chatContent = chatContent;
	}

	
	
	
}
