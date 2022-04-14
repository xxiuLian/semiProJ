<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../common/menubar.jsp" %>
<jsp:include page = "tgbEnterView.jsp"/>

<div class="content3">참여자정보
<c:forEach items="${listMem}" var="list"  varStatus="st">
<tr class="">
	<td><c:out value="아이디 : ${list.userId}"/><br>
	<td><c:out value="휴대폰 : ${list.phone}"/><br>
	<td><c:out value="이메일 : ${list.email}"/><br>
	
</tr>
</c:forEach>
</div>


<%--
<script>
$(document).ready(function(){
	memberdataWook2();
})

function memberdataWook2(){
	
	$.ajax({
		url : "member1.do",
		data : {
			writer : "${listMem.userId}"
		},
		type :"post",
		success : function(listMem){
			
			console.log("test다 : "listMem);
			var a = '<h6>참여자22 아이디 : '+ listMem.userId+'</h6>';
			a += '<h6> 핸드폰 번호 : '+ listMem.phone+'</h6>';
			a += '<h6> 이메일 주소 : '+ listMem.email+'</h6>';
			
			$('.content3').html(a);
			
		},
		error : function(){
			
		}
	})
	
};
--%>


</script>
</body>
</html>