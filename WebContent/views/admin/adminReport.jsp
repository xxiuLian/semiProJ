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
							</div> 전체 상품
						</a><a class="nav-link" href="adminReportTgb.do">
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
									class="nav-link" href="categoryList.do?keyword=board">커뮤니티</a> <a
									class="nav-link" href="categoryList.do?keyword=qna">문의</a>
							</nav>
						</div>
					</div>
				</div>
			</nav>
		</div>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">신고 상품 관리</h1>
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
					<form id="deleteTGB" action="${contextPath}/deleteTGBs.do?report=true"
						method="post">

						<table class="listArea" align="center">
							<thead>
								<tr>
									<th width="100"><button type="reset">전체취소</button></th>
									<th width="100">신고 번호</th>
									<th width="50">썸네일</th>
									<th width="100">공구 번호</th>
									<th width="150">공구 작성자</th>
									<th width="150">공구 등록일</th>
									<th width="150">신고 작성자</th>
									<th width="150">신고일</th>
								</tr>
							<thead>
							<tbody id="tbody">
								<c:choose>
									<c:when test="${empty report}">
										<tr>
											<td colspan="8">조회된 리스트가 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${report}" varStatus="s"> 
											<c:set var="r" value="${requestScope.report[s.count - 1]}" /> 
											<c:set var="t" value="${requestScope.tgb[s.count - 1]}" /> 
												<tr>
												<td><input type="checkbox" id="TGBChecked" name="TGBChecked" value="${r.tgbNo}"></td>
												<td>${r.reportNo}</td>
												<td><img src="${contextPath}/assets/img_upfile/${t.thumnail}" width="200px" height="150px"></td>
												<td>${r.tgbNo}</td>
												<td>${t.tgbWriter}</td>
												<td>${t.createDate}</td>
												<td>${r.reportUserId}</td>
												<td>${r.createDate}</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
						<br>
						<div class="btns" align="center">
							<c:if test="${!empty report}">
								<button type="button" onclick="deleteTGBs()">선택 상품 삭제</button>
							</c:if>
						</div>
						</form>
						<br> <br>
						<!-- 페이징바 만들기 -->
						<div class="pagingArea" align="center">
							<!-- 맨 처음으로 (<<) -->
							<button
								onclick="location.href='${contextPath}/adminReportTgb.do?currentPage=1'">
								&lt;&lt;</button>

							<!-- 이전페이지로(<) -->
							<c:choose>
								<c:when test="${currentPage eq 1}">
									<button disabled>&lt;</button>
								</c:when>
								<c:otherwise>
									<button
										onclick="location.href='${contextPath}/adminReportTgb.do?currentPage=${currentPage - 1}&amdin=admin'">
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
											onclick="location.href='${contextPath}/adminReportTgb.do?currentPage=${p}'">
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
										onclick="location.href='${contextPath}/adminReportTgb.do?currentPage=${currentPage + 1}'">
										&gt;</button>
								</c:otherwise>
							</c:choose>

							<!-- 맨 끝으로 (>>) -->
							<button
								onclick="location.href='${contextPath}/adminReportTgb.do?currentPage=${maxPage}'">
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
function deleteTGBs(){
	if(confirm("삭제 하시겠습니까?")){
		$("#deleteTGB").submit();
	}
}
if(!${empty report}){
	$(function(){
		$("#tbody>tr>td:not(:has(input))").click(function(){
			var rno = $(this).parent().children().eq(1).text();
			console.log(rno)
			window.open("${contextPath}/detailReport.do?rno="+rno, "상품조회", "width=1000, height=600")
		})
	})
}
</script>
<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
<script src="js/scripts.js"></script>
</html>