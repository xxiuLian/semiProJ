<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
</head>
<body>
<%@ include file="../../views/common/menubar.jsp" %>
<div class="container">
	회원가입 성공!
	<div class="btnsArea">
		<div class="btn"><button type="button" id="goMain" onclick= "location.href='<%= request.getContextPath()%>'">메인으로</button></div>
		<div class="btn"><button type="button" id="login" onclick= "location.href='<%= request.getContextPath()%>/login.do'">로그인</button></div>
	</div>
</div>
</body>
</html>