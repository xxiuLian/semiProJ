<%@page import="java.util.ListIterator"%>
<%@page import="com.uni.tgb_board.model.dto.TgbBoard_pageInfo"%>
<%@page import="com.uni.tgb_board.model.dto.TgbBoard_dto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<% String contextPath = request.getContextPath(); %>
<%
	ArrayList<TgbBoard_dto> list = (ArrayList<TgbBoard_dto>)request.getAttribute("list");
	TgbBoard_pageInfo pi = (TgbBoard_pageInfo)request.getAttribute("pi");

	int listCount = pi.getListCount();
	int currentPage = pi.getCurrentPage();
	int barStart = pi.getBarStart();
	int barEnd = pi.getBarEnd();
	int barCount = pi.getBarCount();
	int listPageCount = pi.getListPageCount();
	int barMax = pi.getBarMax();
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
.tgbBoardArea{
		border:1px solid white;
		text-align:center;
	}
.tgbBoardArea>tbody>tr:hover{
	background:darkgrey;
	cursor:pointer
}
</style>
</head>
<body>

<!-- 
	listCount : <%= listCount %> <br>
	currentPage : <%= currentPage %> <br>
	barStart :  <%= barStart %> <br>
	barEnd :  <%= barEnd %> <br>
	barCount : <%= barCount %> <br>
	listPageCount : <%= listPageCount %> <br>
	barMax : <%= barMax %> <br>
  -->

	<!-- 1.목록 -->
	<table class="tgbBoardArea">
		<thead>
			<tr>
				<td>번호</td>
				<td>카테고리</td>
				<td>작성자</td>
				<td>제목</td>
				<td>내용</td>
				<td>조회수</td>
				<td>작성일</td>
				<td>상태값</td>
			</tr>
		</thead>
		<tbody>
			<%if(list.isEmpty()){ %>
			<tr>
				<td>조회된 리스트가 없습니다.</td>
			</tr>
			<%}else{ %>
			
				<% for(TgbBoard_dto b : list){ %>
				<tr>
					<td><%= b.getTgbBoardNo() %></td>
					<td><%= b.getTgbBoardCategory() %></td>
					<td><%= b.getTgbBoardWriter() %></td>
					<td><%= b.getTgbBoardTitle() %></td>
					<td><%= b.getTgbBoardContent() %></td>
					<td><%= b.getTgbBoardCount() %></td>
					<td><%= b.getTgbBoardDate() %></td>
					<td><%= b.getTgbBoardStatus() %></td>
				</tr>
				<%} %>
			<%} %>
		</tbody>
	</table>
	
	<br><br>
	
	<!-- 2.페이징바 -->
	<div class="pagingArea" align="center">
		<button onclick="location.href='<%=contextPath%>/tgbBoardSelect.do?currentPage=<%= 1 %>'"> &lt;&lt; </button>
		<button onclick="location.href='<%=contextPath%>/tgbBoardSelect.do?currentPage=<%= currentPage-1 %>'">&lt;</button>
	
		<!-- 페이징바 이동 -->
		<% for(int i = barStart; i <= barEnd; i++){ %>
			<button onclick="location.href='<%=contextPath %>/tgbBoardSelect.do?currentPage=<%= i %>'"><%= i %></button>
		<% } %>

		<button onclick="location.href='<%=contextPath%>/tgbBoardSelect.do?currentPage=<%= currentPage+1 %>'">&gt;</button>
	</div>
	<div>
		<button onclick="location.href='EnrollTgbBoard.do'">작성하기</button>
	</div>
	<script>
	<%if(!list.isEmpty()){%>
		$(function(){
			$(".tgbBoardArea>tbody>tr").click(function(){
				var bno = $(this).children().eq(0).text();
				location.href = "<%=contextPath%>/tgbBoardDetail.do?bno="+bno;
			})
		})
	<%}%>
	</script>
</body>
</html>