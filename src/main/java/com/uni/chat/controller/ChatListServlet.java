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
		response.setContentType("application/json; charset=utf-8");//Ajax에 채팅을 json으로 보내주기 때문에 인코딩 및 설정
		String fromId = ((Member) request.getSession().getAttribute("loginUser")).getUserId();//채팅보내는 유저(로그인된 유저)
		String toId = request.getParameter("toId");
		String listType = request.getParameter("listType");
		
		//System.out.println("보낸사람 : " + fromId);
		//System.out.println("받는사람 : " + toId);
		
		ArrayList<Chat> list = null;
		Gson gson = new GsonBuilder().setDateFormat("YY-MM-dd HH:mm").create();//채팅에 띄울 날짜 양식(분까지 나오게)
		
		if (toId == null || toId.equals("") || listType == null || listType.equals("")) {//보낼사람이랑 구분이 비어있으면
			response.getWriter().write("");//공백 리턴
		} else if (listType.equals("ten")){//처음 로딩될때 불러올 10개
			list = new ChatService().getChatListByRecent(fromId, toId);//받는사람, 보내는사람으로 10개 받아옴
			gson.toJson(list, response.getWriter());
		} else {//갱신될때 불러올거
			try {
				//이때 listType은 마지막 채팅번호이므로 마지막 채팅이후로 3초마다 새로운 채팅이 올라왔는지 체크
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
