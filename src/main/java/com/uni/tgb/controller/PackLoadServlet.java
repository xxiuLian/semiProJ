package com.uni.tgb.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.tgb.model.service.TgbService;

/**
 * Servlet implementation class PackLoadServlet
 */
@WebServlet("/packLoad.do")
public class PackLoadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PackLoadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int tno = Integer.parseInt(request.getParameter("tno"));
		String com = request.getParameter("company");
		String num = request.getParameter("number");
		
		System.out.println("com : "+com);
		System.out.println("num :"+num);
		//int result = new TgbService().packloaded(tno, com, num);
		int result =1;
		
		if(result >0) {
			
			String sTag = "Y";
					
			request.setAttribute("sTag", sTag);
			request.setAttribute("com", com);
			request.setAttribute("num", num);
			
			String msg = "송장번호를 등록했습니다.";
			request.setAttribute("msg", msg);
			request.getRequestDispatcher("views/tgb/packLoadForm.jsp").forward(request, response);
			
		}else {
			String msg = "등록에 실패했습니다.";
			request.setAttribute("msg", msg);
			request.getRequestDispatcher("views/tgb/packLoadForm.jsp").forward(request, response);
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
