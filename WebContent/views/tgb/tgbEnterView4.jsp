<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	.hostouter{
		width:800px;
		margin: auto;
		margin-top: 30px;
		border: 1px solid rgb(196, 196, 196);
		border-radius: 7px;
		padding: 30px;
	}
	h3{
		border-bottom: 1px solid rgb(149, 149, 149);
	}
</style>
<body>
<%@ include file="../common/menubar.jsp" %>
<jsp:include page = "tgbEnterView.jsp"/>
<div class="hostouter" align="center">
	<h3>진행자 정보</h3>
	<div class="content3" align="left"></div>
</div>

<script>
$(document).ready(function(){
	memberdata();
})

function memberdata(){
	
	$.ajax({
		url : "member1.do",
		data : {
			writer : "${t.tgbWriter}"
		},
		type :"post",
		success : function(m){
			console.log(m);
			var a = '<h6> 아이디 : '+m.userId+'</h6>';
			a += '<h6> 핸드폰 번호 : '+m.phone+'</h6>';
			a += '<h6> 이메일 주소 : '+m.email+'</h6>';
			
			$('.content3').html(a);
		},
		error : function(){
			
		}
	})
};



</script>
</body>
</html>