package com.uni.chat.controller;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.chat.model.dto.Chat;
import com.uni.chat.model.service.ChatService;
import com.uni.member.model.dto.Member;

/**
 * Servlet implementation class ChatSubmitServlet
 */
@WebServlet("/chatSubmit.do")
public class ChatSubmitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ChatSubmitServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");// 보냍 타입과 인코딩 설정
		String fromId = ((Member) request.getSession().getAttribute("loginUser")).getUserId();
		String toId = request.getParameter("toId");
		String chatContent = request.getParameter("chatContent");
		int bno = Integer.parseInt(request.getParameter("bno"));

		if (toId == null || toId.equals("") || chatContent == null || chatContent.equals("")) {
			response.getWriter().write("");
		} else {
			chatContent = URLDecoder.decode(chatContent, "UTF-8");// 안하면 한글깨짐
			Chat c = new Chat(fromId, toId, chatContent, bno);

			response.getWriter().write(new ChatService().insertChat(c));
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
