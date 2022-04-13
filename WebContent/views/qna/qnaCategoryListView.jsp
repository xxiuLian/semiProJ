<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.ArrayList, com.uni.qna.model.dto.*, com.uni.common.PageInfo"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="listCount" value="${pi.listCount}" scope="request" />
<c:set var="currentPage" value="${pi.currentPage}" scope="request" />
<c:set var="maxPage" value="${pi.maxPage}" scope="request" />
<c:set var="startPage" value="${pi.startPage}" scope="request" />
<c:set var="endPage" value="${pi.endPage}" scope="request" />

<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>문의 게시판</title>
<style>
.outer {
	width: 1000px;
	height: 500px;
	margin: auto;
	margin-top: 50px;
}

.listArea {
	border: 1px solid black;
	text-align: center;
}

.listArea>tbody>tr:hover {
	background: darkgrey;
	cursor: pointer
}
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp"%>
	<div class="outer">
		<br>
		<div class="mb-3">
			<select name="category" id="boardCategory">
				<c:forEach items="${category}" var="c">
					<option value="${c.categoryNo}" <c:if test="${categoryNo eq c.categoryNo}">selected</c:if>>${c.categoryName}</option>
				</c:forEach>
			</select>
		</div>
		<h2 align="center">문의 게시판</h2>
		<%-- <c:out value="<p>${sessionScope.contextPath}</p>" escapeXml="false"><br></c:out>
		<c:out value="<p>${sessionScope.loginUser}</p>" escapeXml="false"><br></c:out>
		<c:out value="<p>${sessionScope.msg}</p>" escapeXml="false"><br></c:out>--%>
		<br>
		<table class="listArea" align="center">
			<thead>
				<tr>
					<th width="100">글번호</th>
					<th width="150">카테고리</th>
					<th width="300">글제목</th>
					<th width="100">작성자</th>
					<th width="100">조회수</th>
					<th width="150">작성일</th>
					<th width="150">답변상태</th>
				</tr>
			<thead>
			<tbody id="tbody">
				<c:choose>
					<c:when test="${empty list}">
						<tr>
							<td colspan="7">해당 카테고리에 등록된 글이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="q" items="${list}">
							<tr>
								<td>${q.qnaNo}</td>
								<td>${q.category}</td>
								<td>${q.qnaTitle}</td>
								<td>${q.qnaWriter}</td>
								<td>${q.count}</td>
								<td>${q.createDate}</td>
								<c:choose>
									<c:when test="${q.qnaReply != null}">
										<td>답변 완료</td>
									</c:when>
									<c:otherwise>
										<td>답변 대기중</td>
									</c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>

		<br> <br>

		<!-- 페이징바 만들기 -->
		<div class="pagingArea" align="center">
			<!-- 맨 처음으로 (<<) -->
			<button
				onclick="location.href='${contextPath}/qnaCategoryList.do?currentPage=1&category=${categoryNo}'">
				&lt;&lt;</button>

			<!-- 이전페이지로(<) -->
			<c:choose>
				<c:when test="${currentPage eq 1}">
					<button disabled>&lt;</button>
				</c:when>
				<c:otherwise>
					<button
						onclick="location.href='${contextPath}/qnaCategoryList.do?currentPage=${currentPage - 1}&category=${categoryNo}'">
						&lt;</button>
				</c:otherwise>
			</c:choose>
			<!-- 페이지 목록 -->
			<c:forEach var="p" begin="${startPage}" end="${endPage}" step="1">
				<c:choose>
					<c:when test="${p eq currentPage}">
						<button disabled>${p}</button>
					</c:when>
					<c:otherwise>
						<button
							onclick="location.href='${contextPath}/qnaCategoryList.do?currentPage=${p}&category=${categoryNo}'">
							${p}</button>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<!-- 다음페이지로(>) -->
			<c:choose>
				<c:when test="${currentPage eq maxPage}">
					<button disabled>&gt;</button>
				</c:when>
				<c:otherwise>
					<button
						onclick="location.href='${contextPath}/qnaCategoryList.do?currentPage=${currentPage + 1}&category=${categoryNo}'">
						&gt;</button>
				</c:otherwise>
			</c:choose>

			<!-- 맨 끝으로 (>>) -->
			<button
				onclick="location.href='${contextPath}/qnaCategoryList.do?currentPage=${maxPage}&category=${categoryNo}'">
				&gt;&gt;</button>
		</div>
		<br> <br>
		<div align="center">
			<input type="text" id="search3"><button type="button" onclick="searchQnaList();">검색</button>
		</div>
		
		<br> <br>
		<div align="center">
			<c:if test="${loginUser != null}">
				<button onclick="location.href='enrollFormQna.do'">작성하기</button>
			</c:if>
		</div>
	</div>


</body>
<script type="text/javascript">
	if(!${empty list}){
		$(function(){
			$("#tbody>tr").click(function(){
				var qno = $(this).children().eq(0).text();
				location.href = "${contextPath}/detailQna.do?qno="+qno;
			})
		})
	}
	function searchQnaList(){
		var keyword3 = $('#search3').val();
		console.log(keyword3)
		location.href = "${contextPath}/searchQna.do?keyword="+keyword3;
	}
	
	$(function(){
		$("#boardCategory").change(function(){
		 	var selected = $("option:selected").val();
		 	location.href = "${contextPath}/qnaCategoryList.do?category="+selected;
		})
	})
	
</script>
</html>