package com.uni.admin.model.dao;

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
		} finally {
			close(rset);
			close(pstmt);
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
		} finally {
			close(rset);
			close(pstmt);
		}
		return category;
	}

	public int updateQnaCategory(Connection conn, Category c, int originCno) {
		int result = 0;

		PreparedStatement pstmt = null;

		//updateQnaCategory=UPDATE QNA_CATEGORY SET QNA_CATEGORY_NO=?, QNA_CATEGORY_NAME=? WHERE QNA_CATEGORY_NO=?
		String sql = prop.getProperty("updateQnaCategory");

		try {
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
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int insertQnaCategory(Connection conn, Category c) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		//insertQnaCategory=INSERT INTO QNA_CATEGORY VALUES(?, ?)
		String sql = prop.getProperty("insertQnaCategory");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, c.getCategoryNo());
			pstmt.setString(2, c.getCategoryName());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public ArrayList<Category> selectTGBCategoryList(Connection conn) {
		ArrayList<Category> category = new ArrayList<Category>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		//selectTGBCategoryList=SELECT * FROM TGB_CATEGORY
		String sql = prop.getProperty("selectTGBCategoryList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Category c = new Category(rset.getInt("TGB_CATEGORY_NO"), rset.getString("TGB_CATEGORY_NAME"));
				
				category.add(c);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return category;
	}

	public ArrayList<Category> selectBoardCategoryList(Connection conn) {
		ArrayList<Category> category = new ArrayList<Category>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		//selectBoardCategoryList=SELECT * FROM BOARD_CATEGORY
		String sql = prop.getProperty("selectBoardCategoryList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Category c = new Category(rset.getInt("BOARD_CATEGORY_NO"), rset.getString("BOARD_CATEGORY_NAME"));
				
				category.add(c);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return category;
	}

	public int insertTGBCategory(Connection conn, Category c) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		//insertTGBCategory=INSERT INTO TGB_CATEGORY VALUES(?, ?)
		String sql = prop.getProperty("insertTGBCategory");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, c.getCategoryNo());
			pstmt.setString(2, c.getCategoryName());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int insertBoardCategory(Connection conn, Category c) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		//insertBoardCategory=INSERT INTO BOARD_CATEGORY VALUES(?, ?)
		String sql = prop.getProperty("insertBoardCategory");
		
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
		} finally {
			close(pstmt);
		}
		return result;
	}

	public Category selectTGBCategory(Connection conn, int cno) {
		Category c = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		//selectTGBCategory=SELECT * FROM TGB_CATEGORY WHERE TGB_CATEGORY_NO=?
		String sql = prop.getProperty("selectTGBCategory");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cno);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				c = new Category(rset.getInt("TGB_CATEGORY_NO"), rset.getString("TGB_CATEGORY_NAME"));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return c;
	}

	public Category selectBoardCategory(Connection conn, int cno) {
		Category c = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		//selectBoardCategory=SELECT * FROM BOARD_CATEGORY WHERE BOARD_CATEGORY_NO=?
		String sql = prop.getProperty("selectBoardCategory");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cno);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				c = new Category(rset.getInt("BOARD_CATEGORY_NO"), rset.getString("BOARD_CATEGORY_NAME"));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return c;
	}

	public int updateTGBCategory(Connection conn, Category c, int originCno) {
		int result = 0;

		PreparedStatement pstmt = null;

		//updateTGBCategory=UPDATE TGB_CATEGORY SET TGB_CATEGORY_NO=?, TGB_CATEGORY_NAME=? WHERE TGB_CATEGORY_NO=?
		String sql = prop.getProperty("updateTGBCategory");

		try {
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
		return result;
	}

	public int updateBoardCategory(Connection conn, Category c, int originCno) {
		int result = 0;

		PreparedStatement pstmt = null;

		//updateBoardCategory=UPDATE BOARD_CATEGORY SET BOARD_CATEGORY_NO=?, BOARD_CATEGORY_NAME=? WHERE BOARD_CATEGORY_NO=?
		String sql = prop.getProperty("updateBoardCategory");

		try {
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
		return result;
	}

	public int deleteTGBCategorys(Connection conn, int[] qCaNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		//deleteTGBCategorys=DELETE TGB_CATEGORY WHERE TGB_CATEGORY_NO=?
		String sql = prop.getProperty("deleteTGBCategorys");
		
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
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int deleteBoardCategorys(Connection conn, int[] qCaNo) {
		int result = 0;
		PreparedStatement pstmt = null;

		//deleteBoardCategorys=DELETE BOARD_CATEGORY WHERE BOARD_CATEGORY_NO=?
		String sql = prop.getProperty("deleteBoardCategorys");
		
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
		} finally {
			close(pstmt);
		}
		return result;
	}


}
