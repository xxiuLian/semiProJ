package com.uni.tgb.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.tgb.model.dto.Tgb;
import com.uni.tgb.model.service.TgbService;

/**
 * Servlet implementation class TgbSearchServlet
 */
@WebServlet("/searchTgb.do")
public class TgbSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TgbSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String keyword = request.getParameter("keyword");
		System.out.println(keyword);
		
		//ArrayList<Tgb> list = new TgbService().searchTgb();//비교할 데이터를 담아옴
		
//		ArrayList<Tgb> result = new ArrayList<Tgb>();//비교한 결과 데이터를 담음
//		
//		for(Tgb t : list) {
//			
//			if(t.getTgbTitle().contains(search)) {
//				result.add(t);
//			}else if(t.getTgbContent().contains(search)) {
//				result.add(t);
//			}else if(t.getTgbGuide().contains(search)) {
//				result.add(t);
//			}
//			
//			
//		}
//		
//		request.setAttribute("result", result);
//		
		
		
		
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
