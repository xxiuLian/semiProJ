package com.uni.admin.controller;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.member.model.service.MemberService;

/**
 * Servlet implementation class AdminDeleteMemberServlet
 */
@WebServlet("/deleteMembers.do")
public class MemberDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] strUserNo = request.getParameterValues("memberChecked");

		//String배열을 int 배열로 바로 변환
		int[] userNo = Arrays.stream(strUserNo).mapToInt(Integer::parseInt).toArray();
		
		int result = new MemberService().deleteMembers(userNo);
		
		if(result > 0) {
			request.getSession().setAttribute("msg", "회원 탈퇴 성공");
			response.sendRedirect("adminMember.do");
		}else {
			request.setAttribute("msg", "회원 탈퇴 실패");
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
