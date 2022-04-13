package com.uni.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.admin.model.dto.Category;
import com.uni.admin.model.service.AdminService;

/**
 * Servlet implementation class AddCategoryServlet
 */
@WebServlet("/addCategory.do")
public class AddCategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCategoryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int cno = Integer.parseInt(request.getParameter("cno"));
		String cname = request.getParameter("cname");
		String keyword = request.getParameter("keyword");
		Category c = new Category(cno, cname);
		int result = 0;
		if(keyword.equals("qna")) {
			result = new AdminService().insertQnaCategory(c);
		}else if(keyword.equals("tgb")) {
			result = new AdminService().insertTGBCategory(c);
		}else if(keyword.equals("board")) {
			result = new AdminService().insertBoardCategory(c);
		}
		
		if(result > 0) {
			request.setAttribute("msg", "카테고리 추가 완료");
			request.setAttribute("sTag", "Y");
			request.getRequestDispatcher("views/admin/close.jsp").forward(request, response);
		}else {
			request.setAttribute("msg", "카테고리 추가 실패");
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
