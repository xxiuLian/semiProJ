package com.uni.tgb_board.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.tgb_board.model.dto.TgbBoardReply;
import com.uni.tgb_board.model.service.TgbBoard_service;

/**
 * Servlet implementation class ReplyInsertTgbBoardServlet
 */
@WebServlet("/rTgbBoardInsert.do")
public class ReplyInsertTgbBoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReplyInsertTgbBoardServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String content = request.getParameter("content");
		int bno = Integer.parseInt(request.getParameter("bno"));
		
		//임시 ★
		int writer = 9;
		
		TgbBoardReply r = new TgbBoardReply();
		r.setReplyContent(content);
		r.setRefBoardId(bno);
		r.setReplyWriter(String.valueOf(writer));
		
		int result = new TgbBoard_service().insertReply(r);
		PrintWriter out = response.getWriter();
		
		if(result > 0 ) {
			out.print("success");
		}else {
			out.print("fail");
		}
		out.flush();
		out.close();
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
