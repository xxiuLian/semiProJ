<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.uni.member.model.dto.Member"%>
    <%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<% String msg = (String)session.getAttribute("msg"); %>
<%

	String email = (String)request.getAttribute("email");
	String name = (String)request.getAttribute("name");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.loginArea{border: 2px solid cornflowerblue; margin: 0 auto; padding: 20px; width: 500px; height: 500px; position: relative;}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<!-- 카카오 -->
<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.js"></script>

</head>
<body>
<%@ include file= "../common/menubar.jsp" %>
<div class= "loginArea">
<div id = "userInfo">
				<b style = "color:black;"><%=name %>  님 </b> 의 방문을 환영합니다.
				<br><br>
				<div class ="btns" align="center">
					<a href = "<%= contextPath %>/mypageMember.do">마이페이지</a>

	<button onclick="naverLogout(); return false;">로그아웃</button>
				</div>
			</div>
			

		</div>
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
				location.href="http://localhost:8070/valueSa";
			}
		</script>

</body>
</html>