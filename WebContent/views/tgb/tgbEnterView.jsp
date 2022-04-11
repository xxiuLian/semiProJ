<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</style>
</head>
<body>
<%@ include file="../common/menubar.jsp" %>
<div class="outer">

	<br>
	<h2 align="center">공구 등록 글 상세 보기</h2>
	<br>
	<input type="hidden">
	<div id="titleImg">대표 이미지<img src = "${contextPath }/assets/img_upfile/${t.thumnail}"></div>

	<div class="option">
		
		<div id="title">
			<h2>${t.tgbTitle}</h2>
			<p>${t.tgb_Price }</p>
		</div>
		
		
		<button type="button">결제</button>
		<button type="button" onclick="reportTgb();">상품 신고</button>
	</div>
	<div class="btns">
		<button>진행상황</button>
		<button>게시판</button>
	
	<c:choose>
		<c:when test="${loginUser.userNo} == ${t.tgbWriter }">
			<button>참여자 정보</button>
		</c:when>
		<c:otherwise>
			<button>진행자 정보</button>
		</c:otherwise>
	</c:choose>
	
	</div>
	<div class="time">
	<span id="d-day-days">00</span>
    <span class="col">:</span>
    <span id="d-day-hour">00</span>
    <span class="col">:</span>
    <span id="d-day-min">00</span>
    <span class="col">:</span>
    <span id="d-day-sec">00</span>
  </div>
	<div>
	<div id="hide" hidden>${term}</div>
		<div id="count"></div>
		<progress value="${cntper }" max="100"></progress>
	</div>
	
	<script>
		var term = "${term}";
		//var dday = new Date(term).getTime();
	function remaindTime() {
	    var now = new Date(); //현재시간을 구한다. 
	    var t = new Date(term);
	    
	    console.log(term);
	  
	    var nt = now.getTime(); // 현재의 시간만 가져온다
	    var ot = t.getTime(); // 오픈시간만 가져온다
	    
	  
	   if(nt<ot){ //현재시간이 오픈시간보다 이르면 오픈시간까지의 남은 시간을 구한다.   
	     sec = parseInt(ot - nt) / 1000;
	   	 days = parseInt(sec/60/60/24);
	   	 sec = (sec - (days*60*60*24));
	     hour = parseInt(sec/60/60);
	     sec = (sec - (hour*60*60));
	     min = parseInt(sec/60);
	     sec = parseInt(sec-(min*60));
	  	
	     if(hour<10){hour="0"+hour;}
	     if(min<10){min="0"+min;}
	     if(sec<10){sec="0"+sec;}
	      $("#d-day-days").html(days);
	      $("#d-day-hour").html(hour);
	      $("#d-day-min").html(min);
	      $("#d-day-sec").html(sec);
	      
	   } else{ //현재시간이 종료시간보다 크면
		$("#d-day-days").html('00');
	    $("#d-day-hour").html('00');
	    $("#d-day-min").html('00');
	    $("#d-day-sec").html('00');
	   }
	  }
	  setInterval(remaindTime,1000);
	
	</script>

</body>
</html>