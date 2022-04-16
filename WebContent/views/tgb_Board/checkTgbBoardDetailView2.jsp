<%@page import="com.uni.tgb_board.model.dto.TgbBoard_dto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.uni.tgb_board.model.dto.*" %>
<%
TgbBoard_dto b = (TgbBoard_dto)request.getAttribute("b");
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
		
		<h2 align="center">공구_게시판 상세보기</h2>
		

		<table class="table table-condensed" id="detailArea">
			<tr>
				<td>제목</td>
				<td colspan="4"><%= b.getTgbBoardTitle() %></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><%= b.getTgbBoardWriter() %></td>
				<td></td>
				<td>작성일</td>
				<td><%= b.getTgbBoardDate() %></td>
			</tr>
			<tr>
				<td colspan="5">내용</td>
			
			</tr>
			<tr>
				<td colspan="5">
					<p><%= b.getTgbBoardContent() %></p>
				</td>
			</tr>	
		</table>
		
		<br>

		<%--
			<div class="btns" align="center">
				<a href="tgbBoardSelect.do">목록으로</a> &nbsp;&nbsp;
				<% 
				if(loginUser != null && loginUser.getUserNo() == Integer.parseInt(b.getTgbBoardWriter())) { %>
					<a href="tgbBoardUpdateForm.do?nno=<%=b.getTgbBoardNo()%>">수정하기</a> &nbsp;&nbsp;
					<a href="ChecktgbBoardDelete.do?nno=<%=b.getTgbBoardNo()%>">삭제하기</a>
				<% } %>
			</div>
		--%>
	</div>
</body>
</html>