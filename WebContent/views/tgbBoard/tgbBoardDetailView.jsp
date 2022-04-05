<%@page import="com.uni.tgb_board.model.dto.TgbBoard_dto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	TgbBoard_dto b = (TgbBoard_dto)request.getAttribute("b");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%= b.getTgbBoardTitle() %>
	<%= b.getTgbBoardContent() %>
 	<%= b.getTgbBoardCategory() %>
</body>
</html>