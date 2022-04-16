package com.uni.admin.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.common.PageInfo;
import com.uni.tgb.model.dto.Tgb;
import com.uni.tgb.model.service.TgbService;

/**
 * Servlet implementation class TgbManageListServlet
 */
@WebServlet("/adminTGB.do")
public class TgbManageListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TgbManageListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//페이징처리
				int listCount; //총 게시글 수
				int currentPage;// 현제 페이지
				int startPage;// 시작 페이지 
				int endPage;// 끝 페이지
				
				int maxPage; // 가장 마지막 페이지
				int pageLimit; // 한 페이지 하단에 보여질 페이지 최대 갯수
				int boardLimit; // 한페이지에 보여질 게시글 최대 갯수

				listCount = new TgbService().getlistCount();
				
				currentPage = 1;
				
				if(request.getParameter("currentPage") != null) {
					currentPage = Integer.parseInt(request.getParameter("currentPage"));
				}
				
				pageLimit = 10;
				boardLimit = 5;
				
				maxPage = (int)Math.ceil((double)listCount/boardLimit);
				
				startPage = (currentPage -1)/pageLimit*pageLimit +1;
				
				endPage = startPage+pageLimit-1;
				
				if(maxPage < endPage) {
					endPage = maxPage;
				}
				
				PageInfo pi = new PageInfo(listCount, currentPage, startPage, endPage, maxPage, pageLimit, boardLimit);
				ArrayList<Tgb> list = new TgbService().selectList(pi);
				request.setAttribute("list", list);
				request.setAttribute("pi", pi);
				
				request.getRequestDispatcher("views/admin/adminTGB.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
