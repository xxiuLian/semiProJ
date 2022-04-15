<%@page import="com.uni.event.model.dto.EventDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.uni.event.model.dto.EventDto"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="listCount" value="${pi.listCount}" scope="request" />
<c:set var="currentPage" value="${pi.currentPage}" scope="request" />
<c:set var="maxPage" value="${pi.maxPage}" scope="request" />
<c:set var="startPage" value="${pi.startPage}" scope="request" />
<c:set var="endPage" value="${pi.endPage}" scope="request" />
    
<%
	ArrayList<EventDto> list = (ArrayList<EventDto>) request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/styles.css" rel="stylesheet" />
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
</style>
</head>
<body>
<%@ include file="../common/menubar.jsp" %>

	<div class="outer">
		<br>
		<h2 align="center">이벤트</h2>
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
						<td colspan="5">존재하는 이벤트가 없습니다.</td>
					</tr>
				 <% }else{  %>
				 	<% for(EventDto n : list){ %> <!-- 맨위에 ArrayList(<-list)에 담긴것 -->
				 		<tr>
				 			<td><%= n.getEventNo() %></td>
							<td><%= n.getEventTitle() %></td>
							<td><%= n.getEventWriter() %></td>
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
			<button class="pagingicon"
				onclick="location.href='${contextPath}/eventList.do?currentPage=1'">
				&lt;&lt;</button>

			<!-- 이전페이지로(<) -->
			<c:choose>
				<c:when test="${currentPage eq 1}">
					<button class="pagingicon" disabled>&lt;</button>
				</c:when>
				<c:otherwise>
					<button class="pagingicon"
						onclick="location.href='${contextPath}/eventList.do?currentPage=${currentPage - 1}'">
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
							onclick="location.href='${contextPath}/eventList.do?currentPage=${p}'">
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
						onclick="location.href='${contextPath}/eventList.do?currentPage=${currentPage + 1}'">
						&gt;</button>
				</c:otherwise>
			</c:choose>

			<!-- 맨 끝으로 (>>) -->
			<button class="pagingicon"
				onclick="location.href='${contextPath}/eventList.do?currentPage=${maxPage}'">
				&gt;&gt;</button>
				
			<!-- 페이징끝 -->
		
		<br><br>
		<div align="center">
			<% if(loginUser != null && loginUser.getUserId().equals("admin")) { %> 
			<!-- admin일 경우 컨트롤/NoticeEnrollFormServlet -->
			
			<button class="btn btn-default" id="writeadmin" onclick="location.href='<%=contextPath%>/enrollFormEvent.do'">작성하기</button> 
		<% } %>
		</div>
		
	</div>
	</div>
	<script type="text/javascript">
		<% if(!list.isEmpty()){%>
			$(function(){
				$(".listArea>tbody>tr").click(function(){
					var nno = $(this).children().eq(0).text();
					
					location.href="<%=contextPath%>/eventDetail.do?nno="+nno;
				})
			})
		<%}%>
	</script>
	 <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <!-- * *                               SB Forms JS                               * *-->
        <!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</body>
</html>