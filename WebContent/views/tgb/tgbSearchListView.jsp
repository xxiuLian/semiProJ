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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
</head>

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
h2{
	border-bottom: 1px solid rgb(201, 200, 200) ;
	width: fit-content;
	padding-bottom: 10px;
}
.list p{
	font-family: 'Noto Sans KR', sans-serif;
	
	font-size: 20px;
	margin: 0px;
	
}
.proTitle{
	font-size: 23px;
	font-weight: 700;
}
.proPrice{
	font-weight: bold;
	color: rgb(44, 44, 160);
}
.proTerm{
	font-size: 13px;
	color: rgb(136, 136, 136);
	font-weight: 300;
}
.paging button{
	border: 0.2px solid rgb(255, 255, 255);
	background-color: rgb(223, 223, 223);
	border-radius: 7px;
	color: rgb(75, 75, 75);
	font-weight: bold;
}
.listcount{
	font-family: 'Noto Sans KR', sans-serif;
	color: rgb(176, 176, 177);
}

</style>
<body>
<%@ include file="../common/menubar.jsp" %>
<div class="container">
<h2>"${keyword}" 검색결과</h2>
<p class="listcount"> 총 ${listCount}개</p>
		<br>
		
		<div class="listArea" align="center">
			<div class ="container" >
			<%if(list.isEmpty()){ %>
			<h2>"${keyword}"로 검색된 결과가 없습니다.</h2>
			<%}else{ %>
				<% for( Tgb t : list){ %>
				<div class="list col-lg-3 col-md-4 col-sm-6" align = "center">
					<input type="hidden" value="<%=t.getTgbNo() %>">
					<img src="<%=contextPath %>/assets/img_upfile/<%=t.getThumnail()%>" width="300px" height="200px"><br>
					<p class="proTitle"><%=t.getTgbTitle() %></p>
					<p class="proPrice"><%=t.getPrice() %> 원</p>
					
				 <%if(t.getTgbTerm() != null){ %><!-- Date라 조정필요 -->
					<p class="proTerm"><%=t.getTgbTerm() %>일까지</p>
					<%}%>
					
	
				</div>
				<%} %>
		<%} %>
	</div>	
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
		
			<button onclick="location.href='<%=contextPath %>/searchTgb.do?currentPage=<%=currentPage-1 %>&keyword=<%=keyword%>'">&lt;</button>
		
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
		
			<button onclick="location.href='<%= contextPath %>/searchTgb.do?currentPage=<%= currentPage+1 %>&keyword=<%=keyword%>'"> &gt; </button>
		
		<%} %>
		
		<button onclick="location.href='<%=contextPath%>/searchTgb.do?currentPage=<%=maxPage%>&keyword=<%=keyword%>'"> &gt;&gt; </button>
		
		</div>
</div>
</body>
</html>