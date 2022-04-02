package com.uni.tgb.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.tgb.model.dto.Tgb;
import com.uni.tgb.model.service.TgbService;

/**
 * Servlet implementation class TgbEnrollServlet
 */
@WebServlet("/tgbInsertServlet.do")
public class TgbInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TgbInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String guide = request.getParameter("guide");
		String writer = request.getParameter("writer");
		String category = request.getParameter("category");
		String term = request.getParameter("term");
		int price = Integer.parseInt(request.getParameter("price"));

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
		Date termDate = Date.valueOf(term);
		
		System.out.println("title : "+title);
		System.out.println("content : "+content);
		System.out.println("guide : "+guide);
		System.out.println("writer : "+writer);
		System.out.println("category : "+category);
		System.out.println("term : "+term);
		System.out.println("price : "+price);
		
		Tgb t = new Tgb(category, title, content, guide, writer, termDate, price);
		
		
		int result = new TgbService().insertTgb(t);
		System.out.println("result : "+ result);
		
		if(result >0) {
			request.getSession().setAttribute("msg", "공구 등록에 성공했습니다.");
			response.sendRedirect("views/tgb/tgbListView.jsp");
		}else {
			request.setAttribute("msg", "공구 등록에 실패했습니다.");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
