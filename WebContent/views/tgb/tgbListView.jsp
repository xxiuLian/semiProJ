<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.uni.tgb.model.dto.*, com.uni.common.*"%>
<%
	ArrayList<Tgb> list = (ArrayList<Tgb>)request.getAttribute("list");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	
	int listCount = pi.getListCount();
	int currentPage = pi.getCurrentPage();
	int maxPage = pi.getMaxPage();
	int startPage = pi.getStartPage();
	int endPage = pi.getEndPage();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../../css/styles.css" rel="stylesheet" />
</head>
<body>
<%@ include file="../common/menubar.jsp" %>

<h2 align="center">공구 목록 조회</h2>
		<br>
		
		<table class="listArea" align="center">
			<thead>
				<tr>
					<th width="100">글번호</th>
					<th width="100">카테고리</th>
					<th width="300">글제목</th>
					<th width="100">작성자</th>
					<th width="100">조회수</th>
					<th width="150">작성일</th>
				</tr>
			<thead>
			  <tbody>
				<%if(list.isEmpty()){ %>
				<tr>
					<td colspan="6">조회된 리스트가 없습니다.</td>
				</tr>
				<%}else{ %>
					<% for( Tgb t : list){ %>
					<tr>
						<td><%= t.getTgbNo() %></td>
						<td><%= t.getTgbCategory() %>
						<td><%= t.getTgbTitle() %></td>
						<td><%= t.getTgbContent() %></td>
						<td><%= t.getTgbContent() %></td>
						<td><%= t.getCount() %></td>
						<td><%= t.getCreateDate() %></td>
					</tr>
					<%} %>
				<%} %>
			</tbody>
		</table>
		<br><br>
		<!-- 페이징바 -->
		<div>
			<button onclick="location.href='<%=contextPath%>/tgbList.do?currentPage=1'">&lt;&lt;</button>
		</div>
		<!-- 이전페이지로 -->
		<%if(currentPage == 1) {%>
		<button disabled>&lt;</button>
		<%}else{ %>
		<div>
			<button onclick="location.href='<%=contextPath %>/tgbList.do?currentPage=<%=currentPage-1 %>'">&lt;</button>
		</div>
		<%} %>
		
		<!-- 페이지 목록 -->
		<%for(int i = startPage; i<=endPage; i++){ %>
			<%if(i ==currentPage){ %>
			<button disabled><%= i %></button>
			<%}else{ %>
				<button onclick="location.href='<%=contextPath%>/tgbList.do?currentPage='<%=i%>"><%=i %></button>
			<%} %>
		<%} %>
		
		<!-- 다음페이지로 -->
		<%if(currentPage == maxPage) {%>
		<button disabled>&gt;</button>
		<%}else{ %>
		<div>
			<button onclick="location.href='<%= contextPath %>/listBoard.do?currentPage=<%= currentPage+1 %>'"> &gt; </button>
		</div>
		<%} %>
		
		<button onclick="location.href='<%=contextPath%>/listBoard.do?currentPage=<%=maxPage%>'"> &gt;&gt; </button>
		
		
</body>
</html>