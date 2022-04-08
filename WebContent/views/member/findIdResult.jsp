<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    Member findUser = (Member)request.getAttribute("findUser");
    String userName = (String)request.getAttribute("userName");
    String userId = findUser.getUserId();
    %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    h1{text-align: center;}
    .div1{border: 2px solid cornflowerblue; margin: 0 auto; padding: 20px; width: 400px; height: 300px; position: relative;}
    .button1{border: none; padding: 20px; top: 150px; left: 100px; position: absolute;}
	b{font-size:20px;}
    </style>
</head>
<body>
<%@ include file="../common/menubar.jsp" %>
     <h1>아이디 찾기</h1>
    <div class="div1">
        <div>
        <b><%=userName %>님</b>의<br>
        아이디는 <b><%= userId %></b>입니다.<br>
        <button class="button1" onclick= "history.go(-2)">로그인 화면으로 돌아가기</button>
        </div>
    </div>
</body>
</html>