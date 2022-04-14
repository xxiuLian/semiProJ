<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.uni.member.model.dto.Member"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   Member loginUser = (Member)session.getAttribute("loginUser");
	System.out.print("loginUser :"+loginUser);
	String message = (String)session.getAttribute("msg");
   String contextPath = request.getContextPath();
%>
<c:set var="loginUser" value="${sessionScope.loginUser}" scope="session"/>
<c:set var="msg" value="${sessionScope.msg}" scope="session"/>
<c:set var="contextPath" value="<%= request.getContextPath()%>" scope="session"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
 <link href="css/styles.css" rel="stylesheet" />
 <script type="text/javascript">

	 $(function(){
		 let msg = "<%=message%>";
	 	if(msg != "null"){//msg가 null 아닐 경우 함수가 실행된다.
	 		alert(msg);
	 		<% session.removeAttribute("msg");%>
	 	} 
	 
	 })
</script>
<style type="text/css">
.navLogo{width:100px; height:100px;}
#mainNav .navbar-nav .nav-item .nav-link {
  font-family: "Montserrat", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
  font-size: 0.95rem;
  color: #495057;
  letter-spacing: 0.0625em;
}
.userWho{
  font-family: "Montserrat", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
  color: #495057;
  font-size: 18px;
}
#navbarResponsive{margin-right:30px;}
#search{
  margin-left:80px; 
  margin-right:15px;
  width: 250px;
  height: 40px;
  font-size: 15px;
  border: 0;
  border-radius: 15px;
  outline: none;
  padding-left: 10px;
  background-color: rgb(233, 233, 233);
}
.searchbutton{
  display: block;
  width: 80px;
  margin: 10px 20px 10px 0;
  text-align: center;
  line-height: 40px;
  color: #FFF;
  background: #398af3;
  border-radius: 15px;
  transition: all 0.2s ;
  box-shadow: 0px 5px 0px 0px #2b6bc0;
  border:none;
}
.searchbutton:hover {
  margin-top: 15px;
  margin-bottom: 5px;
  box-shadow: 0px 0px 0px 0px #2b6bc0;
}

a {
  color: #2b69ee;
  text-decoration: none;
}
/*
a:hover {
  color: #1a1f71;
}*/


</style>
</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-dark sticky-top" id="mainNav" style="background-color: #fff;">
		<div class="container"> <!-- 이미지 클릭 시 메인으로 돌아가기 -->
			<img class="navLogo" src="assets/img/navLogo.jpg" alt="가치사 navLogo" onclick="main();"/>

			<% if(loginUser == null){ %>
			 <input type="text" id="search" style="width:500px; height:50px;"><button type="button" class="searchbutton" onclick="searching();">검 색</button><br><br><!-- 검색창 -->
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0" style="margin-right:20px;">
					<li class="nav-item"><a class="nav-link" href="noticeList.do" style="font-size:30px; margin-right:10px;">공지</a></li>
					<li class="nav-item"><a class="nav-link" href="login.do" style="font-size:30px; margin-right:10px;">로그인</a></li>
					<li class="nav-item"><a class="nav-link" href="enroll.do" style="font-size:30px; margin-right:10px;">회원가입</a></li>
				</ul>
			</div>
			<% }else if(loginUser != null && loginUser.getUserId().equals("admin")) {%>
			<input type="text" id="search" style="width:500px; height:50px; margin-left:150px;"><button type="button" class="searchbutton" onclick="searching();">검색</button><br><br><!-- 검색창 -->
			<div class="collapse navbar-collapse" id="navbarResponsive">

			</div>
			<div id = "userInfo">
            <b class="userWho"><%=loginUser.getUserName() %></b> 접속 완료
            <br><br>
            <div class ="btns" align="center">
               <a href = "<%=contextPath %>/adminMember.do">관리자페이지</a> &nbsp;&nbsp;
               <a href = "<%=contextPath %>/logoutMember.do">로그아웃</a>
            </div>
         </div>
			<% }else{ %>
				<input type="text" id="search" style="margin-left:30px;"><button type="button" class="searchbutton" onclick="searching();">검색</button><br><br><!-- 검색창 -->
				<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
					<li class="nav-item"><a class="nav-link" href="tgbBoardSelect.do">공구게시판</a></li>
					<li class="nav-item"><a class="nav-link" href="eventList.do">이벤트</a></li>
					<li class="nav-item"><a class="nav-link" href="noticeList.do">공지</a></li>
					<li class="nav-item"><a class="nav-link" href="qnaList.do">문의게시판</a></li>
					<li class="nav-item"><a class="nav-link" href="tgbInsert.do">공동구매 등록</a></li>
					<li class="nav-item"><a class="nav-link" href="tgbList.do">공동구매 조회</a></li>
				</ul>
			</div>
			<div id = "userInfo">
            <p class="userWho"><b class="userWho"><%=loginUser.getUserName() %></b> 님의 방문을 환영합니다.</p>
            <div class ="btns" align="center">
               <a href = "<%=contextPath %>/myPage.do">마이페이지</a>&nbsp;&nbsp;
               <a href = "<%=contextPath %>/logoutMember.do">로그아웃</a>
            </div>
         </div>
			<% } %>
		</div>
	</nav>
	
	<script>
	function searching(){
		var keyword = $('#search').val();
		
		location.href = "<%=contextPath%>/searchTgb.do?keyword="+keyword;
		
	}
	function main(){
		location.href = "<%=contextPath%>";
	}
	
	</script>
</body>
</html>