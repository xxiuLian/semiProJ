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
 * Servlet implementation class UpdatePwdServlet
 */
@WebServlet("/updatePwdMember.do")
public class UpdatePwdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdatePwdServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = ((Member)request.getSession().getAttribute("loginUser")).getUserId();
		//세션에서 로그인된 유저 아이디 가져오기
		String userPwd = request.getParameter("userPwd"); //기존비번
		String newPwd = request.getParameter("newPwd"); //변경할 새 비번
		String originPwd = (String)request.getAttribute("originPwd");
		
		//현재비번, 새비번, 새비번 확인창
		Member updatePwd = new MemberService().updatePwd(userId, userPwd, newPwd);
		
		if(updatePwd != null) {
			request.setAttribute("sTag", "Y"); //제대로 변경됐으면 Y
			request.setAttribute("msg", "성공적으로 비밀번호를 변경하였습니다.");
			request.getSession().setAttribute("loginUser", updatePwd);
			request.getSession().setAttribute("originPwd", originPwd);//비번도 같이 옮기기!!!
			
		}else {
			request.setAttribute("msg", "비밀번호 변경이 실패하였습니다.");
		}
		RequestDispatcher view = request.getRequestDispatcher("views/member/updatePwdForm.jsp");
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
