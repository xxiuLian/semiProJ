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
		background:#fff;
		color:black;
		margin:auto;
		margin-top:50px;
	}
	#detailArea{width:100%; margin: 15px auto;border-color:black;}
	#detailArea p{height:150px;}
	#detailArea th{font-size:20px;}
	#detailArea td{font-size:18px;}
	.btns a{text-decoration:none; color:black;}
	
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	
	<div class="outer">
		<br>
		
		<h2 align="center">이벤트 상세보기</h2>
		
		<!-- id="detailArea" -->
		<table class="table table-condensed" id="detailArea">
			<tr>
				<th>제목</th>
				<th colspan="4"><%= n.getEventTitle() %></th>
			</tr>
			<tr>
				<th>작성자</th>
				<td><%= n.getEventWriter() %></td>
				<td></td>
				<th>작성일</th>
				<td><%= n.getCreateDate() %></td>
			</tr>
			<tr>
				<th colspan="5">내용</th>
			
			</tr>
			<tr>
				<td colspan="5">
					<p><%= n.getEventContent() %></p>
				</td>
			</tr>	
		</table>
		
		<br>
		
		<div class="btns" align="center">
		
			<a href="eventList.do">목록으로</a> &nbsp;&nbsp;
				
			
			<% if(loginUser != null && loginUser.getUserId().equals("admin")) { %>
			<a href="updateFormEvent.do?nno=<%=n.getEventNo()%>">수정하기</a> &nbsp;&nbsp;
			<a href="deleteEvent.do?nno=<%=n.getEventNo()%>">삭제하기</a>
		
			<% } %>
			
		</div>
	</div>
</body>
</html>