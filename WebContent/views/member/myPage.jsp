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
	
	ul, li { list-style: none; }
	
	
	
	
</style>

<head>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!-- 재욱추가B -->
<link rel="stylesheet" href="css/cssWook.css">

</head>
    
<body>

    <%@ include file="../../views/common/menubar.jsp" %>
    


   <div class="d-flex" id="wrapper">
       <!-- Sidebar-->
       <div class="border-end bg-white" id="sidebar-wrapper" >
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
               <a class="list-group-item list-group-item-action list-group-item-light p-3" href="wishList.do">찜내역관리3</a>
               <a class="list-group-item list-group-item-action list-group-item-light p-3" href="checkQnaList.do">문의내역조회</a>
               <a class="list-group-item list-group-item-action list-group-item-light p-3" href="checkBoardTGBList.do">공동구매게시판조회</a>
               <a class="list-group-item list-group-item-action list-group-item-light p-3" href="#!">Events</a>
               <a class="list-group-item list-group-item-action list-group-item-light p-3" href="#!">Profile</a>
               <a class="list-group-item list-group-item-action list-group-item-light p-3" href="#!">Status</a>
           </div>
       </div>
       
<div class="container" id="pading0">
<div class="col-xs-12" id="pading0" >
    <div class="carousel slide" id="myCarousel">
    <button class="btn btn-primary" id="sidebarToggle">My Menu3</button>
        <div class="carousel-inner" id="backgPink" >
        
            <div class="item active" >
            
                    <ul class="thumbnails">
                    
                        <li class="col-sm-3 " id="pading0">
							<div class="thumbnail upsize" >
								<img src="resources/wookImg/hum.png" id="imgWook" >
								<h4 class="whiteback">${loginUser.userName}</h4>
								<p class="whiteback">${loginUser.userName}님 환영합니다.</p>
								<%-- <a class="btn btn-mini" href="#">» Read More</a> --%>
                            </div>
                        </li>
                        <li class="col-sm-3 upsize">
							<div class="casing whiteback wooksize" >
								<div class="caption whiteback" >
									<h1 class="chatSize">구 매</h1>
									<p>────────────</p>
									<h3><%= payCount %>건</h3>
									<%--<a class="btn btn-mini" href="#">» Read More</a> --%>
								</div>
                            </div>
                        </li>
                        <li class="col-sm-3 upsize">
							<div class="casing whiteback wooksize" >
								<div class="caption ">
									<h1 class="chatSize">진 행</h1>
									<p>────────────</p>
									<h3><%= payCount %>건</h3>
									<%--<a class="btn btn-mini" href="#">» Read More</a> --%>
								</div>
                            </div>
                        </li>
                        <li class="col-sm-3 upsize">
							<div class="casing whiteback wooksize">
								<div class="caption">
									<h1 class="chatSize">문 의</h1>
									<p>────────────</p>
									<h3><%= payCount %>건</h3>
									<%--<a class="btn btn-mini" href="#">» Read More</a> --%>
								</div>
                            </div>
                        </li>
                    </ul>
	   <!-- /.control-box -->   
                              
    </div><!-- /#myCarousel -->
        
</div><!-- /.col-xs-12 -->          

</div><!-- /.container -->

            <%--까지 --%>
   	 		<%--  
            <!-- Page content wrapper-->
            <div id="page-content-wrapper">
                <!-- Top navigation-->
                
                <!-- 추가1_재욱boot -->
                
                <div class="p-3 p-md-5 text-white rounded alert-danger" >
                
	                <div class="container show-grid">
		                <div class="row">
					      <div class="col-md-2 " id="asdf">
					      	<article class="card" style="color:black">
				                <img class="card-img-top" src="resources/wookImg/hum.png" id="imgWook" >
				                <div class="card-body">
				                    <h3 class="card-title">이름</h3>
				                </div>
				            </article>
					      </div>
					      
					      <div class="col-md-2 mr-3" id="asdf">
					      	환영
					      </div>
					      <div class="col-lg-2 mx-3" id="asdf" >
					      	<div class="userIng" style = border:2px solid red">
								<%= payCount %>건
								<b>구 매</b>
							</div>
					      </div>
					      <div class="col-md-2 mx-3" id="asdf">
					      	진행sdf
					      </div>
					      <div class="col-md-2 mx-3" id="asdf">
					      	문의sdf
					      </div>
					    </div>
					</div>
                
            
			    <!-- 까지1_재욱boot 123-->
                
                
                <nav class="navbar navbar-expand-lg navbar-light bg-dark border-bottom">
                    <div class="container-fluid">
                    <div class="container">
                        
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
					<!-- 			
			<table>
				<tr>
					<td><b id="user">${loginUser.userName }님 환영합니다.</b></td>
					<td></td>
					<td>
					<div class="userIng" style = "width:200px;height:200px;border:2px solid red">
						<b>구 매</b>
						<%= payCount %>건
					</div>
					</td>
					<td>
					<div class="userIng" style = "width:200px;height:200px;border:2px solid red">
						<b>진 행</b>
						<%= ingCount %>건
					</div>
					</td>
					<td>
					<div class="userIng" style = "width:200px;height:200px;border:2px solid red">
						<b>문 의</b>
						<%= qnaCount %>건
					</div>
					</td>
					<td></td>
				</tr>
			</table>
			  -->
				</div>
			</div>
			<button class="btn btn-primary" id="sidebarToggle">My Menu3</button>
		</div>
		--%>

        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/myPageScripts.js"></script>
    </body>
</html>
