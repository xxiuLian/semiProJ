<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	String msg = (String)request.getAttribute("msg"); %>
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

	<form name="pwdfindscreen" method = "POST">
			<div class = "search-title">
				<h3>본인확인</h3>
			</div>
		<section class = "form-search">
			<div class = "findId">
				<label>아이디</label>
				<input type="text" name="userId" class ="userId" placeholder="아이디">
			<br>
			</div>
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
		<input type="button" name="enter" value="찾기"  onClick="pwdSearch()">
		<input type="button" name="cancle" value="취소" onClick="history.back()">
 	</div>
 </form>
 <script type="text/javascript">
 function pwdSearch() { 
	 	var frm = document.pwdfindscreen;
	 	if (frm.userId.value.length < 1) {
			  alert("아이디를 입력해주세요");
			  return;
			 }
	 	
	 	if (frm.userName.value.length < 1) {
		  alert("이름을 입력해주세요");
		  return;
		 }

		 if (frm.phone.value.length != 11) {
			  alert("핸드폰번호를 정확하게 입력해주세요");
			  return;
		 }

	 frm.method = "post";
	 frm.action = "<%=request.getContextPath()%>/findPwdResult.do" //넘어간화면
	 frm.submit();  
	 }
 </script>
</body>
</html>