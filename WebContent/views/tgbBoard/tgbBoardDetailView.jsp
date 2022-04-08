<%@page import="com.uni.tgb_board.model.dto.TgbBoard_dto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.uni.tgb_board.model.dto.*, com.uni.common.Attachment" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	TgbBoard_dto b = (TgbBoard_dto)request.getAttribute("b");
	Attachment at = (Attachment)request.getAttribute("at");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%= b.getTgbBoardTitle() %>
	<%= b.getTgbBoardContent() %>
 	<%= b.getTgbBoardCategory() %>

 	<table>
 		<th>첨부파일3</th>
		<td>
			<% if(at != null){ %>
				<a download="<%= at.getOriginName() %>" href="<%=request.getContextPath()%>/assets/tgbBoard_upfiles/<%=at.getChangeName()%>"><%= at.getOriginName() %></a>
			<% }else{ %>
				첨부파일이 없습니다.
			<% } %>
		</td> 
 	</table>
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
				$("#postForm").attr("action", "${contextPath}/tgbBoardUpdate.do");
				$("#postForm").submit();
			}
			
			function deleteQna(){
				$("#postForm").attr("action", "${contextPath}/tgbBoardDelete.do");
				$("#postForm").submit();
			}
		</script>
</body>
</html>