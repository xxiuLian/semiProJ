<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String msg = (String)request.getAttribute("msg");
	String sTag = (String)request.getAttribute("sTag");
	String originPwd = (String)session.getAttribute("originPwd");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	var msg="<%= msg %>";
	var sTag="<%= sTag %>";
	var originPwd = "<%= originPwd %>";
	$(function(){
		if(msg != "null"){
			
			alert(msg) //msg가 있으면 띄워주고
		}
		
		if(sTag == "Y"){
			
			opener.document.getElementById("originPwd").value = originPwd;
			//이 페이지를 연 부모창의 originPwd값을 찾아 바꿔주고
			window.close() //창 닫기
		}
		
	})
	
</script>
</head>
<body>
	<b>비밀번호 변경</b>
	<br>
	
	<form id="updatePwdForm" action="<%= request.getContextPath() %>/updatePwdMember.do" method="post">
		<table>
			<tr>
				<td><label>현재 비밀번호</label>
				<td><input type="password" name="userPwd" id="userPwd"></td>
			</tr>
			<tr>
				<td><label>변경할 비밀번호</label></td>
				<td><input type="password" name="newPwd"></td>
			</tr>
			<tr>
				<td><label>변경할 비밀번호 확인</label></td>
				<td><input type="password" name="checkPwd"></td>
			</tr>
		</table>
		
		<br>
		<br>
		
		<div class="btns" align="center">
			<button  type="button" onclick="fnCheckPwd()">변경하기</button>
		</div>
	</form>
	<script>
		function fnCheckPwd(){
			var userPwd = $("#userPwd");
			var newPwd = $("input[name='newPwd']");
			var checkPwd = $("input[name='checkPwd']");
			
			if(userPwd.val().trim() === "" || newPwd.val().trim() === "" || checkPwd.val().trim() === ""){
				alert("비밀번호를 입력하세요") //빈 칸이 하나라도 있으면 입력하라고 창
				return false;
			}
			
			if(newPwd.val() != checkPwd.val()){
				alert("비밀번호가 다릅니다.") //바꿀 비번과 확인 비번이 다르면 X
				checkPwd.val(''); //확인 비번 리셋해서
				checkPwd.focus(); //포커스 두고 다시 입력하게 하기
				return false;
			}
			
			$("#updatePwdForm").submit();
		}
	</script>
</body>
</html>