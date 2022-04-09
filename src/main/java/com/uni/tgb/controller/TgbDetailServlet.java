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
		
		Tgb t = new TgbService().selectTgb(bno);// 해당 번호의 글을 불러오는 메소드
		ArrayList<Attachment> aList = new TgbService().selectAttachment(bno); // 해당 번호의 글의 첨부파일을 불러오는 메소드
		System.out.println("t : "+ t);
		
		t.setTgbContent(t.getTgbContent().replaceAll("\n", "<br>"));
		t.setTgbGuide(t.getTgbGuide().replaceAll("\n", "<br>"));
		
		
		
		
		if(t != null && aList != null) {
			request.setAttribute("t", t);
			request.setAttribute("aList", aList);
			
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
