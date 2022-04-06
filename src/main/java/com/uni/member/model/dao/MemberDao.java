package com.uni.member.model.dao;

import static com.uni.common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.uni.member.model.dto.Member;

public class MemberDao {
	
	private Properties prop = new Properties();

	public MemberDao() {
		String fileName = MemberDao.class.getResource("/sql/member/member-query.properties").getPath();
		
		System.out.println("fileName   " + fileName);
		try {
			prop.load(new FileReader(fileName)); //load메소드를 활용헤 fileName(member properties)을 읽어들인다.
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public int insertMember(Connection conn, Member member) {
		//insertMember=INSERT INTO MEMBER VALUES(SEQ_MEM.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, SYSDATE, SYSDATE, DEFAULT)
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertMember");
		/*	USER_NO	NUMBER
			1USER_ID	VARCHAR2(30 BYTE)
			2USER_PWD	VARCHAR2(100 BYTE)
			3USER_NAME	VARCHAR2(15 BYTE)
			4PHONE	VARCHAR2(100 BYTE)
			5EMAIL	VARCHAR2(100 BYTE)
			6ACCOUNT	VARCHAR2(100 BYTE)
			7BANK	VARCHAR2(15 BYTE)
			8POST	NUMBER
			9ADDRESS1	VARCHAR2(100 BYTE)
			10ADDRESS2	VARCHAR2(100 BYTE)
			ENROLL_DATE	DATE
			MODIFY_DATE	DATE
			STATUS	VARCHAR2(1 BYTE)*/
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getUserId());
			pstmt.setString(2, member.getUserPwd());
			pstmt.setString(3, member.getUserName());
			pstmt.setString(4, member.getPhone());
			pstmt.setString(5, member.getEmail());
			pstmt.setString(6, member.getAccount());
			pstmt.setString(7, member.getBank());
			pstmt.setInt(8, member.getPost());
			pstmt.setString(9, member.getAddress1());
			pstmt.setString(10, member.getAddress2());
			
			result = pstmt.executeUpdate();
			
			System.out.println(member);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public Member loginUser(Connection conn, String userId, String userPwd) {
		//loginUser=SELECT * FROM MEMBER WHERE USER_ID=? AND USER_PWD=? AND STATUS='Y'
		Member loginUser = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("loginUser");
		/*
		USER_NO	NUMBER
		USER_ID	VARCHAR2(30 BYTE)
		USER_PWD	VARCHAR2(100 BYTE)
		USER_NAME	VARCHAR2(15 BYTE)
		PHONE	VARCHAR2(100 BYTE)
		EMAIL	VARCHAR2(100 BYTE)
		ACCOUNT	VARCHAR2(100 BYTE)
		BANK	VARCHAR2(15 BYTE)
		POST	NUMBER
		ADDRESS1	VARCHAR2(100 BYTE)
		ADDRESS2	VARCHAR2(100 BYTE)
		ENROLL_DATE	DATE
		MODIFY_DATE	DATE
		STATUS	VARCHAR2(1 BYTE)*/
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, userPwd);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				loginUser = new Member(rset.getInt("USER_NO"),
						   rset.getString("USER_ID"),
						   rset.getString("USER_PWD"),
						   rset.getString("USER_NAME"),
						   rset.getString("PHONE"),
						   rset.getString("EMAIL"),
						   rset.getString("ACCOUNT"),
						   rset.getString("BANK"),
						   rset.getInt("POST"),
						   rset.getString("ADDRESS1"),
						   rset.getString("ADDRESS2"),
						   rset.getDate("ENROLL_DATE"),
						   rset.getDate("MODIFY_DATE"),
						   rset.getString("STATUS")
						   );
			}
			
			System.out.println(loginUser);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return loginUser;
	}

	public Member selectMember(Connection conn, String userId) {
		//selectMember=SELECT * FROM MEMBER WHERE USER_ID=? AND STATUS='Y'
		Member mem = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectMember");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				mem = new Member(rset.getInt("USER_NO"),
						   rset.getString("USER_ID"),
						   rset.getString("USER_PWD"),
						   rset.getString("USER_NAME"),
						   rset.getString("PHONE"),
						   rset.getString("EMAIL"),
						   rset.getString("ACCOUNT"),
						   rset.getString("BANK"),
						   rset.getInt("POST"),
						   rset.getString("ADDRESS1"),
						   rset.getString("ADDRESS2"),
						   rset.getDate("ENROLL_DATE"),
						   rset.getDate("MODIFY_DATE"),
						   rset.getString("STATUS")
						   );
			}
			System.out.println("Member : " + mem);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return mem;
	}

	public int idCheck(Connection conn, String userId) {
		//idCheck=SELECT COUNT(*) FROM MEMBER WHERE USER_ID=?
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("idCheck");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				result = rset.getInt(1);
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return result;
	}

	public int updateMember(Connection conn, Member m) {
		//updateMember=UPDATE MEMBER SET USER_NAME=?, PHONE=?, EMAIL=?, ACCOUNT=?, BANK=?, POST=?, ADDRESS1=?, ADDRESS2=?, MODIFY_DATE=SYSDATE WHERE USER_ID=?
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateMember");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m.getUserName());
			pstmt.setString(2, m.getPhone());
			pstmt.setString(3, m.getEmail());
			pstmt.setString(4, m.getAccount());
			pstmt.setString(5, m.getBank());
			pstmt.setInt(6, m.getPost());
			pstmt.setString(7, m.getAddress1());
			pstmt.setString(8, m.getAddress2());
			pstmt.setString(9, m.getUserId());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
		
	}

	public int deleteMember(Connection conn, String userId) {
		//deleteMember=UPDATE MEMBER SET STATUS='N' WHERE USER_ID=?
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteMember");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			
			result = pstmt.executeUpdate();
					
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int updatePwd(Connection conn, String userId, String userPwd, String newPwd) {
		//updatePwd=UPDATE MEMBER SET USER_PWD=?, MODIFY_DATE=SYSDATE WHERE USER_ID=? AND USER_PWD=?
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updatePwd");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newPwd);
			pstmt.setString(2, userId);
			pstmt.setString(3, userPwd);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

}
