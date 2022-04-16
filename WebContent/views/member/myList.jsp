<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.uni.tgb.model.dto.*, com.uni.common.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	ArrayList<Tgb> list = (ArrayList<Tgb>)request.getAttribute("list");
	ArrayList<Tgb> joinList = (ArrayList<Tgb>)request.getAttribute("joinList");
%>
<c:set var="listCount" value="${pi.listCount}" scope="request" />
<c:set var="currentPage" value="${pi.currentPage}" scope="request" />
<c:set var="maxPage" value="${pi.maxPage}" scope="request" />
<c:set var="startPage" value="${pi.startPage}" scope="request" />
<c:set var="endPage" value="${pi.endPage}" scope="request" />

<c:set var="loginUser" value="${sessionScope.loginUser}" scope="session"/>
<c:set var="msg" value="${sessionScope.msg}" scope="session"/>
<c:set var="contextPath" value="<%= request.getContextPath()%>" scope="session"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Simple Sidebar - Start Bootstrap Template</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/myPageStyles.css" rel="stylesheet" />
         <!-- Google fonts-->
		<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
		<link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
<style>
	.myGoods{
		width:1000px;
		margin: 0 auto;
	}

	ul, li { list-style: none; }
	.pagingArea>button{
		border: 1px solid lightgray;
		border-radius: 5px;
	}
	.listArea tr{
	  font-family: "Montserrat", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
	  font-size: 20px;
  	  color: #495057;
      letter-spacing: 0.0625em;
	}
	.listArea td{
	  font-family: "Montserrat", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
	  font-size: 20px;
  	  color: #495057;
      letter-spacing: 0.0625em;
      vertical-align:middle;
	}
	
</style>

    </head>
    <body>
    <%@ include file="../../views/common/menubar.jsp" %>
    <div class="container">
        <div class="d-flex" id="wrapper">
            <!-- Sidebar-->
            <div class="border-end bg-white" id="sidebar-wrapper">
                <div class="sidebar-heading border-bottom bg-light"><a href="<%=contextPath %>/myPage.do">HOME</a></div>
                <div class="list-group list-group-flush">
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="myInfo.do" id="myInfo">내 정보</a>
                    <div>
                    <a id="myList" class="list-group-item list-group-item-action list-group-item-light p-3" href="myList.do">공동구매 내역 조회</a>
                    <ul>
						<li><a class="nav-link" href="myList.do">나의 진행 상품</a></li>
						<li><a class="nav-link" href="myPayList.do">나의 참여 상품</a></li> 
						<li><a class="nav-link" href="myFinishList.do">이전 상품</a></li>
					</ul>
                    </div>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="wishList.do">찜내역관리</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="checkQnaList.do">문의내역조회</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="checkBoardTGBList.do">공동구매게시판조회</a>
                   
                </div>
            </div>
            <!-- Page content wrapper-->
            <div id="page-content-wrapper">
                <!-- Top navigation-->
                <!-- Page content-->
				<!-- <div class="content"></div> -->
		<h2 align="center" style="margin-top:25px;">${loginUser.getUserName()} 님의 진행 상품</h2>
		<br>
		<div class="myGoods" align="center">
		<table class="listArea table table-hover" align="center">
			<thead>
				<tr>
					<th width="100">번호</th>
					<th width="100"></th>
					<th width="300">제목</th>
					<th width="150">작성일</th>
				</tr>
			<thead>
		  	<tbody>
				<c:choose>
					<c:when test="${empty list}">
						<tr>
							<td colspan="5" align="center">공동구매 진행 내역이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${list}" var="list" varStatus="status">
						<!-- <c:out value="${status.index}" /> / <c:out value="${status.end}" /> -->
							<tr class="list">
								<td>${list.tgbNo}</td>
								<td><img src="<%=contextPath%>/assets/img_upfile/${list.thumnail}" width="200px" height="200px"></td>
								<td>${list.tgbTitle }</td>
								<td>${list.createDate }</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<br>
		
		<!-- 페이징바 만들기 -->
		<div class="pagingArea" align="center">
			<!-- 맨 처음으로 (<<) -->
			<button onclick="location.href='${contextPath}/myList.do?currentPage=1'">&lt;&lt;</button>

			<!-- 이전페이지로(<) -->
			<c:choose>
				<c:when test="${currentPage eq 1}">
					<button disabled>&lt;</button>
				</c:when>
				<c:otherwise>
					<button
						onclick="location.href='${contextPath}/myList.do?currentPage=${currentPage - 1}'">
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
							onclick="location.href='${contextPath}/myList.do?currentPage=${p}'">
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
						onclick="location.href='${contextPath}/myList.do?currentPage=${currentPage + 1}'">
						&gt;
					</button>
				</c:otherwise>
			</c:choose>

			<!-- 맨 끝으로 (>>) -->
			<button
				onclick="location.href='${contextPath}/myList.do?currentPage=${maxPage}'">
				&gt;&gt;</button>
		</div>
		<br> <br>
		</div>
	   </div>
	</div>
	</div>
<script>
if(!${empty list}){
	$(function(){
		$(".listArea>tbody>tr>td:not(:has(input))").click(function(){
			var bno = $(this).parent().children().eq(0).text();
			location.href="${contextPath}/detailTgb.do?bno="+bno;
		})
	})
}
</script>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/myPageScripts.js"></script>
    </body>
</html>
