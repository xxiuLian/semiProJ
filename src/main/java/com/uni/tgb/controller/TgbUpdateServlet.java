package com.uni.tgb.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.uni.common.Attachment;
import com.uni.common.MyFileRenamePolicy;
import com.uni.tgb.model.dto.Tgb;
import com.uni.tgb.model.service.TgbService;

/**
 * Servlet implementation class TgbUpdateServlet
 */
@WebServlet("/updateTgb.do")// 공구 글 수정하는 서블릿
public class TgbUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TgbUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(ServletFileUpload.isMultipartContent(request)) {
			
			int maxSize = 10 * 1024*1024;
			
			String resources = request.getSession().getServletContext().getRealPath("/assets");
			String savePath = resources + "\\img_upfile\\";
			System.out.println(resources);
			
			System.out.println("savePath : "+ savePath);
			
			MultipartRequest multiRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
			
			System.out.println("넘어옴");
			String  fno = multiRequest.getParameter("deletefile");//deletefile로 지울 파일을 string으로 연결해서 가져오고
			int result = 0;
			System.out.println("fno"+fno);
			String[] farr= fno.split(",");//","을 기준으로 나눠서 배열로 만들고
			
			if(farr != null) {
				System.out.println("빼빼 :"+farr[0]);
				
				result = new TgbService().updateAttachment(farr);  // 그 배열을 가져가서 파일을 지움 
				
				if(result >0) {
					System.out.println("첨부파일 삭제 성공");
				}else {
					System.out.println("첨부파일 삭제 실패!!!");
				}
			}
//
//			String writer = multiRequest.getParameter("writer");
			String title = multiRequest.getParameter("title");
//			String content= multiRequest.getParameter("content");
//			String guide = multiRequest.getParameter("guide");
//			String category = multiRequest.getParameter("category");
//			String trm = multiRequest.getParameter("term");
//			int price = Integer.parseInt(multiRequest.getParameter("price"));
//				
			System.out.println("title : "+title);
//			System.out.println("writer : "+writer);
//			System.out.println("content : "+content);
//			System.out.println("guide : "+guide);
//			System.out.println("category : "+category);
//			System.out.println("trm : "+trm);
//			
		
			
			

			
			
			
			
		
		
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
