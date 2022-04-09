<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String msg = (String) request.getAttribute("msg");
String sTag = (String) request.getAttribute("sTag");
String originCname = (String) request.getAttribute("originCname");
System.out.println("msg = " + msg);
System.out.println("sTag = " + sTag);
System.out.println("originCname = " + originCname);
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
	var originCname = "<%=originCname%>";
	$(function() {
		if (msg != "null") {

			alert(msg) //msg가 있으면 띄워주고
		}

		if (sTag == "Y") {
			window.opener.location.reload()
			window.close() //창 닫기
		}
	})
</script>
<body>

</body>
</html>