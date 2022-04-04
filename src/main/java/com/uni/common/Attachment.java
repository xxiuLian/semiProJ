package com.uni.common;

import java.sql.Date;

import lombok.Data;

@Data
public class Attachment {
	private int fileNo;			// 파일 고유 번호
	private String originName;	// 파일 원본명
	private String changeName;	// 파일 수정명
	private String filePath;	// 파일이 저장된 폴더 경로
	private Date uploadDate;	// 파일 업로드일
	private String status;		// 파일 상태값
	private int refBoardNo;		// 참조하고 있는 게시글 번호
	private String type;        // 참조하고 있는 게시판 번호 
	
	public Attachment() {
		
	}

	public Attachment(int fileNo, String originName, String changeName, String filePath, Date uploadDate, String status,
			int refBoardNo, String type) {
		super();
		this.fileNo = fileNo;
		this.originName = originName;
		this.changeName = changeName;
		this.filePath = filePath;
		this.uploadDate = uploadDate;
		this.status = status;
		this.refBoardNo = refBoardNo;
		this.type = type;
	}


}
