package com.uni.tgb_board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.tgb.model.service.TgbService;
import com.uni.tgb_board.model.dto.TgbBoard_dto;
import com.uni.tgb_board.model.dto.TgbBoard_pageInfo;
import com.uni.tgb_board.model.service.TGBBoard_service;


/**
 * Servlet implementation class tgbBoardListServlet
 */
@WebServlet("/tgbBoardSelect.do")
public class TgbBoard_listServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TgbBoard_listServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
		int listStart = 0; //글번호(한 페이지 내에 게시글 시작)
		int listEnd = 0;//글번호(한 페이지 내에 게시글 끝)
		int listPageCount = 10; //한 페이지 내의 글 수
		int listCount= 0 ; //총 글 수
		int barStart = 1; //페이징바
		int barEnd = 0; //페이징바
		int barCount = 5; //페이징바 5개
		int currentPage = 1; //현재 페이지
		
		
		
		//파라미터 값에 따라서 페이지 변경
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		barEnd = currentPage + 4 ;
		barStart = barEnd - 4 ;
				
		//게시글 처음~끝 : a+(n-1)d && 존재하는 글만
		//존재하는 글
		//listStart =  1 + (currentPage-1) * 10;
		//listEnd = 10 + (currentPage-1) * 10;
		
		//총 글 수
		listCount = new TGBBoard_service().getTgbBoard_listCount();
		
		//게시글 목록
		ArrayList<TgbBoard_dto> list = new TGBBoard_service().getBoardList(currentPage, listPageCount);
		
		//pi 생성자로 생성
		TgbBoard_pageInfo pi = new TgbBoard_pageInfo(listStart, listEnd, listCount, currentPage, barStart, barEnd, barCount);
		
		
		request.setAttribute("list", list);
		request.setAttribute("pi", pi);

		RequestDispatcher view = request.getRequestDispatcher("views/tgbBoard/tgbBoardListView.jsp");
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
