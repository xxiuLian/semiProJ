package com.uni.tgb_board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.member.model.dto.Member;
import com.uni.tgb_board.model.dto.TgbBoard_dto;
import com.uni.tgb_board.model.service.TgbBoard_service;

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
		ArrayList<TgbBoard_dto> list = new TgbBoard_service().CHECKSelectList(writer);
		
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
