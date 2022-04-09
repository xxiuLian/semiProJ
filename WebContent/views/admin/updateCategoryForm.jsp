<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String msg = (String)request.getAttribute("msg");
	String sTag = (String)request.getAttribute("sTag");
	String originCname = (String)request.getAttribute("originCname");
	System.out.println("msg = " +msg);
	System.out.println("sTag = " +sTag);
	System.out.println("originCname = " +originCname);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<b>카테고리 수정</b>
	<br>
	
	<form id="updateCategory" action="<%= request.getContextPath() %>/updateCategory.do?keyword=${keyword}" method="post">
		<input type="hidden" name="originCno" value="${category.categoryNo}">
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
			<button type="button" onclick="updateCategory()">변경하기</button>
		</div>
	</form>
</body>
<script>
var msg="<%= msg %>";
var sTag="<%= sTag %>";
var originCname = "<%= originCname %>";
	$(function(){
		if(${category.categoryNo} != null){
			console.log('진입');
			$("#cno").val(${category.categoryNo});
			$("#cname").val('${category.categoryName}');
		}
		
		
	})
		
	function updateCategory(){
		if($("#cno").val().trim() === "" || $("#cname").val().trim() === ""){
			alert("카테고리 정보를 입력하세요")
			return false;
		}
		if(isNaN($("#cno").val().trim())){
			alert("카테고리번호는 숫자만 입력 가능합니다.")
			return false;
		}
		$("#updateCategory").submit();
	}
</script>
</html>