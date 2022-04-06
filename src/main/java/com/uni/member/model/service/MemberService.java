package com.uni.member.model.service;

import static com.uni.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

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

	public int idCheck(String userId) {
		Connection conn = getConnection();
		
		int result = new MemberDao().idCheck(conn, userId);
		
		close(conn);
		return result;
	}

	public Member updateMember(Member m) {
		Connection conn = getConnection();
		
		Member updateMember = null;
		
		int result = new MemberDao().updateMember(conn, m);
		
		if(result > 0) {
			commit(conn);
			updateMember = new MemberDao().selectMember(conn, m.getUserId());
		}else {
			rollback(conn);
		}
		close(conn);
		return updateMember;
	}

	public int deleteMember(String userId) {
		Connection conn = getConnection();
		
		int result = new MemberDao().deleteMember(conn, userId);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public Member updatePwd(String userId, String userPwd, String newPwd) {
		Connection conn = getConnection();
		
		Member updateMem = null;
		
		int result = new MemberDao().updatePwd(conn, userId, userPwd, newPwd );
		
		if(result > 0) {
			commit(conn);
			updateMem = new MemberDao().selectMember(conn, userId);
			//비번 수정이 잘 완료 됐다면 dao의 selectMember(조회)를 통해 수정된 정보가 마이페이지에서 보여지기
		}else {
			rollback(conn);
		}
		close(conn);
		return updateMem;
	}

	public ArrayList<Member> selectAllMember() {
		Connection conn = getConnection();
		ArrayList<Member> list = new MemberDao().selectAllMember(conn);
		
		close(conn);
		
		return list;
	}

}
