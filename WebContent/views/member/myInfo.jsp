<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="loginUser" value="${sessionScope.loginUser}" scope="session"/>
<c:set var="msg" value="${sessionScope.msg}" scope="session"/>
<c:set var="contextPath" value="<%= request.getContextPath()%>" scope="session"/>
<%
	String admin = (String)request.getAttribute("admin");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Simple Sidebar - Start Bootstrap Template</title>
<!--google web font-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/myPageStyles.css" rel="stylesheet" />
<style>

#updateForm{
	/* border:1px solid white; */
	width:100%;
	margin-left:auto;
	margin-right:auto;
}
#updateForm td:nth-child(1){text-align:right;}
#updateForm input{margin:3px;}
ul, li { list-style: none; }

.content{
	padding: 40px;
	height: auto;
}
table{
	margin: auto;
}
td{
	height: 60px;
	
}
#updateForm{
	padding-top: 30px;
}
.labelText{
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 20px;
	padding-right: 20px;
   }
.inputcss{
	border: 0.2px solid rgb(197, 195, 195);
	border-radius: 5px;
	height: 40px;
	width: 270px;
}
.inputcss:focus{
	outline: none;
    border-color: #9ecaed;
    box-shadow: 0 0 10px #d2cef5;
}
.Allbtns{
	background-color: rgb(11, 100, 159);
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 20px;
	color: white;
	border-radius: 5px;

}
#titletext{
	font-size: 32px;
	font-weight: 700;
	font-family: 'Noto Sans KR', sans-serif;
	border-bottom: 1px solid rgb(136, 136, 136);
}
#postcodify_search_button{
	background-color: rgb(11, 100, 159);
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 18px;
	border: 0px;
}
#updateBtn{
	height:50px;
	width: 150px;
	border: 0px;
	margin: 30px;
}
#pwdUpdateBtn{
	height:50px;
	width: 150px;
	border: 0px;
	margin: 10px;
}


