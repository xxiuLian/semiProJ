package com.uni.member.model.service;

import static com.uni.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import com.uni.common.PageInfo;
import com.uni.member.model.dao.MemberDao;
import com.uni.member.model.dto.Member;
import com.uni.tgb.model.dao.TgbDao;
import com.uni.tgb.model.dto.Tgb;

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

	public int deleteMembers(int[] userNo) {
		Connection conn = getConnection();
		
		int result = new MemberDao().deleteMembers(conn, userNo);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}
	
	public Member selectMember(int userNo) {
		Connection conn = getConnection();
		Member member = new MemberDao().selectMember(conn, userNo);
		
		close(conn);
		
		return member;

	}
	
	public Member findId(String userName, String phone) {
		Connection conn = getConnection();
		
		Member mem = new MemberDao().findId(conn, userName, phone);
	    
		close(conn);
		return mem;
	}

	public Member findPwd(String userId, String userName, String phone) {
		Connection conn = getConnection();
		
		Member mem = new MemberDao().findPwd(conn, userId, userName, phone);
	    
		close(conn);
		return mem;
	}

	public int findPwdUpdate(String userId, String newPwd) {
		Connection conn = getConnection();
		
		int result = new MemberDao().findPwdUpdate(conn, userId, newPwd );
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public ArrayList<Tgb> mySelectList(PageInfo pi, int userNo) {
		Connection conn = getConnection();
		
		ArrayList<Tgb> list = new MemberDao().mySelectList(conn, pi, userNo);
		
		close(conn);
		
		return list;
	}


	public ArrayList<Tgb> myjoinList(PageInfo pi, int userNo) {
		Connection conn = getConnection();
		
		ArrayList<Tgb> joinList = new MemberDao().myjoinList(conn, pi, userNo);
		
		close(conn);
		
		return joinList;
	}
	
	public ArrayList<Tgb> myFinishList(PageInfo pi, int userNo) {
		Connection conn = getConnection();
		
		ArrayList<Tgb> finishList = new MemberDao().myFinishList(conn, pi, userNo);
		
		close(conn);
		
		return finishList;
	}
	
	public int ingCount(int userNo) {
		Connection conn = getConnection();
		
		int ingCount = new MemberDao().ingCount(conn, userNo);
		
		close(conn);
		return ingCount;
	}

	public int payCount(int userNo) {
		Connection conn = getConnection();
		
		int payCount = new MemberDao().payCount(conn, userNo);
		
		close(conn);
		return payCount;
	}

	public int qnaCount(int userNo) {
		Connection conn = getConnection();
		
		int qnaCount = new MemberDao().qnaCount(conn, userNo);
		
		close(conn);
		return qnaCount;
	}

	public ArrayList<Tgb> bestItem() {
		Connection conn = getConnection();
		
		ArrayList<Tgb> bestItem = new MemberDao().bestItem(conn);
		
		close(conn);
		
		return bestItem;
	}

	public ArrayList<Tgb> newItem() {
		Connection conn = getConnection();
		
		ArrayList<Tgb> newItem = new MemberDao().newItem(conn);
		
		close(conn);
		
		return newItem;
	}

	

}
