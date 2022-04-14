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
 * Servlet implementation class EventUpdateForm
 */
@WebServlet("/updateFormEvent.do")
public class EventUpdateForm extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EventUpdateForm() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  int nno = Integer.parseInt(request.getParameter("nno"));
	      EventDto event = new EventService().selectUpdateEvent(nno);
	   
	      String view = "";
	      if(event != null) {
	    	  event.setEventTitle(event.getEventTitle().replaceAll("<br>", "\n"));
	    	  event.setEventContent(event.getEventContent().replaceAll("<br>", "\n"));
	         request.setAttribute("event", event);
	         view = "views/event/eventUpdateForm.jsp";
	         
	      }else {
	         request.setAttribute("msg", "이벤트 조회에 실패했습니다.");
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
