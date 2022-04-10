package com.uni.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.uni.member.model.dto.Member;
import com.uni.member.model.service.MemberService;

/**
 * Servlet implementation class LoginKakaoServlet
 */
@WebServlet("/kakaoLogin.do")
public class LoginKakaoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginKakaoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		//loginForm.jsp에서 받은 data작성
        String userId = request.getParameter("userId");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        //이름이 "양수연" 이렇게 넘어오기 때문에 " 자르기
        String[] names = name.split("\"");
        String[] emails = email.split("\"");
        
        
        //회원이 있는지 확인, 있으면 로그인 없으면 회원가입
        int result = new MemberService().idCheck(userId);
        
        if(result > 0) {
        	 //있는 회원
        	Member m = new MemberService().selectMember(userId);
            session.setAttribute("loginUser", m);
            response.getWriter().append("/");
            System.out.println(m);
            response.sendRedirect(request.getContextPath());
            
        }else {
        	 //회원가입 필요
            Member mem = new Member();
            mem.setUserId(userId);
            //비번은 빈칸으로 일단..스루
            mem.setUserPwd(" ");
            //실제 이름이 저장된 인덱스
            mem.setUserName(names[1]);
            mem.setEmail(emails[1]);

            //카카오 자동 회원가입 로직 실행
            int rs = new MemberService().insertMember(mem);
            
            if(rs > 0) {
                //회원가입 했으니 로그인까지 연동
                
                //로그인
                Member mem2 = new MemberService().loginMember(userId, " ");
                
                session = request.getSession();
                session.setAttribute("loginUser", mem2);
                response.getWriter().append("/");
                response.sendRedirect(request.getContextPath());
            }else {
                System.out.println("카카오 회원가입 실패");
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
