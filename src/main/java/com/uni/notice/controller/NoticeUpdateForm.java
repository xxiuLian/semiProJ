package com.uni.notice.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.notice.model.dto.Notice;
import com.uni.notice.model.service.NoticeService;

/**
 * Servlet implementation class NoticeUpdateForm
 */
@WebServlet("/updateFormNotice.do")
public class NoticeUpdateForm extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeUpdateForm() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	      int nno = Integer.parseInt(request.getParameter("nno"));
	      Notice notice = new NoticeService().selectUpdateNotice(nno);
	   
	      String view = "";
	      if(notice != null) {
	         notice.setNoticeTitle(notice.getNoticeTitle().replaceAll("<br>", "\n"));
	         notice.setNoticeContent(notice.getNoticeContent().replaceAll("<br>", "\n"));
	         request.setAttribute("notice", notice);
	         view = "views/notice/noticeUpdateForm.jsp";
	         
	      }else {
	         request.setAttribute("msg", "공지사항 조회에 실패했습니다.");
	         view = "views/common/errorPage.jsp";

	      }
	      
	      request.getRequestDispatcher(view).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
