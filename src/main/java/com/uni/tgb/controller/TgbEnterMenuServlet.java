package com.uni.tgb.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.member.model.dto.Member;
import com.uni.member.model.service.MemberService;
import com.uni.chat.model.service.ChatService;
import com.uni.tgb.model.dto.Tgb;
import com.uni.tgb.model.service.TgbService;
import com.uni.tgb_board.model.dto.TgbBoard_dto;
import com.uni.tgb_board.model.dto.TgbBoard_pageInfo;
import com.uni.tgb_board.model.service.TgbBoard_service;

/**
 * Servlet implementation class TgbEnterServlet
 */
@WebServlet("/tgbEnter1.do")
public class TgbEnterMenuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TgbEnterMenuServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int tno = Integer.parseInt(request.getParameter("tno"));

		
		Tgb t = new TgbService().selectTgb(tno);

		
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd hh:mm:ss");
		
		System.out.println(sdf.format(t.getTgbTerm()));
		request.setAttribute("term", sdf.format(t.getTgbTerm()));
		String view = null;
	
		request.getRequestDispatcher(view).forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}