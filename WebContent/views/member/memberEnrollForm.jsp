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
      width:800px;
      height:600px;
      margin-top:50px;
      margin-left:auto;
      margin-right:auto;
      color:gray;
   }

   .form-group{margin-left:150px;}
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
<%@ include file="../common/menubar.jsp" %>

	<div class="outer">
		<br>
		
		<h2 align="center">회원가입</h2>
		
		<form id="enrollForm" action="<%=request.getContextPath() %>/insertMember.do" method="post" onsubmit="return joinValidate();">
			<table>
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
					<td>* 이름</td>
					<td><input type="text" maxlength="5" name="userName" required></td>
					<td></td>
				</tr>
				<tr>
					<td>연락처</td>
					<td><input type="tel" maxlength="11" name="phone" placeholder="(-없이)01012345678"></td>
					<td></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="email" name="email"></td>
					<td></td>
				</tr>
				<tr>
					<td>계좌번호</td>
					<td><input type="text" name="account" placeholder="(-없이) 입력"></td>
					<td>
					<select name="bank">
			            <option selected>선택</option>
			            <option value="신한">신한</option>
			            <option value="우리">우리</option>
			            <option value="농협">농협</option>
			            <option value="국민">국민</option>
			            <option value="하나">하나</option>
			            <option value="기업">기업</option>
			        </select>
					</td>
				</tr>
				<tr>
					<td>주소</td>
					<td>
						<input type="text"  name="post" class="form-control mr-2 postcodify_postcode5" value="${ post }" size="6"> 
         				<button type="button" class="btn btn-primary" id="postcodify_search_button">검색</button>
					</td>
					
					<td></td>
				</tr>
				<tr>
					<td>도로명 주소</td>
					<td> 
						<input type="text" name="address1" class="form-control postcodify_address" value="${ address1 }" size="30">
					</td>
				</tr>
				<tr>
					<td>상세주소</td>
					<td> 
						<input type="text" name="address2" class="form-control postcodify_extra_info" value="${ address2 }" size="30">
					</td>
				</tr>
					
			</table>
			<br>
			  <!-- jQuery와 Postcodify를 로딩한다. -->
		    <script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
		    <script>
		    // 검색 단추를 누르면 팝업 레이어가 열리도록 설정한다.
		    $(function(){
		       $("#postcodify_search_button").postcodifyPopUp();
		    });
		    </script>
			
			<div class="btns" align="center">
				<button type="button" id="goMain" onclick= "location.href='<%= request.getContextPath()%>'">메인으로</button>
				<button type="submit" id="joinBtn" >가입하기</button> <!-- disabled  추가 -->
				
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
		
		function checkId(){
			var userId = $("#enrollForm input[name=userId]");
			if(userId.val()==""){
				alert("아이디를입력해주세요")
				return false;
			}
			
			
			$.ajax({
				url:"idCheck.do", //해당 서블릿 만들기
				type:"post",
				data:{userId:userId.val()}, //userId키값에 userid값을 넣음
				success:function(result){
					if(result =="fail"){
						alert("사용할수없는 아이디입니다.");
						userId.focus();
						
					}else{
						if(confirm("사용가능한 아이디입니다. 사용하시겠습니까?")){
							userId.attr("readonly","true");
							$("#joinBtn").removeAttr("disabled");
						}else{
							userId.focus();
						}
					}
				},
				error:function(){
					console.log("서버통신실패")
				}
			});
			
		}

	</script>

</body>
</html>