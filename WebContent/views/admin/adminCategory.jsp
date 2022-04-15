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
	.grayBtn,  #resetBtn{
		border: 1px solid black;
		
	}
	 .grayBtn:hover{
		background-color:#eee;
	}
	#resetBtn:hover{
		background-color:#eee;
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
     .grayBtn{
	background:rgb(216, 216, 216); 
	color:rgb(85, 85, 85); 
	font-size:20px; 
	width: 200px; 
	height: 50px;
	border-radius:5px;
	border: 0.2px solid rgb(216, 216, 216);
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 700;
	font-size: 15px;
   }
   #blueBtn{
	   background:rgb(11, 100, 159); 
	   color:white; 
	   width: 100px; 
	   height: 40px;
	   border-radius:5px;
	   border: 0.2px solid rgb(216, 216, 216);
	   font-family: 'Noto Sans KR', sans-serif;
	   font-weight: 700;
	   font-size: 13px;
	}
</style>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
					<h1 class="mt-4">카테고리 관리</h1>
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
				<div class="outer">
					<div class="btns" align="right">
						<button type="button" id="blueBtn" onclick="addCategory()">카테고리 추가</button>
					</div>
					<form id="deleteCategory" action="${contextPath}/deleteCategory.do?keyword=${keyword}"
						method="post">

						<table class="listArea table table-hover" align="center">
							<thead>
								<tr>
									<th width="100"><button id="resetBtn" type="reset">전체취소</button></th>
									<th width="300">카테고리 번호</th>
									<th width="300">카테고리명</th>
								</tr>
							<thead>
							<tbody id="tbody">
								<c:choose>
									<c:when test="${empty category}">
										<tr>
											<td colspan="7">조회된 리스트가 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="c" items="${category}">
											<tr>
												<td><input type="checkbox" id="categoryChecked" name="categoryChecked" value="${c.categoryNo}"></td>
												<td>${c.categoryNo}</td>
												<td>${c.categoryName}</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
						<br>
						<div class="btns" align="center">
							<c:if test="${!empty category}">
								<button type="button" class="grayBtn" onclick="deleteCategorys()">선택 카테고리 삭제</button>
							</c:if>
						</div>
						</form>
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
	</div>
</body>
<script>
	function deleteCategorys(){
		if(confirm("삭제하시겠습니까?")){
			$("#deleteCategory").submit();
		}
	}
	
	function addCategory(){
		var option = "width=500, height=450, left=700, top=300, location=no, toolbars=no"
		window.open("${contextPath}/addCategoryForm.do?keyword=${keyword}", "카테고리 추가", option );
	}

	if(!${empty category}){
		$(function(){
			$(".listArea>tbody>tr>td:not(:has(input))").click(function(){
				var cno = $(this).parent().children().eq(1).text();
				console.log(cno)
				window.open("${contextPath}/selectCategory.do?keyword=${keyword}&cno="+cno, "카테고리 수정", "width=500, height=170 left=800, top=200" )
			})
		})
	}
</script>
<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
<script src="js/scripts.js"></script>
</html>