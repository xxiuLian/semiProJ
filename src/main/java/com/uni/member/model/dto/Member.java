package com.uni.member.model.dto;

import java.sql.Date;

import lombok.Data;

@Data //롬복

public class Member {

	private int userNo;
	private String userId;
	private String userPwd;
	private String userName;
	private String phone;
	private String email;
	private String account;
	private String bank;
	private int post;
	private String address1;
	private String address2;
	private Date enrollDate;
	private Date modifyDate;
	private String status;
	
	
	public Member() {}

	
	//추가_재욱
	public Member(int userNo, String userId, String phone, String email) {
		super();
		this.userId = userId;
		this.phone = phone;
		this.email = email;
	}
	
		
	public Member(String userId, String userPwd) {
		this.userId = userId;
		this.userPwd = userPwd;
	}
	
	public Member(String userId, String userPwd, String userName, String phone, String email, String account,
			String bank, int post, String address1, String address2) {
		super();
		this.userId = userId;
		this.userPwd = userPwd;
		this.userName = userName;
		this.phone = phone;
		this.email = email;
		this.account = account;
		this.bank = bank;
		this.post = post;
		this.address1 = address1;
		this.address2 = address2;
	}
	
	public Member(String userId, String phone, String email, String account, String bank, int post, String address1,
			String address2) {
		super();
		this.userId = userId;
		this.phone = phone;
		this.email = email;
		this.account = account;
		this.bank = bank;
		this.post = post;
		this.address1 = address1;
		this.address2 = address2;
	}
	
	public Member(int userNo, String userId, String userPwd, String userName, String phone, String email,
			String account, String bank, int post, String address1, String address2, Date enrollDate, Date modifyDate,
			String status) {
		super();
		this.userNo = userNo;
		this.userId = userId;
		this.userPwd = userPwd;
		this.userName = userName;
		this.phone = phone;
		this.email = email;
		this.account = account;
		this.bank = bank;
		this.post = post;
		this.address1 = address1;
		this.address2 = address2;
		this.enrollDate = enrollDate;
		this.modifyDate = modifyDate;
		this.status = status;
	}


	@Override
	public String toString() {
		return "Member [userNo=" + userNo + ", userId=" + userId + ", userPwd=" + userPwd + ", userName=" + userName
				+ ", phone=" + phone + ", email=" + email + ", account=" + account + ", bank=" + bank + ", post=" + post
				+ ", address1=" + address1 + ", address2=" + address2 + ", enrollDate=" + enrollDate + ", modifyDate="
				+ modifyDate + ", status=" + status + "]";
	}

	











	
	

}
