package com.uni.tgb.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.tgb.model.dto.Tgb;
import com.uni.tgb.model.service.TgbService;

/**
 * Servlet implementation class TgbEnterServlet
 */
@WebServlet("/tgbEnter.do")
public class TgbEnterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TgbEnterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int tno = Integer.parseInt(request.getParameter("tno"));
		System.out.println("tno : "+tno);
		
		Tgb t = new TgbService().selectTgb(tno);
		int current = new TgbService().currentCount(tno);
		double c;
		
		
		if(t.getCount() > 0) {
			c = ((double)current/t.getCount())*100;//마감인원이 정해지지 않았을땐 어떡하지... 
		}else {
			c= 100;
		}
		
		long miliseconds = System.currentTimeMillis();
        Date today = new Date(miliseconds);
		long a = t.getTgbTerm().getTime()-today.getTime();
		long adays = a / ( 24*60*60*1000); 
		System.out.println("adays: "+adays);//남은 일자 
		
		long b = t.getTgbTerm().getTime() - t.getCreateDate().getTime();
		long bdays = b/( 24*60*60*1000); 
		System.out.println("bdays: "+bdays);// 전체일자
//		System.out.println("term : "+t.getTgbTerm());
//		
		double tp = (((double)adays/bdays)*100);
		
//		System.out.println(tper);
//		System.out.println((int)(((double)adays/bdays)*100));
		String cntper = String.format("%.2f", c);
		String tper = String.format("%.2f", tp);
		
		request.setAttribute("cntper", cntper);
		request.setAttribute("term", t.getTgbTerm());
		request.setAttribute("tper", tper);
		
		request.getRequestDispatcher("views/tgb/tgbEnterView.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
