package com.uni.pay.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.member.model.dto.Member;
import com.uni.pay.model.dto.Pay;
import com.uni.pay.model.service.PayService;

/**
 * Servlet implementation class PaySubmitServlet
 */
@WebServlet("/paySubmit.do")
public class PaySubmitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PaySubmitServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int userNo = ((Member) request.getSession().getAttribute("loginUser")).getUserNo();
		int bno = Integer.parseInt(request.getParameter("bno"));
		int totPrice = Integer.parseInt(request.getParameter("totPrice"));
		int amount = Integer.parseInt(request.getParameter("amount"));

		Pay p = new Pay(userNo, bno, totPrice, amount);

		int result = new PayService().insertPay(p);

		if (result > 0) {
			request.setAttribute("msg", "결제 완료. 결제금액 : " + totPrice + "원");
			request.setAttribute("sTag", "Y");
			request.getRequestDispatcher("views/admin/close.jsp").forward(request, response);
		} else {
			request.setAttribute("msg", "결제 실패");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
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
