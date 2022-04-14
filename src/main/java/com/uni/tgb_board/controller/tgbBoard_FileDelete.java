package com.uni.tgb_board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.tgb_board.model.service.TgbBoard_service;

@WebServlet("/tgbBoardFileDelete.do")
public class tgbBoard_FileDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public tgbBoard_FileDelete() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("???????");
		int nno = Integer.parseInt(request.getParameter("nno"));
		
		int result = new TgbBoard_service().deleteFile(nno);
				
		if(result > 0) {
			request.getSession().setAttribute("msg", "파일 삭제 완료");
			response.sendRedirect("tgbBoardDetail.do?nno=" + nno);
		}else {
			request.setAttribute("msg", "파일 삭제 실패");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
