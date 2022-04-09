package com.uni.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.admin.dto.Category;
import com.uni.admin.service.AdminService;

/**
 * Servlet implementation class CategoryEditServlet
 */
@WebServlet("/selectCategory.do")
public class CategorySelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CategorySelectServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int cno = Integer.parseInt(request.getParameter("cno"));
		String keyword = request.getParameter("keyword");
		Category c = null;
		if(keyword.equals("qna")) {
			c = new AdminService().selectQnaCategory(cno);
			request.setAttribute("keyword", "qna");
		}else if(keyword.equals("tgb")) {
			c = new AdminService().selectTGBCategory(cno);
			request.setAttribute("keyword", "tgb");
		}else if(keyword.equals("board")) {
			c = new AdminService().selectBoardCategory(cno);
			request.setAttribute("keyword", "board");
		}
		request.setAttribute("category", c);
		request.getRequestDispatcher("views/admin/updateCategoryForm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
