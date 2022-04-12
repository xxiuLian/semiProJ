package com.uni.chat.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class Chat {
	private int chatId;
	private String fromId;
	private String toId;
	private String chatContent;
	private Date chatTime;
}
