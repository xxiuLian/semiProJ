package com.uni.qna.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.common.Attachment;
import com.uni.qna.model.dto.Qna;
import com.uni.qna.model.service.QnaService;

/**
 * Servlet implementation class qnaDetailServlet
 */
@WebServlet("/detailQna.do")
public class QnaDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QnaDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int qno = Integer.parseInt(request.getParameter("qno"));
		
		Qna q = new QnaService().selectQna(qno);
		Attachment at = new QnaService().selectAttachment(qno);
		
		if(q != null) {
			q.setQnaContent(q.getQnaContent().replaceAll("\n", "<br>"));
			request.setAttribute("q", q);
			request.setAttribute("at", at);
			request.getRequestDispatcher("views/qna/qnaDetailView.jsp").forward(request, response);
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
