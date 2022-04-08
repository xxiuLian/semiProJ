<%@ page import="com.uni.tgb_board.model.dto.TgbBoard_dto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="com.uni.tgb_board.model.dto.*, com.uni.common.Attachment" %>
<%
	TgbBoard_dto b = (TgbBoard_dto)request.getAttribute("b");
	Attachment at = (Attachment)request.getAttribute("at");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
			<button type="button" onclick="updateForm();">수정하기</button>
			<button type="button" onclick="deleteTgb();">삭제하기</button>
		</div>
		
		<form action="" id="postForm" method="post">
			<input type="hidden" name="bno" value="<%= b.getTgbBoardNo() %>">
		</form>
		
		<script>
			function updateForm(){
				$("#postForm").attr("action", "<%=request.getContextPath()%>/tgbBoardUpdateForm.do");
				$("#postForm").submit();
			}
			
			function deleteTgb(){
				$("#postForm").attr("action", "<%=request.getContextPath()%>/tgbBoardDelete.do");
				$("#postForm").submit();
			}
		</script>
</body>
</html>