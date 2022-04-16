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
 * Servlet implementation class MemberInsertServlet
 */
@WebServlet("/insertMember.do")
public class MemberInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//insert
		String userName = request.getParameter("userName");
		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("userPwd");
		String phone = request.getParameter("phone");
		String account = request.getParameter("account");
		int post = Integer.parseInt(request.getParameter("post"));
		String address1 = request.getParameter("address1");
		String address2 = request.getParameter("address2");
		String email = request.getParameter("email");
		String bank = request.getParameter("bank");
	
		System.out.println(bank);
		
		//dto Member 매개변수 생성자 O
		Member member = new Member(userId, userPwd, userName, phone, email, account, bank, post, address1, address2);
		int result = new MemberService().insertMember(member);

		//insert 성공
		if(result > 0) { //회원가입이 성공했다면 성공했다는 jsp페이지로 이동
			request.getRequestDispatcher("views/member/insertComplete.jsp").forward(request, response);
		}else {
			request.setAttribute("msg", "회원가입 실패. 관리자에게 문의해주세요");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
			
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
