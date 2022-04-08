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
 * Servlet implementation class Tgbinsert
 */
@WebServlet("/tgbInsertServlet.do")
public class Tgbinsert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Tgbinsert() {
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
			
			
			String writer = multiRequest.getParameter("writer");
			String title = multiRequest.getParameter("title");
			String content= multiRequest.getParameter("content");
			String guide = multiRequest.getParameter("guide");
			String category = multiRequest.getParameter("category");
			String trm = multiRequest.getParameter("term");
		
			int price = Integer.parseInt(multiRequest.getParameter("price"));
				
			System.out.println("title : "+title);
			System.out.println("writer : "+writer);
			System.out.println("content : "+content);
			System.out.println("guide : "+guide);
			System.out.println("category : "+category);
			System.out.println("trm : "+trm);
			
		
			
			
			Date term = Date.valueOf(trm);//String term을 Date로 변환
			
			Tgb t = new Tgb(category, title, content, guide, writer, term, price);
			
					
			ArrayList<Attachment> fileList = new ArrayList<>();
			
			for(int i = 0; i<=10; i++) {
				
				String name = "file"+i;
				
				if(multiRequest.getOriginalFileName(name) != null) {
					String originName = multiRequest.getOriginalFileName(name);
					String changeName = multiRequest.getFilesystemName(name);
					System.out.println(originName);
					System.out.println("i :"+i);
					
					Attachment at = new Attachment();
					at.setFilePath(savePath);
					at.setOriginName(originName);
					at.setChangeName(changeName);
					at.setType("TGB");
					
					fileList.add(at);
				}
				
			}
			
			
		
		int result = new TgbService().insertTgb(t, fileList);
		System.out.println("result : "+ result);
		
		if(result >0) {
			request.getSession().setAttribute("msg", "공구 등록에 성공했습니다.");
			response.sendRedirect("tgbList.do");
		}else {
			
			for(int i = 0; i<fileList.size(); i++) {
				File failedFile = new File(savePath + fileList.get(i).getChangeName());
				failedFile.delete();
			}
			
			request.setAttribute("msg", "공구 등록에 실패했습니다.");
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
