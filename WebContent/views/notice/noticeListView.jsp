<%@page import="com.uni.notice.model.dto.NoticeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.uni.notice.model.dto.NoticeDto"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="listCount" value="${pi.listCount}" scope="request" />
<c:set var="currentPage" value="${pi.currentPage}" scope="request" />
<c:set var="maxPage" value="${pi.maxPage}" scope="request" />
<c:set var="startPage" value="${pi.startPage}" scope="request" />
<c:set var="endPage" value="${pi.endPage}" scope="request" />
<%
	ArrayList<NoticeDto> list = (ArrayList<NoticeDto>) request.getAttribute("list");
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
	
	/* .listArea>tbody>tr:hover{
		background:lightgrey;
		cursor:pointer
	} */
	
	.pagingArea{
		margin-top:15px;
	}
	.pagingArea button{
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
</style>
</head>
<body>
<%@ include file="../common/menubar.jsp" %>

	<div class="outer">
		<br>
		<h2 align="center">공지사항</h2>
		<br>
		        
		<table class="listArea table table-hover" align="center">
			<thead>
				<tr>
					<th>글번호</th>
					<th width="300">글제목</th>
					<th width="100">작성자</th>
					<th>조회수</th>
					<th width="200">작성일</th>
				</tr>
			</thead>
			<tbody>
				 	 <% if(list.isEmpty()){ %>
				 	<tr>
						<td colspan="5">존재하는 공지사항이 없습니다.</td>
					</tr>
				 <% }else{  %>
				 	<% for(NoticeDto n : list){ %> <!-- 맨위에 ArrayList(<-list)에 담긴것 -->
				 		<tr>
				 			<td><%= n.getNoticeNo() %></td>
							<td><%= n.getNoticeTitle() %></td>
							<td><%= n.getNoticeWriter() %></td>
							<td><%= n.getCount() %></td>
							<td><%= n.getCreateDate() %></td>
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
			<button class="btn btn-default" id="searchbtn" type="submit">검색하기</button>
		</form>
		
		<!-- 페이징바 만들기 -->
		<div class="pagingArea" align="center">
			<!-- 맨 처음으로 (<<) -->
			<button
				onclick="location.href='${contextPath}/noticeList.do?currentPage=1'">
				&lt;&lt;</button>

			<!-- 이전페이지로(<) -->
			<c:choose>
				<c:when test="${currentPage eq 1}">
					<button disabled>&lt;</button>
				</c:when>
				<c:otherwise>
					<button
						onclick="location.href='${contextPath}/noticeList.do?currentPage=${currentPage - 1}'">
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
							onclick="location.href='${contextPath}/noticeList.do?currentPage=${p}'">
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
						onclick="location.href='${contextPath}/noticeList.do?currentPage=${currentPage + 1}'">
						&gt;</button>
				</c:otherwise>
			</c:choose>

			<!-- 맨 끝으로 (>>) -->
			<button
				onclick="location.href='${contextPath}/noticeList.do?currentPage=${maxPage}'">
				&gt;&gt;</button>
		
		<br><br>
		<div align="center">
			<% if(loginUser != null && loginUser.getUserId().equals("admin")) { %> 
			<!-- admin일 경우 컨트롤/NoticeEnrollFormServlet -->
			
			<button class="btn btn-default" id="writeadmin" onclick="location.href='<%=contextPath%>/enrollFormNotice.do'">작성하기</button> 
		<% } %>
		</div>
		
	</div>
	</div>
	<script type="text/javascript">
		<% if(!list.isEmpty()){%>
			$(function(){
				$(".listArea>tbody>tr").click(function(){
					var nno = $(this).children().eq(0).text();
					
					location.href="<%=contextPath%>/noticeDetail.do?nno="+nno;
				})
			})
		<%}%>
	</script>
	

	
</body>
</html>