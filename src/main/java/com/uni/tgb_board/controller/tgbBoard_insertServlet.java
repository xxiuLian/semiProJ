package com.uni.tgb_board.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.uni.common.Attachment;

import com.oreilly.servlet.MultipartRequest;
import com.uni.common.MyFileRenamePolicy;
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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 파일 담을 때 쓸거
		if (ServletFileUpload.isMultipartContent(request)) {
			int maxSize = 10 * 1024 * 1024;

			String resources = request.getSession().getServletContext().getRealPath("/assets");
			
			String savePath = resources + "\\tgbBoard_upfiles\\";
			System.out.println(savePath);

			MultipartRequest multiRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());

			String category = multiRequest.getParameter("category");
			String title = multiRequest.getParameter("title");
			String content = multiRequest.getParameter("content");

			// 로그인한 회원번호(Session으로)★
			// int userNo =((Member)request.getSession().getAttribute("loginUser")).getUserNo();
			String userNo = "1";

			TgbBoard_dto b = new TgbBoard_dto();
			b.setTgbBoardCategory(category);
			b.setTgbBoardTitle(title);
			b.setTgbBoardContent(content);
			b.setTgbBoardWriter(String.valueOf(userNo));

			// 등록할 파일★
			Attachment at = null;
			
			if(multiRequest.getOriginalFileName("upfile") != null){
				System.out.println("됨");
				
				String originName = multiRequest.getOriginalFileName("upfile");
				String changeName = multiRequest.getFilesystemName("upfile");

				at = new Attachment();
				at.setFilePath(savePath);
				at.setOriginName(originName);
				at.setChangeName(changeName);
				
				System.out.println("1 : " + at.getFilePath());
				System.out.println("2 : " + at.getOriginName());
				System.out.println("3 : " + at.getChangeName());
			
			}
			
			// 게시글 등록★(파일 완성하면 b, at 로 수정해야함)
			int result = new TGBBoard_service().insertTgbBoard(b, at);

			if (result > 0) {
				request.getSession().setAttribute("msg", "공구 등록에 성공했습니다.");
				response.sendRedirect("tgbBoardSelect.do");
			} else {
				
				if(at != null) {
					File failedFile = new File(savePath + at.getChangeName());
					failedFile.delete();
				}

				request.setAttribute("msg", "공구 등록에 실패했습니다.");
				request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
