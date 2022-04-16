<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.ArrayList, com.uni.tgb_board.model.dto.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	ArrayList<TgbBoard_dto> list = (ArrayList<TgbBoard_dto>) request.getAttribute("list");
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

							        
		<table class="listArea table table-hover" align="center">
			<thead>
				<tr>
					<th width="100"><button type="reset" id="resetBtn">전체취소</button></th>
					<th width="100">글번호</th>
					<th width="300">글제목</th>
					<th width="150">작성자</th>
					<th width="150">조회수</th>
					<th width="200">작성일</th>
				</tr>
			</thead>
			<tbody>
				 	 <% if(list.isEmpty()){ %>
				 	<tr>
						<td colspan="5">존재하는 공구게시판이 없습니다.</td>
					</tr>
				 <% }else{  %>
				 	<% for(TgbBoard_dto n : list){ %> <!-- 맨위에 ArrayList(<-list)에 담긴것 -->
				 		<tr>
				 		<td><input type="checkbox" id="boardChecked" name="boardChecked" value="<%= n.getTgbBoardNo() %>"></td>
				 			<td><%= n.getTgbBoardNo() %></td>
							<td><%= n.getTgbBoardTitle() %></td>
							<td><%= n.getTgbBoardWriter() %></td>
							<td><%= n.getTgbBoardCount() %></td>
							<td><%= n.getTgbBoardDate() %></td>
				 		</tr>
				 	<% } %>
				 <% } %>
			</tbody>
			
		</table>
		<div class="btns" align="center">
			<c:if test="${!empty list}">
				<button type="button" id="deleteBtn" onclick="deleteBoards()">해당 게시글 삭제</button>
			</c:if>
		</div>
			</form>
			</div>
		<br><br>
		<!-- 페이징바 만들기 -->
		<div class="pagingArea" align="center">
			<!-- 맨 처음으로 (<<) -->
			<button class="pagingicon"
				onclick="location.href='${contextPath}/adminBoard.do.do?currentPage=1'">
				&lt;&lt;</button>

			<!-- 이전페이지로(<) -->
			<c:choose>
				<c:when test="${currentPage eq 1}">
					<button class="pagingicon" disabled>&lt;</button>
				</c:when>
				<c:otherwise>
					<button class="pagingicon"
						onclick="location.href='${contextPath}/adminBoard.do.do?currentPage=${currentPage - 1}'">
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
							onclick="location.href='${contextPath}/adminBoard.do?currentPage=${p}'">
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
						onclick="location.href='${contextPath}/adminBoard.do.do?currentPage=${currentPage + 1}'">
						&gt;</button>
				</c:otherwise>
			</c:choose>

			<!-- 맨 끝으로 (>>) -->
			<button class="pagingicon"
				onclick="location.href='${contextPath}/adminBoard.do.do?currentPage=${maxPage}'">
				&gt;&gt;</button>
		
					<br> <br>
				</div>
			</main>
		</div>
	</div>
	<%@ include file="../../views/common/footer.jsp" %>
</body>
<script>
	function deleteBoards(){
		if(confirm("삭제 하시겠습니까?")){
			$("#deleteBoard").submit();
		}
	}
	if(!${empty list}){
		$(function(){
			$(".listArea>tbody>tr>td:not(:has(input))").click(function(){
				var bno = $(this).parent().children().eq(1).text();
				console.log(bno)
				var option = "width=1000, height=800, left=400, top=100, location=no, toolbars=no"
				window.open("${contextPath}/tgbBoardDetail.do?admin=admin&nno="+bno, "문의글조회", option)
			})
		})
	}
</script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	crossorigin="anonymous"></script>
<script src="js/scripts.js"></script>
</html>