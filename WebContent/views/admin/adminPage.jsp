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
<title>관리자 페이지</title>
<link href="css/adminPageStyles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js"
	crossorigin="anonymous"></script>
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
						<a class="nav-link" href="adminMember.html">
							<div class="sb-nav-link-icon">
								<i class="fas fa-tachometer-alt"></i>
							</div> 전체 회원
						</a>
						<div class="sb-sidenav-menu-heading">상품</div>
						<a class="nav-link" href="adminTGB.html">
							<div class="sb-nav-link-icon">
								<i class="fas fa-tachometer-alt"></i>
							</div> 상품
						</a>
						<div class="sb-sidenav-menu-heading">게시판</div>
						<a class="nav-link" href="adminQna.html">
							<div class="sb-nav-link-icon">
								<i class="fas fa-tachometer-alt"></i>
							</div> 문의
						</a> <a class="nav-link" href="adminBoard.html">
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
								<a class="nav-link" href="layout-static.html">상품</a> <a
									class="nav-link" href="layout-sidenav-light.html">커뮤니티</a> <a
									class="nav-link" href="layout-sidenav-light.html">문의</a>
							</nav>
						</div>
					</div>
				</div>
			</nav>
		</div>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">전체 회원 관리</h1>
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
					<form id="deleteMember" action="${contextPath}/deleteMembers.do"
						method="post">
						<table class="listArea" align="center">
							<thead>
								<tr>
									<th width="100"></th>
									<th width="100">회원번호</th>
									<th width="100">아이디</th>
									<th width="200">전화번호</th>
									<th width="100">이메일</th>
									<th width="100">가입일</th>
									<th width="150">탈퇴여부</th>
								</tr>
							<thead>
							<tbody>
								<c:choose>
									<c:when test="${empty list}">
										<tr>
											<td colspan="6">조회된 리스트가 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="m" items="${list}">
											<tr>
												<c:choose>
													<c:when test="${m.status eq 'Y'}">
														<td><input type="checkbox" id="memberChecked"
															name="memberChecked" value="${m.userNo}"></td>
													</c:when>
													<c:otherwise>
														<td><input type="checkbox" disabled></td>
													</c:otherwise>
												</c:choose>

												<td>${m.userNo}</td>
												<td>${m.userId}</td>
												<td>${m.phone}</td>
												<td>${m.email}</td>
												<td>${m.enrollDate}</td>
												<c:choose>
													<c:when test="${m.status eq 'Y'}">
														<td>미탈퇴</td>
													</c:when>
													<c:otherwise>
														<td>탈퇴</td>
													</c:otherwise>
												</c:choose>
												<td><jsp:forward page="myInfoView.jsp">
														<jsp:param value="${m}" name="member" />
													</jsp:forward></td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
						<br>
						<div class="btns" align="center">
							<button type="reset">취소하기</button>
							<button type="submit">해당 회원탈퇴</button>
						</div>
					</form>
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
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="js/scripts.js"></script>
</body>
</html>