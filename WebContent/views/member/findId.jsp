<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.form-search{padding:0;}
</style>
</head>
<body>
<%@ include file= "../common/menubar.jsp" %>

	<form name="idfindscreen" method = "POST">
			<div class = "search-title">
				<h3>휴대폰 본인확인</h3>
			</div>
		<section class = "form-search">
			<div class = "findName">
				<label>이름</label>
				<input type="text" name="userName" class ="userName" placeholder="등록한 이름">
			<br>
			</div>
			<div class = "findPhone">
				<label>번호</label>
				<input type="text" name="phone" class = phone placeholder = "'-'없이 입력">
			</div>
			<br>
	</section>
	<div class ="btnSearch">
		<input type="button" name="enter" value="찾기"  onClick="idSearch()">
		<input type="button" name="cancle" value="취소" onClick="history.back()">
 	</div>
 </form>
 <script type="text/javascript">
 function idSearch() { 
	 	var frm = document.idfindscreen;

	 	if (frm.userName.value.length < 1) {
		  alert("이름을 입력해주세요");
		  return;
		 }

		 if (frm.phone.value.length != 11) {
			  alert("핸드폰번호를 정확하게 입력해주세요");
			  return;
		 }

	 frm.method = "post";
	 frm.action = "<%=request.getContextPath()%>/findIdResult.do" //넘어간화면
	 frm.submit();  
	 }
 </script>
</body>
</html>