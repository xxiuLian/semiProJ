<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.uni.tgb.model.dto.*, com.uni.common.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	ArrayList<Tgb> finishList = (ArrayList<Tgb>)request.getAttribute("finishList");
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
        <style>

	#updateForm{
		/* border:1px solid white; */
		width:100%;
		margin-left:auto;
		margin-right:auto;
	}
	#updateForm td:nth-child(1){text-align:right;}
	#updateForm input{margin:3px;}
	
	#joinBtn{background:yellowgreen;}
	#goMain{background:orangered;}
	ul, li { list-style: none; }
	
</style>
    </head>
    <body>
    <%@ include file="../../views/common/menubar.jsp" %>
    
        <div class="d-flex" id="wrapper">
            <!-- Sidebar-->
            <div class="border-end bg-white" id="sidebar-wrapper">
                <div class="sidebar-heading border-bottom bg-light"><a href="<%=contextPath %>/myPage.do">Start Bootstrap</a></div>
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
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="#!">Events</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="#!">Profile</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="#!">Status</a>
                </div>
            </div>
            <!-- Page content wrapper-->
            <div id="page-content-wrapper">
                <!-- Top navigation-->
                <nav class="navbar navbar-expand-lg navbar-light bg-dark border-bottom">
                    <div class="container-fluid">
                        <button class="btn btn-primary" id="sidebarToggle">My Menu</button>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav ms-auto mt-2 mt-lg-0 bg-light">
                                <li class="nav-item active"><a class="nav-link" href="/valueSa">Home</a></li>
                                <li class="nav-item"><a class="nav-link" href="#!">Link</a></li>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Dropdown</a>
                                    <div class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                                        <a class="dropdown-item" href="#!">Action</a>
                                        <a class="dropdown-item" href="#!">Another action</a>
                                        <div class="dropdown-divider"></div>
                                        <a class="dropdown-item" href="#!">Something else here</a>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
                <!-- Page content-->
				<!-- <div class="content"></div> -->
				
		<h2 align="center">나의 완료 상품</h2>
		<br>
		<div class="myGoods" align="center">
		<table class="listArea" align="center">
			<thead>
				<tr>
					<th width="50">글번호</th>
					<th width="100">썸네일</th>
					<th width="300">글제목</th>
					<th width="150">작성일</th>
				</tr>
			<thead>
		  	<tbody>
				<c:choose>
					<c:when test="${empty joinList}">
						<tr>
							<td colspan="5">공동구매 만료 내역이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${finishList}" var="finishList" varStatus="status">
						<c:out value="${status.index}" /> / <c:out value="${status.end}" />
							<tr class="list">
								<td>${finishList.tgbNo}</td>
								<td><img src="<%=contextPath%>/assets/img_upfile/${finishList.thumnail}" width="100px" height="100px"></td>
								<td>${finishList.tgbTitle }</td>
								<td>${finishList.createDate }</td>
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
			<button onclick="location.href='${contextPath}/myPayList.do?currentPage=1'">&lt;&lt;</button>

			<!-- 이전페이지로(<) -->
			<c:choose>
				<c:when test="${currentPage eq 1}">
					<button disabled>&lt;</button>
				</c:when>
				<c:otherwise>
					<button
						onclick="location.href='${contextPath}/myPayList.do?currentPage=${currentPage - 1}'">
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
							onclick="location.href='${contextPath}/myPayList.do?currentPage=${p}'">
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
						onclick="location.href='${contextPath}/myPayList.do?currentPage=${currentPage + 1}'">
						&gt;
					</button>
				</c:otherwise>
			</c:choose>

			<!-- 맨 끝으로 (>>) -->
			<button
				onclick="location.href='${contextPath}/myPayList.do?currentPage=${maxPage}'">
				&gt;&gt;</button>
		</div>
		<br> <br>
		</div>
		<!--<h2 align="center">진행</h2>
		<br>
		<div class="listArea" align="center">
		</div>-->
		</div>
		</div>





        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/myPageScripts.js"></script>
    </body>
</html>
