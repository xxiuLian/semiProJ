package com.uni.tgb_board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.uni.common.MyFileRenamePolicy;
import com.uni.member.model.dto.Member;
import com.uni.tgb_board.model.dto.TgbBoard_dto;
import com.uni.tgb_board.model.service.TGBBoard_service;

/**
 * Servlet implementation class tgbBoard_insertServlet
 */
@WebServlet("/insertTgbBoard.do")
public class tgbBoard_insertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public tgbBoard_insertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//파일 담을 때 쓸거
//		int maxSize = 10 * 1024 * 1024 ; 
//		
//		String resources = request.getSession().getServletContext().getRealPath("/resources");
//		String savePath = resources + "\\board_upfiles\\";
//		
//		MultipartRequest multiRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
//		
//		String category = multiRequest.getParameter("category");
//		String title = multiRequest.getParameter("title");
//		String content = multiRequest.getParameter("content");
		
		//테스트 (파일 뺴고 insert)
		String category = request.getParameter("category");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		

		
		//로그인한 회원번호(Session으로)★
		String userNo = "1";
		
		TgbBoard_dto b = new TgbBoard_dto();
		b.setTgbBoardCategory(category);
		b.setTgbBoardTitle(title);
		b.setTgbBoardContent(content);
		b.setTgbBoardWriter(String.valueOf(userNo));
		
		//등록할 파일★

		
		//게시글 등록★(파일 완성하면 b, at 로 수정해야함)
		int result = new TGBBoard_service().insertTgbBoard(b);
		
		if(result > 0) {
			System.out.println("성공");
		}else {
			System.out.println("실패");
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
