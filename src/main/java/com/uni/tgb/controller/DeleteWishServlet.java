package com.uni.tgb.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.member.model.dto.Member;
import com.uni.tgb.model.service.TgbService;

/**
 * Servlet implementation class DeleteWishServlet
 */
@WebServlet("/deleteWish.do")
public class DeleteWishServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteWishServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		Member user = (Member)request.getSession().getAttribute("loginUser");
		int userNo = user.getUserNo();
		int tgbNo = Integer.parseInt(request.getParameter("tgbNo"));
		System.out.println("userNO : "+ userNo);
		System.out.println("TGBNO : "+tgbNo);
		
		int result = new TgbService().deleteWishList(userNo, tgbNo);
		
		
		boolean tf = false;
		
		if(result > 0) {
			tf = true;
		}
		
		response.getWriter().print(tf);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
