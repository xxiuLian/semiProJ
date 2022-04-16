<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.ArrayList, com.uni.tgb.model.dto.*, com.uni.common.*, com.uni.admin.model.dto.*"%>
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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="listCount" value="${pi.listCount}" scope="request" />
<c:set var="currentPage" value="${pi.currentPage}" scope="request" />
<c:set var="maxPage" value="${pi.maxPage}" scope="request" />
<c:set var="startPage" value="${pi.startPage}" scope="request" />
<c:set var="endPage" value="${pi.endPage}" scope="request" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700"
	rel="stylesheet" type="text/css" />
</head>
<body>
<style>
.outer {
	width: 1000px;
	margin: auto;
}

.searchArea {
	margin-top: 50px;
}


td>img {
	width: 300px;
	height: 150px;
}

#dib{
	margin-top:-5px;
	width:30px;
	height: 30px;
}

.listArea tr {
	font-family: "Montserrat", -apple-system, BlinkMacSystemFont, "Segoe UI",
		Roboto, "Helvetica Neue", Arial, sans-serif, "Apple Color Emoji",
		"Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
	font-size: 20px;
	color: #495057;
	letter-spacing: 0.0625em;
}

.listArea td {
	font-family: "Montserrat", -apple-system, BlinkMacSystemFont, "Segoe UI",
		Roboto, "Helvetica Neue", Arial, sans-serif, "Apple Color Emoji",
		"Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
	font-size: 20px;
	color: #495057;
	letter-spacing: 0.0625em;
	vertical-align: middle;
}
#delete {
	border: 1px solid lightgray;
	border-radius: 5px;
}
#delete {
	background-color: #c2c3c4;
	border-radius: 7px;
	border: 1px solid rgb(255, 255, 255);
	color: white;
	font-weight: bold;
	margin-top: 30px;
	width: 120px;
	height: 40px;
}
#delete:hover{
	background-color: #929292;
}
.pagingArea>button {
	border: 1px solid lightgray;
	border-radius: 5px;
}
</style>
<link href="css/myPageStyles.css" rel="stylesheet" />
</head>
<body>
	<%@ include file="../common/menubar.jsp"%>
	
	<div class="container">
		<div class="d-flex" id="wrapper"> 
			<!-- Sidebar-->
			<div class="border-end bg-white" id="sidebar-wrapper">
				<div class="sidebar-heading border-bottom bg-light">
					<a href="<%=contextPath%>/myPage.do">HOME</a>
				</div>
				<div class="list-group list-group-flush">
					<a
						class="list-group-item list-group-item-action list-group-item-light p-3"
						href="myInfo.do" id="myInfo">내 정보</a>
					<div>
						<a id="myList"
							class="list-group-item list-group-item-action list-group-item-light p-3"
							href="myList.do">공동구매 내역 조회</a>
						<ul>
							<li><a class="nav-link" href="myList.do">나의 진행 상품</a></li>
							<li><a class="nav-link" href="myPayList.do">나의 참여 상품</a></li>
							<li><a class="nav-link" href="myFinishList.do">이전 상품</a></li>
						</ul>
					</div>
					<a
						class="list-group-item list-group-item-action list-group-item-light p-3"
						href="wishList.do">찜내역관리</a> <a
						class="list-group-item list-group-item-action list-group-item-light p-3"
						href="checkQnaList.do">문의내역조회</a> <a
						class="list-group-item list-group-item-action list-group-item-light p-3"
						href="checkBoardTGBList.do">공동구매게시판조회</a>
				</div>
			</div>
			<!-- Sidebar End -->
