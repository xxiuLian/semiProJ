<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.uni.tgb.model.dto.*"%>
<%
	ArrayList<Tgb> list = (ArrayList<Tgb>)request.getAttribute("list");
	int ingCount = (int)request.getAttribute("ingCount");
	int payCount = (int)request.getAttribute("payCount");
	int qnaCount = (int)request.getAttribute("qnaCount");
%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Simple Sidebar2 - Start Bootstrap Template</title>
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
	ul, li { list-style: none; }
</style>


<link rel="stylesheet" href="css/cssWook.css">
    </head>
    <body>
    <%@ include file="../../views/common/menubar.jsp" %>
    
        <div class="d-flex" id="wrapper">
            <!-- Sidebar-->
            <div class="border-end bg-white" id="sidebar-wrapper">
                <div class="sidebar-heading border-bottom bg-light"><a href="<%=contextPath %>/myPage.do">Start Bootstrap</a></div>
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
                        <button class="btn btn-primary" id="sidebarToggle">My Menu9</button>
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
                
<div class="row container-fluid back1" >

	    <div class="row1 col-lg-2 row1_img">
	    	<img src="resources/wookImg/hum.png" id="imgWook" >
	    </div>
	    <div class="row1 col-lg-2 row1_img">
	    	<p class="name1">
	    		<br>${loginUser.userName}님<br> 환영합니다.
	    	</p>
	    </div>
		<div class="row1 col-lg-2 ">
			<h5 class="chatSize">구 매</h5>
			<p class="asdf">────────</p>
			<h6><%= payCount %>건</h6>
		</div>
		<div class="row1 col-lg-2 ">
			<h5 class="chatSize">진 행</h5>
			<p class="asdf">────────</p>
			<h6><%= ingCount %>건</h6>
		</div>
		<div class="row1 col-lg-2 ">
			<h5 class="chatSize">구 매</h5>
			<p class="asdf">────────</p>
			<h6><%= qnaCount %>건</h6>
		</div>

</div>
               
                
                
                <!-- Page content-->
				<!-- <div class="content">
				
				</div> -->
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/myPageScripts.js"></script>
    </body>
    
</html>
