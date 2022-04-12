package com.uni.chat.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.uni.chat.model.dto.Chat;
import com.uni.chat.service.ChatService;
import com.uni.member.model.dto.Member;

/**
 * Servlet implementation class ChatListServlet
 */
@WebServlet("/chatList.do")
public class ChatListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ChatListServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json; charset=utf-8");
		String fromId = ((Member) request.getSession().getAttribute("loginUser")).getUserId();
		String toId = request.getParameter("toId");
		String listType = request.getParameter("listType");
		ArrayList<Chat> list = null;
		Gson gson = new GsonBuilder().setDateFormat("YY-MM-dd HH:mm").create();
		if (toId == null || toId.equals("") || listType == null || listType.equals("")) {
			response.getWriter().write("");
		} else if (listType.equals("ten")){
			list = new ChatService().getChatListByRecent(fromId, toId, 10);
			gson.toJson(list, response.getWriter());
		} else {
			try {
				list = new ChatService().getChatListById(fromId, toId, Integer.parseInt(listType));
				gson.toJson(list, response.getWriter());
			} catch (Exception e) {
				response.getWriter().write("");
			}
		}
	}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
