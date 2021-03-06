package com.uni.tgb.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.admin.model.dto.Category;
import com.uni.common.Attachment;
import com.uni.tgb.model.dto.Tgb;
import com.uni.tgb.model.service.TgbService;

/**
 * Servlet implementation class TgbUpdateFormServlet
 */
@WebServlet("/updateForm.do")//공구 글 수정 jsp로 이동하는 서블릿
public class TgbUpdateFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TgbUpdateFormServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int bno =Integer.parseInt(request.getParameter("bno"));
		Tgb t = new TgbService().selectTgb(bno);
		ArrayList<Attachment> list = new TgbService().selectAttachment(bno);
		ArrayList<Category> catelist = new TgbService().getCategory();
		 
		
		if(t != null) {
		
		request.setAttribute("t", t);
		request.setAttribute("list", list);
		request.setAttribute("catelist", catelist);
		request.getRequestDispatcher("views/tgb/tgbUpdateForm.jsp").forward(request, response);
		}else {
			request.setAttribute("msg", "수정할 글 조회에 실패했습니다.");
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
