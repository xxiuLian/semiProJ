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
import com.uni.notice.model.dto.NoticeDto;
import com.uni.notice.model.service.NoticeService;

/**
 * Servlet implementation class BoardTGBDeleteServlet
 */
@WebServlet("/deleteBoardTGB.do")
public class BoardTGBDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardTGBDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int nno = Integer.parseInt(request.getParameter("nno"));
		
		int result = new BoardTGB_service().deleteBoardTGB(nno);
		
		if(result > 0) {
			request.getSession().setAttribute("msg", "삭제성공");
			
			response.sendRedirect("boardTGBList.do");
			
		}else {
			request.getSession().setAttribute("msg", "실패");
			
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
