<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.uni.qna.model.dto.*, com.uni.common.Attachment"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 글 조회</title>
</head>
<style>
	.outer{
		width:1000px;
		height:500px;
		background:#fff;
		color:black;
		margin:auto;
		margin-top:50px;
	}
	.listArea{
		border:1px solid white;
		text-align:center;
	}
	.searchArea{
		margin-top:50px;
	}
	
	.pagingArea{
		margin-top:15px;
	}
	.pagingicon{
		border: 1px solid lightgray;
		border-radius: 5px;
	}
	#writeadmin, #searchbtn{
		border: 1px solid black;
		
	}
	#writeadmin:hover{
		background-color:#eee;
	}
	#searchbtn:hover{
		background-color:#eee;
	}
	.qnaCategory{
		float: left;
	}
	
	.btnsArea{
	   width: 100%;
	   height: 80px;
	   justify-content: center;
	   display: flex;
	   align-items: center;
	   
   }
 
    #resetBtn{
	background:rgb(216, 216, 216); 
	color:rgb(85, 85, 85); 
	font-size:20px; 
	width: 80px; 
	height: 30px;
	border-radius:5px;
	border: 0.2px solid rgb(216, 216, 216);
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 700;
	font-size: 15px;
   }
   
    #deleteBtn{
	background:rgb(216, 216, 216); 
	color:rgb(85, 85, 85); 
	font-size:20px; 
	width: 150px; 
	height: 50px;
	border-radius:5px;
	border: 0.2px solid rgb(216, 216, 216);
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 700;
	font-size: 20px;
   }
   #blueBtn{
	   background:rgb(11, 100, 159); 
	   color:white; font-size:20px; 
	   width: 150px; 
		height: 50px;
	   border-radius:5px;
	   border: 0.2px solid rgb(216, 216, 216);
	   font-family: 'Noto Sans KR', sans-serif;
	   font-weight: 700;
	   font-size: 20px;
	}
	#content{
		padding-right: 180px;
	}
</style>
<body>
<%@ include file="../common/menubar.jsp" %>
	
	<div class="outer">
		<br>
		
		<h2 align="center">신고 상세보기</h2>
		<br>
		<form id="deleteReport" action="${contextPath}/deleteReport.do" method="post">
		<input type="hidden" name="report" value="${r.reportNo}">
		<table class="listArea table table-hover" align="center">
			<tr>
				<th>상품 번호</th>
				<td>${r.reportNo}</td>
				<th>작성일</th>
				<td>${r.createDate}</td>
				<th width="100">작성자</th>
				<td>${r.reportUserId}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td id="content" colspan="6">
					<p>${r.reportContent}</p>
				</td>
			</tr>
				
		</table>
		
		<br>
		
		<div class="btns" align="center">
		<button type="button" id="blueBtn" onclick="location.href='${contextPath}/detailTgb.do?bno=${r.tgbNo}'">상품 보기</button>
		<button type="submit" id="deleteBtn">신고 삭제하기</button>
		</div>
		</form>
		
		
	</div>
	
</body>
</html>