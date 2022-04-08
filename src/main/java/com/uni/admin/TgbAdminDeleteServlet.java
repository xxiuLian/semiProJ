package com.uni.admin;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.tgb.model.service.TgbService;

/**
 * Servlet implementation class TgbAdminDeleteServlet
 */
@WebServlet("/deleteTGBs.do")
public class TgbAdminDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TgbAdminDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] strBnoNo = request.getParameterValues("TGBChecked");

		//String배열을 int 배열로 바로 변환
		int[] bno = Arrays.stream(strBnoNo).mapToInt(Integer::parseInt).toArray();
		
		int result1 = new TgbService().deleteTgbs(bno);
		int result2 = new TgbService().deleteTgbAttachments(bno);
		
		if(result1*result2 > 0) {
			request.getSession().setAttribute("msg", "글이 삭제되었습니다.");
			response.sendRedirect("adminTGB.do");
			
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
