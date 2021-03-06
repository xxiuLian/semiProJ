<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.uni.qna.model.dto.*, com.uni.common.Attachment"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String admin = (String) request.getAttribute("admin");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 글 조회</title>
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js"
	crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700"
	rel="stylesheet" type="text/css" />
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<link href="css/styles.css" rel="stylesheet" />
<link href="css/myPageStyles.css" rel="stylesheet" />
<style>
.outer {
	width: 850px;
	height: 500px;
	background: #fff;
	color: black;
	margin: auto;
	margin-top: 50px;
}

#detailArea, #replyList {
	width: 100%;
	margin: 15px auto;
	border-color: black;
}

#detailArea th, #replyList th {
	font-size: 20px;
}

#detailArea td, #replyList td {
	font-size: 18px;
}

table {
	width: 100%;
	margin: 15px auto;
	border-color: black;
}

table th {
	font-size: 20px;
}

table td {
	font-size: 18px;
}

.btns a {
	text-decoration: none;
	color: black;
}

.replyBtn {
	border: 1px solid lightgray;
	border-radius: 5px;
}
</style>
</head>
<body>
	<!-- Sidebar Start -->
	<%@ include file="../common/menubar.jsp"%>
	<div class="container">
		<div class="d-flex" id="wrapper">

			<!-- Sidebar-->
			<div class="border-end bg-white" id="sidebar-wrapper">
				<div class="sidebar-heading border-bottom bg-light">
					<a href="<%=contextPath%>/myPage.do">Start Bootstrap</a>
				</div>
				<div class="list-group list-group-flush">
					<a
						class="list-group-item list-group-item-action list-group-item-light p-3"
						href="myInfo.do" id="myInfo">내 정보</a>
					<div>
						<a id="myList"
							class="list-group-item list-group-item-action list-group-item-light p-3"
							href="myList.do">공동구매 내역 조회</a>
						<ul>
							<li><a class="nav-link" href="myList.do">나의 진행 상품</a></li>
							<li><a class="nav-link" href="myPayList.do">나의 참여 상품</a></li>
							<li><a class="nav-link" href="myFinishList.do">이전 상품</a></li>
						</ul>
					</div>
					<a
						class="list-group-item list-group-item-action list-group-item-light p-3"
						href="wishList.do">찜내역관리</a> <a
						class="list-group-item list-group-item-action list-group-item-light p-3"
						href="checkQnaList.do">문의내역조회</a> <a
						class="list-group-item list-group-item-action list-group-item-light p-3"
						href="checkBoardTGBList.do">공동구매게시판조회</a>

				</div>
			</div>
			<!-- Sidebar End -->

			<!-- Page content wrapper-->

			<div class="outer">
				<br>

				<h2 align="center">게시판 상세보기</h2>
				<br>

				<table class="table table-condensed" id="detailArea">
					<tr>
						<th width="100">분야</th>
						<td>${q.category}</td>
						<th>제목</th>
						<td colspan="3">${q.qnaTitle}</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${q.qnaWriter}</td>
						<th>조회수</th>
						<td>${q.count}</td>
						<th>작성일</th>
						<td>${q.createDate}</td>
					</tr>
					<tr>
						<th>내용</th>
						<td style="padding-left: 50px" colspan="5">
							<p>${q.qnaContent}</p>
						</td>
					</tr>
				</table>
				<br>


				<form action="" id="postForm" method="post">
					<input type="hidden" name="qno" value="${q.qnaNo}">
				</form>


				<!-- 댓글 리스트들 보여주는 div -->
				<div id="replyListArea">
					<table class="table table-condensed" id="replyList" align="center">

					</table>
				</div>
				<br> <br>
				<div class="replyArea">
					<!-- 댓글 작성하는 div -->
					<table id="adminReply" class="table table-condensed" align="center">
						<tr>
							<c:if test="${loginUser.userId == 'admin'}">
								<th>답변작성</th>
								<td><textarea rows="3" cols="60" id="replyContent"
										style="resize: none;"></textarea></td>
								<td id="replyBtn"><button class="replyBtn" id="addReply">답변등록</button></td>
							</c:if>
						</tr>
					</table>
				</div>
				<%--
				<%
				if (admin == null) {
				%>


				<div class="btns" align="center">
					<a href="${contextPath}/qnaList.do?currentPage=1">목록으로</a>
					&nbsp;&nbsp;

					<c:if test="${sessionScope.loginUser.userId eq q.qnaWriter}">
						<a href="javascript:void(0);" onclick="updateForm();">수정하기</a>&nbsp;&nbsp;
			 --%>
				<a href="javascript:void(0);" onclick="deleteQna();">삭제하기</a>
				</div>
			

				<br> <br>
			</div>
		</div>
	</div>
</body>
<script>
	function updateForm(){
		$("#postForm").attr("action", "${contextPath}/updateFormQna.do");
		$("#postForm").submit();
	}
	
	function deleteQna(){
		if(confirm("삭제하시겠습니까?")){
			$("#postForm").attr("action", "${contextPath}/deleteQna.do");
			$("#postForm").submit();
		}
	}
</script>
<script>
$(function(){
	selectReplyList();
	$("#addReply").click(function(){
		var content = $("#replyContent").val();
		var qId = ${q.qnaNo};
		
		
		$.ajax({
			url:"rinsert.do",
			type:"post",
			data:{
					content:content,
				    qId:qId
			},
			success:function(status){
				if(status =="success"){
					selectReplyList();
					$("#replyContent").val("");
				}
			},
			error:function(){
				console.log("ajax 통신실패 -댓글등록")
			}
			
		})
		
	})
	
})
	function selectReplyList(){
			$("#replyList").empty();
			$.ajax({
				url:"rlist.do",
				data:{qId:${q.qnaNo}},
				type:"get",
				success:function(reply){
					console.log(reply)
					console.log(reply.qnaReply)
					console.log(reply.replyDate)
						if(reply.qnaReply != null){
							var replyInfo = $("<td>").html('<b>답변내용</b>').attr("width", "100px");
							var dateInfo = $("<td>").html('<b>답변 작성일</b>').attr("width", "100px");
							var replyContent = $("<td>").html(reply.qnaReply).attr("width", "330px");
							var replyDate = $("<td>").text(reply.replyDate).attr("width", "150px");
							
							var tr = $("<tr>").append(replyInfo, replyContent, dateInfo, replyDate);
							$("#replyList").append(tr);
							$("#adminReply").html('')
							$("#adminReply").append('<th>답변수정</th>' +
													'<td><textarea rows="3" cols="60" id="replyContent"' +
													'style="resize: none;">' +
													reply.qnaReply +
													'</textarea></td>' +
													'<td id="replyBtn"><button class="replyBtn" id="addReply">답변수정</button></td>'+
													'<td id="deleteBtn"><button class="replyBtn" id="deleteReply">답변삭제</button></td>'
							)
							$("#replyBtn").on('click', '#addReply', function submitReply(){
								var content = $("#replyContent").val();
								var qId = ${q.qnaNo};
								
								
								$.ajax({
									url:"rinsert.do",
									type:"post",
									data:{
											content:content,
										    qId:qId
									},
									success:function(status){
										if(status =="success"){
											selectReplyList();
											$("#replyContent").val("");
										}
									},
									error:function(){
										console.log("ajax 통신실패 -댓글등록")
									}
									
								})
							})
							
							$("#deleteBtn").on('click', '#deleteReply', function deleteReply(){
								var qId = ${q.qnaNo};
								if(confirm("삭제하시겠습니까?")){
									
								
								$.ajax({
									url:"rdelete.do",
									type:"post",
									data:{
										    qId:qId
									},
									success:function(status){
										console.log(status)
										if(status =="success"){
											selectReplyList();
											$("#replyContent").val("");
											$("#adminReply").html('')
											$("#adminReply").append('<th>답변작성</th>' +
																	'<td><textarea rows="3" cols="60" id="replyContent"' +
																	'style="resize: none;"></textarea></td>' +
																	'<td id="replyBtn"><button class="replyBtn" id="addReply">답변등록</button></td>'
																	
																	)
											$("#replyBtn").on('click', '#addReply', function submitReply(){
												var content = $("#replyContent").val();
												var qId = ${q.qnaNo};
												
												
												$.ajax({
													url:"rinsert.do",
													type:"post",
													data:{
															content:content,
														    qId:qId
													},
													success:function(status){
														if(status =="success"){
															selectReplyList();
															$("#replyContent").val("");
														}
													},
													error:function(){
														console.log("ajax 통신실패 -댓글등록")
													}
													
												})
											})					
										}
									},
									error:function(){
										console.log("ajax 통신실패 -댓글등록")
									}
									
								})
							}
							})
						}else{
							var replyInfo = $("<td>").html('<b>답변 대기중</b>').attr("width", "500px").attr("align", "center");
							var tr = $("<tr>").append(replyInfo);
							$("#replyList").append(tr);
						}
						
						
				
				},
				error:function(){
					console.log("ajax 통신실패 -댓글조회")
				}
				
			})
		}
	</script>
</html>