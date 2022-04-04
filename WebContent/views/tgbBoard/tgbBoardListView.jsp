<%@page import="com.uni.tgb_board.model.dto.TgbBoard_pageInfo"%>
<%@page import="com.uni.tgb_board.model.dto.TgbBoard_dto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String contextPath = request.getContextPath(); %>
<%
	ArrayList<TgbBoard_dto> list = (ArrayList<TgbBoard_dto>)request.getAttribute("list");
	TgbBoard_pageInfo pi = (TgbBoard_pageInfo)request.getAttribute("pi");
	
	int noStart = pi.getNoStart();
	int noEnd = pi.getNoEnd();
	int currentPage = pi.getCurrentPage();
	
%>
noStart : <%= noStart %> <br>
noEnd : <%= noEnd %> <br>
currentPage : <%= currentPage %> <br>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 1.목록 -->
	<table>
		<thead></thead>
		<tbody>
				<%if(list.isEmpty()){ %>
				<tr>
					<td>조회된 리스트가 없습니다.</td>
				</tr>
				<%}else{ %>
					<% for(TgbBoard_dto b : list){ %>
					<tr>
						<td><%= b.getTgbBoardNo() %></td>
						<td><%= b.getTgbBoardCategory() %></td>
						<td><%= b.getTgbBoardWriter() %></td>
						<td><%= b.getTgbBoardTitle() %></td>
						<td><%= b.getTgbBoardContent() %></td>
						<td><%= b.getTgbBoardCount() %></td>
						<td><%= b.getTgbBoardDate() %></td>
						<td><%= b.getTgbBoardStatus() %></td>
					</tr>
					<%} %>
				<%} %>
		</tbody>
	</table>
	
	<!-- 2.페이징바 -->
	<div class="pagingArea" align="center">
		<button onclick="location.href='<%=request.getContextPath()%>/tgbBoardSelect.do?currentPage=1'"> &lt;&lt;</button> 
	</div>
	
		<!-- 페이지 목록 -->
	<%for(int p=noStart; p<=noEnd; p++){ %>
		<% if(p == currentPage){ %>
		
		<% }else{ %>
		
		<%} %>
	<%} %>
	
</body>
</html>