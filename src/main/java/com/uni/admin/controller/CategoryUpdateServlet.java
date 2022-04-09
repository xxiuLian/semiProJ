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
 * Servlet implementation class CategoryUpdateServlet
 */
@WebServlet("/updateCategory.do")
public class CategoryUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CategoryUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int cno = Integer.parseInt(request.getParameter("cno"));
		int originCno = Integer.parseInt(request.getParameter("originCno"));
		String cname = request.getParameter("cname");
		System.out.println("cnmae : " + cname);
		request.setAttribute("originCname", cname);
		Category c = new Category(cno, cname);
		int result = new AdminService().updateCategory(c, originCno);
		
		if(result > 0) {
			request.setAttribute("sTag", "Y");
			request.setAttribute("msg", "카테고리 변경 완료");
			request.getRequestDispatcher("views/admin/close.jsp").forward(request, response);
		}else {
			request.setAttribute("msg", "카테고리 변경 실패");
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
