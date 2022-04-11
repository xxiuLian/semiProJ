package com.uni.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.member.model.dto.Member;
import com.uni.member.model.service.MemberService;

/**
 * Servlet implementation class MyPageServlet
 */
@WebServlet("/myPage.do")
public class MyPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyPageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Member loginUser = (Member)request.getSession().getAttribute("loginUser");
		int userNo = loginUser.getUserNo();
		
		int payCount = new MemberService().payCount(userNo);
		request.setAttribute("payCount", payCount);
		System.out.println("서블릿에서 결제 카운트" + payCount);
		
		int ingCount = new MemberService().ingCount(userNo);
		request.setAttribute("ingCount", ingCount);
		System.out.println("서블릿에서 진행 카운트" + ingCount);
		
		int qnaCount = new MemberService().qnaCount(userNo);
		request.setAttribute("qnaCount", qnaCount);
		System.out.println("서블릿에서 문의 카운트" + qnaCount);
		
		request.getRequestDispatcher("views/member/myPage.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
