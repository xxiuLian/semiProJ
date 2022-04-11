package com.uni.pay.model.dao;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;

import com.uni.admin.dao.AdminDao;
import com.uni.pay.model.dto.Pay;

public class PayDao {
	private Properties prop = new Properties();

	public PayDao() {
		String fileName = PayDao.class.getResource("/sql/pay_kwon/pay-query.properties").getPath();
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

	public int insertPay(Connection conn, Pay p) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		//insertPay=INSERT INTO PAY VALUES(?, ?, ?, ?)
		String sql = prop.getProperty("insertPay");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p.getUserNo());
			pstmt.setInt(2, p.getTgbNo());
			pstmt.setInt(3, p.getTotPrice());
			pstmt.setInt(4, p.getAmount());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

}
