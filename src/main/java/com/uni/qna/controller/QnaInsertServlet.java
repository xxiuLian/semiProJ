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
import com.uni.member.model.dto.Member;
import com.uni.qna.model.dto.Qna;
import com.uni.qna.model.service.QnaService;

/**
 * Servlet implementation class QnaInsertServlet
 */
@WebServlet("/insertQna.do")
public class QnaInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QnaInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (ServletFileUpload.isMultipartContent(request)) {
			int maxSize = 10 * 1024 * 1024; // 10MB
			
			String resources = request.getSession().getServletContext().getRealPath("/resources");
			
			String savePath = resources + "\\qna_board_upfiles\\";
			
			MultipartRequest multiRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
			
			String category = multiRequest.getParameter("category");
			String title = multiRequest.getParameter("title");
			String content = multiRequest.getParameter("content");
			
			int userNo = ((Member)request.getSession().getAttribute("loginUser")).getUserNo();
			
			Qna q = new Qna();
			q.setCategory(category);
			q.setQnaTitle(title);
			q.setQnaContent(content);
			q.setQnaWriter(String.valueOf(userNo));
			Attachment at = null;
			if(multiRequest.getOriginalFileName("upfile") != null) {
				String originName = multiRequest.getOriginalFileName("upfile");
				String changeName = multiRequest.getFilesystemName("upfile");
				
				System.out.println("originName : " + originName);
				System.out.println("changeName : " + changeName);
				
				at = new Attachment();
				at.setFilePath(savePath);
				at.setOriginName(originName);
				at.setChangeName(changeName);
			}
			
			int result = new QnaService().insertQna(q, at);
			
			if(result > 0) {
				request.getSession().setAttribute("msg", "게시글 등록 완료");
				response.sendRedirect("qnaList.do");
			}else {
				if(at != null) {
					File failedFile = new File(savePath + at.getChangeName());
					failedFile.delete();
				}
				
				request.setAttribute("msg", "게시글 등록 실패");
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
