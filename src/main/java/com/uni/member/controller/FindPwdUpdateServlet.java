package com.uni.member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.member.model.dto.Member;
import com.uni.member.model.service.MemberService;

/**
 * Servlet implementation class FindPwdUpdateServlet
 */
@WebServlet("/findPwdUpdate.do")
public class FindPwdUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FindPwdUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = ((Member)request.getSession().getAttribute("loginUser")).getUserId();
		//세션에서 로그인된 유저 아이디 가져오기
		String newPwd = request.getParameter("newPwd"); //변경할 새 비번
		String originPwd = (String)request.getAttribute("originPwd");
		
		int updatePwd = new MemberService().findPwdUpdate(userId, newPwd);
		
		if(updatePwd > 0) {
			request.setAttribute("sTag", "Y"); //제대로 변경됐으면 Y
			request.setAttribute("msg", "성공적으로 비밀번호를 변경하였습니다.");

			request.getSession().setAttribute("originPwd", originPwd);//비번도 같이 옮기기!!!
			response.sendRedirect(request.getContextPath());
			
		}else {
			request.setAttribute("msg", "비밀번호 변경 실패. 관리자에게 문의하세요");
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
