package com.uni.chat.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class Chat {
	private String UserId;
	private String chatContent;
	private Date chatDate;
}