<!-- Page content wrapper-->
			
			<div id="page-content-wrapper">
				<!-- Top navigation-->
	
			<div class="outer styleCheck">
				<br>
				<h2 align="center">${loginUser.getUserName()} 님의 찜 <img id="dib" src="<%=contextPath%>/assets/TgbAssets/dib.jpg"></h2>
				<br>

				<div>
					<select name="tgbCategory" id="tgbCategory">
						<option value="000">카테고리 선택</option>
						<c:forEach items="${catelist}" var="category" varStatus="st">
							<option value="${category.categoryNo}"><c:out
									value="${category.categoryName}" /></option>
						</c:forEach>
					</select>
				</div>

				<form action="<%= contextPath %>/wishListDelete.do" method="post"
					id="frm">
					<table class="listArea table table-hover" align="center">
						<thead>
							<tr>
								<th></th>
								<!-- 체크 -->
								<th width="100">번호</th>
								<th width="100"></th>
								<th width="300">제목</th>
								<th width="150">가격</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty list}">
									<tr>
										<td colspan="5" align="center">찜 내역이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${list}" var="list" varStatus="st">
										<tr class="list">
											<td><input type="checkbox" name="ch"
												value="${list.tgbNo}"></td>
											<td>${list.tgbNo}</td>
											<td><img
												src="<%=contextPath%>/assets/img_upfile/${list.thumnail}"></td>
											<td>${list.tgbTitle }</td>
											<td>${list.tgb_Price }</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>

					</table>
					<button type="submit" id="delete">선택 삭제</button>
				</form>
				<br> <br>
			</div>
		</div>

	</div>
	<script type="text/javascript">
	$(function(){
		$('#tgbCategory').change(function(){
			var selected = $('option:selected').val();
			console.log(selected)
			
			if(selected === '000'){
				$('.listArea').children('tbody').empty();
				<%if(list.isEmpty()){%>
				$('.listArea').children('tbody').html('<tr><td colspan="5">찜한 내역이 없습니다.</td></tr>');
				
				<%}else{%>
				<%for(Tgb t : list){%>
				var imgsrc = "<%=t.getThumnail()%>";
				var td = '<tr><td><input type="checkbox" name="ch" vlaue = "<%=t.getTgbNo()%>"></td>';
				td += '<td>'+<%=t.getTgbNo()%>+'</td>';
				td += '<td><img src='+"<%=contextPath%>"+'/assets/img_upfile/'+imgsrc+'>';
				td +='<td>'+"<%=t.getTgbTitle()%>"+'</td>';
				td+='<td>'+<%=t.getTgb_Price()%>+'</td></tr>';
					
				$('.listArea').children('tbody').append(td);
										
			
					
				<%}%>
					
				
				
				<%}%>
				
				
			}else{
				$('.listArea').children('tbody').empty();
				$('.listArea').children('tbody').empty();
				<%if(list.isEmpty()){%>
				$('.listArea').children('tbody').html('<tr><td colspan="5">찜한 내역이 없습니다.</td></tr>');
				
				<%}else{%>
				<%for(Tgb t : list){%>
				
				if(selected === "<%=t.getTgbCategory()%>"){
					var imgsrc = "<%=t.getThumnail()%>";
					var td = '<tr><td><input type="checkbox" name="ch" vlaue = "<%=t.getTgbNo()%>"></td>';
					td += '<td>'+<%=t.getTgbNo()%>+'</td>';
					td += '<td><img src='+"<%=contextPath%>"+'/assets/img_upfile/'+imgsrc+'>';
					td +='<td>'+"<%=t.getTgbTitle()%>"+'</td>';
					td+='<td>'+<%=t.getTgb_Price()%>+'</td></tr>';
						
					$('.listArea').children('tbody').append(td);
										
				}
				<%}%>
				
				<%}%>
		
			}
			

		})
		
	})
	
	$(function(){
				$('.list').click(function(){
					var bno = $(this).children().eq(1).text();
					alert("[지우기]글번호:"+bno);
					location.href="<%=contextPath%>
		/detailTgb.do?bno=" + bno;
			});
		});
	</script>
	<!-- 페이징바 -->
	<div class="paging" align="center">

		<c:forEach var="p" begin="${startPage}" end="${endPage }" step="1">
			<c:choose>
				<c:when test="${p eq currentPage}">
					<button disabled>${p}</button>
				</c:when>
				<c:otherwise>
					<button
						onclick="location.href='<%=contextPath%>/qnaList.do?currentPage=${p}'">${p}</button>
				</c:otherwise>
			</c:choose>
		</c:forEach>

	</div>

</div>

</body>
</html>