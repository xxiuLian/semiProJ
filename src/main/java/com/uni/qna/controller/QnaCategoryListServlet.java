package com.uni.qna.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.uni.admin.model.dto.Category;
import com.uni.common.PageInfo;
import com.uni.qna.model.dto.Qna;
import com.uni.qna.model.service.QnaService;

/**
 * Servlet implementation class QnaCategoryListServlet
 */
@WebServlet("/qnaCategoryList.do")
public class QnaCategoryListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QnaCategoryListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int categoryNo = Integer.parseInt(request.getParameter("category"));
		
		System.out.println("카테고리 번호 : " + categoryNo);
		//페이징처리
		
		int listCount; 	 //총 게시글 개수
		int currentPage; //현재페이지(요청한페이지)
		int startPage;   //현재페이지 하단에 보여지는 페이징 바의 시작 수
		int endPage; 	 //현재페이지 하단에 보여지는 페이징 바의 끝 수
		
		int maxPage;     //전체 페이지의 가장 마지막 페이지
		int pageLimit;   //한페이지 하단에 보여질 최대 개수
		int boardLimit;  //한페이지에 보여질 게시글 최대 개수
		
		//총 게시글 개수
		listCount = new QnaService().getCategoryListCount(categoryNo);
		System.out.println("listCount : " + listCount);
		
		//현재페이지
		currentPage = 1;
		
		//페이지 전환시 전달받은 페이지가 있을 경우 전달받은 페이지를 currentPage에 담기
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		//페이지 최대개수
		pageLimit = 10;
		
		//게시글 최대개수
		boardLimit = 10;
		
		// * maxPage : 총 페이지 수
		/*
		 * ex) boardLimit : 10 이라는 가정 하에
		 * 
		 * 총갯수   / boardLimit
		 * 100.0 / 10 = 10.0 = 10.0		=> 10페이지
		 * 101.0 / 10 = 10.1 = 11.0		=> 11페이지
		 * 105.0 / 10 = 10.5 = 11.0		=> 11페이지
		 * 109.0 / 10 = 10.9 = 11.0		=> 11페이지
		 * 
		 * 총게시글갯수(실수)/boardLimit의 값을 올림한 값!
		 */
		
		maxPage = (int)Math.ceil((double)listCount/boardLimit);

		
		// * startPage : 현재 페이지에 보여지는 페이징 바의 시작 수
		/*
		 * ex) pageLimit : 10
		 * 1, 11, 21, 31, ...			=> n * 10 + 1
		 * 
		 * currentPage = 1				=> 0 * 10 + 1
		 * currentPage = 5				=> 0 * 10 + 1
		 * currentPage = 10				=> 0 * 10 + 1
		 * 
		 * currentPage = 11				=> 1 * 10 + 1
		 * currentPage = 12				=> 1 * 10 + 1
		 * currentPage = 20				=> 1 * 10 + 1
		 * 
		 * currentPage = 1~10			=> n=0
		 * currentPage = 11~20			=> n=1
		 * 
		 * 								   n = (currentPage - 1) / pageLimit
		 */

		startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
		// * endPage : 현재 페이지에 보여지는 페이징 바의 끝 수
		// startPage : 1	=> endPage : 10
		// startPage : 11	=> endPage : 20
		
		endPage = startPage + pageLimit - 1;
		
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		PageInfo pi = new PageInfo(listCount, currentPage, startPage, endPage, maxPage, pageLimit, boardLimit);
		ArrayList<Qna> list = new QnaService().selectCategoryList(pi, categoryNo);
		ArrayList<Category> category = new QnaService().getCategoryList();
		request.setAttribute("category", category);
		request.setAttribute("categoryNo", categoryNo);
		request.setAttribute("list", list);
		request.setAttribute("pi", pi);
		request.getRequestDispatcher("views/qna/qnaCategoryListView.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}