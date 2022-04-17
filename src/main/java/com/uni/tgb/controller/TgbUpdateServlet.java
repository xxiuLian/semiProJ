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
			String  deleteAt = multiRequest.getParameter("deleteAt");//deletefile로 지울 파일을 string으로 연결해서 가져오고
	
			String tno  = multiRequest.getParameter("tno");
			String writer = multiRequest.getParameter("writer");
			String title = multiRequest.getParameter("title");
			String content= multiRequest.getParameter("content");
			String guide = multiRequest.getParameter("guide");
			String category = multiRequest.getParameter("category");
			String trm = multiRequest.getParameter("term");
			int count = Integer.parseInt(multiRequest.getParameter("pcont"));
			int price = Integer.parseInt(multiRequest.getParameter("price"));
				
			System.out.println("title : "+title);
			System.out.println("writer : "+writer);
			System.out.println("content : "+content);
			System.out.println("guide : "+guide);
			System.out.println("category : "+category);
			System.out.println("trm : "+trm);
			System.out.println("deleteAt :"+deleteAt);
			System.out.println("pcont :"+count);
			System.out.println("tno :"+tno);
			Date term = Date.valueOf(trm);
			
			Tgb t = new Tgb(category, title, content, guide, writer, count, term, price);
			t.setTgbNo(Integer.parseInt(tno));
			
			String name = "file0";
			Attachment at = new Attachment();
			
			if(multiRequest.getOriginalFileName(name) != null) {
				String originName = multiRequest.getOriginalFileName(name);
				String changeName = multiRequest.getFilesystemName(name);
				System.out.println(originName);
			
				
				at.setFilePath(savePath);
				at.setOriginName(originName);
				at.setChangeName(changeName);
				at.setType("TGB");
	
			}
			
			ArrayList<Attachment> fileList = new ArrayList<>();
			for(int i = 1; i<=10; i++) {
				
				String name2 = "file"+i;
				
				if(multiRequest.getOriginalFileName(name2) != null) {
					String originName = multiRequest.getOriginalFileName(name2);
					String changeName = multiRequest.getFilesystemName(name2);
					System.out.println(originName);
					System.out.println("i :"+i);
					
					Attachment at1 = new Attachment();
					at1.setFilePath(savePath);
					at1.setOriginName(originName);
					at1.setChangeName(changeName);
					at1.setType("TGB");
					
					fileList.add(at1);
				}
				
			}
			
			
			for(Attachment a : fileList) {
				System.out.println("==========파일 정보===========");
				System.out.println(a.getOriginName());
				System.out.println(a.getChangeName());
				System.out.println(a.getFilePath());
				System.out.println(a.getType());
				System.out.println("========================");
			}
			

			
			int result = new TgbService().updateTgb(t, at, tno, fileList);
			
			
			if(result >0) {
				request.getSession().setAttribute("msg", "공구 글 수정에 성공했습니다.");
				response.sendRedirect("tgbList.do");
			}else {
				
				
				request.setAttribute("msg", "공구 글 수정에 실패했습니다.");
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
