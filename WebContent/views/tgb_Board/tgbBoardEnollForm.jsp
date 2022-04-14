<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- enctype="multipart/form-data"  -->
	<form id="insertForm" action="<%= request.getContextPath()%>/insertTgbBoard.do" method="post" enctype="multipart/form-data">
		<table>
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
				<th>제목</th>
				<td><input type="text" name="title"></td>
			</tr>
			<tr>
				<th>내용</th>
				<!-- style="resize:none; -->
				<td><textarea row="15" name="content"></textarea></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td><input type="file" name="upfile"></td>
			</tr>
		</table>
		
		<div class="btns">
			<button type="submit">등록하기</button>
			<button type="reset">취소하기</button>
		</div>
	</form>

</body>
</html>