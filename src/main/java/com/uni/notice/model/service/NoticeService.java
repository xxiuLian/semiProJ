package com.uni.notice.model.service;

import static com.uni.common.JDBCTemplate.close;
import static com.uni.common.JDBCTemplate.commit;
import static com.uni.common.JDBCTemplate.getConnection;
import static com.uni.common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import com.uni.common.PageInfo;
import com.uni.notice.model.dao.NoticeDao;
import com.uni.notice.model.dto.NoticeDto;
import com.uni.tgb_board.model.dao.TgbBoard_dao;

public class NoticeService {

	public ArrayList<NoticeDto> selectList(PageInfo pi) {
		Connection conn = getConnection();
		ArrayList<NoticeDto> list = new NoticeDao().selectList(conn, pi);
		
		close(conn);
		return list;
	}

	public int insertNotice(NoticeDto n) {
		Connection conn = getConnection();
		
		int result = new NoticeDao().insertNotice(conn,n);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public NoticeDto selectNotice(int nno) {
		Connection conn = getConnection();
		int result = new NoticeDao().increaseCount(conn,nno); //조회수 증가
		NoticeDto n = null;
		
		if(result > 0) {
			commit(conn);
			n = new NoticeDao().selectNotice(conn, nno);
			
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return n;
	}

	public int deleteNotice(String nno) {
		Connection conn = getConnection();
		
		int result = new NoticeDao().deleteNotice(conn, nno);
		
		if(result > 0 ) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public NoticeDto selectUpdateNotice(int nno) {
	Connection conn = getConnection();
		
		NoticeDto n = new NoticeDao().selectNotice(conn, nno);
		
		close(conn);
		return n;

	}

	public int updateNotice(NoticeDto n) {
		Connection conn = getConnection();
		
		int result = new NoticeDao().updateNotice(conn, n);
		
		if(result > 0 ) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public int getListCount() {
		Connection conn = getConnection();
		
		int listCount = new NoticeDao().getListCount(conn);
		
		close(conn);
		return listCount;
	}



}
