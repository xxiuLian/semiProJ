<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js"	crossorigin="anonymous"></script>
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
<c:set var="maxPage" value="${pi.maxPage}" scope="request" />
<c:set var="startPage" value="${pi.startPage}" scope="request" />
<c:set var="endPage" value="${pi.endPage}" scope="request" />

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
							</div> 상품
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
								<a class="nav-link" href="TGBCategoryList.do">상품</a> <a
									class="nav-link" href="BoardCategoryList.do">커뮤니티</a> <a
									class="nav-link" href="QnaCategoryList.do">문의</a>
							</nav>
						</div>
					</div>
				</div>
			</nav>
		</div>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">문의 게시판 관리</h1>
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
					<form id="deleteQna" action="${contextPath}/deleteQnas.do"
						method="post">

						<table class="listArea" align="center">
							<thead>
								<tr>
									<th width="100"><button type="reset">전체취소</button></th>
									<th width="100">글번호</th>
									<th width="100">카테고리</th>
									<th width="300">글제목</th>
									<th width="100">작성자</th>
									<th width="100">조회수</th>
									<th width="150">작성일</th>
									<th width="150">답변상태</th>
								</tr>
							<thead>
							<tbody id="tbody">
								<c:choose>
									<c:when test="${empty list}">
										<tr>
											<td colspan="7">조회된 리스트가 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="q" items="${list}">
											<tr>
												<td><input type="checkbox" id="qnaChecked" name="qnaChecked" value="${q.qnaNo}"></td>
											
												<td>${q.qnaNo}</td>
												<td>${q.category}</td>
												<td>${q.qnaTitle}</td>
												<td>${q.qnaWriter}</td>
												<td>${q.count}</td>
												<td>${q.createDate}</td>
												<c:choose>
													<c:when test="${q.qnaReply != null}">
														<td>답변 완료</td>
													</c:when>
													<c:otherwise>
														<td>답변 대기중</td>
													</c:otherwise>
												</c:choose>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
						<br>
						<div class="btns" align="center">
							<c:if test="${!empty list}">
								<button type="button" onclick="deleteQnas()">선택 게시글 삭제</button>
							</c:if>
						</div>
						</form>
						<br> <br>

						<!-- 페이징바 만들기 -->
						<div class="pagingArea" align="center">
							<!-- 맨 처음으로 (<<) -->
							<button
								onclick="location.href='${contextPath}/adminQnaList.do?currentPage=1'">
								&lt;&lt;</button>

							<!-- 이전페이지로(<) -->
							<c:choose>
								<c:when test="${currentPage eq 1}">
									<button disabled>&lt;</button>
								</c:when>
								<c:otherwise>
									<button
										onclick="location.href='${contextPath}/adminQnaList.do?currentPage=${currentPage - 1}&amdin=admin'">
										&lt;</button>
								</c:otherwise>
							</c:choose>
							<!-- 페이지 목록 -->
							<c:forEach var="p" begin="${startPage}" end="${endPage}" step="1">
								<c:choose>
									<c:when test="${p eq currentPage}">
										<button disabled>${p}</button>
									</c:when>
									<c:otherwise>
										<button
											onclick="location.href='${contextPath}/adminQnaList.do?currentPage=${p}'">
											${p}</button>
									</c:otherwise>
								</c:choose>
							</c:forEach>

							<!-- 다음페이지로(>) -->
							<c:choose>
								<c:when test="${currentPage eq maxPage}">
									<button disabled>&gt;</button>
								</c:when>
								<c:otherwise>
									<button
										onclick="location.href='${contextPath}/adminQnaList.do?currentPage=${currentPage + 1}'">
										&gt;</button>
								</c:otherwise>
							</c:choose>

							<!-- 맨 끝으로 (>>) -->
							<button
								onclick="location.href='${contextPath}/adminQnaList.do?currentPage=${maxPage}'">
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
	function deleteQnas(){
		if(confirm("삭제하시겠습니까?")){
			$("#deleteQna").submit();
		}
	}

	if(!${empty list}){
		$(function(){
			$(".listArea>tbody>tr>td:not(:has(input))").click(function(){
				var qno = $(this).parent().children().eq(1).text();
				window.open("${contextPath}/detailQna.do?qno="+qno, "문의글조회", "width=1000, height=600")
			})
		})
	}
</script>
<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
<script src="js/scripts.js"></script>
</html>