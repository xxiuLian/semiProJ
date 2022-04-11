<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	.outer{
		width:800px;
		height:500px;
		background:black;
		color:white;
		margin:auto;
		margin-top:50px;
	}
	#enrollForm{width:60%; margin:auto;}
	#enrollForm>table{border:1px solid white;}
	#enrollForm>table input{
		width:100%;
		box-sizing:border-box;
	}
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	
	<div class="outer">
		<br>
		
		<h2 align="center">게시판 작성하기</h2>
		
		<form id="enrollForm" action="<%= contextPath %>/insertBoardTGB.do" method="post" >
			<table align="center">
				<tr>
					<th width="100">카테고리</th>
					<td width="500">
						<select name="category">
							<option value="1">의류</option>
							<option value="2">잡화</option>
							<option value="3">기기</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3"><input type="text" name="title"></td>
				</tr>
				
				<tr>
					<td>내용</td>
					<td colspan="3"></td>
				</tr>
				<tr>
					<td colspan="4">
						<textarea name="content" cols="60" rows="10" style="resize:none;"></textarea>
					</td>
				</tr>	
			</table>
			<br>
			
			<div class="btns" align="center">
				<button type="submit">등록하기</button>
				
			</div>
		</form>
	</div>


</body>
</html>