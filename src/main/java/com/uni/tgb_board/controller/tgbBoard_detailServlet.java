package com.uni.tgb_board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.common.Attachment;
import com.uni.tgb_board.model.dto.TgbBoard_dto;
import com.uni.tgb_board.model.service.TgbBoard_service;

/**
 * Servlet implementation class tgbBoard_detailServlet
 */
@WebServlet("/tgbBoardDetail.do")
public class tgbBoard_detailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public tgbBoard_detailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int nno = Integer.parseInt(request.getParameter("nno"));
		System.out.println("재욱nno : " + nno);
		TgbBoard_dto b = new TgbBoard_service().selectDetailTgbBoard(nno);
		
		String view = "";
		if(b != null) {
			request.setAttribute("b", b);
			view = "views/tgb_Board/tgbBoardDetailView.jsp";
		}else {
			request.setAttribute("msg", "공지사항 조회에 실패했습니다.");
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
