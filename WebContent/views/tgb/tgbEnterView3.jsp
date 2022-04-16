<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	.memberouter{
		width:800px;
		margin: auto;
		margin-top: 30px;
	}
	h3{
		border-bottom: 1px solid rgb(149, 149, 149);
	}
</style>
<body>
	<%@ include file="../common/menubar.jsp" %>
	<c:set var="i" value="0"></c:set>
<jsp:include page = "tgbEnterView.jsp"/>

<div class="memberouter" align="center">
	<h3>참여자 정보</h3>
	<table class="table table-striped" >
		<tr>
			<th>번호</th>
			<th>아이디</th>
			<th>휴대폰 번호</th>
			<th>이메일</th>
		</tr>
		
		<c:forEach items="${listMem}" var="list"  varStatus="st">
		<tr class="">
			<td style="width: 50px;"><c:out value="${i+st.count}"/></td>
			<td style="width: 100px;"><c:out value="${list.userId}"/></td>
			<td style="width: 200px;"><c:out value="${list.phone}"/></td>
			<td style="width: 200px;"><c:out value="${list.email}"/></td>
			
		</tr>
		</c:forEach>

		
	</table>


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