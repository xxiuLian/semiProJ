package com.uni.tgb_board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.common.Attachment;
import com.uni.qna.model.dto.Qna;
import com.uni.qna.model.service.QnaService;
import com.uni.tgb.model.service.TgbService;
import com.uni.tgb_board.model.dto.TgbBoard_dto;

/**
 * Servlet implementation class tgbBoard_updateFormServlet
 */
@WebServlet("/tgbBoard_updateFormServlet")
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
		int bno = Integer.parseInt(request.getParameter("bno"));
		
		TgbBoard_dto b = new TgbService().selectUpdateQna(bno);
		Attachment at = new TgbService().selectAttachment(bno);
		
		if(q != null) {
			request.setAttribute("b", b);
			request.setAttribute("at", at);
			request.getRequestDispatcher("views/qna/qnaUpdateForm.jsp").forward(request, response);
		}else {
			request.setAttribute("msg", "수정할 게시글을 불러오는데 실패하였습니다.");
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
