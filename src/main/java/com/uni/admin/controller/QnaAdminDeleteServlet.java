package com.uni.admin.controller;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.qna.model.service.QnaService;

/**
 * Servlet implementation class QnaAdminDeleteServlet
 */
@WebServlet("/deleteQnas.do")
public class QnaAdminDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QnaAdminDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] strQnaNo = request.getParameterValues("qnaChecked");

		//String배열을 int 배열로 바로 변환
		int[] qno = Arrays.stream(strQnaNo).mapToInt(Integer::parseInt).toArray();
		
		int result = new QnaService().deleteQnas(qno);
		
		if(result > 0) {
			request.getSession().setAttribute("msg", result +  "개 문의게시글 삭제 성공");
			response.sendRedirect("adminQnaList.do");
		}else {
			request.setAttribute("msg", "문의게시글 삭제 실패");
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
