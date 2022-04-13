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
<div class="content3">진행자 id : ${t.tgbWriter}</div>

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
			var a = '<h6>진행자 아이디 : '+m.userId+'</h6>';
			a += '<h6> 핸드폰 번호 : '+m.phone+'</h6>';
			a += '<h6> 이메일 주소 : '+m.email+'</h6>';
			
			$('.content3').html(a);
		},
		error : function(){
			
		}
	})
};

//추가_재욱
function memberdataWook2(){
	
	$.ajax({
		url : "member1.do",
		data : {
			writer : "${t.tgbWriter}"
		},
		type :"post",
		success : function(m){
			console.log(m);
			var a = '<h6>참여자22 아이디 : '+ m.userId+'</h6>';
			a += '<h6> 핸드폰 번호 : '+ m.phone+'</h6>';
			a += '<h6> 이메일 주소 : '+ m.email+'</h6>';
			
			$('.content3').html(a);
		},
		error : function(){
			
		}
	})
};
//까지_재욱

</script>
</body>
</html>