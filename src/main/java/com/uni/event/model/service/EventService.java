package com.uni.event.model.service;

import static com.uni.common.JDBCTemplate.close;
import static com.uni.common.JDBCTemplate.commit;
import static com.uni.common.JDBCTemplate.getConnection;
import static com.uni.common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import com.uni.event.model.dao.EventDao;
import com.uni.event.model.dto.EventDto;
import com.uni.notice.model.dao.NoticeDao;
import com.uni.notice.model.dto.NoticeDto;

public class EventService {

	public ArrayList<EventDto> selectList() {
		Connection conn = getConnection();
		ArrayList<EventDto> list = new EventDao().selectList(conn);
		
		close(conn);
		return list;
	}

	public int insertNotice(EventDto n) {
		Connection conn = getConnection();
		
		int result = new EventDao().insertNotice(conn,n);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public EventDto selectEvent(int nno) {
		
		Connection conn = getConnection();
		int result = new EventDao().increaseCount(conn,nno); //조회수 증가
		EventDto n = null;
		
		if(result > 0) {
			commit(conn);
			n = new EventDao().selectEvent(conn, nno);
			
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return n;
	}

	public int deleteEvent(String nno) {
		Connection conn = getConnection();
		
		int result = new EventDao().deleteEvent(conn, nno);
		
		if(result > 0 ) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public EventDto selectUpdateEvent(int nno) {
		Connection conn = getConnection();
		
		EventDto n = new EventDao().selectEvent(conn, nno);
		
		close(conn);
		return n;
	}

	public int updateEvent(EventDto n) {
		Connection conn = getConnection();
		
		int result = new EventDao().updateEvent(conn, n);
		
		if(result > 0 ) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

}