<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String msg = (String) request.getAttribute("msg");
String sTag = (String) request.getAttribute("sTag");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	var msg="<%=msg%>";
	var sTag="<%=sTag%>";
	$(function() {
		if (msg != "null") {
			alert(msg) //msg가 있으면 띄워주고
		}

		if (sTag == "Y") {
			window.opener.location.reload()//부모페이지 새로고침
			window.close() //창 닫기
		}
	})
</script>
<body>

</body>
</html>