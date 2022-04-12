package com.uni.boardTGB.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.boardTGB.model.dto.BoardTGB_dto;
import com.uni.boardTGB.model.service.BoardTGB_service;
import com.uni.notice.model.dto.NoticeDto;
import com.uni.notice.model.service.NoticeService;

/**
 * Servlet implementation class BoardTGBUpdateServlet
 */
@WebServlet("/updateBoardTGB.do")
public class BoardTGBUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardTGBUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int nno = Integer.parseInt(request.getParameter("nno"));
	      
	      String title = request.getParameter("title");
	      String content = request.getParameter("content").replaceAll("\n", "<br>");
	      
	      BoardTGB_dto n = new BoardTGB_dto();
	      n.setBoardTgbTitle(title);
	      n.setBoardTgbContent(content);
	      n.setBoardTgbNo(nno);
	      
	      int result = new BoardTGB_service().updateBoardTGB(n);
	     
	      
	      if(result > 0) {
	         request.getSession().setAttribute("msg", "공지 수정 완료");
	         response.sendRedirect("boardTGBDetail.do?nno=" + nno);
	      }else {
	         request.setAttribute("msg", "공지 수정 실패");
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
