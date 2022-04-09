<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<b>카테고리 추가</b>
	<br>
	
	<form id="addCategory" action="<%= request.getContextPath() %>/addCategory.do" method="post">
		<table>
			<tr>
				<td><label>카테고리 번호</label>
				<td><input type="text" name="cno" id="cno"></td>
			</tr>
			<tr>
				<td><label>카테고리 이름</label></td>
				<td><input type="text" name="cname" id="cname"></td>
			</tr>
		</table>
		
		<br>
		<br>
		
		<div class="btns" align="center">
			<button type="submit">추가하기</button>
		</div>
	</form>
</body>
</html>