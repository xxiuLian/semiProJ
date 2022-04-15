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
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
 <!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico"/>
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
  box-shadow: 0px 0px 0px 0px #e9677de1;
}

a {
  color: #2b69ee;
  text-decoration: none;
}
a:hover {
  color: #e9677de1;
}
.navbar-nav{
	margin-left: 10px;
	padding: 0 10px;
}
.navbar-nav li{
	margin-left: 10px;
}
/*
a:hover {
  color: #1a1f71;
}*/

/* 공지 드롭다운 */
.event {
    /*position: absolute;
	left: 1150px; */
    margin-left:-30px;
    display: none;
}
.event.on { visibility: visible; }

</style>
</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-dark sticky-top" id="mainNav" style="background-color: #fff;">
		<div class="container"> <!-- 이미지 클릭 시 메인으로 돌아가기 -->
			<img class="navLogo" src="assets/img/navLogo.jpg" alt="가치사 navLogo" onclick="main();"/>

			<% if(loginUser == null){ %>
			 <input type="text" id="search" style="width:500px; height:50px;"><button type="button" class="searchbutton" onclick="searching();">검 색</button><br><br><!-- 검색창 -->
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav" style="">					
					<li class="nav-item"><a class="nav-link" href="noticeList.do" style="font-size:28px; margin-right:10px;">공지 <i class="fa-solid fa-angle-down"></i></a>
					<ul class="event">
						<li class="nav-item"><a class="nav-link" href="eventList.do" style="font-size:20px;">이벤트</a></li>
						<li class="nav-item"><a class="nav-link" href="noticeList.do" style="font-size:20px;">공지</a></li>
					</ul>
					<li class="nav-item"><a class="nav-link" href="login.do" style="font-size:28px; margin-right:10px;">로그인</a></li>
					<li class="nav-item"><a class="nav-link" href="enroll.do" style="font-size:28px; margin-right:10px;">회원가입</a></li>
				</ul>
			</div>

			<% }else if(loginUser != null && loginUser.getUserId().equals("admin")) {%>
			<input type="text" id="search" style="width:500px; height:50px; margin-left:150px;"><button type="button" class="searchbutton" onclick="searching();">검 색</button><br><br><!-- 검색창 -->
			<div class="collapse navbar-collapse" id="navbarResponsive">
					<ul class="navbar-nav">
						<li class="nav-item"><a class="nav-link" href="noticeList.do" style="font-size:28px; margin-right:10px;">공지 <i class="fa-solid fa-angle-down"></i></a>
							<ul class="event">
								<li class="nav-item"><a class="nav-link" href="eventList.do">이벤트</a></li>
								<li class="nav-item"><a class="nav-link" href="noticeList.do">공지</a></li>
								<li class="nav-item"><a class="nav-link" href="tgbBoardSelect.do">공동구매게시판</a></li>
							</ul>
					</ul>
			</div>
			<div id = "userInfo">
            <b class="userWho"><%=loginUser.getUserName() %></b> 접속중
            <br><br>
            <div class ="btns" align="center">
               <a href = "<%=contextPath %>/adminMember.do">관리자페이지</a> &nbsp;&nbsp;
               <a href = "<%=contextPath %>/logoutMember.do">로그아웃</a>
            </div>
         </div>
			<% }else{ %>
				<input type="text" id="search" style="margin-left:30px;"><button type="button" class="searchbutton" onclick="searching();">검 색</button><br><br><!-- 검색창 -->
				<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="noticeList.do">공지 <i class="fa-solid fa-angle-down"></i></a>
					<ul class="event">
						<li class="nav-item"><a class="nav-link" href="eventList.do">이벤트</a></li>
						<li class="nav-item"><a class="nav-link" href="noticeList.do">공지</a></li>
					</ul>
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
	//서브메뉴 슬라이드다운
	$(".navbar-nav>li").on({
	    "mouseenter" : function(){ //공지에 마우스를 올리면 1. ul event에 on이라는 클래스를 적용(94행) 2. 슬라이드다운
	        $(this).children(".event").stop().addClass("on").slideDown()
	    },
		"mouseleave" :function(){//마우스가 떠나면 1. 슬라이드업 2.on클래스 삭제
	        $(".event").stop().slideUp().removeClass("on");
	    } //마우스enter,leave 반복하면 연속적으로 이벤트가 실행됨 .stop()으로 막기 
	    
	})

	</script>
</body>
</html>