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
					<div id="titletext" align="center">????????????</div>
				</div>
			</div>
			<div class="col-md-9">
				<form role="form" id="enrollForm" action="<%=request.getContextPath() %>/insertMember.do" method="post" onsubmit="return joinValidate();">
					<table>
						<tr>
							<td class="labelText" width="200px">* ?????????</td>
							<td><input type="text" class="inputcss" maxlength="13" name="userId" required></td>
							<td width="200px">
								<button type="button" class="formBtns" id="idCheckBtn" onclick="checkId();">????????????</button>
							</td>
						</tr>
						<tr>
							<td class="labelText">* ????????????</td>
							<td><input type="password" class="inputcss" maxlength="15" name="userPwd" required></td>
							<td></td>
						</tr>
						<tr>
							<td class="labelText" >* ???????????? ??????</td>
							<td><input type="password" class="inputcss" maxlength="15" name="checkPwd" required></td>
							<td><label id = "pwdResult"></label></td>
						</tr>	
						<tr>
							<td class="labelText" >* ??????</td>
							<td><input type="text" class="inputcss" maxlength="5" name="userName" required></td>
							<td></td>
						</tr>
						<tr>
							<td class="labelText" >* ?????????</td>
							<td><input type="tel" class="inputcss" maxlength="11" name="phone" placeholder="(-??????)01012345678" required></td>
							<td></td>
						</tr>
						<tr>
							<td class="labelText" >* ?????????</td>
							<td><input type="email" class="inputcss" name="email" required></td>
							<td></td>
						</tr>
						<tr>
							<td class="labelText" >????????????</td>
							<td><input type="text" class="inputcss" name="account" placeholder="(-??????) ??????"></td>
							<td>
							<select name="bank" class="inputcss" style="width: 150px;">
								<option selected>??????</option>
								<option value="??????">??????</option>
								<option value="??????">??????</option>
								<option value="??????">??????</option>
								<option value="??????">??????</option>
								<option value="??????">??????</option>
								<option value="??????">??????</option>
								<option value="???????????????">???????????????</option>
							</select>
							</td>
							<tr>
						</tr>
						<tr>
							<td class="labelText" >????????????</td>
							<td>
								<input type="text" name="post" class="form-control mr-2 postcodify_postcode5" value="${ post }" size="6"> 
							</td>
							<td>
								<button type="button" class="formBtns" id="postcodify_search_button">??????</button>
							</td>
							
							<td></td>
						</tr>
						<tr>
							<td class="labelText" >????????? ??????</td>
							<td> 
								<input type="text" name="address1" class="form-control postcodify_address" value="${ address1 }" size="30">
							</td>
						</tr>
						<tr>
							<td class="labelText" >????????????</td>
							<td> 
								<input type="text" name="address2" class="form-control postcodify_extra_info" value="${ address2 }" size="30">
							</td>
						</tr>
							
					</table>
					<p id="p">* ????????? ?????? ?????? ???????????????.</p>
					<br>
					
					
					  <!-- jQuery??? Postcodify??? ????????????. -->
					<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
					<script>
					// ?????? ????????? ????????? ?????? ???????????? ???????????? ????????????.
					$(function(){
					   $("#postcodify_search_button").postcodifyPopUp();
					});
					</script>
					
					
					<div class="btnsArea">
						<div class="btn"><button type="button" id="goMain" onclick= "location.href='<%= request.getContextPath()%>'">????????????</button></div>
						<div class="btn"><button type="submit" id="joinBtn"  disabled>????????????</button></div> <!-- disabled  ?????? -->
					</div>
				
				</form>
			</div><!--col-md-9-->

		</div><!--row-->
		
		<br>
	</div>
	<script>
	
		function joinValidate(){
			// /^[a-z][a-z\d]{3,11}$/ : ????????? ?????? ?????? ???????????? ????????? ??? ?????? 
			if(!(/^[a-z\d]{3,10}$/i.test($("#enrollForm input[name=userId]").val()))){
				$("#enrollForm input[name=userId]").focus();
		        return false;
			}
			
			if($("#enrollForm input[name=userPwd]").val() != $("#enrollForm input[name=checkPwd]").val()){
				$("#pwdResult").text("???????????? ?????????").css("color", "red");
				return false;			
			}
			
			 if(!(/^[???-???]{2,}$/.test($("#enrollForm input[name=userName]").val()))){
				 $("#enrollForm input[name=userName]").focus();
		        return false;
			 }
			 
			 return true;

		}
		
		function checkId(){
			var userId = $("#enrollForm input[name=userId]");
			if(userId.val()==""){
				alert("???????????? ??????????????????")
				return false;
			}
			
			$.ajax({
				url:"idCheck.do",
				type:"post",
				data:{userId : userId.val()}, //userId????????? userid?????? ??????
				success:function(result){
					if(result =="fail"){ //????????? ??????
						alert("????????? ??? ?????? ??????????????????.");
						userId.focus();
						
					}else{
						if(confirm("?????? ????????? ??????????????????. ?????? ???????????????????")){
							userId.attr("readonly","true");
							$("#joinBtn").removeAttr("disabled");
						}else{
							userId.focus();
						}
					}
				},
				error:function(){
					console.log("??????????????????")
				}
			});
			
		}

	</script>

</body>
</html>