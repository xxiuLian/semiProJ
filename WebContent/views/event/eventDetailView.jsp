<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.uni.event.model.dto.EventDto" %>
<%
	EventDto n = (EventDto)request.getAttribute("event");
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
	#detailArea{width:60%; margin:auto;border-color:white;}
	#detailArea p{height:150px;}
	.btns a{text-decoration:none; color:white;}
	
	
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	
	<div class="outer">
		<br>
		
		<h2 align="center">공지사항 상세보기</h2>
		

		<table id="detailArea" border="1">
			<tr>
				<td>제목</td>
				<td colspan="3"><%= n.getEventTitle() %></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><%= n.getEventWriter() %></td>
				<td>작성일</td>
				<td><%= n.getCreateDate() %></td>
			</tr>
			<tr>
				<td colspan="4">내용</td>
			
			</tr>
			<tr>
				<td colspan="4">
					<p><%= n.getEventContent() %></p>
				</td>
			</tr>	
		</table>
		
		<br>
		
		<div class="btns" align="center">
		
			<a href="noticeList.do">목록으로</a> &nbsp;&nbsp;
				
			
			<% if(loginUser != null && loginUser.getUserId().equals("admin")) { %>
			<a href="updateFormNotice.do?nno=<%=n.getEventNo()%>">수정하기</a> &nbsp;&nbsp;
			<a href="deleteNotice.do?nno=<%=n.getEventNo()%>">삭제하기</a>
		
			<% } %>
			
		</div>
	</div>
</body>
</html>