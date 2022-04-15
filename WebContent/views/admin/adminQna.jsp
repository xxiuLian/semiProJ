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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
.outer{
		width:1000px;
		height:500px;
		background:#fff;
		color:black;
		margin:auto;
		margin-top:50px;
	}
	.listArea{
		border:1px solid white;
		text-align:center;
	}
	.searchArea{
		margin-top:50px;
	}
	
	.pagingArea{
		margin-top:15px;
	}
	.pagingicon{
		border: 1px solid lightgray;
		border-radius: 5px;
	}
	#writeadmin, #searchbtn{
		border: 1px solid black;
		
	}
	#writeadmin:hover{
		background-color:#eee;
	}
	#searchbtn:hover{
		background-color:#eee;
	}
	.qnaCategory{
		float: left;
	}
	
	.btnsArea{
	   width: 100%;
	   height: 80px;
	   justify-content: center;
	   display: flex;
	   align-items: center;
	   
   }
 
    #resetBtn{
	background:rgb(216, 216, 216); 
	color:rgb(85, 85, 85); 
	font-size:20px; 
	width: 80px; 
	height: 30px;
	border-radius:5px;
	border: 0.2px solid rgb(216, 216, 216);
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 700;
	font-size: 15px;
   }
   
    #deleteBtn{
	background:rgb(216, 216, 216); 
	color:rgb(85, 85, 85); 
	font-size:20px; 
	width: 210px; 
	height: 60px;
	border-radius:5px;
	border: 0.2px solid rgb(216, 216, 216);
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 700;
	font-size: 25px;
   }
   #enrollBtn{
	   background:rgb(11, 100, 159); 
	   color:white; font-size:20px; 
	   width: 140px; 
		height: 50px;
	   border-radius:5px;
	   border: 0.2px solid rgb(216, 216, 216);
	   font-family: 'Noto Sans KR', sans-serif;
	   font-weight: 700;
	   font-size: 20px;
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
							</div> 선택
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
					<div class="card mb-4">
						<div class="card-body" align="center">
							<code><h2>문의게시판 관리</h2></code>
						</div>
					</div>
					<br>
					<form id="deleteQna" action="${contextPath}/deleteQnas.do"
						method="post">

						<table class="listArea table table-hover" align="center">
							<thead>
								<tr>
									<th width="100"><button type="reset" id="resetBtn">전체취소</button></th>
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
								<button type="button" id="deleteBtn" onclick="deleteQnas()">선택 게시글 삭제</button>
							</c:if>
						</div>
						</form>
						<br> <br>

						<!-- 페이징바 만들기 -->
						<div class="pagingArea" align="center">
							<!-- 맨 처음으로 (<<) -->
							<button class="pagingicon"
								onclick="location.href='${contextPath}/adminQnaList.do?currentPage=1'">
								&lt;&lt;</button>

							<!-- 이전페이지로(<) -->
							<c:choose>
								<c:when test="${currentPage eq 1}">
									<button class="pagingicon" disabled>&lt;</button>
								</c:when>
								<c:otherwise>
									<button class="pagingicon"
										onclick="location.href='${contextPath}/adminQnaList.do?currentPage=${currentPage - 1}&amdin=admin'">
										&lt;</button>
								</c:otherwise>
							</c:choose>
							<!-- 페이지 목록 -->
							<c:forEach var="p" begin="${startPage}" end="${endPage}" step="1">
								<c:choose>
									<c:when test="${p eq currentPage}">
										<button class="pagingicon" disabled>${p}</button>
									</c:when>
									<c:otherwise>
										<button class="pagingicon"
											onclick="location.href='${contextPath}/adminQnaList.do?currentPage=${p}'">
											${p}</button>
									</c:otherwise>
								</c:choose>
							</c:forEach>

							<!-- 다음페이지로(>) -->
							<c:choose>
								<c:when test="${currentPage eq maxPage}">
									<button class="pagingicon" disabled>&gt;</button>
								</c:when>
								<c:otherwise>
									<button class="pagingicon"
										onclick="location.href='${contextPath}/adminQnaList.do?currentPage=${currentPage + 1}'">
										&gt;</button>
								</c:otherwise>
							</c:choose>

							<!-- 맨 끝으로 (>>) -->
							<button class="pagingicon"
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
				var option = "width=1000, height=800, left=400, top=100, location=no, toolbars=no"
				window.open("${contextPath}/detailQna.do?admin=admin&qno="+qno, "문의글조회", option)
			})
		})
	}
</script>
<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
<script src="js/scripts.js"></script>
</html>