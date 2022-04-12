package com.uni.boardTGB.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.boardTGB.model.dto.BoardTGB_dto;
import com.uni.boardTGB.model.service.BoardTGB_service;
import com.uni.member.model.dto.Member;
import com.uni.notice.model.dto.NoticeDto;
import com.uni.notice.model.service.NoticeService;

/**
 * Servlet implementation class test
 */
@WebServlet("/checkBoardTGBList.do")
public class CheckBoardTGBList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckBoardTGBList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int writer = ((Member)request.getSession().getAttribute("loginUser")).getUserNo();
		ArrayList<BoardTGB_dto> list = new BoardTGB_service().CHECKSelectList(writer);
		
		request.setAttribute("list", list);
		
		RequestDispatcher view = request.getRequestDispatcher("views/boardTGB/boardTGBListView.jsp");
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
