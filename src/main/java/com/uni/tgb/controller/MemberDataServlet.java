package com.uni.tgb.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.google.gson.Gson;
import com.uni.member.model.dto.Member;
import com.uni.tgb.model.service.TgbService;

/**
 * Servlet implementation class MemberDataServlet
 */
@WebServlet("/member1.do")
public class MemberDataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberDataServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId= request.getParameter("writer");
		
		Member m = new TgbService().searchById(userId);// 유저 정보 가져오기
		int cnt = new TgbService().countTgbById(m.getUserNo());//해당 아이디가 공구를 얼마나 진행했는지 알아봄 
		
		JSONObject jm = null;
		if(m != null) {
			jm = new JSONObject();
			jm.put("userId", m.getUserId());
			jm.put("phone", m.getPhone());
			jm.put("email", m.getEmail());
		}
		
		jm.put("cnt", cnt);
		response.setContentType("application/json; charset=utf-8");
		
		new Gson().toJson(jm, response.getWriter());
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
