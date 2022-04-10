<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.uni.member.model.dto.Member"%>
    <%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<% String msg = (String)session.getAttribute("msg"); %>
<!-- 네이버 -->
<%
    String clientId = "ZncfIzzOzACjfv58Qta_";//가치사 아이디값";
    String redirectURI = URLEncoder.encode("http://127.0.0.1:8100/valueSa/naverLogin.do", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
    apiURL += "&client_id=" + clientId;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&state=" + state;
    session.setAttribute("state", state);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<style>
.loginArea{border: 2px solid cornflowerblue; margin: 0 auto; padding: 20px; width: 500px; height: 500px; position: relative;}
#kakaoLogin{margin-top:5px;}
#loginAPI{margin-top:50px;}
.divider .border {
	background:#e7eaee;
	height:1px;
	position: absolute;
	left:0;
	width:40%;
	top:40%;
}
.divider .border.right {
	left:auto;
	right:0;
}
</style>
<!-- 카카오 -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

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
				<button id = "enrollBtn" type="button" onclick="enrollPage();">회원가입</button><br>

				 <a href="<%=request.getContextPath()%>/findId.do">아이디 찾기</a>
				 <a href="<%=request.getContextPath()%>/findPwd.do">비밀번호 찾기</a>
				
			</div>
			
			<div class="divider">
				<div class="border"></div>
				<br>
				<div class="border right"></div>
			</div>
			
			<div id ="loginAPI">
				<!-- 네이버 로그인 버튼 노출영역 -->
				<a href="<%=apiURL%>"><img width="220" height="48" src="<%=contextPath%>/resources/smarteditor/img/naver.png"></a>
				<br>
				<!-- 카카오 버튼이 생기는 a태그 -->
				<div id="kakaoLogin">  
    				<a id="kakao-login-btn"></a>
    				<a href="http://developers.kakao.com/logout"></a>
				</div>
			</div>
		</form>
		<% }else{ %> 
			<div id = "userInfo">
				<b style = "color:black;"><%=loginUser.getUserName() %> 님 </b> 의 방문을 환영합니다.
				<br><br>
				<div class ="btns" align="center">
					<a href = "<%= contextPath %>/mypageMember.do">마이페이지</a>
					<a href = "<%= contextPath %>/logoutMember.do">로그아웃</a>
				</div>
			</div>
			
		<% } %>
		</div>
		<script>
			function enrollPage(){
				location.href="<%=request.getContextPath()%>/enroll.do";
			}
			
		</script>

		<script type='text/javascript'>
    	//가치사 javascript키
    	Kakao.init('9fb8871864e8f093d41c5c8020df9c37');
    	// 카카오 로그인 버튼을 생성합니다.
    	Kakao.Auth.createLoginButton({
      		container: '#kakao-login-btn',
     		success: function(authObj) {
          
          //로그인 성공시, 카카오 API를 호출한다.(카카오에 있는 데이터 불러옴)
          Kakao.API.request({
              url: '/v2/user/me',
              success: function(res){
                  console.log(res);
                  console.log(res.id);
                  console.log(JSON.stringify(res.properties.nickname));
                  console.log(JSON.stringify(res.kakao_account.email));
                 $.ajax({
                    url:"<%=request.getContextPath()%>/kakaoLogin.do",
                    data:{ //kakaologin 서블릿으로 던질 데이터들
                    	"userId":res.id, 
                    	"name":JSON.stringify(res.properties.nickname),
                    	"email":JSON.stringify(res.kakao_account.email)
                    	},
                    Type:"post",
                    success:function(data){
                        //성공적으로 하고나면 이동할 url
                        location.href="<%=request.getContextPath()%>/login.do";
                    }
                    
                 });
              },
              fail: function(error){
                  alert(JSON.stringify(error));
              }
          });
         //접속이 잘 된다면 회원의 토큰값 출력됨
        alert(JSON.stringify(authObj));
        
      },
      fail: function(err) {
         alert(JSON.stringify(err));
      }
    });
</script>  

</body>
</html>