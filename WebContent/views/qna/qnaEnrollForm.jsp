<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../common/menubar.jsp" %>
	
	<div class="outer">
		<br>
		
		<h2 align="center">문의게시판 작성하기</h2>
		<br>
		
		<form id="insertForm" action="<%= contextPath %>/insertQna.do" method="post" enctype="multipart/form-data">
			<table align="center">
				<tr>
					<th width="100">분야</th>
					<td width="500">
						<select name="category">
							<option value="10">공통</option>
							<option value="20">운동</option>
							<option value="30">등산</option>
							<option value="40">게임</option>
							<option value="50">낚시</option>
							<option value="60">요리</option>
							<option value="70">기타</option> 
						</select>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea rows="15" name="content" style="resize:none;"></textarea>
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td><input type="file" name="upfile"></td>
				</tr>
			</table>
			<br>
			
			<div class="btns" align="center">
				<button type="reset">취소하기</button>
				<button type="submit">등록하기</button>
			</div>
		</form>
	</div>
</body>
</html>