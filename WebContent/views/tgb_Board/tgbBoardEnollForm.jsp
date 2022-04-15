<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.outer{
		width:800px;
		height:500px;
		background:#fff;
		color:black;
		margin:0 auto;
		margin-top:50px;
	}
	#insertForm{width:100%; margin: 15px auto;}
	#insertForm>table{border:1px solid white;}
	#insertForm>table input{
		width:100%;
		box-sizing:border-box;
	}
	#searchbtn:hover{
		background-color:#eee;
	}
	#cancel:hover{
		background-color:#eee;
	}
	#cancel, #searchbtn{
		border:1px solid grey;
		margin-left:5px;
	}
	.btns{
		margin-top:10px;
		text-align:center;
	}
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	<div class="outer">
	<h2 align="center">공동구매 게시판 작성하기</h2>
	<!-- enctype="multipart/form-data"  -->
	<form id="insertForm" action="<%= request.getContextPath()%>/insertTgbBoard.do" method="post" enctype="multipart/form-data">
		<table align="center">
			<tr>
				<th width="100">카테고리</th>
				<td width="500">
					<select name="category">
						<option value="1">의류</option>
						<option value="2">잡화</option>
						<option value="3">기기</option>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="3"><input type="text" name="title" class="form-control" placeholder="제목을 입력하세요." required></td>
			</tr>
			<tr>
				<!-- style="resize:none; -->
				<td colspan="4"><textarea  name="content" cols="60" rows="15"  style="resize:none;" class="form-control" placeholder="내용을 입력하세요." required></textarea></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td><input id="attachment" type="file" name="upfile"></td>
			</tr>
		</table>
		
		<div class="btns">
			<button class="btn btn-default" id="searchbtn" type="submit" >등록하기</button>
			<button class="btn btn-default" id="cancel"type="reset">취소하기</button>
		</div>
	</form>
	</div>
</body>
</html>