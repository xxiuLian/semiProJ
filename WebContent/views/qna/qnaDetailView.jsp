<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.uni.qna.model.dto.*, com.uni.common.Attachment"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../common/menubar.jsp" %>
	
	<div class="outer">
		<br>
		
		<h2 align="center">게시판 상세보기</h2>
		<br>
		
		<table align="center">
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
			<%--
			<tr>
				<th>첨부파일</th>
				<td colspan="3">
					<% if(at != null){ %>
					<a download="<%= at.getOriginName() %>" href="<%=contextPath%>/resources/board_upfiles/<%=at.getChangeName()%>"><%= at.getOriginName() %></a>
					<% }else{ %>
					첨부파일이 없습니다.
					<% } %>
				</td> 
			</tr> --%>
		</table>
		<br>
		
		<div class="btns" align="center">
			<button type="button" onclick="location.href='${contextPath}/qnaList.do?currentPage=1';">목록으로</button>
			
			<c:if test="${sessionScope.loginUser.userId eq q.qnaWriter}">
				<button type="button" onclick="updateForm();">수정하기</button>
				<button type="button" onclick="deleteQna();">삭제하기</button>
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
	
	<div class="replyArea">
		<!-- 댓글 작성하는 div -->
		<table border="1" align="center">
			<tr>
				<c:if test="${sessionScope.loginUser.userId == 'admin'}">
					<th>답변작성</th>
						<td><textarea rows="3" cols="60" id="replyContent" style="resize:none;"></textarea></td>
						<td><button id="addReply">답변등록</button></td>
				</c:if>
			</tr>
		</table>
		<!-- 댓글 리스트들 보여주는 div -->
		<div id="replyListArea">
			<table id="replyList" border="1" align="center">
				<!-- <tr>
					<td width="100px">admin</td>
					<td width="330px">댓글작성내용</td>
					<td width="150px">2020년 1월 23일</td>
				</tr>
				<tr>
					<td width="100px">user01</td>
					<td width="330px">댓글작성내용</td>
					<td width="150px">2020년 1월 22일</td>
				</tr>
				<tr>
					<td width="100px">test01</td>
					<td width="330px">댓글작성내용</td>
					<td width="150px">2020년 1월 20일</td>
				</tr> -->
			</table>
		</div>
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
							
						}else{
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