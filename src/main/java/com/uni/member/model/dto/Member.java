package com.uni.member.model.dto;

import java.sql.Date;

import lombok.Data;

@Data //롬복

public class Member {

	private int userNo;
	private String userId;
	private String userPwd;
	private String userName;
	private String address;
	private String phone;
	private String email;
	private String account;
	private Date enrollDate;
	private Date modifyDate;
	private String status;
	
	
	public Member() {}

	
	public Member(String userId, String userPwd) {
		this.userId = userId;
		this.userPwd = userPwd;
	}
	
	public Member(String userId, String userName, String address, 
			String phone, String email, String account) {
		this.userId = userId;
		this.userName = userName;
		this.address = address;
		this.phone = phone;
		this.email = email;
		this.account = account;
	}
	
	public Member(String userId, String address, 
			String phone, String email, String account) {
		this.userId = userId;
		this.address = address;
		this.phone = phone;
		this.email = email;
		this.account = account;
	}
	
	public Member(String userId, String userPwd, String userName, String address, 
			String email, String phone, String account) {
		this.userId = userId;
		this.userPwd = userPwd;
		this.userName = userName;
		this.phone = phone;
		this.email = email;
		this.address = address;
		this.account = account;
	}
	
	public Member(int userNo, String userId, String userPwd, String userName, String address, 
			String phone, String email, String account, Date enrollDate, Date modifyDate, String status) {
		this.userNo = userNo;
		this.userId = userId;
		this.userPwd = userPwd;
		this.userName = userName;
		this.address = address;
		this.phone = phone;
		this.email = email;
		this.account = account;
		this.enrollDate = enrollDate;
		this.modifyDate = modifyDate;
		this.status = status;
	}


	@Override
	public String toString() {
		return "Member [userNo=" + userNo + ", userId=" + userId + ", userPwd=" + userPwd + ", userName=" + userName
				+ ", address=" + address + ", phone=" + phone + ", email=" + email + ", account=" + account
				+ ", enrollDate=" + enrollDate + ", modifyDate=" + modifyDate + ", status=" + status + "]";
	}
	
	

}
