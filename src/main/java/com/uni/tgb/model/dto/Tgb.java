package com.uni.tgb.model.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class Tgb {
	
	private int tgbNo;           // 공구 글 번호
	private String tgbCategory;  // 공구 카테고리 (숫자 아니면 문자)
	private String tgbTitle;     // 공구 글 제목
	private String tgbContent;   // 공구 글 내용
	private String tgbGuide;     // 공구 진행 설명
	private String tgbWriter;    // 공구 진행자
	private int count;           // 공구 글 조회수
	private Date tgbTerm;        // 공구 기간
	private int tgb_Price;       // 공구 가격
	private Date createDate;     // 공구 글 작성일
	private String status;       // 상태값 
	
	private String thumnail;    //썸네일
	
	public Tgb() {}

	public Tgb(int tgbNo, String tgbCategory, String tgbTitle, String tgbContent, String tgbGuide, String tgbWriter,
			int count, Date tgbTerm, int tgb_Price, Date createDate) {
		super();
		this.tgbNo = tgbNo;
		this.tgbCategory = tgbCategory;
		this.tgbTitle = tgbTitle;
		this.tgbContent = tgbContent;
		this.tgbGuide = tgbGuide;
		this.tgbWriter = tgbWriter;
		this.count = count;
		this.tgbTerm = tgbTerm;
		this.tgb_Price = tgb_Price;
		this.createDate = createDate;
		this.status = status;
	}

	public Tgb(String tgbCategory, String tgbTitle, String tgbContent, String tgbGuide, String tgbWriter, Date tgbTerm,
			int tgb_Price) {
		super();
		this.tgbCategory = tgbCategory;
		this.tgbTitle = tgbTitle;
		this.tgbContent = tgbContent;
		this.tgbGuide = tgbGuide;
		this.tgbWriter = tgbWriter;
		this.tgbTerm = tgbTerm;
		this.tgb_Price = tgb_Price;
	}

	public Tgb(int tgbNo, String tgbCategory, String tgbTitle, String tgbWriter, int count, Date tgbTerm, int tgb_Price,
			Date createDate, String thumnail) {
		super();
		this.tgbNo = tgbNo;
		this.tgbCategory = tgbCategory;
		this.tgbTitle = tgbTitle;
		this.tgbWriter = tgbWriter;
		this.count = count;
		this.tgbTerm = tgbTerm;
		this.tgb_Price = tgb_Price;
		this.createDate = createDate;
		this.thumnail = thumnail;
	}

	public Tgb(int tgbNo, String tgbCategory, String tgbTitle, int count, Date tgbTerm, int tgb_Price, Date createDate,
			String thumnail) {
		super();
		this.tgbNo = tgbNo;
		this.tgbCategory = tgbCategory;
		this.tgbTitle = tgbTitle;
		this.count = count;
		this.tgbTerm = tgbTerm;
		this.tgb_Price = tgb_Price;
		this.createDate = createDate;
		this.thumnail = thumnail;
	}

	
	
	


	
	
	
	
	
	
	
}
