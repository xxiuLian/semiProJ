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
	.outer{
		width:1000px;
		height:500px;
		background:#fff;
		color:black;
		margin:auto;
		margin-top:50px;
	}
	.listArea{
		border:1px solid white;
		text-align:center;
	}
	.searchArea{
		margin-top:50px;
	}
	
	/* .listArea>tbody>tr:hover{
		background:lightgrey;
		cursor:pointer
	} */
	
	.pagingArea{
		margin-top:15px;
	}
	.pagingicon{
		border: 1px solid lightgray;
		border-radius: 5px;
	}
	#writeadmin, #searchbtn{
		border: 1px solid black;
		
	}
	#writeadmin:hover{
		background-color:#eee;
	}
	#searchbtn:hover{
		background-color:#eee;
	}
	.qnaCategory{
		float: left;
	}
	.btnsArea{
	   width: 100%;
	   height: 80px;
	   justify-content: center;
	   display: flex;
	   align-items: center;
	   
   }
   #search2{
   		padding-top: 10px;
   		width: 200px; 
   		height: 40px;
   		border-radius:5px;
   		border: 0.2px solid rgb(150, 150, 150);
   }
   
    #searchbtn{
	background:rgb(216, 216, 216); 
	color:rgb(85, 85, 85); 
	font-size:20px; 
	width: 70px; 
	height: 40px;
	border-radius:5px;
	border: 0.2px solid rgb(216, 216, 216);
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 700;
	font-size: 25px;
   }
   #enrollBtn{
	   background:rgb(11, 100, 159); 
	   color:white; font-size:20px; 
	   width: 140px; 
		height: 50px;
	   border-radius:5px;
	   border: 0.2px solid rgb(216, 216, 216);
	   font-family: 'Noto Sans KR', sans-serif;
	   font-weight: 700;
	   font-size: 20px;
	}
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp"%>
	<div class="outer">
		<br>
		<h2 align="center">문의 게시판</h2>
		<div class="qnaCategory">
			<select name="category" id="boardCategory">
				<option value="non">카테고리 선택</option>
				<c:forEach items="${category}" var="c">
					<option value="${c.categoryNo}">${c.categoryName}</option>
				</c:forEach>
			</select>
		</div>
		<br>
		<table class="listArea table table-hover" align="center">
			<thead>
				<tr>
					<th width="100">글번호</th>
					<th width="200">카테고리</th>
					<th width="250">글제목</th>
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
							<td colspan="7">${keyword}로 검색된 리스트가 없습니다.</td>
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
		<br>
		<c:if test="${loginUser != null}">
			<div class="btnsArea" align="center">
					<button id="enrollBtn" onclick="location.href='enrollFormQna.do'">작성하기</button>
			</div>
		</c:if>
		<div class="searchArea" align="center">
			<input type="text" id="search2"><button type="button" id="searchbtn" onclick="searchQnaList();">검색</button>
		</div>
		
		<br> <br>
		<!-- 페이징바 만들기 -->
		<div class="pagingArea" align="center">
			<!-- 맨 처음으로 (<<) -->
			<button class="pagingicon"
				onclick="location.href='${contextPath}/searchQna.do?currentPage=1&keyword=${keyword}'">
				&lt;&lt;</button>

			<!-- 이전페이지로(<) -->
			<c:choose>
				<c:when test="${currentPage eq 1}">
					<button class="pagingicon" disabled>&lt;</button>
				</c:when>
				<c:otherwise>
					<button class="pagingicon"
						onclick="location.href='${contextPath}/searchQna.do?currentPage=${currentPage - 1}&keyword=${keyword}'">
						&lt;</button>
				</c:otherwise>
			</c:choose>
			<!-- 페이지 목록 -->
			<c:forEach var="p" begin="${startPage}" end="${endPage}" step="1">
				<c:choose>
					<c:when test="${p eq currentPage}">
						<button class="pagingicon" disabled>${p}</button>
					</c:when>
					<c:otherwise>
						<button class="pagingicon"
							onclick="location.href='${contextPath}/searchQna.do?currentPage=${p}&keyword=${keyword}'">
							${p}</button>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<!-- 다음페이지로(>) -->
			<c:choose>
				<c:when test="${currentPage eq maxPage}">
					<button class="pagingicon" disabled>&gt;</button>
				</c:when>
				<c:otherwise>
					<button class="pagingicon"
						onclick="location.href='${contextPath}/searchQna.do?currentPage=${currentPage + 1}&keyword=${keyword}'">
						&gt;</button>
				</c:otherwise>
			</c:choose>

			<!-- 맨 끝으로 (>>) -->
			<button class="pagingicon"
				onclick="location.href='${contextPath}/searchQna.do?currentPage=${maxPage}&keyword=${keyword}'">
				&gt;&gt;</button>
		</div>
		<br><br>
		
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
		var keyword2 = $('#search2').val();
		location.href = "${contextPath}/searchQna.do?keyword="+keyword2;
	}
	
	$(function(){
		$("#boardCategory").change(function(){
		 	var selected = $("option:selected").val();
		 	if(selected == 'non'){
				return;
			}
		 	location.href = "${contextPath}/qnaCategoryList.do?category="+selected;
		})
	})
</script>
</html>