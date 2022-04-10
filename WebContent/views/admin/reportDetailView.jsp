<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.uni.qna.model.dto.*, com.uni.common.Attachment"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 글 조회</title>
</head>
<body>
<%@ include file="../common/menubar.jsp" %>
	
	<div class="outer">
		<br>
		
		<h2 align="center">신고 상세보기</h2>
		<br>
		<form id="deleteReport" action="${contextPath}/deleteReport.do" method="post">
		<input type="hidden" name="report" value="${r.reportNo}">
		<table align="center">
			<tr>
				<th>상품 번호</th>
				<td colspan="2">${r.reportNo}</td>
				<th>작성일</th>
				<td>${r.createDate}</td>
			</tr>
			<tr>
				<th width="100">작성자</th>
				<td>${r.reportUserId}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3">
					<p>${r.reportContent}</p>
				</td>
			</tr>
			<tr>
				<td><button type="button" onclick="location.href='${contextPath}/detailTgb.do?bno=${r.tgbNo}'">상품 보기</button></td>
			</tr>
		</table>
		
		<br>
		
		<div class="btns" align="center">
			<button type="submit">신고 삭제하기</button>
		</div>
		</form>
		
		
	</div>
	
</body>
</html>