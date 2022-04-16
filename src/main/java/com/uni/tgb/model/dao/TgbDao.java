package com.uni.tgb.model.dao;

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

import com.uni.admin.model.dto.Category;
import com.uni.common.Attachment;
import com.uni.common.PageInfo;
import com.uni.member.model.dto.Member;
import com.uni.tgb.model.dto.Tgb;


public class TgbDao {
	private Properties prop = new Properties();
	
	public TgbDao() {

		String fileName = TgbDao.class.getResource("/sql/TGB_choi/TGB-query.properties").getPath();
		System.out.println("fileName   " + fileName);
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	}

	public ArrayList<Tgb> selectList(Connection conn, PageInfo pi) {//현재페이지/1페이지 공구 글 목록 조회해오는 메소드
		ArrayList<Tgb> list = new ArrayList<>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectList");
		
		int startRow = (pi.getCurrentPage() -1)*pi.getBoardLimit()+1;
		int endRow = startRow+pi.getBoardLimit() -1;
//tgbselectlist=SELECT * FROM (SELECT ROWNUM RNUM, A.* FROM(SELECT TGB_NO, TGB_CATEGORY_NAME, TGB_TITLE, USER_ID, TGB_COUNT, TGB_TERM, TGB_PRICE, CREATE_DATE, CHANGE_NAME \
//FROM TGB JOIN MEMBER ON TGB_WRITER=USER_NO JOIN TGB_CATEGORY USING(TGB_CATEGORY_NO) JOIN (SELECT * FROM ATTACHMENT \
//WHERE FILE_NO IN(SELECT MIN(FILE_NO) FROM ATTACHMENT WHERE TYPE LIKE 'TGB' GROUP BY B_NO)) ON TGB_NO = B_NO \
//WHERE STATUS = 'Y' ORDER BY TGB_NO DESC)A) WHERE RNUM BETWEEN ? AND ?
		
		try { 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();

			while(rset.next()) {
				list.add(new Tgb(rset.getInt("TGB_NO"),
								rset.getString("TGB_CATEGORY_NAME"),
								rset.getString("TGB_TITLE"), 
								rset.getString("USER_ID"), 
								rset.getInt("TGB_COUNT"), 
								rset.getDate("TGB_TERM"), 
								rset.getString("TGB_PRICE"), 
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
		
		
		
		return list;
	}

	public int insertTgb(Connection conn, Tgb t) {//공구 글 등록하는 메소드
		
		
		int result = 0;
		//tgbInsert=INSERT INTO TGB VALUES
		//(SEQ.TGB.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, DEFAULT)

//		TGB_CATEGORY_NO
//		TGB_TITLE
//		TGB_CONTENT
//		TGB_GUIDE
//		TGB_WRITER
//		TGB_COUNT
//		TGB_TERM
//		TGB_PRICE
//		CREATE_DATE
//		STATUS
		
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertTgb");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(t.getTgbCategory()));
			pstmt.setString(2, t.getTgbTitle());
			pstmt.setString(3, t.getTgbContent());
			pstmt.setString(4, t.getTgbGuide());
			pstmt.setInt(5, Integer.parseInt(t.getTgbWriter()));
			pstmt.setInt(6, t.getCount());
			pstmt.setDate(7, t.getTgbTerm());
			pstmt.setInt(8, t.getTgb_Price());
			
			result = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}

		return result;
	}

	public int insertAttachment(Connection conn, ArrayList<Attachment> fileList) {//공구 글 등록할 때, 첨부파일 등록하는 메소드
		//insertAttachment=INSERT INTO ATTACHMENT VALUES(SEQ_ANO.NEXTVAL, ?, ?, ?, SYSDATE, DEFAULT, SEQ_TGB.CURRVAL, ?)
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertAttachment");
		
		try {
			for(Attachment f : fileList) {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, f.getOriginName());
			pstmt.setString(2, f.getChangeName());
			pstmt.setString(3, f.getFilePath());
			pstmt.setString(4, f.getType());
			
			result = pstmt.executeUpdate();
			
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		
		return result;
	}

	public int getlistCount(Connection conn) {//전체 글 갯수
		
		//listCount=SELECT COUNT(*) FROM TGB WHERE STATUS='Y'
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getlistCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				result = rset.getInt(1);
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		
		return result;
	}

	public Tgb selectTgb(Connection conn, int bno) {// 해당 번호의 글을 불러오는 메소드
		Tgb t = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
//		selectTgb=SELECT TGB_NO, TGB_CATEGORY_NAME, TGB_TITLE, TGB_CONTENT, TGB_GUIDE, USER_ID, TGB_COUNT, TGB_TERM, TGB_PRICE, CREATE_DATE, TGB.STATUS FROM TGB \
//				JOIN MEMBER ON TGB_WRITER = USER_NO JOIN TGB_CATEGORY USING(TGB_CATEGORY_NO) WHERE TGB_NO = ? AND TGB.STATUS!='N'
		String sql = prop.getProperty("selectTgb");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				t = new Tgb(rset.getInt("TGB_NO"), 
							rset.getString("TGB_CATEGORY_NAME"), 
							rset.getString("TGB_TITLE"), 
							rset.getString("TGB_CONTENT"), 
							rset.getString("TGB_GUIDE"), 
							rset.getString("USER_ID"), 
							rset.getInt("TGB_COUNT"), 
							rset.getDate("TGB_TERM"), 
							rset.getInt("TGB_PRICE"), 
							rset.getDate("CREATE_DATE"));
				
				t.setStatus(rset.getString("STATUS"));
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
			
		}
		
		
		return t;
	}

	public ArrayList<Attachment> selectAttachment(Connection conn, int bno) {// 해당 번호의 글의 첨부파일을 불러오는 메소드
		ArrayList<Attachment> list = new ArrayList<Attachment>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		//selectAttachment=SELECT * FROM ATTACHMENT WHERE B_NO = ? AND TYPE LIKE ?
		String sql = prop.getProperty("selectAttachment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			pstmt.setString(2, "TGB");
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
//				System.out.println("Dao에서 rset 담는다");
//				System.out.println(rset.getString("ORIGIN_NAME"));
				Attachment a = new Attachment();
				a.setOriginName(rset.getString("ORIGIN_NAME"));
				a.setChangeName(rset.getString("CHANGE_NAME"));
				a.setFilePath(rset.getString("FILE_PATH"));
				a.setFileNo(rset.getInt("FILE_NO"));
				
				list.add(a);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
	
		
		return list;
	}

	public int deleteTgb(Connection conn, int bno) {//해당 번호 글을 삭제하는 메소드
		//deleteTgb=UPDATE TGB SET STATUS='N'WHERE TGB_NO=?
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteTgb");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}
	public int deleteTgbAttachment(Connection conn, int bno) {//해당 번호 글의 첨부파일을 삭제하는 메소드
		//deleteTgbAttachment=UPDATE ATTACHMENT SET STATUS='N'WHERE B_NO=? AND TYPE LIKE 'TGB'
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteTgbAttachment");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}


	public int updateAttachment(Connection conn, String[] fno) {//글 수정할 때 선택된 첨부파일을 먼저 지우는 메소드 지울 파일번호를 배열로 받는다 
		int result = 0;
		PreparedStatement pstmt = null;
		//deleteAttachment=UPDATE ATTACHMENT SET STATUS=N WHERE FILE_NO=?
		String sql = prop.getProperty("deleteAttachment");
		System.out.println("다오에서 fno 0qjs"+fno[0]);
		
			
			try {
				
				for(String no : fno) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, no);
				
				result += pstmt.executeUpdate();
				
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
			close(pstmt);
		}
	
		return result;
	}

	public ArrayList<Tgb> searchTgb(Connection conn, PageInfo pi, String keyword) {//현재 페이지와 키워드를 가지고 검색하는 메소드<- 페이징 검사 안해봤음
		ArrayList<Tgb> list = new ArrayList<>();
		String k = "%"+keyword+"%";
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int startRow = (pi.getCurrentPage() -1)*pi.getBoardLimit()+1;
		int endRow = startRow+pi.getBoardLimit() -1;
		//searchTgb=SELECT * FROM ( SELECT ROWNUM RNUM, A.* FROM(SELECT TGB_NO, TGB_CATEGORY_NAME, TGB_TITLE, USER_ID, TGB_COUNT, \
//		TGB_TERM, TGB_PRICE, CREATE_DATE, CHANGE_NAME FROM TGB JOIN MEMBER ON TGB_WRITER=USER_NO LEFT JOIN TGB_CATEGORY USING(TGB_CATEGORY_NO) \
//		LEFT JOIN (SELECT * FROM ATTACHMENT WHERE FILE_NO IN(SELECT MIN(FILE_NO) FROM ATTACHMENT WHERE TYPE LIKE 'TGB' \
//		#AND ATTACHMENT.STATUS='Y' GROUP BY B_NO)) ON TGB_NO = B_NO WHERE  TGB.STATUS = 'Y' AND TGB_TITLE LIKE ? OR TGB_CONTENT LIKE ? \
//		OR TGB_GUIDE LIKE ?  ORDER BY TGB_NO DESC)A) WHERE RNUM BETWEEN ? AND ?
		String sql = prop.getProperty("searchTgb");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, k);
			pstmt.setString(2, k);
			pstmt.setString(3, k);
			pstmt.setInt(4, startRow);
			pstmt.setInt(5, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(new Tgb(rset.getInt("TGB_NO"),
						rset.getString("TGB_CATEGORY_NAME"),
						rset.getString("TGB_TITLE"), 
						rset.getString("USER_ID"), 
						rset.getInt("TGB_COUNT"), 
						rset.getDate("TGB_TERM"), 
						rset.getString("TGB_PRICE"), 
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

		
		return list;
	}

	public int deleteTgb(Connection conn, int[] bno) {//권오선
		//deleteTgb=UPDATE TGB SET STATUS='N'WHERE TGB_NO=?

		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteTgb");
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			if(bno != null) {
				for(int i = 0; i < bno.length; i++) {
					pstmt.setInt(1, bno[i]);
					result += pstmt.executeUpdate();
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}
	
	public int deleteTgbAttachment(Connection conn, int[] bno) {//권오선
		//deleteTgbAttachment=UPDATE ATTACHMENT SET STATUS='N'WHERE B_NO=? AND TYPE LIKE 'TGB'
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteTgbAttachment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			if(bno != null) {
				for(int i = 0; i < bno.length; i++) {
					pstmt.setInt(1, bno[i]);
					result += pstmt.executeUpdate();
				}
			}
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	public int insertWishList(Connection conn, int userNo, int tgbNo) {//찜하기
		//insertWishList=INSERT INTO WISHLIST VALUES(?, ?)
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertWishList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNo);
			pstmt.setInt(2, tgbNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	public int selectWish(Connection conn, int userNo, int bno) {// 글 상세조회할때 찜한 내역 들고 오기
		int result = 0;
		PreparedStatement pstmt =null;
		ResultSet rset = null;
//		/selectWish=SELECT COUNT(*) FROM WISHLIST WHERE USER_NO = ? AND TGB_NO = ?
		String sql = prop.getProperty("selectWish");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNo);
			pstmt.setInt(2, bno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				result = rset.getInt(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		
		return result;
	}

	public int deleteWishList(Connection conn, int userNo, int tgbNo) {//찜한 내역 지우기
		//deleteWishList=DELETE FROM WISHLIST WHERE USER_NO = ? AND TGB_NO = ?
				int result = 0;
				PreparedStatement pstmt = null;
				String sql = prop.getProperty("deleteWishList");
				
				try {
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, userNo);
					pstmt.setInt(2, tgbNo);
					
					result = pstmt.executeUpdate();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}finally {
					close(pstmt);
				}
				
				return result;
	}

	public ArrayList<Tgb> wishList(Connection conn, PageInfo pi, int userNO) {//마이페이지 찜목록
//		wishList=SELECT * FROM ( SELECT ROWNUM RNUM, A.* FROM(SELECT TGB_NO, TGB_CATEGORY_NO, \
//		TGB_TITLE, TGB_COUNT, TGB_TERM, TGB_PRICE, CREATE_DATE, CHANGE_NAME FROM TGB LEFT JOIN TGB_CATEGORY USING(TGB_CATEGORY_NO) \
//		JOIN WISHLIST USING(TGB_NO) LEFT JOIN (SELECT * FROM ATTACHMENT WHERE FILE_NO IN(SELECT MIN(FILE_NO) FROM ATTACHMENT \
//		WHERE TYPE LIKE 'TGB' AND ATTACHMENT.STATUS='Y' GROUP BY B_NO)) ON TGB_NO = B_NO WHERE  TGB.STATUS = 'Y' AND WISHLIST.USER_NO=? \
//		ORDER BY TGB_NO DESC)A) WHERE RNUM BETWEEN ? AND ?
		

		ArrayList<Tgb> list = new ArrayList<Tgb>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		int startRow = (pi.getCurrentPage() -1)*pi.getBoardLimit()+1;
		int endRow = startRow+pi.getBoardLimit() -1;
		
		String sql = prop.getProperty("wishList");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNO);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rset=pstmt.executeQuery();
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
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		
		return list;
	}

	public int getSearchinglistCount(Connection conn, String keyword) {// 검색 페이징바할 때 전체 글 수 불러오는 메소드
			//getSearchinglistCount=SELECT COUNT(*) FROM TGB WHERE STATUS='Y' AND (TGB_TITLE LIKE ? OR TGB_CONTENT LIKE ? OR TGB_GUIDE LIKE ?)
				int result = 0;
				String k = "%"+keyword+"%";
				PreparedStatement pstmt = null;
				ResultSet rset = null;
				
				String sql = prop.getProperty("getSearchinglistCount");
				
				try {
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, k);
					pstmt.setString(2, k);
					pstmt.setString(3, k);
					
					rset = pstmt.executeQuery();
					
					if(rset.next()) {
						result = rset.getInt(1);
					}
					
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}finally {
					close(rset);
					close(pstmt);
				}
				
				
				return result;
	}

	public int getWishListlistCount(Connection conn, int userNo) {//찜목록 페이징바 전체 글수
//		getWishListlistCount=SELECT COUNT(*) FROM WISHLIST WHERE USER_NO=?
		int result = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("getWishListlistCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNo );
		
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				result = rset.getInt(1);
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		
		return result;
	}

	public ArrayList<Category> getCategory(Connection conn) {//마이페이지 찜목록 내역에 카테고리 가져오기
		ArrayList<Category> list = new ArrayList<Category>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getCategory");
		//getCategory=SELECT * FROM TGB_CATEGORY
		try {
			pstmt = conn.prepareStatement(sql);
			
			rset = pstmt.executeQuery();
//			TGB_CATEGORY_NO	NUMBER
//			TGB_CATEGORY_NAME	VARCHAR2(30 BYTE)
			
			while(rset.next()) {
				list.add(new Category(rset.getInt("TGB_CATEGORY_NO"), rset.getString("TGB_CATEGORY_NAME")));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public int deleteWishList(Connection conn, int user, String[] arr) {//찜목록 지우기
		//deleteWishList=DELETE FROM WISHLIST WHERE USER_NO = ? AND TGB_NO = ?
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteWishList");
		
		try {
			
		for(int i =0; i<arr.length; i++) {
			
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, user);
			pstmt.setInt(2, Integer.parseInt(arr[i]));
			
			result += pstmt.executeUpdate();
		
		}
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
	
		return result;
	}

	public String selectThumbnail(Connection conn, int tgbNo) {//권오선
		String thumbnail = null;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
//		selectThumbnail=SELECT TGB_NO, CHANGE_NAME
//		FROM TGB JOIN MEMBER ON TGB_WRITER=USER_NO JOIN TGB_CATEGORY USING(TGB_CATEGORY_NO) JOIN (SELECT * FROM ATTACHMENT 
//		WHERE FILE_NO IN(SELECT MIN(FILE_NO) FROM ATTACHMENT WHERE TYPE LIKE 'TGB' GROUP BY B_NO)) ON TGB_NO = B_NO 
//		WHERE STATUS = 'Y' AND TGB_NO=?
		String sql = prop.getProperty("selectThumbnail");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, tgbNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				thumbnail = rset.getString("CHANGE_NAME");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
	
		
		return thumbnail;
	}

	public int currentCount(Connection conn, int tno) {
		//currentCount=SELECT COUNT(*) FROM PAY WHERE TGB_NO = ?
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("currentCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, tno);
			
			rset = pstmt.executeQuery();
			if(rset.next()) {
				result = rset.getInt(1);
				
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		
		
		
		return result;
	}

	public Member searchById(Connection conn, String userId) {
		//searchById=SELECT * FROM MEMBER WHERE USER_ID LIKE ?
		Member m = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("searchById");
		
		try {
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			
			rset = pstmt.executeQuery();
	
			
			if(rset.next()) {
				m=new Member();
				m.setUserId(rset.getString("USER_ID"));
				m.setPhone(rset.getString("PHONE"));
				m.setEmail(rset.getString("EMAIL"));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		
		
		
		return m;
	}

	public int countTgbById(Connection conn, int userNo) {
		//countTgbById=SELECT COUNT(*) FROM TGB JOIN MEMBER ON TGB_WRITER = USER_NO WHERE USER_ID LIKE ?

		int result=0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("countTgbById");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				result = rset.getInt(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return result;
	}

	public int updateStatus(Connection conn, int tno) {
		// updateStatus=UPDATE TGB SET STATUS='YN'WHERE TGB_NO=?
		int result=0;
		
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateStatus");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, tno);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		

		return result;
	}

	public int updateAt(Connection conn, Attachment at, String tno) {
		int result=0;
		PreparedStatement pstmt = null;
		
		//updateAt=SET ORIGIN_NAME = ?, CHANGE_NAME= ?, FILE_PATH=? WHERE 
		//FILE_NO = (SELECT MIN(FILE_NO) FROM ATTACHMENT WHERE B_NO = ? AND TYPE LIKE 'TGB')
		String sql = prop.getProperty("updateAt");
		
		try {

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, at.getOriginName());
			pstmt.setString(2, at.getChangeName());
			pstmt.setString(3, at.getFilePath());
			pstmt.setInt(4, Integer.parseInt(tno));
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}

		
		return result;
	}

	public int updateTgb(Connection conn, Tgb t) {
		int result=0;
		PreparedStatement pstmt = null;
		//updateTgb=UPDATE TGB SET TGB_CATEGORY_NO = ?, TGB_TITLE=?, 
		//TGB_CONTENT=?, TGB_GUIDE=?,TGB_COUNT=?, TGB_TERM=?,TGB_PRICE=? WHERE TGB_NO = ?
		String sql = prop.getProperty("updateTgb");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(t.getTgbCategory()));
			pstmt.setString(2, t.getTgbTitle());
			pstmt.setString(3, t.getTgbContent());
			pstmt.setString(4, t.getTgbGuide());
			pstmt.setInt(5, t.getCount());
			pstmt.setDate(6, t.getTgbTerm());
			pstmt.setInt(7, t.getTgb_Price());
			pstmt.setInt(8, t.getTgbNo());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		
		return result;
	}

	public int updateAtList(Connection conn, ArrayList<Attachment> fileList, String tno) {
		//insertAttachment=INSERT INTO ATTACHMENT VALUES(SEQ_ANO.NEXTVAL, ?, ?, ?, SYSDATE, DEFAULT, SEQ_TGB.CURRVAL, ?)
		//updateAtList=INSERT INTO ATTACHMENT VALUES(SEQ_ANO.NEXTVAL, ?, ?, ?, SYSDATE, DEFAULT, ?, ?)

				int result = 1;
				
				PreparedStatement pstmt = null;
				String sql = prop.getProperty("updateAtList");
				
				try {
					for(Attachment f : fileList) {
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, f.getOriginName());
					pstmt.setString(2, f.getChangeName());
					pstmt.setString(3, f.getFilePath());
					pstmt.setInt(4, Integer.parseInt(tno));
					pstmt.setString(5, f.getType());
					System.out.println("머가 invalid 넘버인데 "+tno);
					result = pstmt.executeUpdate();
					
					}
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}finally {
					close(pstmt);
				}
				
				
				return result;
			}

	public Tgb enterTgb(Connection conn, int tno) {
		Tgb t = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
//		enterTgb=SELECT TGB_NO, TGB_CATEGORY_NAME, TGB_TITLE, TGB_CONTENT, TGB_GUIDE, USER_ID, TGB_COUNT, TGB_TERM, TGB_PRICE, CREATE_DATE, CHANGE_NAME \
//		FROM TGB JOIN MEMBER ON TGB_WRITER = USER_NO JOIN TGB_CATEGORY USING(TGB_CATEGORY_NO) JOIN (SELECT * FROM ATTACHMENT WHERE FILE_NO IN( \
//				SELECT MIN(FILE_NO) FROM ATTACHMENT WHERE TYPE LIKE 'TGB' GROUP BY B_NO)) ON B_NO= TGB_NO WHERE TGB_NO = ?
		String sql = prop.getProperty("enterTgb");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, tno);
			
			rset = pstmt.executeQuery();
			System.out.println(sql);
			
			if(rset.next()) {
				t = new Tgb(rset.getInt("TGB_NO"), 
							rset.getString("TGB_CATEGORY_NAME"), 
							rset.getString("TGB_TITLE"), 
							rset.getString("TGB_CONTENT"), 
							rset.getString("TGB_GUIDE"), 
							rset.getString("USER_ID"), 
							rset.getInt("TGB_COUNT"), 
							rset.getDate("TGB_TERM"), 
							rset.getString("TGB_PRICE"), 
							rset.getDate("CREATE_DATE"));
				
			
				t.setThumnail(rset.getString("CHANGE_NAME"));
				
			}
			System.out.println("다오에서 썸네일 : "+t.getThumnail());
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
			
		}
		
		
		return t;
	}



}