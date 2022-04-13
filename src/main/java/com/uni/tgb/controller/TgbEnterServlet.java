package com.uni.tgb.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.member.model.dto.Member;
import com.uni.member.model.service.MemberService;
import com.uni.chat.model.service.ChatService;
import com.uni.tgb.model.dto.Tgb;
import com.uni.tgb.model.service.TgbService;
import com.uni.tgb_board.model.dto.TgbBoard_dto;
import com.uni.tgb_board.model.dto.TgbBoard_pageInfo;
import com.uni.tgb_board.model.service.TgbBoard_service;

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
		
		
		int tmenu = Integer.parseInt(request.getParameter("tmenu"));
		System.out.println("tno : "+tno);
		
		Tgb t = new TgbService().enterTgb(tno);
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
		String cntper = String.format("%.1f", c);
		String tper = String.format("%.1f", tp);
		
		ArrayList<String> buyer = new ChatService().selectBuyer(tno);
		System.out.println("바이어 " + buyer);
		request.setAttribute("buyer", buyer);
		request.setAttribute("cntper", cntper);
		request.setAttribute("t", t);
		request.setAttribute("tper", tper);
		
		//추가_재욱
		System.out.println("tno123 : " + tno);
		ArrayList<Member> listMem = new MemberService().WookselectList(tno);
		System.out.println("listMem재욱테스트 : " + listMem);
		request.setAttribute("listMem", listMem);
		//까지_재욱
		
		//게시판
		int listPageCount = 10; //한 페이지 내의 글 수
		int listCount= 0 ; //총 글 수
		int barStart = 1; //페이징바(한페이지 내에서)
		int barEnd = 0; //페이징바(한페이지 내에서)
		int barMax = 0; //페이징바 가장 마지막
		int barCount = 5; //페이징바 5개
		int currentPage = 1; //현재 페이지
			
		//파라미터 값에 따라서 페이지 변경
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		//총 글 수
		listCount = new TgbBoard_service().getTgbBoard_listCount();
		
		//게시글 목록
		ArrayList<TgbBoard_dto> list = new TgbBoard_service().getBoardList(currentPage, listPageCount);
		
		//목록 마지막
		// 총 124 한 페이지 10개 면 13개 바 개수
		barMax = listCount/listPageCount+1;
	
		// 이제 저기에 + 1 해주면, 1...2...3... 이런 식
		// => a + (n-1)d = x (등차 어쩌고 공식)
		// => 1 + (x-1)*5 => 1...6...11... 
		
		int x = 0;
		x = (currentPage - 1) / barCount + 1 ; //1...2...3...
		barStart = 1 + (x - 1) * barCount; //6...11...16...
		
		barEnd = barStart + barCount - 1;  //5...10...15...
		
		//마지막 페이지 일경우 //5...10..15(x)13(o)...
		if((barStart <= barMax) && (barMax <= barEnd)){
			System.out.println((barStart <= barMax) && (barMax <= barEnd));
			barEnd = barMax; 
		}

		//pi 생성자로 생성
		TgbBoard_pageInfo pi = new TgbBoard_pageInfo(listCount, currentPage, barStart, barEnd, barCount, listPageCount, barMax);
		
		
		request.setAttribute("list", list);
		request.setAttribute("pi", pi);
		//
		System.out.println("썸네일 : "+t.getThumnail());
		
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd hh:mm:ss");
		
		System.out.println(sdf.format(t.getTgbTerm()));
		request.setAttribute("term", sdf.format(t.getTgbTerm()));
		String view = null;
		if(tmenu == 4) {
			view = "views/tgb/tgbEnterView4.jsp";
		}else if(tmenu ==3){
			view = "views/tgb/tgbEnterView3.jsp";
		}else if(tmenu ==2) {
			view = "views/tgb/tgbEnterView2.jsp";
		}else if(tmenu ==1) {
			view = "views/tgb/tgbEnterView1.jsp";
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