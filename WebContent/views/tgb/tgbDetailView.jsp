<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.uni.tgb.model.dto.*, java.util.ArrayList, com.uni.common.Attachment"%>
 <%
 	Tgb t = (Tgb)request.getAttribute("t");
 	ArrayList<Attachment> alist = (ArrayList<Attachment>)request.getAttribute("aList");
 
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.outer{
		width:1000px;
		height:800px;
		background:black;
		color:white;
		margin:auto;
		margin-top:50px;
	}
	#contentArea{
		height:50px;
	}
	
	.detail td{
		text-align:center;
		border:1px solid white;
	}
	.detailImgArea{
		width:220px;
		height:190px;
	}
</style>
</head>
<body>
<div class="outer">
	
		<br>
		<h2 align="center">사진게시판 상세보기</h2>
		<br>
		
		<table class="detail" align="center">
			<tr>
				<td width="70px">제목</td>
				<td colspan="5"><%= t.getTgbTitle() %></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><%= t.getTgbWriter() %></td>
				<td>조회수</td>
				<td><%= t.getTgb_Price() %></td>
				<td>작성일</td>
				<td><%= t.getCreateDate() %></td>
			</tr>
			<tr>
				<td>내용</td>
				<td colspan="6">
					<p id="contentArea"><%= t.getTgbContent() %></p>
				</td>
			</tr>
					
		</table>
		
		<table class="detail" align="center">
			<tr>
				<% for(int i=0; i<alist.size(); i++){ %>
				<td>
					<div class="detailImgArea" align="center">
						<img width="200px" height="150px" src="<%=request.getContextPath()%>/assets/img_upfile/<%=alist.get(i).getChangeName()%>"><br>
						<a download="<%=alist.get(i).getOriginName() %>" href="<%= request.getContextPath() %>/assets/img_upfile/<%=alist.get(i).getChangeName()%>">다운로드</a>
						
					</div>
				</td>
				<% } %>
			</tr>
		</table>
		
		<button type="button" onclick="tgbUpdateForm(<%= t.getTgbNo()%>)">수정하기</button>
		<button type="button" onclick= "tgbDelete(<%= t.getTgbNo()%>)">삭제하기</button>

		<script>
			function tgbUpdateForm(bno){
				location.href = "<%=request.getContextPath()%>/updateForm.do?bno="+bno;
			}
			
			function tgbDelete(bno){
				var a = confirm("정말 삭제하시겠습니까?");
				
				if(a){
					location.href = "<%=request.getContextPath()%>/deleteTgb.do?bno="+bno;
				}
				
			}

		</script>
		
	</div>
</body>
</html>