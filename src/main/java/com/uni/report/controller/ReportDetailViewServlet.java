package com.uni.report.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.qna.model.dto.Qna;
import com.uni.qna.model.service.QnaService;
import com.uni.report.model.dto.Report;
import com.uni.report.model.service.ReportService;

/**
 * Servlet implementation class ReportDetailViewServlet
 */
@WebServlet("/detailReport.do")
public class ReportDetailViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportDetailViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int rno = Integer.parseInt(request.getParameter("rno"));
		Report r = new ReportService().selectReport(rno);
		
		if(r != null) {
			request.setAttribute("r", r);
			request.getRequestDispatcher("views/admin/reportDetailView.jsp").forward(request, response);
		}else {
			request.setAttribute("msg", "게시글 상세조회 실패");
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
