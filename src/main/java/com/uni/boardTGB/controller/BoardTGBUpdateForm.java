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
 * Servlet implementation class BoardTGBUpdateForm
 */
@WebServlet("/updateFormBoardTGB.do")
public class BoardTGBUpdateForm extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardTGBUpdateForm() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	      int nno = Integer.parseInt(request.getParameter("nno"));
	      BoardTGB_dto b = new BoardTGB_service().selectUpdateBoardTGB(nno);
	   
	      String view = "";
	      if(b != null) {
	         b.setBoardTgbTitle(b.getBoardTgbTitle().replaceAll("<br>", "\n"));
	         b.setBoardTgbContent(b.getBoardTgbContent().replaceAll("<br>", "\n"));
	         request.setAttribute("b", b);
	         view = "views/boardTGB/boardTGBUpdateForm.jsp";
	         
	      }else {
	         request.setAttribute("msg", "게시판 조회에 실패했습니다.");
	         view = "views/common/errorPage.jsp";

	      }
	      
	      request.getRequestDispatcher(view).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
