<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.uni.member.model.dto.Member"%>
<%
   Member loginUser = (Member)session.getAttribute("loginUser");
   String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
 <link href="../../css/styles.css" rel="stylesheet" />
</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
		<div class="container">
			<a class="navbar-brand" href="#page-top"><img
				src="assets/img/navbar-logo.svg" alt="..." /></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				Menu <i class="fas fa-bars ms-1"></i>
			</button>
			<% if(loginUser == null){ %>
			 <form action=""><input type="text" name="search"><button type="submit">검색</button></form><br><br><!-- 검색창 -->
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
					<li class="nav-item"><a class="nav-link" href="noticeList.do">공지</a></li>
					<li class="nav-item"><a class="nav-link" href="login.do">로그인</a></li>
					<li class="nav-item"><a class="nav-link" href="enroll.do">회원가입</a></li>
					 <li class="nav-item"><a class="nav-link" href="qnaList.do">문의게시판</a></li>
					<li class="nav-item"><a class="nav-link" href="myPage.do">마이페이지</a></li>
					<li class="nav-item"><a class="nav-link" href="admin.do">관리자페이지</a></li>
					<li class="nav-item"><a class="nav-link" href="tgbInsert.do">공동구매 등록</a></li>
					<li class="nav-item"><a class="nav-link" href="tgbList.do">공동구매 조회</a></li><!--  -->
					<li class="nav-item"><a class="nav-link" href="category.do">카테고리</a></li>
					<li class="nav-item"><a class="nav-link" href="wishlist.do">찜목록</a></li>
				</ul>
			</div>
			<% }else{ %>
				<form action=""><input type="text" name="search"><button type="submit">검색</button></form><br><br><!-- 검색창 -->
				<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
					<li class="nav-item"><a class="nav-link" href="category.do">카테고리</a></li>
					<li class="nav-item"><a class="nav-link" href="noticeList.do">공지</a></li>
					<li class="nav-item"><a class="nav-link" href="wishlist.do">찜목록</a></li>
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
</body>
</html>