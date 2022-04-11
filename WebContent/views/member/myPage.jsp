<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.uni.tgb.model.dto.*"%>
<%
	ArrayList<Tgb> list = (ArrayList<Tgb>)request.getAttribute("list");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="loginUser" value="${sessionScope.loginUser}" scope="session"/>
<c:set var="msg" value="${sessionScope.msg}" scope="session"/>
<c:set var="contextPath" value="<%= request.getContextPath()%>" scope="session"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Simple Sidebar - Start Bootstrap Template</title>
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
	
	#joinBtn{background:yellowgreen;}
	#goMain{background:orangered;}
	
	table{margin-top:100px}
	#user{margin-left:300px; margin-right:100px;}
	.userIng{margin-left:20px;}
</style>
    </head>
    <body>
    <%@ include file="../../views/common/menubar.jsp" %>
    
        <div class="d-flex" id="wrapper">
            <!-- Sidebar-->
            <div class="border-end bg-white" id="sidebar-wrapper">
                <div class="sidebar-heading border-bottom bg-light">Start Bootstrap</div>
                <div class="list-group list-group-flush">
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="myInfo.do" id="myInfo">내 정보</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="myList.do">공동구매 내역 조회</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="wishList.do">찜내역관리</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="#!">Events</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="#!">Profile</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="#!">Status</a>
                </div>
            </div>
            <!-- Page content wrapper-->
            <div id="page-content-wrapper">
                <!-- Top navigation-->
                <nav class="navbar navbar-expand-lg navbar-light bg-dark border-bottom">
                    <div class="container-fluid">
                        <button class="btn btn-primary" id="sidebarToggle">My Menu</button>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav ms-auto mt-2 mt-lg-0 bg-light">
                                <li class="nav-item active"><a class="nav-link" href="/valueSa">Home</a></li>
                                <li class="nav-item"><a class="nav-link" href="#!">Link</a></li>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Dropdown</a>
                                    <div class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                                        <a class="dropdown-item" href="#!">Action</a>
                                        <a class="dropdown-item" href="#!">Another action</a>
                                        <div class="dropdown-divider"></div>
                                        <a class="dropdown-item" href="#!">Something else here</a>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
                <!-- Page content-->
				<!-- <div class="content">
				
				</div> -->
				
				<div>
				<h2 align="center">마이페이지</h2>
								
			<table>
				<tr>
					<td><b id="user">${loginUser.userName }님 환영합니다.</b></td>
					<td></td>
					<td>
					<div class="userIng" style = "width:200px;height:200px;border:2px solid red">
						<b>구 매</b>
					</div>
					</td>
					<td>
					<div class="userIng" style = "width:200px;height:200px;border:2px solid red">
						<b>진 행</b>
						<input type="text" id="output3" style="width: 300px" readonly>
					</div>
					</td>
					<td>
					<div class="userIng" style = "width:200px;height:200px;border:2px solid red">
						<b>문 의</b>
					</div>
					</td>
					<td></td>
				</tr>
			</table>
				</div>
			</div>
		</div>
	<script>
		$(function(){
			
		})
	
		function updatePwd(){
			window.open("<%= contextPath %>/updatePwdForm.do","비밀번호 변경창 ","width=500, height=300")
		} //window.open : 새창 열기

		function deleteMember(){
			var pwd = prompt("비밀번호를 입력하세요");
			var op = $("#originPwd").val(); //form 안에 있는 원래 비번 값(.val())
			
			if(op === pwd){
				var val = confirm("정말로 가치사를 탈퇴 하시겠습니까?");
				if(val){ //true(확인) : 삭제하겠따
					$("#updateForm").attr("action","<%= contextPath %>/deleteMember.do"); 
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
