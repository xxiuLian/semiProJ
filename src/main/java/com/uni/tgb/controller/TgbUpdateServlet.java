package com.uni.tgb.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.tgb.model.service.TgbService;

/**
 * Servlet implementation class TgbUpdateServlet
 */
@WebServlet("/updateTgb.do")
public class TgbUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TgbUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] fno = request.getParameterValues("deletefile");
		int result = 0;
		System.out.println(fno.length);
		
		if(fno != null) {
			
			result = new TgbService().deleteAttachment(fno);  
		
			if(result == fno.length) {
				System.out.println("첨부파일 삭제 성공");
			}else {
				System.out.println("첨부파일 삭제 실패!!!");
			}
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
