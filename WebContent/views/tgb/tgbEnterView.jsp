<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>

.title{
	text-align:center;
}
.outer{
	width:800px;
	height:300px;
	color:black;
	margin:auto;
	margin-top:50px;
	text-align : center;
	
}
.menu1{
	width:80%;
	height:auto;
	color:black;
	margin:auto;
	margin-top:50px;
	text-align : center;
	
}

.menu1>.*{
	display : inline-block;
}
#titleImg{
	width:300px;
	height:200px;
	border: 0.2px solid black;
	overflow:hidden;
	margin : 0 auto;
	display:inline-block;
	float : left;
}

#thumb{
	max-width:100%;
	max-height: 100%;
	object-fit:cover;
}
.option{
	width:350px;
	height:200px;
	margin : 10px;
	display:inline-block;
}
.textarea{
	overflow: hidden;
	height : auto;
	text-align : left;
	border : 1px solid black;
	padding : 30px;
}
.btns{
	text-align: left;
}
#ctnbtn{
	background-color: rgb(2, 2, 59);
	color: white;
}
#gidbtn{
	background-color: rgb(190, 190, 190);
	color: rgb(199, 197, 197);
}

.detail td{
	text-align:center;
	border:1px solid white;
}
.detailImgArea{
	width:220px;
	height:190px;
}
#wish{
	border:0px;
	background-color:white;
	margin : 10px;
}
#wish>img{
	width:100px;
	height:100px;

}
#ptici{
	width:150px;
	height:100px;
	
	margin:10px;
}
.time{
	display : inline-block;
}

.mg{
	margin : 30px;
}

.progress {

     border-radius: 10px;
    
}

.progress-bar {
    -webkit-transition: width 2.5s ease;
    transition: width 2.5s ease;
     border-radius: 20px;
     background-color : #00003F;
     color :white;
}



</style>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>



<br><br>
<div id="menu1">
	<div class="outer">
	
		<br>
		<h2 align="center">공구 등록 글 상세 보기</h2>
		<br>
		<input type="hidden">
		<div id="titleImg">대표 이미지<img id="titleImgTag" src = "${contextPath }/assets/img_upfile/${t.thumnail}"></div>
	
		<div class="option">
			
			<div id="title">
				<h2>${t.tgbTitle}</h2>
				<p>${t.thumnail}왜안돼</p>
				<p>${t.tgb_Price }</p>
			</div>
			
			<c:choose>
				<c:when test="${loginUser.userId eq t.tgbWriter}">
					<button type="button" onclick="deadline();">마감완료</button>
				</c:when>
				<c:when test = "${t.status eq 'YN'}">
					<button disabled>마감완료된 상품입니다.</button>
				</c:when>
				<c:otherwise>
					<button type="button" onclick="payment();">결제</button>
					<button type="button" onclick="reportTgb();">상품 신고</button>
				</c:otherwise>
			</c:choose>
			
		</div>
		<div class="btns">
			<button  type="button" onclick="progressdata();">진행상황</button>
			<button type="button" onclick="boardMenu();">게시판</button>
		
		<c:choose>
			<c:when test="${loginUser.userId eq t.tgbWriter}">
				<button type="button" onclick="memberdata_wook();">참여자 정보</button>
			</c:when>
			<c:otherwise>
				<button type="button" onclick="memberdata1();">진행자 정보</button>
			</c:otherwise>
		</c:choose>
		</div>
	</div>

</div>



	<script>
	/*$(document).ready(function(){
		
		$.ajax({
			url : "tgbEnterMenu.do",
			data : {
				tno : "${t.tgbNo}"
			},
			type :"post",
			success : function(m){
				console.log(m);
				$('titleImgTag').attr("src", "${contextPath }/assets/img_upfile/${t.thumnail}")
				
				
			},
			error : function(){
				
			}
		})
		
		
		
	})*/
	
	
	function progressdata(){
		location.href = "<%=request.getContextPath()%>/tgbEnter.do?tmenu=1&tno=${t.tgbNo}";
	}
	function boardMenu(){
		location.href = "<%=request.getContextPath()%>/tgbEnter.do?tmenu=2&tno=${t.tgbNo}";
	}
	function memberdata_wook(){
		location.href = "<%=request.getContextPath()%>/tgbEnter.do?tmenu=3&tno=${t.tgbNo}";
	}
	function memberdata1(){
		location.href = "<%=request.getContextPath()%>/tgbEnter.do?tmenu=4&tno=${t.tgbNo}";
	}

	  function deadline(){
		  
		  $.ajax({
			  url : "updateStatus.do",
			  data : {
				  tno : ${t.tgbNo}
			  },
			  type : "post",
			  success : function(result){
				  console.log(result);
				  alert("마감이 완료되었습니다.");
			  },
			  error : function(e){
				  console.log("통신 실패"+e);
			  }
		  })
		  
		  
	  }
	  
	  function payment(){
		  window.open("${contextPath}/payView.do?bno=${t.tgbNo}", "결제정보", "width=700, height=500 left=800, top=200" )
		}
	
	</script>



</body>
</html>