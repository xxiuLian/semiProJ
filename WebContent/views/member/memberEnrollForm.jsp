<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<style>

   .form-group{margin-left:150px;}
   #enrollForm{
      padding-top: 30px;
      width:100%;
      margin-left:auto;
      margin-right:auto;
	  background-color: rgb(255, 194, 194, 0.1);
   }
   #enrollForm td:nth-child(1){text-align:right; padding-right: 20px;}
   #enrollForm input{margin:3px;}


   #enrollForm td{font-weight:bold;}
   
   #p{font-size:12px; color:rgb(127, 127, 253); margin:5px 150px 0 0; padding:0; float:right;}
   
 
   #container{
	   width: 1000px;
	   padding: 50px;
	   
   }
   
 
   #title{
	   display: inline-block;
	   width : 100%;
	   height: auto;
	   border-right: 1PX solid black;
	}
	#titletext{
	   font-size: 48px;
	   font-weight: 700;
	   font-family: 'Noto Sans KR', sans-serif;

   }
   td{
	   height: 60px;
	   
   }
   .labelText{
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 20px;
   }
  .inputcss{
	   border: 0.2px solid rgb(197, 195, 195);
	   border-radius: 5px;
	   height: 40px;
	   width: 250px;
   }
   .inputcss:focus{
	outline: none;
    border-color: #9ecaed;
    box-shadow: 0 0 10px #d2cef5;
   }
   .formBtns{
	   border: 0px;
	   width: 100px;
	   height: 60%;
	   background-color: rgb(11, 100, 159);
	   color: white;
	   border-radius: 7px;
	   margin-left: 10px;
	   font-family: 'Noto Sans KR', sans-serif;
   }
   .btnsArea{
	   width: 100%;
	   height: 150px;
	   justify-content: center;
	   display: flex;
	   align-items: center;
	   
   }
   .btn{
	   margin-right: 30px;
	   display: inline-block;
   }
   #goMain{
	 
	background:rgb(216, 216, 216); 
	color:rgb(85, 85, 85); 
	font-size:20px; 
	width: 180px; 
	height: 50px;
	border-radius:5px;
	border: 0.2px solid rgb(216, 216, 216);
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 700;
	font-size: 25px;
   }
   #joinBtn{
	   background:rgb(11, 100, 159); 
	   color:white; font-size:20px; 
	   width: 180px; 
		height: 50px;
	   border-radius:5px;
	   border: 0.2px solid rgb(216, 216, 216);
	   font-family: 'Noto Sans KR', sans-serif;
	   font-weight: 700;
	   font-size: 25px;
	}
   
   
</style>

</head>
<body>
<%@ include file="../common/menubar.jsp" %>

	<div class="container" id="container">
		<div class="row">
			<div class="col-md-3">
				<div id="title">
					<div id="titletext" align="center">회원가입</div>
				</div>
			</div>
			<div class="col-md-9">
				<form role="form" id="enrollForm" action="<%=request.getContextPath() %>/insertMember.do" method="post" onsubmit="return joinValidate();">
					<table>
						<tr>
							<td class="labelText" width="200px">* 아이디</td>
							<td><input type="text" class="inputcss" maxlength="13" name="userId" required></td>
							<td width="200px">
								<button type="button" class="formBtns" id="idCheckBtn" onclick="checkId();">중복확인</button>
							</td>
						</tr>
						<tr>
							<td class="labelText">* 비밀번호</td>
							<td><input type="password" class="inputcss" maxlength="15" name="userPwd" required></td>
							<td></td>
						</tr>
						<tr>
							<td class="labelText" >* 비밀번호 확인</td>
							<td><input type="password" class="inputcss" maxlength="15" name="checkPwd" required></td>
							<td><label id = "pwdResult"></label></td>
						</tr>	
						<tr>
							<td class="labelText" >* 이름</td>
							<td><input type="text" class="inputcss" maxlength="5" name="userName" required></td>
							<td></td>
						</tr>
						<tr>
							<td class="labelText" >* 연락처</td>
							<td><input type="tel" class="inputcss" maxlength="11" name="phone" placeholder="(-없이)01012345678" required></td>
							<td></td>
						</tr>
						<tr>
							<td class="labelText" >* 이메일</td>
							<td><input type="email" class="inputcss" name="email" required></td>
							<td></td>
						</tr>
						<tr>
							<td class="labelText" >계좌번호</td>
							<td><input type="text" class="inputcss" name="account" placeholder="(-없이) 입력"></td>
							<td>
							<select name="bank" class="inputcss" style="width: 150px;">
								<option selected>선택</option>
								<option value="신한">신한</option>
								<option value="우리">우리</option>
								<option value="농협">농협</option>
								<option value="국민">국민</option>
								<option value="하나">하나</option>
								<option value="기업">기업</option>
								<option value="카카오뱅크">카카오뱅크</option>
							</select>
							</td>
							<tr>
						</tr>
						<tr>
							<td class="labelText" >우편번호</td>
							<td>
								<input type="text" name="post" class="form-control mr-2 postcodify_postcode5" value="${ post }" size="6"> 
							</td>
							<td>
								<button type="button" class="formBtns" id="postcodify_search_button">검색</button>
							</td>
							
							<td></td>
						</tr>
						<tr>
							<td class="labelText" >도로명 주소</td>
							<td> 
								<input type="text" name="address1" class="form-control postcodify_address" value="${ address1 }" size="30">
							</td>
						</tr>
						<tr>
							<td class="labelText" >상세주소</td>
							<td> 
								<input type="text" name="address2" class="form-control postcodify_extra_info" value="${ address2 }" size="30">
							</td>
						</tr>
							
					</table>
					<p id="p">* 표시는 필수 입력 항목입니다.</p>
					<br>
					
					
					  <!-- jQuery와 Postcodify를 로딩한다. -->
					<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
					<script>
					// 검색 단추를 누르면 팝업 레이어가 열리도록 설정한다.
					$(function(){
					   $("#postcodify_search_button").postcodifyPopUp();
					});
					</script>
					
					
					<div class="btnsArea">
						<div class="btn"><button type="button" id="goMain" onclick= "location.href='<%= request.getContextPath()%>'">메인으로</button></div>
						<div class="btn"><button type="submit" id="joinBtn"  disabled>가입하기</button></div> <!-- disabled  추가 -->
					</div>
				
				</form>
			</div><!--col-md-9-->

		</div><!--row-->
		
		<br>
	</div>
	<script>
	
		function joinValidate(){
			// /^[a-z][a-z\d]{3,11}$/ : 숫자가 먼저 오는 아이디는 사용할 수 없음 
			if(!(/^[a-z\d]{3,10}$/i.test($("#enrollForm input[name=userId]").val()))){
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
				alert("아이디를 입력해주세요")
				return false;
			}
			
			$.ajax({
				url:"idCheck.do", //해당 서블릿 만들기
				type:"post",
				data:{userId : userId.val()}, //userId키값에 userid값을 넣음
				success:function(result){
					if(result =="fail"){
						alert("사용할 수 없는 아이디입니다.");
						userId.focus();
						
					}else{
						if(confirm("사용 가능한 아이디입니다. 사용 하시겠습니까?")){
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