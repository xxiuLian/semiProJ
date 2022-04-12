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
		response.setContentType("text/html;charset=UTF-8");
		String fromId = ((Member) request.getSession().getAttribute("loginUser")).getUserId();
		// String toId = request.getParameter("toId");
		String toId = "user02";
		String listType = request.getParameter("listType");
		System.out.println("아이디 " + fromId);
		System.out.println("리스트타입 " + listType);
		ArrayList<Chat> list = null;
		if (toId == null || toId.equals("") || listType == null || listType.equals("")) {
			response.getWriter().write("");
		} else if (listType.equals("ten")){
			System.out.println("진입");
			list = new ChatService().getChatListByRecent(fromId, toId, 10);
			System.out.println("채팅내역 : " + list);
			Gson gson = new GsonBuilder().setDateFormat("YY-MM-dd HH:mm:ss").create();
			gson.toJson(list, response.getWriter());
		} else {
			try {
				list = new ChatService().getChatListById(fromId, toId, 10);
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
