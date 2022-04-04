<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String message = (String)request.getAttribute("msg");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.outer{
		background:powderblue;
		width:600px;
		height:500px;
		margin-top:50px;
		margin-left:auto;
		margin-right:auto;
		color:gray;
	}
	#enrollForm{
		/* border:1px solid white; */
		width:100%;
		margin-left:auto;
		margin-right:auto;
	}
	#enrollForm td:nth-child(1){text-align:right;}
	#enrollForm input{margin:3px;}

	#joinBtn{background:cornflowerblue; color:white; font-size:20px; margin:20px 30px 0 0; padding:10px 20px; border-radius:5px;}
	#cancel{background:white; color:gray; font-size:20px; padding:10px 30px;  border-radius:5px;}
	
	#enrollForm td{font-weight:bold;}
	
	#p{font-size:12px; color:blue; margin:5px 100px 0 0; padding:0; float:right;}
</style>
</head>
<body>

<%@ include file= "../common/menubar.jsp" %>

	<div class="outer">
		<br>
		
		<h1 align="center">회원가입</h1>
		
		<form id="enrollForm" action="<%=request.getContextPath() %>/insertMember.do" method="post" onsubmit="return joinValidate();">
			<!-- 회원가입 양식 작성 후 insertMember.do로 전송 -> MemberInsertServlet.java만들기  -->
		<table>
				<tr>
					<td>* 이름</td>
					<td><input type="text" maxlength="5" name="userName" required></td>
					<td></td>
				</tr>
				<tr>
					<td width="200px">* 아이디</td>
					<td><input type="text" maxlength="13" name="userId" required></td>
					<td width="200px">
						<button type="button" id="idCheckBtn" onclick="checkId();">중복확인</button>
					</td>
				</tr>
				<tr>
					<td>* 비밀번호</td>
					<td><input type="password" maxlength="15" name="userPwd" required></td>
					<td></td>
				</tr>
				<tr>
					<td>* 비밀번호 확인</td>
					<td><input type="password" maxlength="15" name="checkPwd" required></td>
					<td><label id = "pwdResult"></label></td>
				</tr>	
				
				<tr>
					<td>* 휴대폰 번호</td>
					<td><input type="tel" maxlength="11" name="phone" placeholder="(-없이)01012345678" required></td>
					<td></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="email" name="email"></td>
					<td></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="address"></td>
					<td></td>
				</tr>
				<tr>
					<td>계좌번호</td>
					<td><input type="text" name="account"></td>
					<td></td>
				</tr>
			</table>
			<br>
			<p id="p">* 표시는 필수 입력 항목입니다.</p>
			<br>
			
			<div class="btns" align="center">
				<button type="submit" id="joinBtn">가입하기</button><!-- disabled  추가 -->
				<button type="button" id="cancel" onclick="cancel();">취소</button>
				<!-- onclick= "location.href='<%= request.getContextPath()%>'"-->
			</div>
		</form>
	
	</div>
	<script>
	
		function joinValidate(){
			
			if(!(/^[a-z][a-z\d]{3,11}$/i.test($("#enrollForm input[name=userId]").val()))){
				$("#enrollForm input[name=userId]").focus();
		        return false;
			}
			
			if($("#enrollForm input[name=userPwd]").val() != $("#enrollForm input[name=checkPwd]").val()){
				$("#pwdResult").text("비밀번호 불일치").css("color", "red");
				return false;			
			}
			
			 if(!(/^[가-힣]{2,}$/.test($("#enrollForm input[name=userName]").val()))){
				 $("#enrollForm input[name=userName]").focus();
		        return false;
			 }
			 
			 return true;

		}
		</script>

</body>
</html>