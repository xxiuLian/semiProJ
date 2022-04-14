package com.uni.event.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.event.model.dto.EventDto;
import com.uni.event.model.service.EventService;
import com.uni.member.model.dto.Member;

/**
 * Servlet implementation class EventInsertServlet
 */
@WebServlet("/insertEvent.do")
public class EventInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EventInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String writer = String.valueOf(((Member)request.getSession().getAttribute("loginUser")).getUserNo());
		
		EventDto n = new EventDto(title, writer, content.replaceAll("\n", "<br>"));
		
		int result = new EventService().insertNotice(n);
		
		if(result > 0 ) {
			request.getSession().setAttribute("msg", "이벤트가 등록되었습니다.");
			response.sendRedirect("eventList.do");
		}else {
			request.setAttribute("msg", "이벤트 등록이 실패하였습니다. ");
		
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
