package com.uni.common;

import java.sql.Date;

import lombok.Data;

@Data
public class Attachment {
	private int fileNo;			// 파일 고유 번호
	private int refBoardNo;		// 참조하고 있는 게시글 번호
	private String originName;	// 파일 원본명
	private String changeName;	// 파일 수정명
	private String filePath;	// 파일이 저장된 폴더 경로
	private Date uploadDate;	// 파일 업로드일
	private int fileLevel;		// 0:타이틀이미지, 1:내용이미지
	private String status;		// 파일 상태값
	
	public Attachment() {
		
	}
	public Attachment(int fileNo, int refBoardNo, String originName, String changeName, String filePath, Date uploadDate,
			int fileLevel, String status) {
		super();
		this.fileNo = fileNo;
		this.refBoardNo = refBoardNo;
		this.originName = originName;
		this.changeName = changeName;
		this.filePath = filePath;
		this.uploadDate = uploadDate;
		this.fileLevel = fileLevel;
		this.status = status;
	}	

}
