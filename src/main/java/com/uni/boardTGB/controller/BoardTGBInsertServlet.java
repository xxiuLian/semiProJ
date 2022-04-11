package com.uni.boardTGB.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.boardTGB.model.dto.BoardTGB_dto;
import com.uni.boardTGB.model.service.BoardTGB_service;
import com.uni.member.model.dto.Member;


/**
 * Servlet implementation class boardTGBInsertServlet
 */
@WebServlet("/insertBoardTGB.do")
public class BoardTGBInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardTGBInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String writer = String.valueOf(((Member)request.getSession().getAttribute("loginUser")).getUserNo());
		int category =  Integer.parseInt(request.getParameter("category"));
		
		BoardTGB_dto n = new BoardTGB_dto(category, title, writer, content.replaceAll("\n", "<br>"));
		
		int result = new BoardTGB_service().insertBoardTGB(n);
		
		if(result > 0 ) {
			request.getSession().setAttribute("msg", "글이 등록되었습니다.");
			response.sendRedirect("boardTGBList.do");
		}else {
			request.setAttribute("msg", "등록을 실패하였습니다. ");
		
			RequestDispatcher view = request.getRequestDispatcher("views/common/errorPage.jsp");
			view.forward(request, response);
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
