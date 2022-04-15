<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.uni.qna.model.dto.*, com.uni.common.Attachment"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 글 조회</title>
<style>
	.outer{
		width:800px;
		height:500px;
		background:#fff;
		color:black;
		margin:auto;
		margin-top:50px;
	}
	.listArea {
		border:1px solid white;
		text-align:center;
	}
	.searchArea{
		margin-top:50px;
	}
	
	/* .listArea>tbody>tr:hover{
		background:lightgrey;
		cursor:pointer
	} */
	
	.pagingArea{
		margin-top:15px;
	}
	.pagingicon{
		border: 1px solid lightgray;
		border-radius: 5px;
	}
	#writeadmin, #searchbtn{
		border: 1px solid black;
		
	}
	#writeadmin:hover{
		background-color:#eee;
	}
	#searchbtn:hover{
		background-color:#eee;
	}
	.qnaCategory{
		float: left;
	}
</style>
</head>
<body>
<%@ include file="../common/menubar.jsp" %>
	
	<div class="outer">
		<br>
		
		<h2 align="center">게시판 상세보기</h2>
		<br>
		
		<table class="listArea table" align="center">
			<tr>
				<th width="100">분야</th>
				<td>${q.category}</td>
				<th>제목</th>
				<td colspan="2">${q.qnaTitle}</td>
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
				<td colspan="3">
					<p>${q.qnaContent}</p>
				</td>
			</tr>
		</table>
		<br>
		
		<div class="btns" align="center">
			<button type="button" class="pagingicon" onclick="location.href='${contextPath}/qnaList.do?currentPage=1';">목록으로</button>
			
			<c:if test="${sessionScope.loginUser.userId eq q.qnaWriter}">
				<button type="button" class="pagingicon" onclick="updateForm();">수정하기</button>
				<button type="button" class="pagingicon" onclick="deleteQna();">삭제하기</button>
			</c:if>	
		</div>
		
		<form action="" id="postForm" method="post">
			<input type="hidden" name="qno" value="${q.qnaNo}">
		</form>
		
		<script>
			function updateForm(){
				$("#postForm").attr("action", "${contextPath}/updateFormQna.do");
				$("#postForm").submit();
			}
			
			function deleteQna(){
				$("#postForm").attr("action", "${contextPath}/deleteQna.do");
				$("#postForm").submit();
			}
		</script>
	</div>
		<br> <br>
		<!-- 댓글 리스트들 보여주는 div -->
		<div id="replyListArea">
			<table id="replyList" border="1" align="center">
				
			</table>
		</div>
		<br><br>
		<div class="replyArea">
		<!-- 댓글 작성하는 div -->
		<table border="1" align="center">
			<tr>
				<c:if test="${sessionScope.loginUser.userId == 'admin'}">
					<th>답변작성</th>
						<td><textarea rows="3" cols="60" id="replyContent" style="resize:none;"></textarea></td>
						<td><button class="pagingicon" id="addReply">답변등록</button></td>
				</c:if>
			</tr>
		</table>
	</div>
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
							var replyInfo = $("<td>").text('답변내용').attr("width", "100px");
							var dateInfo = $("<td>").text('답변 작성일').attr("width", "100px");
							var replyContent = $("<td>").text(reply.qnaReply).attr("width", "330px");
							var replyDate = $("<td>").text(reply.replyDate).attr("width", "150px");
							
							var tr = $("<tr>").append(replyInfo, replyContent, dateInfo, replyDate);
							
							$("#replyList").append(tr);
							
						}else {
							var replyInfo = $("<td>").text('답변 대기중').attr("width", "500px").attr("text-align", "center");
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
</body>
</html>