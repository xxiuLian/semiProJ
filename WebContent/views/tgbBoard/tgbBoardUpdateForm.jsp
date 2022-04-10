<%@page import="com.uni.common.Attachment"%>
<%@page import="com.uni.tgb_board.model.dto.TgbBoard_dto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	TgbBoard_dto b = (TgbBoard_dto)request.getAttribute("b");
	Attachment at = (Attachment)request.getAttribute("at");
%>

<!-- category부분임시★ -->
<%
	String category = b.getTgbBoardCategory();
	String[] selected = new String[7];
	
	switch(category){
	case "식품": selected[0] = "selected";break;
	case "의류": selected[1] = "selected";break;
	case "뷰티": selected[1] = "selected";break;
	case "주방용품": selected[1] = "selected";break;
	case "문구/오피스": selected[1] = "selected";break;
	case "잡화": selected[1] = "selected";break;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<h2 align="center">게시판 수정하기</h2>
	
	<form id="updateForm" action="<%= request.getContextPath()%>/tgbBoardUpdate.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="bno" value="<%= b.getTgbBoardNo() %>">
	
		<table align="center">
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" value="<%= b.getTgbBoardTitle() %>"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="15" name="content" style="resize:none;"><%= b.getTgbBoardContent() %></textarea>
				</td>
			</tr>
			<tr>
				<th width="100">카테고리</th>
				<td width="500">
					<select name="category">
						<option value="1" <%= selected[0] %>>식품</option>
						<option value="2" <%= selected[1] %>>의류</option>
						<option value="3" <%= selected[2] %>>뷰티</option>
						<option value="4" <%= selected[3] %>>주방용품</option>
						<option value="5" <%= selected[4] %>>문구/오피스</option>
						<option value="6" <%= selected[5] %>>잡화</option> 
					</select>
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td>
					<% if(at != null){ %> <!-- 기존의 첨부파일이 있었을 경우 -->
						<%= at.getOriginName() %> <br>
						<input type='hidden' name='originFile' value='<%=at.getChangeName()%>'>
						<input type='hidden' name='originFileNo' value='<%=at.getFileNo()%>'>
					<% }%>
					<input type="file" name="upFile">
				</td>
			</tr>
		</table>
		<div class="btns" align="center">
			<button type="submit">수정하기</button>
		</div>
	</form>
	
	<div class="btns">
		<% if(at != null ){ %>
			<button type="button" onclick="fDelete();">파일삭제</button>
		<% } %>
	</div>
	
	<form action="" id="postForm" method="post">
		<input type="hidden" name="bno" value="<%= b.getTgbBoardNo() %>">
	</form>
	
	<script>
		function fDelete(){
			$("#postForm").attr("action", "<%=request.getContextPath()%>/tgbBoardFileDelete.do");
			$("#postForm").submit();
		}
	</script>
</body>
</html>