package com.uni.qna.controller;

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
import com.uni.qna.model.dto.Qna;
import com.uni.qna.model.service.QnaService;

/**
 * Servlet implementation class QnaUpdateServlet
 */
@WebServlet("/updateQna.do")
public class QnaUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QnaUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(ServletFileUpload.isMultipartContent(request)) {
			int maxSize = 10 * 1024 * 1024; // 10MB

			String resources = request.getSession().getServletContext().getRealPath("/resources");

			String savePath = resources + "\\qna_board_upfiles\\";

			System.out.println("savePath : " + savePath);

			MultipartRequest multiRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
			
			int qno = Integer.parseInt(multiRequest.getParameter("qno"));
			
			Qna q = new Qna();
			q.setQnaTitle(multiRequest.getParameter("title"));
			q.setQnaContent(multiRequest.getParameter("content"));
			q.setCategory(multiRequest.getParameter("category"));
			q.setQnaNo(qno);
			
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
					at.setRefBoardNo(qno);
				}
			}
			
			int result = new QnaService().updateQna(q, at);
			
			if(result > 0) {
				request.getSession().setAttribute("msg", "게시글 수정 완료");
				response.sendRedirect("detailQna.do?qno=" + qno);
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
