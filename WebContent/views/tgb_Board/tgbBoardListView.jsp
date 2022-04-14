<%@page import="com.uni.tgb_board.model.dto.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.uni.tgb_board.model.dto.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="listCount" value="${pi.listCount}" scope="request" />
<c:set var="currentPage" value="${pi.currentPage}" scope="request" />
<c:set var="maxPage" value="${pi.maxPage}" scope="request" />
<c:set var="startPage" value="${pi.startPage}" scope="request" />
<c:set var="endPage" value="${pi.endPage}" scope="request" />
<%
	ArrayList<TgbBoard_dto> list = (ArrayList<TgbBoard_dto>) request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>
<style>
	.outer{
		width:800px;
		height:500px;
		background:black;
		color:white;
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
	
	.listArea>tbody>tr:hover{
		background:darkgrey;
		cursor:pointer
	}
</style>
</head>
<body>
<%@ include file="../common/menubar.jsp" %>

	<div class="outer">
		<br>
		<h2 align="center">공구_게시판</h2>
		<br>
		        
		<table class="listArea" align="center">
			<thead>
				<tr>
					<th>글번호</th>
					<th width="300">글제목</th>
					<th width="100">작성자</th>
					<th>조회수</th>
					<th width="100">작성일</th>
				</tr>
			</thead>
			<tbody>
				<!-- 
				<tr>
					<td>3</td>
					<td>마지막 공지사항제목</td>
					<td>admin</td>
					<td>10</td>
					<td>2020-02-10</td>
				</tr>
				<tr>
					<td>2</td>
					<td>두번째 공지사항제목</td>
					<td>admin</td>
					<td>100</td>
					<td>2020-02-01</td>
				</tr>
				<tr>
					<td>1</td>
					<td>첫번째 공지사항 제목</td>
					<td>admin</td>
					<td>45</td>
					<td>2019-12-25</td>
				</tr>
				 -->
				 	 <% if(list.isEmpty()){ %>
				 	<tr>
						<td colspan="5">존재하는 공지사항이 없습니다.</td>
					</tr>
				 <% }else{  %>
				 	<% for(TgbBoard_dto n : list){ %> <!-- 맨위에 ArrayList(<-list)에 담긴것 -->
				 		<tr>
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
		
		<form class="searchArea" align="center">
			<select id="condition" name="condition">
				<option value="writer">작성자</option>
				<option value="title">제목</option>
				<option value="content">내용</option>
			</select>
			<input type="search" name="search">
			<button type="submit">검색하기</button>
		</form>
		
		<!-- 페이징바 만들기 -->
		<div class="pagingArea" align="center">
			<!-- 맨 처음으로 (<<) -->
			<button
				onclick="location.href='${contextPath}/tgbBoardSelect.do?currentPage=1'">
				&lt;&lt;</button>

			<!-- 이전페이지로(<) -->
			<c:choose>
				<c:when test="${currentPage eq 1}">
					<button disabled>&lt;</button>
				</c:when>
				<c:otherwise>
					<button
						onclick="location.href='${contextPath}/tgbBoardSelect.do?currentPage=${currentPage - 1}'">
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
							onclick="location.href='${contextPath}/tgbBoardSelect.do?currentPage=${p}'">
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
						onclick="location.href='${contextPath}/tgbBoardSelect.do?currentPage=${currentPage + 1}'">
						&gt;</button>
				</c:otherwise>
			</c:choose>

			<!-- 맨 끝으로 (>>) -->
			<button
				onclick="location.href='${contextPath}/tgbBoardSelect.do?currentPage=${maxPage}'">
				&gt;&gt;</button>
		
		<br><br>
		<div align="center">
			<% if(loginUser != null) { %> 
			<!-- admin일 경우 컨트롤/NoticeEnrollFormServlet -->
			
			<button onclick="location.href='<%=contextPath%>/EnrollTgbBoard.do'">작성하기</button> 
		<% } %>
		</div>
		
	</div>
	<script type="text/javascript">
		<% if(!list.isEmpty()){%>
			$(function(){
				$(".listArea>tbody>tr").click(function(){
					var nno = $(this).children().eq(0).text();
					
					location.href="<%=contextPath%>/tgbBoardDetail.do?nno="+nno;
				})
			})
		<%}%>
	</script>
	

	
</body>
</html>