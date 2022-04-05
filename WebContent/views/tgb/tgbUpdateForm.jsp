<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.uni.tgb.model.dto.*, java.util.ArrayList, com.uni.common.Attachment"%>
<%
	Tgb t = (Tgb)request.getAttribute("t");
	ArrayList<Attachment> list = (ArrayList<Attachment>)request.getAttribute("list");

	System.out.println(t.getTgbContent()+"이거");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<style>
	.outer{
		width:1000px;
		height:650px;
		background:black;
		color:white;
		margin:auto;
		margin-top:50px;
	}
	
	#insertForm>table{
		border:1px solid white;
	}
	#insertForm input, #insertForm textarea{
		width:100%;
		box-sizing:border-box;
	}
	#insertForm img{
		border:1px dashed darkgray;
	}
</style>
</head>

<body>
	
	<div class="outer">
		<br>
		<h2 align="center">사진 게시판 작성하기</h2>
		<br>
		
		
		<form id="insertForm" action="insertThumb.do" method="post" enctype="multipart/form-data">
			<%-- <input type="hidden" name="writer" value="<%= loginUser.getUserNo() %>">--%>
			<table align="center">
				<tr>
					<th width="100">제목</th>
					<td colspan="3"><input type="text" name="title" value="<%= t.getTgbTitle()%>"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3"><textarea name="content" rows="5" style="resize:none;" ><%=t.getTgbContent()%></textarea>
				</tr>
				<tr>
					<th>대표이미지</th>
					<td colspan="3">
						<img id="titleImg" width="150" height="120" src="<%=request.getContextPath()%>/assets/img_upfile/<%=list.get(0).getChangeName()%>">
					</td>
				</tr>
				<tr>
				<% for(int i=1; i<list.size(); i++){ %>
					<th>내용이미지</th>
					<td>
						<img id="contentImg<%=i%>" width="150" height="120" src="<%=request.getContextPath()%>/assets/img_upfile/<%=list.get(i).getChangeName()%>">
					</td>
					
				<% } %>
				</tr>
			</table>
			<div id="fileArea" hidden>
			    <input type="file" name="file1" id="file1" onchange="loadImg(this, 1);">
			    <input type="file" name="file2" id="file2" onchange="loadImg(this, 2);">
			    <input type="file" name="file3" id="file3" onchange="loadImg(this, 3);">
			</div>
						 
			
			<br>
			
			<div class="btns" align="center">
		
				<button type="submit">수정 완료하기</button>
			</div>
		</form>
		
	</div>
	
	<script>
	$(function(){
		$("#fileArea").hide();
		
		$("#titleImg").click(function(){
			$("#file1").click();
		});
		
		$("#contentImg1").click(function(){
			$("#file2").click();
		});
		
		$("#contentImg2").click(function(){
			$("#file3").click();
		});
		
		$("#contentImg3").click(function(){
			$("#file4").click();
		});
		
	});
	function loadImg(inputFile, num){
		if(inputFile.files.length == 1){//length? 
			var reader = new FileReader();//파일 읽어 들일 객체 생성
			reader.readAsDataURL(inputFile.files[0]);//파일 읽어 들이는 메소드 
			//https://developer.mozilla.org/ko/docs/Web/API/FileReader
			reader.onload = function(e){//파일 읽기가 다 완료되면 실행
				switch(num){
				case 1 : $("#titleImg").attr("src", e.target.result); break;//공부
				case 2 : $("#contentImg1").attr("src", e.target.result); break;
				case 3 : $("#contentImg2").attr("src", e.target.result); break;
				case 4 : $("#contentImg3").attr("src", e.target.result); break;
				}
			}
		}
	}
	
	
	</script>

</body>
</html>