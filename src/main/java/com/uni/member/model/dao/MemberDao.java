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
		/*	USER_NO		NUMBER
			*USER_ID	VARCHAR2(30 BYTE)
			*USER_PWD	VARCHAR2(100 BYTE)
			*USER_NAME	VARCHAR2(15 BYTE)
			*ADDRESS	VARCHAR2(100 BYTE)
			*PHONE		VARCHAR2(100 BYTE)
			*EMAIL		VARCHAR2(100 BYTE)
			*ACCOUNT	VARCHAR2(100 BYTE)
			ENROLL_DATE	DATE
			MODIFY_DATE	DATE
			STATUS		VARCHAR2(1 BYTE)*/
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getUserId());
			pstmt.setString(2, member.getUserPwd());
			pstmt.setString(3, member.getUserName());
			pstmt.setString(4, member.getAddress());
			pstmt.setString(5, member.getPhone());
			pstmt.setString(6, member.getEmail());
			pstmt.setString(7, member.getAccount());
			
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
						   rset.getString("ADDRESS"),
						   rset.getString("PHONE"),
						   rset.getString("EMAIL"),
						   rset.getString("ACCOUNT"),
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

}
