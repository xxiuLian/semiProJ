<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.ArrayList, com.uni.tgb.model.dto.*, com.uni.common.*"%>
<%@page import="com.uni.tgb_board.model.dto.TgbBoard_pageInfo"%>
<%@page import="com.uni.tgb_board.model.dto.TgbBoard_dto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.uni.member.model.dto.Member"%>
<%
ArrayList<TgbBoard_dto> list = (ArrayList<TgbBoard_dto>) request.getAttribute("list");
TgbBoard_pageInfo pi = (TgbBoard_pageInfo) request.getAttribute("pi");

int listCount = pi.getListCount();
int currentPage = pi.getCurrentPage();
int barStart = pi.getBarStart();
int barEnd = pi.getBarEnd();
int barCount = pi.getBarCount();
int barMax = pi.getBarMax();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Insert title here</title>
<link href="${contextPath}/css/adminPageStyles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js"
	crossorigin="anonymous"></script>
<style type="text/css">
.listArea {
	border: 1px solid black;
	text-align: center;
}

.listArea>tbody>tr:hover {
	background: darkgrey;
	cursor: pointer
}
</style>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="listCount" value="${pi.listCount}" scope="request" />
<c:set var="currentPage" value="${pi.currentPage}" scope="request" />
<c:set var="barMax" value="${pi.barMax}" scope="request" />
<c:set var="barStart" value="${pi.barStart}" scope="request" />
<c:set var="barEnd" value="${pi.barEnd}" scope="request" />

</head>
<body>
	<%@ include file="../../views/common/menubar.jsp"%>
	<div id="layoutSidenav">
		<div id="layoutSidenav_nav">
			<nav class="sb-sidenav accordion sb-sidenav-light"
				id="sidenavAccordion">
				<div class="sb-sidenav-menu">
					<div class="nav">
						<div class="sb-sidenav-menu-heading">회원</div>
						<a class="nav-link" href="adminMember.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-tachometer-alt"></i>
							</div> 전체 회원
						</a>
						<div class="sb-sidenav-menu-heading">상품</div>
						<a class="nav-link" href="adminTGB.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-tachometer-alt"></i>
							</div> 전체 상품
						</a><a class="nav-link" href="reportTGB.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-tachometer-alt"></i>
							</div> 신고된 상품
						</a>
						<div class="sb-sidenav-menu-heading">게시판</div>
						<a class="nav-link" href="adminQnaList.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-tachometer-alt"></i>
							</div> 문의
						</a> <a class="nav-link" href="adminBoard.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-tachometer-alt"></i>
							</div> 커뮤니티
						</a>
						<div class="sb-sidenav-menu-heading">카테고리</div>
						<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
							data-bs-target="#collapseLayouts" aria-expanded="false"
							aria-controls="collapseLayouts">
							<div class="sb-nav-link-icon">
								<i class="fas fa-columns"></i>
							</div> 카테고리
							<div class="sb-sidenav-collapse-arrow">
								<i class="fas fa-angle-down"></i>
							</div>
						</a>
						<div class="collapse" id="collapseLayouts"
							aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
							<nav class="sb-sidenav-menu-nested nav">
								<a class="nav-link" href="categoryList.do?keyword=tgb">상품</a> <a
									class="nav-link" href="categoryList.do?keyword=board">커뮤니티</a>
								<a class="nav-link" href="categoryList.do?keyword=qna">문의</a>
							</nav>
						</div>
					</div>
				</div>
			</nav>
		</div>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">커뮤니티 관리</h1>
					<div class="card mb-4">
						<div class="card-body">
							This page is an example of using the light side navigation
							option. By appending the
							<code>.sb-sidenav-light</code>
							class to the
							<code>.sb-sidenav</code>
							class, the side navigation will take on a light color scheme. The
							<code>.sb-sidenav-dark</code>
							is also available for a darker option.
						</div>
					</div>
					<br>
					<form id="deleteBoard" action="${contextPath}/deleteBoards.do"
						method="post">

						<table class="tgbBoardArea">
							<thead>
								<tr>
									<td>번호</td>
									<td>카테고리</td>
									<td>작성자</td>
									<td>제목</td>
									<td>내용</td>
									<td>조회수</td>
									<td>작성일</td>
									<td>상태값</td>
								</tr>
							</thead>
							<tbody>
								<%
								if (list.isEmpty()) {
								%>
								<tr>
									<td>조회된 리스트가 없습니다.</td>
								</tr>
								<%
								} else {
								%>

								<%
								for (TgbBoard_dto b : list) {
								%>
								<tr>
									<td><input type="checkbox" id="boardChecked"
										name="boardChecked" value="<%=b.getTgbBoardNo()%>"></td>
									<td><%=b.getTgbBoardNo()%></td>
									<td><%=b.getTgbBoardCategory()%></td>
									<td><%=b.getTgbBoardWriter()%></td>
									<td><%=b.getTgbBoardTitle()%></td>
									<td><%=b.getTgbBoardContent()%></td>
									<td><%=b.getTgbBoardCount()%></td>
									<td><%=b.getTgbBoardDate()%></td>
									<td><%=b.getTgbBoardStatus()%></td>
								</tr>
								<%
								}
								%>
								<%
								}
								%>
							</tbody>
						</table>

						<div class="btns" align="center">
							<c:if test="${!empty list}">
								<button type="button" onclick="deleteBoards()">선택 게시글
									삭제</button>
							</c:if>
						</div>
					</form>
					<br> <br>

					<!-- 2.페이징바 -->
					<div class="pagingArea" align="center">
						<button
							onclick="location.href='<%=contextPath%>/tgbBoardSelect.do?currentPage=<%=1%>'">
							&lt;&lt;</button>
						<button
							onclick="location.href='<%=contextPath%>/tgbBoardSelect.do?currentPage=<%=currentPage - barCount%>'">&lt;</button>

						<!-- 페이징바 이동 -->
						<%
						for (int i = barStart; i <= barEnd; i++) {
						%>
						<button
							onclick="location.href='<%=contextPath%>/tgbBoardSelect.do?currentPage=<%=i%>'"><%=i%></button>
						<%
						}
						%>

						<button
							onclick="location.href='<%=contextPath%>/tgbBoardSelect.do?currentPage=<%=currentPage + barCount%>'">&gt;</button>
						<button
							onclick="location.href='<%=contextPath%>/tgbBoardSelect.do?currentPage=<%=barMax%>'">
							&gt;&gt;</button>
					</div>
					<br> <br>
				</div>
			</main>
			<footer class="py-4 bg-light mt-auto">
				<div class="container-fluid px-4">
					<div
						class="d-flex align-items-center justify-content-between small">
						<div class="text-muted">Copyright &copy; Your Website 2022</div>
						<div>
							<a href="#">Privacy Policy</a> &middot; <a href="#">Terms
								&amp; Conditions</a>
						</div>
					</div>
				</div>
			</footer>
		</div>
	</div>
</body>
<script>
	function deleteBoards(){
		if(confirm("삭제 하시겠습니까?")){
			$("#deleteBoard").submit();
		}
	}
	if(!${empty list}){
		$(function(){
			$(".tgbBoardArea>tbody>tr>td:not(:has(input))").click(function(){
				var bno = $(this).parent().children().eq(1).text();
				console.log(bno)
				window.open("${contextPath}/tgbBoardDetail.do?bno="+bno, "문의글조회", "width=1000, height=600")
			})
		})
	}
</script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	crossorigin="anonymous"></script>
<script src="js/scripts.js"></script>
</html>