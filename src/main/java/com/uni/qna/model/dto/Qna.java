package com.uni.qna.model.dto;

import java.sql.Date;

import lombok.Data;

@Data

public class Qna {
	private int qnaNo; 			//문의게시글 고유 번호
	private String category; 	//문의게시글 분류
	private String qnaTitle; 	//문의게시글 제목
	private String qnaContent; 	//문의게시글  내용
	private String qnaWriter; 	//문의게시글 작성자
	private int count; 			//문의게시글 조회수
	private Date createDate; 	//문의게시글 작성일
	private String status;		//문의게시글 상태값(Y,N)

	private String qnaReply;	//문의게시글 댓글(답변)
	 
	
	public Qna() {}
	
	
	public Qna(int qnaNo, String category, String qnaTitle, String qnaContent, 
			String qnaWriter, int count, String status) {
		super();
		this.qnaNo = qnaNo;
		this.category = category;
		this.qnaTitle = qnaTitle;
		this.qnaContent = qnaContent;
		this.qnaWriter = qnaWriter;
		this.count = count;
		this.status = status;
	}
	
	public Qna(int qnaNo, String category, String qnaTitle, String qnaContent, 
			String qnaWriter, int count, String status, String qnaReply) {
		super();
		this.qnaNo = qnaNo;
		this.category = category;
		this.qnaTitle = qnaTitle;
		this.qnaContent = qnaContent;
		this.qnaWriter = qnaWriter;
		this.count = count;
		this.status = status;
		this.qnaReply = qnaReply;
	}
	
	public Qna(int qnaNo, String category, String qnaTitle, 
			String qnaWriter, int count, String status) {
		super();
		this.qnaNo = qnaNo;
		this.category = category;
		this.qnaTitle = qnaTitle;
		this.qnaWriter = qnaWriter;
		this.count = count;
		this.status = status;
	}
}
