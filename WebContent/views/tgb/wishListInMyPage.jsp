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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="listCount" value="${pi.listCount}" scope="request"/>
<c:set var="currentPage" value="${pi.currentPage}" scope="request"/>
<c:set var="maxPage" value="${pi.maxPage}" scope="request"/>
<c:set var="startPage" value="${pi.startPage}" scope="request"/>
<c:set var="endPage" value="${pi.endPage}" scope="request"/>


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
td>img{
	width:300px;
	height:150px;
	
}
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp"%>

	<div class="outer">
		<br>
		<h2 align="center">찜목록 내역</h2>
		<br>

		<div>
			<select name="tgbCategory" id="tgbCategory">
				<option value="000">카테고리 선택</option>
				<c:forEach items="${catelist}" var="category" varStatus="st">
					<option value="${category.categoryNo}"><c:out value="${category.categoryName}"/></option>
				</c:forEach>
			</select>
		</div>


		<table class="listArea" align="center">
			<thead>
				<tr>
					<th></th><!-- 체크 -->
					<th>글번호</th>
					<th width="300">썸네일</th>
					<th width="100">글제목</th>
					<th width="100">공구 가격</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty list}">
						<tr>
							<td colspan="5">찜한 내역이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${list}" var="list" varStatus="st">
							<tr>
								<td><input type="checkbox"></td>
								<td>${list.tgbNo}</td>
								<td><img src="<%=contextPath%>/assets/img_upfile/${list.thumnail}"></td>
								<td>${list.tgbTitle }</td>
								<td>${list.tgb_Price }</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>

		</table>
		<button type="button" id="delete">선택 목록 삭제하기</button>
		<br>
		<br>
		

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
				var td = '<tr><td><input type="checkbox"></td>';
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
					var td = '<tr><td><input type="checkbox"></td>';
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
	
	
	$('#delete').click(function(){
		var checked = $('td').children('input[type=checkbox]:checked').val();
		console.log(checked);
		
		
	})
	
	</script>
	<!-- 페이징바 -->
		<div class="paging" align="center">
		
			<c:forEach var="p" begin="${startPage}" end="${endPage }" step="1">
				<c:choose>
					<c:when test="${p eq currentPage}">
						<button disabled>${p}</button>
					</c:when>
					<c:otherwise>
						<button onclick="location.href='<%=contextPath%>/qnaList.do?currentPage=${p}'">${p}</button>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		
		</div>
	


</body>
</html>