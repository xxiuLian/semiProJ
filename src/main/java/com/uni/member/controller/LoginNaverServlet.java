package com.uni.member.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.uni.member.model.dto.Member;
import com.uni.member.model.service.MemberService;

/**
 * Servlet implementation class test
 */
@WebServlet("/naverLogin.do")
public class LoginNaverServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginNaverServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String clientId = "ZncfIzzOzACjfv58Qta_";//애플리케이션 클라이언트 아이디값";
	      String clientSecret = "2flkt6Xepj";//애플리케이션 클라이언트 시크릿값";
	      String code = request.getParameter("code");
	      String state = request.getParameter("state");
	      String redirectURI = URLEncoder.encode("http://localhost:8100/valueSa/naverLogin.do", "UTF-8");
	      String apiURL;
	      apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
	      apiURL += "client_id=" + clientId;
	      apiURL += "&client_secret=" + clientSecret;
	      apiURL += "&redirect_uri=" + redirectURI;
	      apiURL += "&code=" + code;
	      apiURL += "&state=" + state;
	      String access_token = "";
	      String refresh_token = "";
	      System.out.println("apiURL="+apiURL);
	      try {
	        URL url = new URL(apiURL);
	        HttpURLConnection con = (HttpURLConnection)url.openConnection();
	        con.setRequestMethod("GET");
	        int responseCode = con.getResponseCode();
	        BufferedReader br;
	        System.out.print("responseCode="+responseCode);
	        if(responseCode==200) { // 정상 호출
	          br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	        } else {  // 에러 발생
	          br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	        }
	        String inputLine;
	        StringBuffer res = new StringBuffer();
	        while ((inputLine = br.readLine()) != null) {
	          res.append(inputLine);
	        }
	        br.close();
	        if(responseCode==200) {
	          System.out.println(res.toString());
	          JSONParser parsing = new JSONParser();
	      	Object obj = parsing.parse(res.toString());
	      	JSONObject jsonObj = (JSONObject)obj;
	      		        
	      	access_token = (String)jsonObj.get("access_token");
	      	refresh_token = (String)jsonObj.get("refresh_token");
	      	
	      	
	        }
	      } catch (Exception e) {
	        System.out.println(e);
	      }

	      if(access_token != null) { // access_token을 잘 받아왔다면
      		try {
      			 String apiurl = "https://openapi.naver.com/v1/nid/me";
      			 URL url = new URL(apiurl);
      			HttpURLConnection con = (HttpURLConnection)url.openConnection();
      			con.setRequestMethod("GET");
      			con.setRequestProperty("Authorization", "Bearer "  +access_token.trim());
      			int responseCode = con.getResponseCode();
      			BufferedReader br;
      			if(responseCode==200) { // 정상 호출
      			 br = new BufferedReader(new InputStreamReader(con.getInputStream()));
      			} else {  // 에러 발생
      			br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
      			}
      			String inputLine;
      			StringBuffer res = new StringBuffer();
      			 while ((inputLine = br.readLine()) != null) {
      			res.append(inputLine);
      			JSONParser parsing = new JSONParser();
      			Object obj = parsing.parse(res.toString());
      			
      			JSONObject jsonObj = (JSONObject)obj;
      			JSONObject resObj = (JSONObject)jsonObj.get("response");
      			System.out.println("jsonObj" + jsonObj);
      			System.out.println("resObj" +resObj);

      			//왼쪽 변수 이름은 원하는 대로 정하면 된다. 
      			//단, 우측의 get()안에 들어가는 값은 와인색 상자 안의 값을 그대로 적어주어야 한다.
      			String name = (String)resObj.get("name");
      			String mobile = (String)resObj.get("mobile");
      			String userIds = (String)resObj.get("id");
      			
      			String userId = userIds.substring(0,10);
      			System.out.println(userId.substring(0,10));//임의로 아이디 정해주기 너무 길어서 10자로 잘랐음
      			
      			request.setAttribute("name", name);
      			request.setAttribute("mobile", mobile);
      			
      			//카카오에서 받은 회원가입 네이버에서 적용시키기
      			HttpSession session = request.getSession();
      			//회원이 있는지 확인, 있으면 로그인 없으면 회원가입
      	        int result = new MemberService().idCheck(userId);
      	        
      	        if(result > 0) {
      	        	 //있는 회원
      	        	Member m = new MemberService().selectMember(userId);
      	            session.setAttribute("loginUser", m);
      	            response.getWriter().append("/");
      	            System.out.println(m);
      	            response.sendRedirect(request.getContextPath());
      	            
      	        }else {
      	        	 //회원가입 필요
      	            Member mem = new Member();
      	            mem.setUserId(userId);
      	            //비번은 빈칸으로 일단..스루
      	            mem.setUserPwd(" ");
      	            //실제 이름이 저장된 인덱스
      	            mem.setUserName(name);
      	            mem.setPhone(mobile);

      	            //회원가입 로직 실행
      	            int rs = new MemberService().insertMember(mem);
      	            
      	            if(rs > 0) {
      	                //회원가입 했으니 로그인까지 연동
      	                
      	                //로그인
      	                Member mem2 = new MemberService().loginMember(userId, " ");
      	                
      	                session = request.getSession();
      	                session.setAttribute("loginUser", mem2);
      	                response.getWriter().append("/");
      	                response.sendRedirect(request.getContextPath());
      	            }else {
      	                System.out.println("네이버 회원가입 실패");
      	            }
      	        }
      			

      			}
      			br.close();

      	    } catch (Exception e) {
      	    	e.printStackTrace();
      	    }
      	}
	      //request.getRequestDispatcher("views/member/naverLogin.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
