<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.uni.tgb.model.dto.*"%>
<%
	ArrayList<Tgb> list = (ArrayList<Tgb>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2 align="center">공구 게시판</h2>
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
			<%--   <tbody>
				<%if(list.isEmpty()){ %>
				<tr>
					<td colspan="6">조회된 리스트가 없습니다.</td>
				</tr>
				<%}else{ %>
					<% for( Tgb t : list){ %>
					<tr>
						<td><%= t.getTgbTitle() %></td>
						<td><%= t.getTgbContent() %></td>
						<td><%= t.getTgbContent() %></td>
						<td><%= t.getCount() %></td>
						<td><%= t.getCreateDate() %></td>
					</tr>
					<%} %>
				<%} %>
			</tbody>
		</table>--%>
</body>
</html>