#deleteBtn{
	height:50px;
	width: 150px;
	border: 0px;
	margin: 30px;
	background-color: rgb(153, 153, 153);
}


	
</style>
    </head>
    <body>
	<%if(admin == null){ %>
		 <%@ include file="../../views/common/menubar.jsp" %>
	<%}%>
    <div class="container">
   
        <div class="d-flex" id="wrapper">
            <!-- Sidebar-->
             <%if(admin == null){ %>

            <div class="border-end bg-white" id="sidebar-wrapper">
                <div class="sidebar-heading border-bottom bg-light"><a href="${contextPath}/myPage.do">HOME</a></div>
                <div class="list-group list-group-flush">
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="myInfo.do" id="myInfo">내 정보</a>
                        <div>
                    	<a id="myList" class="list-group-item list-group-item-action list-group-item-light p-3" href="myList.do">공동구매 내역 조회</a>
                    	<ul>
							<li><a class="nav-link" href="myList.do">나의 진행 상품</a></li>
							<li><a class="nav-link" href="myPayList.do">나의 참여 상품</a></li> 
							<li><a class="nav-link" href="myFinishList.do">이전 상품</a></li>
						</ul>
                    </div>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="wishList.do">찜내역관리</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="checkQnaList.do">문의내역조회</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="checkBoardTGBList.do">공동구매게시판조회</a>
                </div>
            </div>
            <!-- Page content wrapper-->
            <div id="page-content-wrapper">
                <!-- Top navigation-->
               
                <!-- Page content-->
				<!-- <div class="content">
				
				</div> -->
					<%}%>
				<div class="content">
				<%if(admin == null){ %>
	
					<div id="titletext" align="center">마이페이지</div>
					<%}else {%>
					<div id="titletext" align="center">회원 정보</div>
					<%}%>
					<form id="updateForm" action="<%=request.getContextPath() %>/updateMember.do" method="post">
										
					<table>
						<tr>
							<td class="labelText" width="200px"> 아이디</td>
							<td><input type="text" class="inputcss" maxlength="13" name= "userId" var ="loginUser" value= "${loginUser.userId}"readonly></td>
						</tr>
						<tr>
							<td class="labelText"> 비밀번호</td>
							<td><input type="text" class="inputcss" id = "originPwd" name ="originPwd" <%if(admin == null){ %>value="${originPwd}"<%}else{ %>value="해당 유저만 확인 가능합니다."<%} %> readonly></td>
							<td></td>
						</tr>
						<tr>
							<td class="labelText"> 이름</td>
							<td><input type="text" class="inputcss" maxlength="5" name="userName" value= "${loginUser.userName }" required></td>
							<td></td>
						</tr>
						<tr>
							<td class="labelText"> 연락처</td>
							<td><input type="tel" class="inputcss" maxlength="11" name="phone" value= "${loginUser.phone }" placeholder="(-없이)01012345678"></td>
							<td></td>
						</tr>
						<tr>
							<td class="labelText"> 이메일</td>
							<td><input type="email"  class="inputcss"name="email" value= "${loginUser.email }"></td>
							<td></td>
						</tr>
						<tr>
							<td class="labelText"> 계좌번호</td>
							<td><input type="text" class="inputcss" name="account" value= "${loginUser.account }" placeholder="(-없이) 입력"></td>
							<td>
							<select name="bank" class="inputcss" style="width: 150px;">
								<option>선택</option>
								<option value="신한" <c:if test ="${loginUser.bank eq '신한'}">selected</c:if>>신한</option>
								<option value="우리"  <c:if test ="${loginUser.bank eq '우리'}">selected</c:if>>우리</option>
								<option value="농협"  <c:if test ="${loginUser.bank eq '농협'}">selected</c:if>>농협</option>
								<option value="국민" <c:if test ="${loginUser.bank eq '국민'}">selected</c:if>>국민</option>
								<option value="하나" <c:if test ="${loginUser.bank eq '하나'}">selected</c:if>>하나</option>
								<option value="기업"  <c:if test ="${loginUser.bank eq '기업'}">selected</c:if>>기업</option>
								<option value="카카오뱅크" <c:if test ="${loginUser.bank eq '카카오뱅크'}">selected</c:if>>카카오뱅크</option>
							</select>
							</td>
						</tr>
						<tr>
							<td class="labelText"> 우편번호</td>
							<td><input type="text"  class="inputcss" name="post" value= "${loginUser.post }" class="form-control mr-2 postcodify_postcode5" size="6"></td> 
							<td><%if(admin == null){ %><button type="button" class="btn btn-primary" id="postcodify_search_button">검색</button><%} %></td>
							
							
							<td></td>
						</tr>
						<tr>
							<td class="labelText"> 도로명 주소</td>
							<td> 
								<input type="text" name="address1" value= "${loginUser.address1 }" class="form-control postcodify_address"  size="30">
							</td>
						</tr>
						<tr>
							<td class="labelText"> 상세주소</td>
							<td> 
								<input type="text" name="address2" value= "${loginUser.address2 }" class="form-control postcodify_extra_info" size="30">
							</td>
						</tr>
					</table>
					<br>
			<%if(admin == null){ %>

						<div class="btns" align="center">
							<button type="submit" class="Allbtns" id="updateBtn">수정하기</button>
							
							<button type="button" class="Allbtns" id = "pwdUpdateBtn" onclick="updatePwd();">비밀번호 변경</button>
							<button type="button" class="Allbtns" id = "deleteBtn" onclick="deleteMember();">탈퇴하기</button>
							
						</div>
			<%}%>
						<!-- jQuery와 Postcodify를 로딩한다. -->
						<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
						<script>
							// 검색 단추를 누르면 팝업 레이어가 열리도록 설정한다.
							$(function(){
								$("#postcodify_search_button").postcodifyPopUp();
							});
						</script>

					</form> <!-- form 안에 있는 button은 type 설정하지 않으면 onclick함수 적용이 안됨 꼭 type을 지정해야함 -->
				</div><!--content-->
			</div><!--page-content-wrapper-->
	</div>
	</div>
	<script>
	if(window.opener){
		console.log('진입')
	}
		function updatePwd(){
			window.open("${contextPath}/updatePwdForm.do","비밀번호 변경창 ","width=500, height=300")
		} //window.open : 새창 열기

		function deleteMember(){
			if($('#originPwd').val() != ""){
				var pwd = prompt("비밀번호를 입력하세요");
				var op = $("#originPwd").val(); //form 안에 있는 원래 비번 값(.val())
				
				if(op === pwd){
					var val = confirm("정말로 가치사를 탈퇴 하시겠습니까?");
					if(val){ //true(확인) : 삭제하겠따
						$("#updateForm").attr("action","${contextPath}/deleteMember.do"); 
						                                                            //MemberDeleteServlet.java로 이동
						$("#updateForm").submit();
						alert("탈퇴 완료 되었습니다.");
					}else{
						alert("취소하였습니다");
					}
				}
			}else{ //네이버, 카카오 유저일 경우 비밀번호가 없다
				var val = confirm("정말로 가치사를 탈퇴 하시겠습니까?");
				if(val){ //true(확인) : 삭제하겠따
					$("#updateForm").attr("action","${contextPath}/deleteMember.do"); 
					                                                            //MemberDeleteServlet.java로 이동
					$("#updateForm").submit();
					alert("탈퇴 완료 되었습니다.");
				}else{
					alert("취소하였습니다");
				}
				
			}
		}

	</script>

        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/myPageScripts.js"></script>
    </body>
</html>