<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	.outer{
		width:800px;
		height:500px;
		background:#fff;
		color:black;
		margin:auto;
		margin-top:50px;
	}
	#enrollForm{width:100%; margin: 15px auto;}
	#enrollForm>table{border:1px solid white;}
	#enrollForm>table input{
		width:100%;
		box-sizing:border-box;
	}
	#searchbtn:hover{
		background-color:#eee;
	}
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	
	<div class="outer">
		<br>
		
		<h2 align="center">이벤트 작성하기</h2>
		
		<form id="enrollForm" action="<%= contextPath %>/insertEvent.do" method="post" >
			<table align="center">
				<tr>
					<td colspan="3"><input type="text" name="title" class="form-control" placeholder="제목을 입력하세요." required></td>
				</tr>
				<tr>
					<td colspan="4">
						<textarea name="content" cols="60" rows="15" style="resize:none;" class="form-control" placeholder="내용을 입력하세요." required></textarea>
					</td>
				</tr>	
			</table>
			<br>
			
			<div class="btns" align="center">
				<button class="btn btn-default" id="searchbtn" type="submit" style="border:1px solid grey">등록하기</button>
			</div>
		</form>
	</div>


</body>
</html>