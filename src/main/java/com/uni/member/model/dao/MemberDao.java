package com.uni.member.model.dao;

import static com.uni.common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.uni.common.PageInfo;
import com.uni.member.model.dto.Member;
import com.uni.tgb.model.dto.Tgb;

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

	public ArrayList<Member> selectAllMember(Connection conn) {
		 ArrayList<Member> list = new ArrayList<Member>();
		 PreparedStatement pstmt = null;
		 ResultSet rset = null;
		 
		 //selectAllMember=SELECT * FROM MEMBER
		 String sql = prop.getProperty("selectAllMember");
			
			try {
				pstmt = conn.prepareStatement(sql);
				
				rset = pstmt.executeQuery();
				
				while(rset.next()) {
					Member m = new Member(rset.getInt("USER_NO"),
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
					list.add(m);
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				close(rset);
				close(pstmt);
			}
		 
		return list;
	}

	public int deleteMembers(Connection conn, int[] userNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		//deleteMembers=UPDATE MEMBER SET STATUS='N' WHERE USER_NO=?
		String sql = prop.getProperty("deleteMembers");
		
		try {
			pstmt = conn.prepareStatement(sql);
			if(userNo != null) {
				for(int i = 0; i < userNo.length; i++) {
					System.out.println("userNo[i] : "+userNo[i]);
					pstmt.setInt(1, userNo[i]);
					result += pstmt.executeUpdate();
				}
			}
			
			System.out.println("회원탈퇴 result : " + result);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	public Member selectMember(Connection conn, int userNo) {
		//adminSelectMember=SELECT * FROM MEMBER WHERE USER_NO=?
		Member member = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("adminSelectMember");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				member = new Member(rset.getInt("USER_NO"),
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
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return member;

	}

	public Member findId(Connection conn, String userName, String phone) {
		//findId=SELECT USER_ID, USER_NAME FROM MEMBER WHERE USER_NAME=? AND PHONE=?
		Member mem = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findId");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userName);
			pstmt.setString(2, phone);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				mem = new Member(rset.getString("USER_ID"),
								rset.getString("USER_NAME"));
			}
			
			System.out.println(mem);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return mem;
	}

	public Member findPwd(Connection conn, String userId, String userName, String phone) {
		//findPwd=SELECT * FROM MEMBER WHERE USER_ID=? AND USER_NAME=? AND PHONE=?
		Member mem = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findPwd");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, userName);
			pstmt.setString(3, phone);
			
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
			
			System.out.println(mem);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return mem;
	}

	public int findPwdUpdate(Connection conn, String userId, String newPwd) {
		//findPwdUpdate=UPDATE MEMBER SET USER_PWD=?, MODIFY_DATE=SYSDATE WHERE USER_ID=?
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("findPwdUpdate");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newPwd);
			pstmt.setString(2, userId);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public ArrayList<Tgb> mySelectList(Connection conn, PageInfo pi, int userNo) {
		ArrayList<Tgb> list = new ArrayList<Tgb>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("myList");
		
		int startRow = (pi.getCurrentPage() -1)*pi.getBoardLimit()+1;
		int endRow = startRow+pi.getBoardLimit() -1;
//		myList=SELECT * FROM ( SELECT ROWNUM RNUM, A.* FROM(SELECT TGB_NO, TGB_CATEGORY_NO, TGB_CATEGORY_NAME, \
//				TGB_TITLE, TGB_COUNT, TGB_TERM, TGB_PRICE, CREATE_DATE, CHANGE_NAME FROM TGB LEFT JOIN TGB_CATEGORY USING(TGB_CATEGORY_NO) \
//				JOIN WISHLIST USING(TGB_NO) LEFT JOIN (SELECT * FROM ATTACHMENT WHERE FILE_NO IN(SELECT MIN(FILE_NO) FROM ATTACHMENT \
//				WHERE TYPE LIKE 'TGB' AND ATTACHMENT.STATUS='Y' GROUP BY B_NO)) ON TGB_NO = B_NO WHERE  TGB.STATUS = 'Y' AND USER_NO=? \
//				ORDER BY TGB_NO DESC)A) WHERE RNUM BETWEEN ? AND ?
		try { 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNo);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rset = pstmt.executeQuery();

			while(rset.next()) {
				list.add(new Tgb(rset.getInt("TGB_NO"),
						rset.getString("TGB_CATEGORY_NO"),
						rset.getString("TGB_TITLE"), 
						rset.getInt("TGB_COUNT"), 
						rset.getDate("TGB_TERM"), 
						rset.getInt("TGB_PRICE"), 
						rset.getDate("CREATE_DATE"),
						rset.getString("CHANGE_NAME")));
				
			} 
			System.out.println(list);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}	
		
		return list;
	}
	
	public ArrayList<Tgb> myjoinList(Connection conn, PageInfo pi, int userNo) {
		//myJoinList=SELECT * FROM ( SELECT ROWNUM RNUM, A.* FROM(SELECT TGB_NO, TGB_CATEGORY_NO, TGB_CATEGORY_NAME, \
//		TGB_TITLE, TGB_COUNT, TGB_TERM, TGB_PRICE, CREATE_DATE, CHANGE_NAME FROM TGB LEFT JOIN TGB_CATEGORY USING(TGB_CATEGORY_NO) \
//		JOIN PAY USING(TGB_NO) LEFT JOIN (SELECT * FROM ATTACHMENT WHERE FILE_NO IN(SELECT MIN(FILE_NO) FROM ATTACHMENT \
//		WHERE TYPE LIKE 'TGB' AND ATTACHMENT.STATUS='Y' GROUP BY B_NO)) ON TGB_NO = B_NO WHERE  TGB.STATUS = 'Y' AND USER_NO=? \
//		ORDER BY TGB_NO DESC)A) WHERE RNUM BETWEEN ? AND ?
		ArrayList<Tgb> joinList = new ArrayList<Tgb>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("myJoinList");
		
		int startRow = (pi.getCurrentPage() -1)*pi.getBoardLimit()+1;
		int endRow = startRow+pi.getBoardLimit() -1;
		
		try { 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNo);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rset = pstmt.executeQuery();

			while(rset.next()) {
				joinList.add(new Tgb(rset.getInt("TGB_NO"),
						rset.getString("TGB_CATEGORY_NO"),
						rset.getString("TGB_TITLE"), 
						rset.getInt("TGB_COUNT"), 
						rset.getDate("TGB_TERM"), 
						rset.getInt("TGB_PRICE"), 
						rset.getDate("CREATE_DATE"),
						rset.getString("CHANGE_NAME")));
				
			} 

			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}	
		
		return joinList;
	}
	
	public ArrayList<Tgb> myFinishList(Connection conn, PageInfo pi, int userNo) {
//		myFinishList=SELECT  * FROM ( SELECT ROWNUM RNUM, A.* FROM(SELECT TGB_NO, TGB_CATEGORY_NO, TGB_CATEGORY_NAME, \
//		TGB_TITLE, TGB_COUNT, TGB_TERM, TGB_PRICE, CREATE_DATE, CHANGE_NAME FROM TGB LEFT JOIN TGB_CATEGORY USING(TGB_CATEGORY_NO) \
//		JOIN MEMBER ON TGB_WRITER=USER_NO LEFT JOIN (SELECT * FROM ATTACHMENT WHERE FILE_NO IN(SELECT MIN(FILE_NO) FROM ATTACHMENT \
//		WHERE TYPE LIKE 'TGB' AND ATTACHMENT.STATUS='Y' GROUP BY B_NO)) ON TGB_NO = B_NO WHERE  TGB.STATUS = 'YN' AND USER_NO=? \
//		ORDER BY TGB_NO DESC)A) \
//		UNION \
//		SELECT * FROM ( SELECT ROWNUM RNUM, A.* FROM(SELECT TGB_NO, TGB_CATEGORY_NO, TGB_CATEGORY_NAME, \
//		TGB_TITLE, TGB_COUNT, TGB_TERM, TGB_PRICE, CREATE_DATE, CHANGE_NAME FROM TGB LEFT JOIN TGB_CATEGORY USING(TGB_CATEGORY_NO) \
//		JOIN PAY USING(TGB_NO) LEFT JOIN (SELECT * FROM ATTACHMENT WHERE FILE_NO IN(SELECT MIN(FILE_NO) FROM ATTACHMENT \
//		WHERE TYPE LIKE 'TGB' AND ATTACHMENT.STATUS='Y' GROUP BY B_NO)) ON TGB_NO = B_NO WHERE  TGB.STATUS = 'YN' AND USER_NO=? \
//		ORDER BY TGB_NO DESC)A)WHERE RNUM BETWEEN ? AND ?;
		ArrayList<Tgb> finishList = new ArrayList<Tgb>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("myFinishList");
		
		int startRow = (pi.getCurrentPage() -1)*pi.getBoardLimit()+1;
		int endRow = startRow+pi.getBoardLimit() -1;
		
		try { 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNo);
			pstmt.setInt(2, userNo);
			pstmt.setInt(3, startRow);
			pstmt.setInt(4, endRow);
			
			rset = pstmt.executeQuery();

			while(rset.next()) {
				finishList.add(new Tgb(rset.getInt("TGB_NO"),
						rset.getString("TGB_CATEGORY_NO"),
						rset.getString("TGB_TITLE"), 
						rset.getInt("TGB_COUNT"), 
						rset.getDate("TGB_TERM"), 
						rset.getInt("TGB_PRICE"), 
						rset.getDate("CREATE_DATE"),
						rset.getString("CHANGE_NAME")));
				
			} 
			System.out.println(finishList);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}	
		
		return finishList;
	}

	public int ingCount(Connection conn, int userNo) {
		int ingCount = 0;
		//ingCount=SELECT COUNT(*) FROM TGB JOIN MEMBER ON TGB_WRITER = USER_NO WHERE USER_NO = ?
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("ingCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				ingCount = rset.getInt(1);
				
			}
			System.out.println("dao에서 가져옴" + ingCount);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return ingCount;
	}

	public int payCount(Connection conn, int userNo) {
		int payCount = 0;
		//payCount=SELECT COUNT(*) FROM PAY JOIN MEMBER USING(USER_NO) WHERE USER_NO = ?
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("payCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				payCount = rset.getInt(1);
				
			}
			System.out.println("dao에서 가져옴" + payCount);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return payCount;
	}

	public int qnaCount(Connection conn, int userNo) {
		int qnaCount = 0;
		//qnaCount=SELECT COUNT(*) FROM QNA_BOARD JOIN MEMBER ON QNA_WRITER = USER_NO WHERE USER_NO = ?
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("qnaCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				qnaCount = rset.getInt(1);
				
			}
			System.out.println("dao에서 가져옴" + qnaCount);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return qnaCount;
	}

	

}
