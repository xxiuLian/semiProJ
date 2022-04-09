<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.uni.tgb.model.dto.*, com.uni.common.*"%>
<%
	ArrayList<Tgb> list = (ArrayList<Tgb>)request.getAttribute("list");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	
	int listCount = pi.getListCount();
	int currentPage = pi.getCurrentPage();
	int maxPage = pi.getMaxPage();
	int startPage = pi.getStartPage();
	int endPage = pi.getEndPage();
	
	String keyword = (String)request.getAttribute("keyword");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../../css/styles.css" rel="stylesheet" />
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>

.listArea{

	display:flex;
}
.list{
	width:300px;
	height:auto;
	display: inline-block;
	margin:20px;
}

</style>
<body>
<%@ include file="../common/menubar.jsp" %>

<h2 align="center">공구 검색결과</h2>
		<br>
		
		<div class="listArea" align="center">
			
				<%if(list.isEmpty()){ %>
				
					<h2 >"<%=keyword%>"로 검색된 리스트가 없습니다.</h2>
				
				<%}else{ %>
					<% for( Tgb t : list){ %>
					
					<div class="list" align = "center">
						<input type="hidden" value="<%=t.getTgbNo() %>">
						<img src="<%=contextPath %>/assets/img_upfile/<%=t.getThumnail()%>" width="300px" height="200px"><br>
						<p>제목 : <%=t.getTgbTitle() %></p>
						<p><%=t.getTgb_Price() %>원</p>
						<%if(t.getCount() != 00){ %>
						<p><%=t.getCount() %>명(진행도로 표시)</p>
						<%}else{ %>
						<p>무제한(진행도로 표시)</p>
						<%} %>
					 <%if(t.getTgbTerm() != null){ %><!-- Date라 조정필요 -->
						<p><%=t.getTgbTerm() %>일(진행도로 표시)</p>
						<%}else{ %>
						<p>무제한(진행도로 표시)</p>
						<%} %>	

					</div>
					<%} %><!-- for문 끝 -->
				<%} %>
		
		</div>
		<script>
			$(function(){
				$('.list').click(function(){
					var bno = $('.list').children().eq(0).val();
					alert("[지우기]글번호:"+bno);
					location.href="<%=contextPath%>/detailTgb.do?bno="+bno ;
 				});
			});
		</script>

		<br><br>
		<!-- 페이징바 -->
		<div class="paging" align="center">
			<button onclick="location.href='<%=contextPath%>/searchTgb.do?currentPage=1&keyword=<%=keyword%>'">&lt;&lt;</button>
		
		<!-- 이전페이지로 -->
		<%if(currentPage == 1) {%>
		<button disabled>&lt;</button>
		<%}else{ %>
		<div>
			<button onclick="location.href='<%=contextPath %>/searchTgb.do?currentPage=<%=currentPage-1 %>&keyword=<%=keyword%>'">&lt;</button>
		</div>
		<%} %>
		
		<!-- 페이지 목록 -->
		<%for(int i = startPage; i<=endPage; i++){ %>
			<%if(i ==currentPage){ %>
			<button disabled><%= i %></button>
			<%}else{ %>
				<button onclick="location.href='<%=contextPath%>/searchTgb.do?currentPage=<%=i%>&keyword=<%=keyword%>'"><%=i %></button>
			<%} %>
		<%} %>
		
		<!-- 다음페이지로 -->
		<%if(currentPage == maxPage) {%>
		<button disabled>&gt;</button>
		<%}else{ %>
		<div>
			<button onclick="location.href='<%= contextPath %>/searchTgb.do?currentPage=<%= currentPage+1 %>&keyword=<%=keyword%>'"> &gt; </button>
		</div>
		<%} %>
		
		<button onclick="location.href='<%=contextPath%>/searchTgb.do?currentPage=<%=maxPage%>&keyword=<%=keyword%>'"> &gt;&gt; </button>
		
		</div>
</body>
</html>