package com.uni.tgb.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uni.member.model.dto.Member;
import com.uni.tgb.model.service.TgbService;

/**
 * Servlet implementation class WishListDeleteServlet
 */
@WebServlet("/wishListDelete.do")
public class WishListDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WishListDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Member loginUser = (Member)request.getSession().getAttribute("loginUser");
		int user = loginUser.getUserNo();
		String[] arr = request.getParameterValues("ch");
		for(int i = 0; i<arr.length; i++) {
			System.out.println(arr[i]);
		}
		
		/*int result = new TgbService().wishListDelete(user, arr);
		
		if(result <= arr.length) {
			request.getRequestDispatcher("wishList.do").forward(request, response);
			
		}else if(result < 0) {
			request.getRequestDispatcher("").forward(request, response);
			
		}*/
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
