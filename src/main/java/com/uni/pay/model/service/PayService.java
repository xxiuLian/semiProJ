package com.uni.pay.model.service;

import static com.uni.common.JDBCTemplate.*;

import java.sql.Connection;

import com.uni.pay.model.dao.PayDao;
import com.uni.pay.model.dto.Pay;

public class PayService {

	public int insertPay(Pay p) {
		Connection conn = getConnection();
		
		int result = new PayDao().insertPay(conn, p);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

}
