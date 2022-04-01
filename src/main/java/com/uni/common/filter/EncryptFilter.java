package com.uni.common.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

import com.uni.common.wrapper.EncryptWrapper;

/**
 * Servlet Filter implementation class EncryptFilter
 */
//@WebFilter("/EncryptFilter")
//@WebFilter(filterName = "encryptfilter", urlPatterns = {"/loginMember.do", "/insertMember.do", "/updatePwd.do"})
public class EncryptFilter implements Filter {

    /**
     * Default constructor. 
     */
    public EncryptFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		if(request.getParameter("newPwd") == null) {//새비번이 null이면 >> 로그인할 때 
			request.setAttribute("originPwd", request.getParameter("userPwd"));//request에 originPwd 에 userPwd를 저장
			
			System.out.println("변경전 userPwd : "+ request.getParameter("userPwd"));
		}else {//>> 비번 변경, 회원가입할 때 
			request.setAttribute("originPwd", request.getParameter("newPwd"));//originPwd에 새비번을 저장
			
			System.out.println("변경전 newPwd : "+ request.getParameter("newPwd"));
		}
		
		EncryptWrapper encRequest = new EncryptWrapper((HttpServletRequest)request);//Wrapper 클래스 객체 생성해서 리턴
		
		if(request.getParameter("newPwd") == null) {
			System.out.println("변경후 userPwd : "+ encRequest.getParameter("userPwd"));//Wrapper 클래스에 getParameter 메소드에 uswrPwd를 매개변수로 전달해서 리턴받아온다. 
		}else {
			
			System.out.println("변경후 newPwd : "+ encRequest.getParameter("newPwd"));
		}//같은 문자열에 같은 암호화가 리턴되서 보안에 안 좋다. 

		chain.doFilter(encRequest, response);// response 객체가 아닌 암호화된 비번이 감겨있는 객체를 전달시킨다.
		// 데이터에는 암호화하기 이전에 비번이 저장되있고 이 필터를 거쳐 Dao로 가기 때문에 기존 계정들은 수정하지 않으면 사용할 수 없다.
		
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
