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
</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-dark sticky-top" id="mainNav" style="background-color: #CF3D82;">
		<div class="container">
			<a class="navbar-brand" href=""><img
				src="assets/img/navbar-logo.svg" alt="..."/></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				Menu <i class="fas fa-bars ms-1"></i>
			</button>

			<% if(loginUser == null){ %>
			 <input type="text" id="search"><button type="button" onclick="searching();">검색</button><br><br><!-- 검색창 -->
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
					<li class="nav-item"><a class="nav-link" href="boardTGBList.do">재욱공구</a></li>
					<li class="nav-item"><a class="nav-link" href="eventList.do">재욱이벤트</a></li>
					<li class="nav-item"><a class="nav-link" href="noticeList.do">재욱공지</a></li>
					<li class="nav-item"><a class="nav-link" href="login.do">로그인</a></li>
					<li class="nav-item"><a class="nav-link" href="enroll.do">회원가입</a></li>
					<li class="nav-item"><a class="nav-link" href="qnaList.do">문의게시판</a></li>
					<li class="nav-item"><a class="nav-link" href="adminMember.do">관리자페이지</a></li>
					<li class="nav-item"><a class="nav-link" href="tgbInsert.do">공동구매 등록</a></li>
					<li class="nav-item"><a class="nav-link" href="tgbList.do">공동구매 조회</a></li><!--  -->
					<li class="nav-item"><a class="nav-link" href="category.do">카테고리</a></li>
					<li class="nav-item"><a class="nav-link" href="wishlist.do">찜목록</a></li>
				</ul>
			</div> 
			<% }else{ %>
				<input type="text" id="search"><button type="button" onclick="searching();">검색</button></form><br><br><!-- 검색창 -->
				<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
					<li class="nav-item"><a class="nav-link" href="category.do">카테고리</a></li>
					<li class="nav-item"><a class="nav-link" href="boardTGBList.do">재욱공구</a></li>
					<li class="nav-item"><a class="nav-link" href="eventList.do">재욱이벤트</a></li>
					<li class="nav-item"><a class="nav-link" href="noticeList.do">재욱공지</a></li>
					<li class="nav-item"><a class="nav-link" href="qnaList.do">문의게시판</a></li>
					<li class="nav-item"><a class="nav-link" href="wishlist.do">찜목록</a></li>
					<li class="nav-item"><a class="nav-link" href="adminMember.do">관리자페이지</a></li>
					<li class="nav-item"><a class="nav-link" href="tgbInsert.do">공동구매 등록</a></li>
					<li class="nav-item"><a class="nav-link" href="tgbList.do">공동구매 조회</a></li>
				</ul>
			</div>
			<div id = "userInfo">
            <b style = "color:black;"><%=loginUser.getUserName() %> 님 </b> 의 방문을 환영합니다.
            <br><br>
            <div class ="btns" align="center">
               <a href = "<%=contextPath %>/myPage.do">마이페이지</a>
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
	
	</script>
</body>
</html>