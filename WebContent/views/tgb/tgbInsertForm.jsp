<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method="post" action="tgbInsertServlet.do">
제목 : <input type="text" name="title"><br>
<select name="category">
    <option value="1">식품</option>
    <option value="2">의류</option>
</select><br>

제품 설명 : <textarea rows="3" cols="10" name="content"></textarea><br>
공구 설명 : <textarea rows="3" cols="10" name="guide"></textarea><br>
공구 기간 : <input type="date" name="term">
공구 가격 : <input type="text" name="price">
writer_no<input type="text" name="writer" value="5">
<button type="submit">등록</button>
</form>

</body>
</html>