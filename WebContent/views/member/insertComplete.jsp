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
<style type="text/css">
.outer{
	width:900px;
	height:500px;
	color:black;
	margin:auto;
	margin-top:50px;
	text-align : center;
	background-color: rgb(217, 237, 255);
	border-radius: 7px;
}
.btnsArea{
    margin-top: 50px;
}
.btn button{
	border-radius: 7px;
	border: 0px;
	padding: 10px;
	background-color: rgb(75, 125, 168);
	padding-left: 20px;
	padding-right: 20px;
	color: white;
	font-weight: bold;
	font-family: 'Noto Sans KR', sans-serif;
	margin: 5px;
}
.btn button:hover{
	background-color: rgb(17, 69, 114);
	
}
.title{
    margin-top: 30px;
}
</style>
</head>
<body>
<%@ include file="../../views/common/menubar.jsp" %>
	<div class="outer">
        <h2>회원가입 성공!</h2>
        <div class="btnsArea">
            <div class="btn"><button type="button" id="goMain" onclick= "location.href='<%= request.getContextPath()%>'">메인으로</button></div>
            <div class="btn"><button type="button" id="login" onclick= "location.href='<%= request.getContextPath()%>/login.do'">로그인</button></div>
        </div>
    </div>
<%@ include file="../../views/common/footer.jsp" %>
</body>
</html>