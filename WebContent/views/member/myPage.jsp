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
    



       
<div class="container" id="pading0">
<div class="col-xs-12" id="pading0" >
    <div class="carousel slide" id="myCarousel">
    
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

   <div class="d-flex" id="wrapper"> <!-- 부터 -->
   
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
               <%--
               <a class="list-group-item list-group-item-action list-group-item-light p-3" href="#!">Events</a>
               <a class="list-group-item list-group-item-action list-group-item-light p-3" href="#!">Profile</a>
               <a class="list-group-item list-group-item-action list-group-item-light p-3" href="#!">Status</a>
                --%>
           </div>
       </div> <!-- 까지 -->
       <div><button class="btn btn-primary sideButoon" id="sidebarToggle">My Menu9</button></div>
</div><!-- /.container -->

        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/myPageScripts.js"></script>
    </body>
    
</html>
