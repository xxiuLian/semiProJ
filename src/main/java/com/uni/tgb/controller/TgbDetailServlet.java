package com.uni.tgb.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.common.Attachment;
import com.uni.member.model.dto.Member;
import com.uni.tgb.model.dto.Tgb;
import com.uni.tgb.model.service.TgbService;

/**
 * Servlet implementation class TgbDetailServlet
 */
@WebServlet("/detailTgb.do")
public class TgbDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TgbDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bno = Integer.parseInt(request.getParameter("bno"));
		System.out.println(bno);
		String admin = request.getParameter("admin");
		Tgb t = new TgbService().detailTgb(bno);// 해당 번호의 글을 불러오는 메소드
		ArrayList<Attachment> aList = new TgbService().selectAttachment(bno); // 해당 번호의 글의 첨부파일을 불러오는 메소드
		System.out.println("t : "+ t);
		boolean wish = false;
		
		if(request.getSession().getAttribute("loginUser") != null) {//로그인 되 있으면 찜한 내역 불러오기
			
			int userNo = ((Member)request.getSession().getAttribute("loginUser")).getUserNo();
			
			int result = new TgbService().selectWish(userNo, bno);//찜한 내역 1 아니면 0 
			
			if(result == 1) {
				wish = true;
			}
			
		}
		
		
		
		
		
		
		if(t != null && aList != null) {
			request.setAttribute("t", t);
			request.setAttribute("aList", aList);
			request.setAttribute("wish", wish);
			request.setAttribute("admin", admin);
			
			request.getRequestDispatcher("views/tgb/tgbDetailView.jsp").forward(request, response);
			
		}else {
			request.setAttribute("msg", "상세조회에 실패했습니다.");
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
