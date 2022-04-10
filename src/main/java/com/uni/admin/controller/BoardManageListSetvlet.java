package com.uni.admin.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.common.PageInfo;
import com.uni.tgb.model.dto.Tgb;
import com.uni.tgb.model.service.TgbService;
import com.uni.tgb_board.model.dto.TgbBoard_dto;
import com.uni.tgb_board.model.dto.TgbBoard_pageInfo;
import com.uni.tgb_board.model.service.TgbBoard_service;

/**
 * Servlet implementation class BoardManageListSetvlet
 */
@WebServlet("/adminBoard.do")
public class BoardManageListSetvlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardManageListSetvlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int listPageCount = 10; //한 페이지 내의 글 수
		int listCount= 0 ; //총 글 수
		int barStart = 1; //페이징바(한페이지 내에서)
		int barEnd = 0; //페이징바(한페이지 내에서)
		int barMax = 0; //페이징바 가장 마지막
		int barCount = 5; //페이징바 5개
		int currentPage = 1; //현재 페이지
			
		//파라미터 값에 따라서 페이지 변경
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		//총 글 수
		listCount = new TgbBoard_service().getTgbBoard_listCount();
		
		//게시글 목록
		ArrayList<TgbBoard_dto> list = new TgbBoard_service().getBoardList(currentPage, listPageCount);
		
		//목록 마지막
		// 총 124 한 페이지 10개 면 13개 바 개수
		barMax = listCount/listPageCount+1;
	
		// 이제 저기에 + 1 해주면, 1...2...3... 이런 식
		// => a + (n-1)d = x (등차 어쩌고 공식)
		// => 1 + (x-1)*5 => 1...6...11... 
		
		int x = 0;
		x = (currentPage - 1) / barCount + 1 ; //1...2...3...
		barStart = 1 + (x - 1) * barCount; //6...11...16...
		
		barEnd = barStart + barCount - 1;  //5...10...15...
		
		//마지막 페이지 일경우 //5...10..15(x)13(o)...
		if((barStart <= barMax) && (barMax <= barEnd)){
			System.out.println((barStart <= barMax) && (barMax <= barEnd));
			barEnd = barMax; 
		}

		//pi 생성자로 생성
		TgbBoard_pageInfo pi = new TgbBoard_pageInfo(listCount, currentPage, barStart, barEnd, barCount, listPageCount, barMax);
		
		
		request.setAttribute("list", list);
		request.setAttribute("pi", pi);

		RequestDispatcher view = request.getRequestDispatcher("views/admin/adminBoard.jsp");
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
