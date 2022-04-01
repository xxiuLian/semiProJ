package com.uni.tgb.model.dao;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.uni.tgb.model.dto.Tgb;
import static com.uni.common.JDBCTemplate.*;


public class TgbDao {
	private Properties prop = new Properties();
	
	public TgbDao() {

		String fileName = TgbDao.class.getResource("/sql/valueSa-query.properties").getPath();
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

	public ArrayList<Tgb> selectList(Connection conn) {
		ArrayList<Tgb> list = new ArrayList<>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("tgbselectlist");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();

			while(rset.next()) {
				list.add(new Tgb(rset.getInt("TGB_NO"),
								String.valueOf(rset.getInt("TGB_CATEGORY_NO")), 
								rset.getString("TGB_TITLE"), 
								rset.getString("TGB_CONTENT"), 
								rset.getString("TGB_GUIDE"), 
								String.valueOf(rset.getInt("TGB_WRITER")), 
								rset.getInt("TGB_COUNT"), 
								rset.getDate("TGB_TERM"), 
								rset.getInt("TGB_PRICE"), 
								rset.getDate("CREATE_DATE"), 
								rset.getString("STATUS")));
				
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

}
