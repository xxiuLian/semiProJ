<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import ="com.uni.qna.model.dto.*, com.uni.common.Attachment"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% 
	//Qna q  = (Qna)request.getAttribute("q");
	//Attachment at  = (Attachment)request.getAttribute("at");
	
	//String category = q.getCategory();
	//String[] selected = new String[7];
	
	//switch(category){
	//case "공통": selected[0] = "selected";break;
	//case "운동": selected[1] = "selected";break;
	//case "등산": selected[2] = "selected";break;
	//case "게임": selected[3] = "selected";break;
	//case "낚시": selected[4] = "selected";break;
	//case "요리": selected[5] = "selected";break;
	//case "기타": selected[6] = "selected";break;
	//}
	%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>
<style>
	.outer{
		width:900px;
		height:500px;
		background:black;
		color:white;
		margin:auto;
		margin-top:50px;
	}
	
	#updateForm>table{
		border:1px solid white;
	}
	
	#updateForm>table input, #updateForm>table textarea{
		width:100%;
		box-sizing:border-box;
	}
	
	#deleteBtn{color:gray;}
	#deleteBtn:hover{cursor:pointer}
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	
	<div class="outer">
		<br>
		
		<h2 align="center">문의게시판 수정하기</h2>
		<br>
		
		<form id="updateForm" action="${contextPath}/updateQna.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="qno" value="${q.qnaNo}">
			<table align="center">
				<tr>
					<th width="100">분야</th>
					<td width="500">
						<select name="category">
						<c:set var="ctg" value="${q.category}"/>
						<c:choose>
							<c:when test="${ctg eq '공통'}">
								<option value="10" selected[0] = "selected">공통</option>
							</c:when>
							<c:when test="${ctg eq '회원'}">
								<option value="20" selected[1] = "selected">회원</option>
							</c:when>
							<c:when test="${ctg eq '이벤트'}">
								<option value="30" selected[2] = "selected">이벤트</option>
							</c:when>
							<c:when test="${ctg eq '주문/결제'}">
								<option value="40" selected[3] = "selected">주문/결제</option>
							</c:when>
							<c:when test="${ctg eq '배송'}">
								<option value="50" selected[4] = "selected">배송</option>
							</c:when>
							<c:when test="${ctg eq '취소/반품/교환'}">
								<option value="10" selected[5] = "selected">취소/반품/교환</option>
							</c:when>
							<c:otherwise>
								<option value="10" selected[6] = "selected">기타</option>
							</c:otherwise>
						</c:choose>
							<%--<option value="10" <%= selected[0] %>>공통</option>
							<option value="20" <%= selected[1] %>>운동</option>
							<option value="30" <%= selected[2] %>>등산</option>
							<option value="40" <%= selected[3] %>>게임</option>
							<option value="50" <%= selected[4] %>>낚시</option>
							<option value="60" <%= selected[5] %>>요리</option>
							<option value="70" <%= selected[6] %>>기타</option> --%>
						</select>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" value="${q.qnaTitle}"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea rows="15" name="content" style="resize:none;">${q.qnaContent}</textarea>
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td>
						<c:if test="${at != null}"><!-- 기존의 첨부파일이 있었을 경우 -->
							${at.originName}<br>
							<input type='hidden' name='originFile' value='${at.changeName}'>
							<input type='hidden' name='originFileNo' value='${at.fileNo}'>
						</c:if>
						<input type="file" name="upFile">
					</td>
					
				</tr>
			</table>
			<br>
			
			<div class="btns" align="center">
				<button type="submit">수정하기</button>
			</div>
		</form>
	</div>
</body>
</html>