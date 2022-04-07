<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.uni.member.model.dto.Member"%>
    <%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<% String msg = (String)session.getAttribute("msg"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 네이버 -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<!-- 카카오 -->

<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<script type="text/javascript">

	$(function(){
		let msg = "<%=msg %>"
		if(msg != "null"){
			alert(msg);
			<% session.removeAttribute("msg");%> //메세지 띄우고 삭제
		}
	})
	function loginValidate(){
		if($("#userId").val().trim().length === 0){
			alert("아이디를 입력하세요");
			$("#userId").focus();
			return false;
		}
		if($("#userPwd").val().trim().length === 0){
			alert("비밀번호를 입력하세요");
			$("#userPwd").focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>
<%@ include file= "../common/menubar.jsp" %>
<div class= "loginArea">

		 <% if(loginUser == null){ %>
		<form id = "loginForm" action="<%=request.getContextPath()%>/loginMember.do" method="post" onsubmit="return loginValidate();">
			<table>
				<tr>
					<th><label for = "userId" style="color:black;">아이디</label></th>
					<td><input id="userId" type="text" name="userId"></td>
				</tr>
				<tr>
					<th><label for = "userPwd" style="color:black;">비밀번호</label></th>
					<td><input id="userPwd" type="text" name="userPwd"></td>
				</tr>
			</table>
			<div class ="btns" align="center">
				
				<button id = "loginBtn" type="submit">로그인</button>
			    <button id = "enrollBtn" type="button" onclick="enrollPage();">회원가입</button>
			</div>
			<div style="height: 50px;margin-top: 1%; " id="naver_id_login"></div>
			<!-- 카카오 로그인 버튼 노출 영역 -->
			<a href="javascript:kakaoLogin();"><img src="https://www.gb.go.kr/Main/Images/ko/member/certi_kakao_login.png" style="height:40px;width:auto;"></a>
	  	  	<ul>
		<li onclick="kakaoLogout();">
	      <a href="javascript:void(0)">
	          <span>카카오 로그아웃</span>
	      </a>
		</li>
	</ul>
	<ul>
	<li onclick="naverLogout(); return false;">
      <a href="javascript:void(0)">
          <span>네이버 로그아웃</span>
      </a>
	</li>
</ul>

<!-- 네이버 스크립트 -->
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<%
		    String clientId = "ZncfIzzOzACjfv58Qta_";//애플리케이션 클라이언트 아이디값";
		    String redirectURI = URLEncoder.encode("http://localhost:8070/valueSa/naverLogin.do", "UTF-8");
		    SecureRandom random = new SecureRandom();
		    String state = new BigInteger(130, random).toString();
		    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
		    apiURL += "&client_id=" + clientId;
		    apiURL += "&redirect_uri=" + redirectURI;
		    apiURL += "&state=" + state;
		    session.setAttribute("state", state);
		 %>
<a href="<%=apiURL%>"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
		<script>
			var testPopUp;
			function openPopUp() {
			    testPopUp= window.open("https://nid.naver.com/nidlogin.logout", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,width=1,height=1");
			}
			function closePopUp(){
			    testPopUp.close();
			}
			
			function naverLogout() {
				openPopUp();
				setTimeout(function() {
					closePopUp();
					}, 1000);
			}
		</script>
	  <!-- 네이버 로그인 버튼 노출 영역 -->
	  <script type="text/javascript">

		  
		  
	  	<!-- 카카오 로그인 버튼 노출 영역 -->


	Kakao.init('9fb8871864e8f093d41c5c8020df9c37'); //발급받은 키 중 javascript키를 사용해준다.
	Kakao.isInitialized();
	console.log(Kakao.isInitialized()); // sdk초기화여부판단
	//카카오로그인
	function kakaoLogin() {
	    Kakao.Auth.login({
	      success: function (response) {
	        Kakao.API.request({
	          url: '/v2/user/me',
	          success: function (response) {
	                console.log(response),
	                location.href="http://localhost:8070/valueSa"
	         },
	          fail: function (error) {
	            console.log(error)
	          },
	        })
	      },
	      fail: function (error) {
	        console.log(error)
	      },
	    })
	  }
	//카카오로그아웃  
	function kakaoLogout() {
	    if (Kakao.Auth.getAccessToken()) {
	      Kakao.API.request({
	        url: '/v1/user/unlink',
	        success: function (response) {
	        	console.log(response)
	        },
	        fail: function (error) {
	          console.log(error)
	        },
	      })
	      Kakao.Auth.setAccessToken(undefined)
	    }
	  }  
	</script>

		</form>
		<% }else{ %> 
			<div id = "userInfo">
				<b style = "color:black;"><%=loginUser.getUserName() %> 님 </b> 의 방문을 환영합니다.
				<br><br>
				<div class ="btns" align="center">
					<a href = "<%=request.getContextPath() %>/mypageMember.do">마이페이지</a>
					<a href = "<%=request.getContextPath() %>/logoutMember.do">로그아웃</a>
				</div>
			</div>
			
		<% } %>
		</div>
		<script>
			function enrollPage(){
				location.href="<%=request.getContextPath()%>/enroll.do";
			}
		</script>
</body>
</html>