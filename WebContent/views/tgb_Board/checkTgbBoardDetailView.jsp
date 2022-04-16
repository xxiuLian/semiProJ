<%@page import="com.uni.tgb_board.model.dto.TgbBoard_dto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.uni.tgb_board.model.dto.*"%>
<%
TgbBoard_dto b = (TgbBoard_dto) request.getAttribute("b");
String admin = (String) request.getAttribute("admin");
%>

<!DOCTYPE html>
<html>
<head>
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js"
	crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700"
	rel="stylesheet" type="text/css" />
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<link href="css/styles.css" rel="stylesheet" />
<link href="css/myPageStyles.css" rel="stylesheet" />
<title>Insert title here</title>
<style>
.outer {
	width: 850px;
	height: 500px;
	background: #fff;
	color: black;
	margin: auto;
	margin-top: 50px;
}

#detailArea, #replyList {
	width: 100%;
	margin: 15px auto;
	border-color: black;
}

#detailArea th, #replyList th {
	font-size: 20px;
}

#detailArea td, #replyList td {
	font-size: 18px;
}

table {
	width: 100%;
	margin: 15px auto;
	border-color: black;
}

table th {
	font-size: 20px;
}

table td {
	font-size: 18px;
}

.btns a {
	text-decoration: none;
	color: black;
}

.replyBtn {
	border: 1px solid lightgray;
	border-radius: 5px;
}
</style>
</head>
<body>
	<!-- Sidebar Start -->
	<%@ include file="../common/menubar.jsp"%>
	<div class="container">
		<div class="d-flex" id="wrapper">

			<!-- Sidebar-->
			<div class="border-end bg-white" id="sidebar-wrapper">
				<div class="sidebar-heading border-bottom bg-light">
					<a href="<%=contextPath%>/myPage.do">Start Bootstrap</a>
				</div>
				<div class="list-group list-group-flush">
					<a
						class="list-group-item list-group-item-action list-group-item-light p-3"
						href="myInfo.do" id="myInfo">내 정보</a>
					<div>
						<a id="myList"
							class="list-group-item list-group-item-action list-group-item-light p-3"
							href="myList.do">공동구매 내역 조회</a>
						<ul>
							<li><a class="nav-link" href="myList.do">나의 진행 상품</a></li>
							<li><a class="nav-link" href="myPayList.do">나의 참여 상품</a></li>
							<li><a class="nav-link" href="myFinishList.do">이전 상품</a></li>
						</ul>
					</div>
					<a
						class="list-group-item list-group-item-action list-group-item-light p-3"
						href="wishList.do">찜내역관리</a> <a
						class="list-group-item list-group-item-action list-group-item-light p-3"
						href="checkQnaList.do">문의내역조회</a> <a
						class="list-group-item list-group-item-action list-group-item-light p-3"
						href="checkBoardTGBList.do">공동구매게시판조회</a>

				</div>
			</div>
			<!-- Sidebar End -->

			<!-- Page content wrapper-->
	<br>

			<div class="outer">
				<br>

				<h2 align="center">내 글 조회</h2>


				<table class="table table-condensed" id="detailArea">
					<tr>
						<td>종류</td>
						<td>${b.tgbBoardCategory}</td>
						<td>제목</td>
						<td colspan="4"><%=b.getTgbBoardTitle()%></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td><%=b.getTgbBoardWriter()%></td>
						<td></td>
						<td>작성일</td>
						<td><%=b.getTgbBoardDate()%></td>
					</tr>
					<tr>
						<th>내용</th>
						<td colspan="5" style="padding-left: 50px">
							<p><%=b.getTgbBoardContent()%></p>
						</td>
					</tr>
				</table>

				<br>
<%--
				<div class="btns" align="center">
					<%
					if (admin == null) {
					%>

					<a href="tgbBoardSelect.do">목록으로</a> &nbsp;&nbsp;
					<%
					}
					%>

					<%
					if (request.getSession().getAttribute("loginUser") != null && ((Member) request.getSession().getAttribute("loginUser"))
							.getUserNo() == Integer.parseInt(b.getTgbBoardWriter())) {
					%>
					<a href="tgbBoardUpdateForm.do?nno=<%=b.getTgbBoardNo()%>">수정하기</a>
					&nbsp;&nbsp; 
					 --%>
					<a href="ChecktgbBoardDelete.do?nno=<%=b.getTgbBoardNo()%>">삭제하기</a>
					

				</div>
			</div>
			
		</div>
	</div>
</body>
</html>