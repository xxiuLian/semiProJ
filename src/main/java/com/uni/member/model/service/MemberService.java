package com.uni.member.model.service;

import static com.uni.common.JDBCTemplate.*;

import java.sql.Connection;

import com.uni.member.model.dao.MemberDao;
import com.uni.member.model.dto.Member;

public class MemberService {

	public int insertMember(Member member) {
		Connection conn = getConnection();
		
		int result = new MemberDao().insertMember(conn, member);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public Member loginMember(String userId, String userPwd) {
		Connection conn = getConnection();
		
		Member loginUser = new MemberDao().loginUser(conn, userId, userPwd);

		close(conn);
		return loginUser;
	}

	public Member selectMember(String userId) {
		Connection conn = getConnection();
		Member member = new MemberDao().selectMember(conn, userId);
		
		close(conn);//조회 잘 했으면 Connection 닫기
		
		return member;
	}

}
