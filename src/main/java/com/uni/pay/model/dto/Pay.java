package com.uni.pay.model.dto;

import lombok.Data;

@Data //롬복
public class Pay {
	private int userNo;
	private int tgbNo;
	private int totPrice;
	private int amount;
	private String userId; //추가1_재욱

	public Pay() {}

	public Pay(int userNo, int tgbNo, int totPrice, int amount) {
		super();
		this.userNo = userNo;
		this.tgbNo = tgbNo;
		this.totPrice = totPrice;
		this.amount = amount;
	}

	//추가2까지_재욱
	public Pay(String userId ) {
		super();
		this.userId = userId;
	}

	
	
}
