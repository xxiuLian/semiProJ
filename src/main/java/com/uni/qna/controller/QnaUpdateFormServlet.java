package com.uni.qna.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.admin.model.dto.Category;
import com.uni.common.Attachment;
import com.uni.qna.model.dto.Qna;
import com.uni.qna.model.service.QnaService;

/**
 * Servlet implementation class QnaUpdateFormServlet
 */
@WebServlet("/updateFormQna.do")
public class QnaUpdateFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QnaUpdateFormServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int qno = Integer.parseInt(request.getParameter("qno"));
		
		Qna q = new QnaService().selectUpdateQna(qno);
	
		
		if(q != null) {
			q.setQnaContent(q.getQnaContent().replaceAll(System.lineSeparator(), ""));
			ArrayList<Category> category = new QnaService().getCategoryList();
			request.setAttribute("category", category);
			request.setAttribute("q", q);
			request.getRequestDispatcher("views/qna/qnaUpdateForm.jsp").forward(request, response);
		}else {
			request.setAttribute("msg", "수정할 게시글을 불러오는데 실패하였습니다.");
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
