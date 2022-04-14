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
 * Servlet implementation class tgbBoard_updateFormServlet
 */
@WebServlet("/tgbBoardUpdateForm.do")
public class tgbBoard_updateFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public tgbBoard_updateFormServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int nno = Integer.parseInt(request.getParameter("nno"));
		
		TgbBoard_dto b = new TgbBoard_service().selectUpdateTgbBoard(nno);
		Attachment at = new TgbBoard_service().selectAttachment(nno);
		
		if(b != null) {
			request.setAttribute("b", b);
			request.setAttribute("at", at);
			request.getRequestDispatcher("views/tgb_Board/tgbBoardUpdateForm.jsp").forward(request, response);
		}else {
			request.setAttribute("msg", "tgbBoard의 게시글을 불러오는데 실패하였습니다.");
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
