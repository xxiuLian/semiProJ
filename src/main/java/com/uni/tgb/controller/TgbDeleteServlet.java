package com.uni.tgb.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.tgb.model.service.TgbService;

/**
 * Servlet implementation class TgbDeleteServlet
 */
@WebServlet("/deleteTgb.do")
public class TgbDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TgbDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int bno = Integer.parseInt(request.getParameter("bno"));
		
		int result1 = new TgbService().deleteTgb(bno);
		int result2 = new TgbService().deleteTgbAttachment(bno);
		
		if(result1*result2 > 0) {
			request.getSession().setAttribute("msg", "글이 삭제되었습니다.");
			response.sendRedirect("tgbList.do");
			
		}else if(result1>0 &&result2 < 0 ) {
			request.setAttribute("msg", "글이 완전히 삭제되지 않았습니다.");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
			
		}else {
			request.setAttribute("msg", "글이 삭제되지 않았습니다");
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
