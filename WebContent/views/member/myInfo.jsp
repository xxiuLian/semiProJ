<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
 <%
	Member m = (Member)request.getAttribute("loginUser");
	String userId = m.getUserId(); //loginUser 세션에 담겨있는 유저 정보들
	String userPwd = m.getUserPwd();
	String userName = m.getUserName();
	String phone = m.getPhone() != null ? m.getPhone() : "";
	String email = m.getEmail()!= null ? m.getEmail() : "";
	String account = m.getAccount() != null ? m.getAccount() : "";
	
	int post = m.getPost() == 0 ? 0 : m.getPost();
	String address1 = m.getAddress1()!= null ? m.getAddress1() : "";
	String address2 = m.getAddress2()!= null ? m.getAddress2() : "";
	String originPwd = (String)session.getAttribute("originPwd");
	
	String[] bankArr = new String[7];
	for(int i = 0; i < bankArr.length; i++){
		switch(m.getBank()){
		case "신한" : bankArr[0] = "selected"; break;
		case "우리" : bankArr[1] = "selected"; break;
		case "농협" : bankArr[2] = "selected"; break;
		case "국민" : bankArr[3] = "selected"; break;
		case "하나" : bankArr[4] = "selected"; break;
		case "기업" : bankArr[5] = "selected"; break;
		case "선택" : bankArr[6] = "selected"; break;
		}
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.outer{
		background:black;
		width:600px;
		height:500px;
		margin-top:50px;
		margin-left:auto;
		margin-right:auto;
		color:white;
	}
	#updateForm{
		/* border:1px solid white; */
		width:100%;
		margin-left:auto;
		margin-right:auto;
	}
	#updateForm td:nth-child(1){text-align:right;}
	#updateForm input{margin:3px;}
	
	#joinBtn{background:yellowgreen;}
	#goMain{background:orangered;}
</style>
</head>
<body>
<%@ include file="../common/menubar.jsp" %>

	<div class="outer">
		<br>
		
		<h2 align="center">마이페이지</h2>
		<form id="updateForm" action="<%=request.getContextPath() %>/updateMember.do" method="post">
															
			<table>
				<tr>
					<td width="200px">* 아이디</td>
					<td><input type="text" maxlength="13" name= "userId" value= "<%= userId %>"readonly></td>
				</tr>
				<tr>
					<td>* 비밀번호</td>
					<td><input type="text" id = "originPwd" name ="originPwd" value="<%=originPwd %>" readonly></td>
					<td></td>
				</tr>
				<tr>
					<td>* 이름</td>
					<td><input type="text" maxlength="5" name="userName" value= "<%= userName %>" required></td>
					<td></td>
				</tr>
				<tr>
					<td>연락처</td>
					<td><input type="tel" maxlength="11" name="phone" value= "<%= phone %>"placeholder="(-없이)01012345678"></td>
					<td></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="email" name="email" value= "<%= email %>"></td>
					<td></td>
				</tr>
				<tr>
					<td>계좌번호</td>
					<td><input type="text" name="account" value= "<%= account %>" placeholder="(-없이) 입력"></td>
					<td>
					<select name="bank">
			            <option <%= bankArr[6] %>>선택</option>
			            <option value="신한" <%= bankArr[0] %>>신한</option>
			            <option value="우리"  <%= bankArr[1] %>>우리</option>
			            <option value="농협"  <%= bankArr[2] %>>농협</option>
			            <option value="국민"  <%= bankArr[3] %>>국민</option>
			            <option value="하나"  <%= bankArr[4] %>>하나</option>
			            <option value="기업"  <%= bankArr[5] %>>기업</option>
			        </select>
					</td>
				</tr>
				<tr>
					<td>주소</td>
					<td>
						<input type="text"  name="post" value= "<%= post %>"class="form-control mr-2 postcodify_postcode5" size="6"> 
         				<button type="button" class="btn btn-primary" id="postcodify_search_button">검색</button>
					</td>
					
					<td></td>
				</tr>
				<tr>
					<td>도로명 주소</td>
					<td> 
						<input type="text" name="address1" value= "<%= address1 %>" class="form-control postcodify_address"  size="30">
					</td>
				</tr>
				<tr>
					<td>상세주소</td>
					<td> 
						<input type="text" name="address2" value= "<%= address2 %>"class="form-control postcodify_extra_info" size="30">
					</td>
				</tr>
			</table>
			<br>
			
			<div class="btns" align="center">
				<button type="submit" id="updateBtn">수정하기</button>
				
				<button type="button" id = "pwdUpdateBtn" onclick="updatePwd();">비밀번호 변경</button>
				<button type="button" id = "deleteBtn" onclick="deleteMember();">탈퇴하기</button>
				
			</div>
		</form> <!-- form 안에 있는 button은 type 설정하지 않으면 onclick함수 적용이 안됨 꼭 type을 지정해야함 -->
	</div>
	<script>
	
		function updatePwd(){
			window.open("<%= request.getContextPath()%>/updatePwdForm.do","비밀번호 변경창 ","width=500, height=300")
		} //window.open : 새창 열기

		function deleteMember(){
			var pwd = prompt("현재 비밀번호를 입력하세요");
			var op = $("#originPwd").val(); //form 안에 있는 원래 비번 값(.val())
			
			if(op === pwd){
				var val = confirm("정말로 삭제 하시겠습니까?");
				if(val){ //true(확인) : 삭제하겠따
					$("#updateForm").attr("action","<%= request.getContextPath()%>/deleteMember.do"); 
					                                                            //MemberDeleteServlet.java로 이동
					$("#updateForm").submit();
				}else{
					alert("취소하였습니다");
				}
			}
		}
	</script>

</body>
</html>