<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.uni.tgb.model.dto.*, com.uni.common.*, com.uni.admin.dto.*"%>
<%
	ArrayList<Tgb> list = (ArrayList<Tgb>)request.getAttribute("list");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	ArrayList<Category> ctg = (ArrayList<Category>)request.getAttribute("catelist");
	
	int listCount = pi.getListCount();
	int currentPage = pi.getCurrentPage();
	int maxPage = pi.getMaxPage();
	int startPage = pi.getStartPage();
	int endPage = pi.getEndPage();
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<style>
.outer {
	width: 800px;
	height: 500px;
	background: black;
	color: white;
	margin: auto;
	margin-top: 50px;
}

.listArea {
	border: 1px solid white;
	text-align: center;
}

.searchArea {
	margin-top: 50px;
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
		<h2 align="center">찜목록 내역</h2>
		<br>

		<table class="listArea" align="center">
			<thead>
				<tr>
					<th></th><!-- 체크 -->
					<th width="300"></th>
					<th width="100">작성자</th>
					<th>조회수</th>
					<th width="100">작성일</th>
				</tr>
			</thead>
			<tbody>
				
				<% if(list.isEmpty()){ %>
				<tr>
					<td colspan="5">존재하는 공지사항이 없습니다.</td>
				</tr>
				<% }else{  %>
				<% for(Tgb t : list){ %>
				<tr>
					<td><%= t.getNoticeNo() %></td>
					<td><%= t.getNoticeTitle() %></td>
					<td><%= t.getNoticeWriter() %></td>
					<td><%= t.getCount() %></td>
					<td><%= t.getCreateDate() %></td>
				</tr>
				<% } %>
				<% } %>
			</tbody>

		</table>
		<form class="searchArea" align="center">
			<select id="condition" name="condition">
				<option value="writer">작성자</option>
				<option value="title">제목</option>
				<option value="content">내용</option>
			</select> <input type="search" name="search">
			<button type="submit">검색하기</button>
		</form>
		<br>
		<br>
		<div align="center">
			<% if(loginUser != null && loginUser.getUserId().equals("admin")) { %>

			<button
				onclick="location.href='<%=contextPath%>/enrollFormNotice.do'">작성하기</button>
			<% } %>
		</div>

	</div>
	<script type="text/javascript">
	
	<% if(!list.isEmpty()){%>
	$(function(){
		$(".listArea>tbody>tr").click(function(){
			var nno = $(this).children().eq(0).text();//한 행을 클릭하면 그 행의 첫번째 열의 text를 반환
			
			location.href = "<%=contextPath%>/detailNotice.do?nno="+nno;
			//menubar에서 contextPath를 아예 선언해서 쓰고 있다
		})
	})
	
	
	<%}%>
	
	</script>
	<!-- 페이징바 -->
		<div class="paging" align="center">
		
		
		<!-- 페이지 목록 -->
		<%for(int i = startPage; i<=endPage; i++){ %>
			<%if(i ==currentPage){ %>
			<button disabled><%= i %></button>
			<%}else{ %>
				<button onclick="location.href='<%=contextPath%>/tgbList.do?currentPage='<%=i%>"><%=i %></button>
			<%} %>
		<%} %>
		
		
		</div>
	


</body>
</html>