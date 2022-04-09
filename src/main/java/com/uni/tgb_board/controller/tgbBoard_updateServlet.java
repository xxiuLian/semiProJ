package com.uni.tgb_board.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.uni.common.Attachment;
import com.uni.common.MyFileRenamePolicy;
import com.uni.tgb_board.model.dto.TgbBoard_dto;
import com.uni.tgb_board.model.service.TgbBoard_service;

/**
 * Servlet implementation class tgbBoard_updateServlet
 */
@WebServlet("/tgbBoardUpdate.do")
public class tgbBoard_updateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public tgbBoard_updateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		
		if(ServletFileUpload.isMultipartContent(request)) {
			int maxSize = 10 * 1024 * 1024; 

			String resources = request.getSession().getServletContext().getRealPath("/assets");

			String savePath = resources + "\\tgbBoard_upfiles\\";

			System.out.println("savePath : " + savePath);

			MultipartRequest multiRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());

			int bno = Integer.parseInt(multiRequest.getParameter("bno"));
			
			
			TgbBoard_dto b = new TgbBoard_dto();
			b.setTgbBoardTitle(multiRequest.getParameter("title"));
			b.setTgbBoardContent(multiRequest.getParameter("content"));
			b.setTgbBoardCategory(multiRequest.getParameter("category"));
			b.setTgbBoardNo(bno);
			
			
			Attachment at = null;
			
			//수정페이지에서  사용자가 새로 파일 첨부하면
			if(multiRequest.getOriginalFileName("upFile") != null) {
				String originName = multiRequest.getOriginalFileName("upFile");
				String changeName = multiRequest.getFilesystemName("upFile");
				//수정
				at = new Attachment();
				at.setFilePath(savePath);
				at.setOriginName(originName);
				at.setChangeName(changeName);
				
				if(multiRequest.getParameter("originFile") != null) {
					File deleteFile = new File(savePath + multiRequest.getParameter("originFile"));
					deleteFile.delete();
					
					at.setFileNo(Integer.parseInt(multiRequest.getParameter("originFileNo")));
				}else {
					at.setRefBoardNo(bno);
				}
			}
			
			int result = new TgbBoard_service().updateTgbBoard(b, at);
			
			if(result > 0) {
				request.getSession().setAttribute("msg", "게시글 수정 완료");
				response.sendRedirect("tgbBoardDetail.do?bno=" + bno);
			}else {
				request.setAttribute("msg", "게시글 수정 실패");
				request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
			}
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
