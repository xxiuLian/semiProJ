<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">

</head>
<style>
.outer{
	width:900px;
	height:auto;
	color:black;
	margin:auto;
	margin-top:50px;
	text-align : center;
	background-color: rgb(217, 237, 255);
	
	border-radius: 7px;
}
#container{
	width: 900px;
}
.entermain{
	width: 100%;
	height: auto;
	display: block;
}
.imgdiv{
	display: inline-block;
	float: left;
	height: auto;
	padding: 20px;
	
}
#title{
	text-align:center;
	font-family: 'Noto Sans KR', sans-serif;
}
#price{
	font-weight: bold;
	color: rgb(44, 44, 160);
	font-size: 25px;
	font-family: 'Noto Sans KR', sans-serif;
	margin-bottom: 30px;
}

#titleImgTag{
	width:300px;
	height:250px;
	border: 0.2px solid rgb(201, 201, 201);
	display:inline-block;
	margin-bottom: 20px;
	border-radius: 7px;
	
}

.option{
	margin: 20px;
	width: 100%;
	height: 250px;
	background-color: aliceblue;
	border-radius: 7px;
	display:inline-block;
	float: right;
	padding-top: 30px;
	
}
.paytext{
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 16px;
	
	color: rgb(133, 133, 133);
}
.btns{
	text-align: left;
}

.btns button{
	border-radius: 7px;
	border: 0px;
	padding: 10px;
	background-color: rgb(75, 125, 168);
	padding-left: 20px;
	padding-right: 20px;
	color: white;
	font-weight: bold;
	font-family: 'Noto Sans KR', sans-serif;
	margin: 5px;
}
.btns button:hover{
	background-color: rgb(17, 69, 114);
	
}
.option button{
	background-color: rgb(78, 78, 185);
	padding: 10px;
	padding-left: 20px;
	padding-right: 20px;
	border-radius: 7px;
	border: 0px;
	font-weight: bold;
	font-family: 'Noto Sans KR', sans-serif;
	color: white;
	
}
.paybutton{
	width: 200px;
	font-size: 25px;
	
}

#outer{
	background-color: white;
}
</style>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>


<br><br>
<div class="container outer" id="container">
	
	
		<br>
		
		<br>
		<input type="hidden">
		
		<div class="row entermain">	
		<div class="col-lg-6 imgdiv"><img id="titleImgTag" src = "${contextPath }/assets/img_upfile/${t.thumnail}"></div>
	
		<div class="col-lg-6">
			<div class="option">
			<div id="title">
				<h2 >${t.tgbTitle}</h2>
				<p id="price">${t.price }원</p>
			</div>
			
			<c:choose>
				<c:when test="${loginUser.userId eq t.tgbWriter}">
					<button type="button"  onclick="deadline();">마감완료</button>
				</c:when>
				<c:when test = "${t.status eq 'YN'}">
					<button disabled>마감완료된 상품입니다.</button>
				</c:when>
				<c:otherwise> 
					<c:forEach var="b" items="${buyer}">
						<c:if test="${b eq loginUser.userId}">
							<c:set var="status" value="true"/>
						</c:if>
					</c:forEach>
					<c:choose>
							<c:when test="${status eq 'true'}">
								<p class="paytext">이미 결제된 상품입니다.</p>
	                        </c:when>
					     	<c:otherwise>
								 <button class="paybutton" type="button" onclick="payment();">결 제</button>
					     	</c:otherwise>
			     	  	</c:choose>
				</c:otherwise>
			</c:choose>
			</div>
		</div>
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
		  window.open("${contextPath}/payView.do?bno=${t.tgbNo}", "결제정보", "width=1000, height=700 left=800, top=200" )
		}
	
	</script>



</body>
</html>