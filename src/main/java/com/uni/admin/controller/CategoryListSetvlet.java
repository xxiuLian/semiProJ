package com.uni.admin.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.admin.model.dto.Category;
import com.uni.admin.model.service.AdminService;

/**
 * Servlet implementation class CategoryListSetvlet
 */
@WebServlet("/categoryList.do")
public class CategoryListSetvlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CategoryListSetvlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String keyword = request.getParameter("keyword");
		
		ArrayList<Category> category = new ArrayList<Category>();
		if(keyword.equals("qna")) {
			category = new AdminService().selectQnaCategoryList();
			request.setAttribute("keyword", "qna");
		}else if(keyword.equals("tgb")) {
			category = new AdminService().selectTGBCategoryList();
			request.setAttribute("keyword", "tgb");
		}else if(keyword.equals("board")) {
			category = new AdminService().selectBoardCategoryList();
			request.setAttribute("keyword", "board");
		}
		request.setAttribute("category", category);
		request.getRequestDispatcher("views/admin/adminCategory.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
