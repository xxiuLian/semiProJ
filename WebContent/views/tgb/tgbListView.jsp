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
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../../css/styles.css" rel="stylesheet" />
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>

.listArea{
	
	display:flex;
}
.list{
	/*width:300px;*/
	height:auto;
	display: inline-block;
	margin:20px;
}

</style>
<body>
<%@ include file="../common/menubar.jsp" %>

<h2 align="center">공구 목록 조회</h2>
<br>

<div class="listArea" align="center">
	<div class ="container" >
			<%if(list.isEmpty()){ %>
			<h2>조회된 리스트가 없습니다.</h2>
			<%}else{ %>
				<% for( Tgb t : list){ %>
				<div class="list col-lg-3 col-md-4 col-sm-6" align = "center">
					<input type="hidden" value="<%=t.getTgbNo() %>">
					<img src="<%=contextPath %>/assets/img_upfile/<%=t.getThumnail()%>" width="300px" height="200px"><br>
					<p>제목 : <%=t.getTgbTitle() %></p>
					<p><%=t.getTgb_Price() %>원</p>
					
				 <%if(t.getTgbTerm() != null){ %><!-- Date라 조정필요 -->
					<p><%=t.getTgbTerm() %>일까지</p>
					<%}%>
					
	
				</div>
				<%} %>
		<%} %>
	</div>	
</div>
<script>
	$(function(){
		$('.list').click(function(){
			var bno = $(this).children().eq(0).val();
			//alert("[지우기]글번호:"+bno);
			location.href="<%=contextPath%>/detailTgb.do?bno="+bno ;
			});
	});
</script>

<br><br>
<!-- 페이징바 -->
<div class="paging" align="center">
	<button onclick="location.href='<%=contextPath%>/tgbList.do?currentPage=1'">&lt;&lt;</button>

<!-- 이전페이지로 -->
	<%if(currentPage == 1) {%>
	<button disabled>&lt;</button>
	<%}else{ %>
	
		<button onclick="location.href='<%=contextPath %>/tgbList.do?currentPage=<%=currentPage-1 %>'">&lt;</button>
	
	<%} %>
	
	<!-- 페이지 목록 -->
	<%for(int i = startPage; i<=endPage; i++){ %>
		<%if(i ==currentPage){ %>
		<button disabled><%= i %></button>
		<%}else{ %>
		<button onclick="location.href='<%=contextPath%>/tgbList.do?currentPage=<%=i%>'"><%=i %></button>
		<%} %>
	<%} %>
	
	<!-- 다음페이지로 -->
	<%if(currentPage == maxPage) {%>
	<button disabled>&gt;</button>
	<%}else{ %>
	
	<button onclick="location.href='<%= contextPath %>/tgbList.do?currentPage=<%= currentPage+1 %>'"> &gt; </button>
	
	<%} %>
	
	<button onclick="location.href='<%=contextPath%>/tgbList.do?currentPage=<%=maxPage%>'"> &gt;&gt; </button>

</div>
</body>
</html>