package com.uni.admin.service;
import static com.uni.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import com.uni.admin.dao.AdminDao;
import com.uni.admin.dto.Category;
import com.uni.qna.model.dao.QnaDao;
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
}
