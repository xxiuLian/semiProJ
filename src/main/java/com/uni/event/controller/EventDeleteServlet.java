package com.uni.event.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.event.model.service.EventService;

/**
 * Servlet implementation class EventDeleteServlet
 */
@WebServlet("/deleteEvent.do")
public class EventDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EventDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nno = request.getParameter("nno"); 
		
		
		int result = new EventService().deleteEvent(nno);
		
		if(result > 0) {
			//삭제완료
			//메뉴바 해준 Session을 가져와서 set해줌
			request.getSession().setAttribute("msg", "삭제성공");
			
			response.sendRedirect("eventList.do");
			
		}else {
			//실패
			request.getSession().setAttribute("msg", "실패");
			
			RequestDispatcher view = request.getRequestDispatcher("views/common/errorPage.jsp");
			view.forward(request, response);
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
