package com.uni.admin.controller;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.admin.model.service.AdminService;


/**
 * Servlet implementation class DeleteQnaCategory
 */
@WebServlet("/deleteCategory.do")
public class DeleteCategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteCategoryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] QCaNos = request.getParameterValues("categoryChecked");
		String keyword = request.getParameter("keyword");
		//String배열을 int 배열로 바로 변환
		int[] QCaNo = Arrays.stream(QCaNos).mapToInt(Integer::parseInt).toArray();
		
		int result = 0;
		
		if(keyword.equals("qna")) {
			result = new AdminService().deleteQnaCategorys(QCaNo);
			request.setAttribute("keyword", "qna");
		}else if(keyword.equals("tgb")) {
			result = new AdminService().deleteTGBCategorys(QCaNo);
			request.setAttribute("keyword", "tgb");
		}else if(keyword.equals("board")) {
			result = new AdminService().deleteBoardCategorys(QCaNo);
			request.setAttribute("keyword", "board");
		}
		
		if(result > 0) {
			request.setAttribute("msg", "카테고리 삭제 성공");
			response.sendRedirect("categoryList.do?keyword="+keyword);
		}else {
			request.setAttribute("msg", "카테고리 삭제 실패");
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
