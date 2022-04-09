package com.uni.admin.dao;

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

import com.uni.admin.dto.Category;

public class AdminDao {
	private Properties prop = new Properties();

	public AdminDao() {
		String fileName = AdminDao.class.getResource("/sql/admin_kwon/admin-query.properties").getPath();
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
	
	public Category selectQnaCategory(Connection conn, int cno) {
		Category c = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		//selectQnaCategory=SELECT * FROM QNA_CATEGORY WHERE QNA_CATEGORY_NO=?
		String sql = prop.getProperty("selectQnaCategory");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cno);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				c = new Category(rset.getInt("QNA_CATEGORY_NO"), rset.getString("QNA_CATEGORY_NAME"));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return c;
	}
	
	public ArrayList<Category> selectQnaCategoryList(Connection conn) {
		ArrayList<Category> category = new ArrayList<Category>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		//selectQnaCategoryList=SELECT * FROM QNA_CATEGORY
		String sql = prop.getProperty("selectQnaCategoryList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Category c = new Category(rset.getInt("QNA_CATEGORY_NO"), rset.getString("QNA_CATEGORY_NAME"));
				
				category.add(c);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return category;
	}

	public int updateCategory(Connection conn, Category c, int originCno) {
		int result = 0;

		PreparedStatement pstmt = null;

		//updateQnaCategory=UPDATE QNA_CATEGORY SET QNA_CATEGORY_NO=?, QNA_CATEGORY_NAME=? WHERE QNA_CATEGORY_NO=?
		String sql = prop.getProperty("updateQnaCategory");

		try {
			System.out.println("바꾸는 번호 : " + c.getCategoryNo());
			System.out.println("바꾸는 이름 : " + c.getCategoryName());
			System.out.println("원래 번호 : " + originCno);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, c.getCategoryNo());
			pstmt.setString(2, c.getCategoryName());
			pstmt.setInt(3, originCno);

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		System.out.println("리턴 전 확인");
		return result;
	}

	public int deleteQnaCategorys(Connection conn, int[] qCaNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		//deleteQnaCategorys=DELETE QNA_CATEGORY WHERE QNA_CATEGORY_NO=?
		String sql = prop.getProperty("deleteQnaCategorys");
		
		try {
			pstmt = conn.prepareStatement(sql);
			if(qCaNo != null) {
				for(int i = 0; i < qCaNo.length; i++) {
					pstmt.setInt(1, qCaNo[i]);
					result += pstmt.executeUpdate();
				}
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	public int insertQnaCategory(Connection conn, Category c) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		//insertQnaCategory=INSERT INTO QNA_CATEGORY VALUES(?, ?)
		String sql = prop.getProperty("insertQnaCategory");
		
		try {
			System.out.println(c.getCategoryNo());
			System.out.println(c.getCategoryName());
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, c.getCategoryNo());
			pstmt.setString(2, c.getCategoryName());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}


}
