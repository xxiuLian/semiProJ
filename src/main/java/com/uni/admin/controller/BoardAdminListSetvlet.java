package com.uni.admin.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.admin.model.dto.Category;
import com.uni.common.PageInfo;
import com.uni.tgb_board.model.dto.TgbBoard_dto;
import com.uni.tgb_board.model.dto.TgbBoard_pageInfo;
import com.uni.tgb_board.model.service.TgbBoard_service;

/**
 * Servlet implementation class BoardManageListSetvlet
 */
@WebServlet("/adminBoard.do")
public class BoardAdminListSetvlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardAdminListSetvlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//페이징시작
		int listCount; 	 //총 게시글 개수
		int currentPage; //현재페이지(요청한페이지)
		int startPage;   //현재페이지 하단에 보여지는 페이징 바의 시작 수
		int endPage; 	 //현재페이지 하단에 보여지는 페이징 바의 끝 수
		int maxPage;     //전체 페이지의 가장 마지막 페이지
		int pageLimit;   //한페이지 하단에 보여질 최대 개수
		int boardLimit;  //한페이지에 보여질 게시글 최대 개수
		//총 게시글 개수
		listCount = new TgbBoard_service().getListCount(); //
		System.out.println("listCount : " + listCount);
		//현재페이지
		currentPage = 1;
		//페이지 전환시 전달받은 페이지가 있을 경우 전달받은 페이지를 currentPage에 담기
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		pageLimit = 10;
		boardLimit = 10;
		maxPage = (int)Math.ceil((double)listCount/boardLimit);
		startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
		endPage = startPage + pageLimit - 1;
		
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		PageInfo pi = new PageInfo(listCount, currentPage, startPage, endPage, maxPage, pageLimit, boardLimit);
		//페이징끝

		ArrayList<TgbBoard_dto> list = new TgbBoard_service().getBoardList(pi);
		ArrayList<Category> category = new TgbBoard_service().getCategoryList();
		
		request.setAttribute("category", category);
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
