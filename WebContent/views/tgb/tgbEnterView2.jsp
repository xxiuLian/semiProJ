 <%@page import="java.util.ListIterator"%>
<%@page import="com.uni.common.PageInfo"%>
<%@page import="com.uni.tgb_board.model.dto.TgbBoard_dto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.uni.member.model.dto.Member" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="listCount" value="${pi.listCount}" scope="request" />
<c:set var="currentPage" value="${pi.currentPage}" scope="request" />
<c:set var="maxPage" value="${pi.maxPage}" scope="request" />
<c:set var="startPage" value="${pi.startPage}" scope="request" />
<c:set var="endPage" value="${pi.endPage}" scope="request" />
  
<%
	ArrayList<TgbBoard_dto> list = (ArrayList<TgbBoard_dto>)request.getAttribute("list");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
.tgbBoardArea{
		border:1px solid white;
		text-align:center;
	}
.tgbBoardArea>tbody>tr:hover{
	background:darkgrey;
	cursor:pointer
}
</style>
</head>
<body>
<%@ include file="../common/menubar.jsp" %>
<jsp:include page = "tgbEnterView.jsp"/>

	<!-- 1.목록 -->
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
			<% if(loginUser != null && loginUser.getUserId().equals("admin")) { %> 
			<!-- admin일 경우 컨트롤/NoticeEnrollFormServlet -->
			
			<button onclick="location.href='<%=contextPath%>/enrollFormNotice.do'">작성하기</button> 
		<% } %>
		</div>
		
	</div>
	<script>
	<%if(!list.isEmpty()){%>
		$(function(){
			$(".tgbBoardArea>tbody>tr").click(function(){
				var bno = $(this).children().eq(0).text();
				location.href = "<%=contextPath%>/tgbBoardDetail.do?bno="+bno;
			})
		})
	<%}%>
	</script>
</body>
</html>