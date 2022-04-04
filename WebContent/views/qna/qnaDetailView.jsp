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
				<td>${q.qnaWrite)}</td>
				<th>조회수</th>
				<td>${q.Count}</td>
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
			
			<% //if(loginUser != null && loginUser.getUserId().equals(q.getQnaWriter())){ %>
				
				<button type="button" onclick="updateForm();">수정하기</button>
				<button type="button" onclick="deleteQna();">삭제하기</button>
			<% //} %>
		</div>
		
		<form action="" id="postForm" method="post">
			<input type="hidden" name="qno" value="${q.qnaNo}">
		</form>
		<script>
			function updateForm(){
				$("#postForm").attr("action", "${contextPath}/updateFormQna.do");
				$("#postForm").submit();
			}
			
			function deleteBoard(){
				$("#postForm").attr("action", "${contextPath}/deleteQna.do");
				$("#postForm").submit();
			}
		</script>
	</div>
	
	<div class="replyArea">
		<!-- 댓글 작성하는 div -->
		<table border="1" align="center">
			<tr>
				<th>댓글작성</th>
				<c:if test="${loginUser.userId() == 'admin'}">
					<td><textarea readonly rows="3" cols="60" id="replyContent" style="resize:none;">관리자만 작성 가능합니다.</textarea></td>
					<td><button disabled>댓글등록</button></td>
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
			var qId = ${q.qnaNo()};
			
			
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
				data:{bId:${q.qnaNo()}},
				type:"get",
				success:function(list){
					console.log(list)
				/*	var value="";
					for(var i in list){
						value += '<tr>'+
									'<td width="100px">'+ list[i].replyWriter+'</td>'+ 
									'<td width="330px">'+ list[i].replyContent+'</td>'+ 
									'<td width="150px">'+ list[i].createDate+'</td>'+ 
								'</tr>';
					}
					$("#replyList").html(value);
					
					
					//2번방법 
					var value="";
					$.each(list,function(index,obj){
						value += '<tr>'+
								'<td width="100px">'+ obj.replyWriter+'</td>'+ 
								'<td width="330px">'+ obj.replyContent+'</td>'+ 
								'<td width="150px">'+ obj.createDate+'</td>'+ 
						'</tr>';
					})
					$("#replyList").html(value);*/
					
					
					// 3번 방법
					$.each(list, function(index, obj){
						
						var writerTd = $("<td>").text(obj.replyWriter).attr("width", "100px");
						var contentTd = $("<td>").text(obj.replyContent).attr("width", "330px");
						var dateTd = $("<td>").text(obj.createDate).attr("width", "150px");
						
						var tr = $("<tr>").append(writerTd, contentTd, dateTd);
						
						$("#replyList").append(tr);
						
					});
				},
				error:function(){
					console.log("ajax 통신실패 -댓글조회")
				}
				
			})
		}
	</script>
</body>
</html>