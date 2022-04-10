package com.uni.report.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.member.model.dto.Member;
import com.uni.report.model.dto.Report;
import com.uni.report.model.service.ReportService;

/**
 * Servlet implementation class TgbReportServlet
 */
@WebServlet("/reportTgb.do")
public class TgbReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TgbReportServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int reportUser = ((Member)request.getSession().getAttribute("loginUser")).getUserNo();
		System.out.println("신고서블릿 bno : " + request.getParameter("bno"));
		
		int bno = Integer.parseInt(request.getParameter("bno"));
		String content = request.getParameter("content");
		
		Report r = new Report(reportUser, content, bno);
		
		int result = new ReportService().insertReport(r);
		
		if(result > 0) {
			request.getSession().setAttribute("msg", "신고 완료");
			response.sendRedirect("detailTgb.do?bno="+bno);
		}else {
			request.setAttribute("msg", "게시글 등록 실패");
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
