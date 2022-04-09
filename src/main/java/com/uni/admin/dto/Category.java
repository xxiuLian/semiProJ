package com.uni.admin.dto;

import lombok.Data;

@Data
public class Category {
	private int categoryNo; //카테고리 번호
	private String categoryName; 	//카테고리 이름
	
	public Category(int categoryNo, String categoryName) {
		super();
		this.categoryNo = categoryNo;
		this.categoryName = categoryName;
	}
}
