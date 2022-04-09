package com.uni.admin.service;
import static com.uni.common.JDBCTemplate.close;
import static com.uni.common.JDBCTemplate.commit;
import static com.uni.common.JDBCTemplate.getConnection;
import static com.uni.common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import com.uni.admin.dao.AdminDao;
import com.uni.admin.dto.Category;
public class AdminService {

	public Category selectQnaCategory(int cno) {
		Connection conn = getConnection();

		Category c = new AdminDao().selectQnaCategory(conn, cno);
		close(conn);
		
		return c;
	}
	
	public ArrayList<Category> selectQnaCategoryList() {
		Connection conn = getConnection();
		
		ArrayList<Category> category = new AdminDao().selectQnaCategoryList(conn);
		
		close(conn);
		
		return category;
	}

	public int updateCategory(Category c, int originCno) {
		Connection conn = getConnection();
		
		int result = new AdminDao().updateCategory(conn, c, originCno);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

	public int deleteQnaCategorys(int[] qCaNo) {
		Connection conn = getConnection();
		
		int result = new AdminDao().deleteQnaCategorys(conn, qCaNo);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}

	public int insertQnaCategory(Category c) {
		Connection conn = getConnection();
		
		int result = new AdminDao().insertQnaCategory(conn, c);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}
}
