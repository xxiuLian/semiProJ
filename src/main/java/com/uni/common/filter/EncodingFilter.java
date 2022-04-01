package com.uni.common.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

/**
 * Servlet Filter implementation class EncodingFilter
 */
//@WebFilter("/*") web.xml에서 매핑 설정했기 때문에 주석처리 해준다. 
public class EncodingFilter implements Filter {

    /**
     * Default constructor. 
     */
    public EncodingFilter() {
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
	// 클라이언트 요청이 있을 때마다 매번 실행된다. 그리고 filterchain을 통해 조작 이후 요청을 원래 목적지인 서블릿으로 전달한다. 
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		System.out.println("============인코딩필터 동작 start============");
		//모든 클래스를 실행시키기 전에 filter를 거치게 된다. 

		if(((HttpServletRequest)request).getMethod().equalsIgnoreCase("post")) {
			
			System.out.println("===========post 방식 요청됨==========");
			request.setCharacterEncoding("UTF-8");//만약 method 형식이 post와 같으면 utf-8로 인코딩 해준다. 
		}
		
		chain.doFilter(request, response);// 다음필터로 넘기는 작업을 수행한다. 로그인이나 회원가입 비번 변경할때는 encryptfilter로 넘겨질듯
		System.out.println("===========서블릿 동작 하고 나서 실행============");//응답이 필터에서 처리되는 것
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
