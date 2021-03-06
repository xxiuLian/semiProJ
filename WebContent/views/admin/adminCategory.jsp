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
	#deleteBtn,  #resetBtn{
		border: 1px solid black;
		
	}
	 #deleteBtn:hover{
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
   #deleteBtn{
	background:rgb(216, 216, 216); 
	color:rgb(85, 85, 85); 
	font-size:20px; 
	width: 250px; 
	height: 60px;
	border-radius:5px;
	border: 0.2px solid rgb(216, 216, 216);
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 700;
	font-size: 25px;
   }
   
   #blueBtn{
	   background:rgb(11, 100, 159); 
	   color:white; 
	   width: 140px; 
	   height: 40px;
	   border-radius:5px;
	   border: 0.2px solid rgb(216, 216, 216);
	   font-family: 'Noto Sans KR', sans-serif;
	   font-weight: 700;
	   font-size: 17px;
	   margin-bottom: 20px;
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
						<div class="sb-sidenav-menu-heading">??????</div>
						<a class="nav-link" href="adminMember.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-tachometer-alt"></i>
							</div> ?????? ??????
						</a>
						<div class="sb-sidenav-menu-heading">??????</div>
						<a class="nav-link" href="adminTGB.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-tachometer-alt"></i>
							</div> ?????? ??????
						</a><a class="nav-link" href="adminReportTgb.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-tachometer-alt"></i>
							</div> ????????? ??????
						</a>
						<div class="sb-sidenav-menu-heading">?????????</div>
						<a class="nav-link" href="adminQnaList.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-tachometer-alt"></i>
							</div> ??????
						</a> <a class="nav-link" href="adminBoard.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-tachometer-alt"></i>
							</div> ???????????? ?????????
						</a>
						<div class="sb-sidenav-menu-heading">????????????</div>
						<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
							data-bs-target="#collapseLayouts" aria-expanded="false"
							aria-controls="collapseLayouts">
							<div class="sb-nav-link-icon">
								<i class="fas fa-columns"></i>
							</div> ??????
							<div class="sb-sidenav-collapse-arrow">
								<i class="fas fa-angle-down"></i>
							</div>
						</a>
						<div class="collapse" id="collapseLayouts"
							aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
							<nav class="sb-sidenav-menu-nested nav">
								<a class="nav-link" href="categoryList.do?keyword=tgb">??????</a> <a
									class="nav-link" href="categoryList.do?keyword=board">???????????? ?????????</a> <a
									class="nav-link" href="categoryList.do?keyword=qna">??????</a>
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
							<code><h2>???????????? ??????</h2></code>
						</div>
					</div>
					<br>
				<div class="outer">
					<div class="btns" align="right">
						<button type="button" id="blueBtn" onclick="addCategory()">???????????? ??????</button>
					</div>
					<form id="deleteCategory" action="${contextPath}/deleteCategory.do?keyword=${keyword}"
						method="post">

						<table class="listArea table table-hover" align="center">
							<thead>
								<tr>
									<th width="100"><button id="resetBtn" type="reset">????????????</button></th>
									<th width="300">???????????? ??????</th>
									<th width="300">???????????????</th>
								</tr>
							<thead>
							<tbody id="tbody">
								<c:choose>
									<c:when test="${empty category}">
										<tr>
											<td colspan="7">????????? ???????????? ????????????.</td>
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
								<button type="button" id="deleteBtn" onclick="deleteCategorys()">?????? ???????????? ??????</button>
							</c:if>
						</div>
						</form>
						</div>
						<br> <br>

				</div>
			</main>
			</div>
		</div>
	<%@ include file="../../views/common/footer.jsp" %>
</body>
<script>
	function deleteCategorys(){
		if(confirm("?????????????????????????")){
			$("#deleteCategory").submit();
		}
	}
	
	function addCategory(){
		var option = "width=500, height=450, left=700, top=300, location=no, toolbars=no"
		window.open("${contextPath}/addCategoryForm.do?keyword=${keyword}", "???????????? ??????", option );
	}

	if(!${empty category}){
		$(function(){
			$(".listArea>tbody>tr>td:not(:has(input))").click(function(){
				var cno = $(this).parent().children().eq(1).text();
				console.log(cno)
					var option = "width=500, height=450, left=700, top=300, location=no, toolbars=no"
				window.open("${contextPath}/selectCategory.do?keyword=${keyword}&cno="+cno, "???????????? ??????", option)
			})
		})
	}
</script>
<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
<script src="js/scripts.js"></script>
</html>