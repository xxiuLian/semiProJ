package com.uni.event.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.event.model.dto.EventDto;
import com.uni.event.model.service.EventService;
import com.uni.notice.model.dto.NoticeDto;
import com.uni.notice.model.service.NoticeService;

/**
 * Servlet implementation class EventUpdateServlet
 */
@WebServlet("/updateEvent.so")
public class EventUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EventUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	  int nno = Integer.parseInt(request.getParameter("nno"));
	  
	  String title = request.getParameter("title");
	  String content = request.getParameter("content").replaceAll("\n", "<br>");
	  
	  EventDto n = new EventDto();
	  n.setEventTitle(title);
	  n.setEventContent(content);
	  n.setEventNo(nno);
	  
	  int result = new EventService().updateEvent(n);
	 
	  
	  if(result > 0) {
	     request.getSession().setAttribute("msg", "공지 수정 완료");
	 response.sendRedirect("eventDetail.do?nno=" + nno);
	  }else {
	     request.setAttribute("msg", "공지 수정 실패");
	 request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
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
