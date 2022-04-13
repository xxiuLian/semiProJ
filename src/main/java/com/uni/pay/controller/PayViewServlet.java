package com.uni.pay.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.tgb.model.dto.Tgb;
import com.uni.tgb.model.service.TgbService;

/**
 * Servlet implementation class PayViewServlet
 */
@WebServlet("/payView.do")
public class PayViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PayViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bno = Integer.parseInt(request.getParameter("bno"));
		Tgb t = new TgbService().selectTgb(bno);
		
		request.setAttribute("t", t);
		String thumbnail = new TgbService().selectThumbnail(bno);
		request.setAttribute("thumbnail", thumbnail);
		
		request.getRequestDispatcher("views/pay/payView.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
