package com.uni.pay.model.dto;

import lombok.Data;

@Data //롬복
public class Pay {
	private int userNo;
	private int tgbNo;
	private int totPrice;
	private int amount;
	
	public Pay() {}

	public Pay(int userNo, int tgbNo, int totPrice, int amount) {
		super();
		this.userNo = userNo;
		this.tgbNo = tgbNo;
		this.totPrice = totPrice;
		this.amount = amount;
	}
}
