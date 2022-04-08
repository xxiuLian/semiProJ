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
				<option value="000">카테고리 선택</option>
				<option value="10">공통</option>
				<option value="20">회원</option>
				<option value="30">주문/결제</option>
				<option value="40">배송</option>
				<option value="50">취소/반품/교환</option>
				<option value="60">이벤트</option>
				<option value="70">기타</option>
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
					<th width="100">카테고리</th>
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
							<td colspan="6">조회된 리스트가 없습니다.</td>
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
				onclick="location.href='${contextPath}/qnaList.do?currentPage=1'">
				&lt;&lt;</button>

			<!-- 이전페이지로(<) -->
			<c:choose>
				<c:when test="${currentPage eq 1}">
					<button disabled>&lt;</button>
				</c:when>
				<c:otherwise>
					<button
						onclick="location.href='${contextPath}/qnaList.do?currentPage=${currentPage - 1}'">
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
							onclick="location.href='${contextPath}/qnaList.do?currentPage=${p}'">
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
						onclick="location.href='${contextPath}/qnaList.do?currentPage=${currentPage + 1}'">
						&gt;</button>
				</c:otherwise>
			</c:choose>

			<!-- 맨 끝으로 (>>) -->
			<button
				onclick="location.href='${contextPath}/qnaList.do?currentPage=${maxPage}'">
				&gt;&gt;</button>
		</div>
		<br> <br>

		<div align="center">

			<c:if test="${loginUser != null}">
				<button onclick="location.href='enrollFormQna.do'">작성하기</button>
			</c:if>

		</div>

	</div>
	<script>
	if(!${empty list}){
		$(function(){
			$(".listArea>tbody>tr").click(function(){
				var qno = $(this).children().eq(0).text();
				location.href = "${contextPath}/detailQna.do?qno="+qno;
			})
		})
	}
</script>

</body>
<script type="text/javascript">
$(function(){
	$("#boardCategory").change(function(){
	 	var selected = $("option:selected").val();
	 	$.ajax({
			url : "qnaList.do",
			data:{
				category:selected
			},
			type:"get",
			
			success:function(list){
				
			 	console.log(list)
			 	
			 	var table = $("#tbody");
				table.html("");
					
					if(list.length == 0){
						table.html("<tr><td>조회된 리스트가 없습니다.</td></tr>")
						table.children("tr").children("td").attr("colspan","7")
					}else {
						for(var i = 0; i < list.length; i++){
							if(selected == list[i].category){
								table.append("<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td>")
								table.children("tr").eq(i).children("td").eq(0).text(list[i].qnaNo)
								table.children("tr").eq(i).children("td").eq(1).text(list[i].category)
								table.children("tr").eq(i).children("td").eq(2).text(list[i].qnaTitle)
								table.children("tr").eq(i).children("td").eq(3).text(list[i].qnaWriter)
								table.children("tr").eq(i).children("td").eq(4).text(list[i].count)
								table.children("tr").eq(i).children("td").eq(5).text(list[i].createDate)
								if(list[i].qnaReply != null){
									table.children("tr").eq(i).children("td").eq(6).text('답변 완료')
								}else{
									table.children("tr").eq(i).children("td").eq(6).text('답변 대기중')
								}
							}
							
						}
					}
				
			},
			error:function(e){
				console.log("Ajax통신실패")
			}
		})
	})
})
</script>
</html>