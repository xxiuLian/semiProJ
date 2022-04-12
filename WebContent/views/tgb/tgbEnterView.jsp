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
<%@ include file="../common/menubar.jsp" %>

<br><br>
<div id="menu1">
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
		
		<c:choose>
			<c:when test="${loginUser.userId eq t.tgbWriter}">
				<button type="button" onclick="deadline();">마감완료</button>
			</c:when>
			<c:when test = "${t.status eq 'YN'}">
				<button disabled>마감완료된 상품입니다.</button>
			</c:when>
			<c:otherwise>
				<button type="button">결제</button>
				<button type="button" onclick="reportTgb();">상품 신고</button>
			</c:otherwise>
		</c:choose>
		
	</div>
	<div class="btns">
		<button  type="button" onclick="progressdata();">진행상황</button>
		<button>게시판</button>
	
	<c:choose>
		<c:when test="${loginUser.userId eq t.tgbWriter}">
			<button>참여자 정보</button>
		</c:when>
		<c:otherwise>
			<button type="button" onclick="memberdata1();">진행자 정보</button>
		</c:otherwise>
	</c:choose>
	</div>
	
</div>
<div class="menu1">
	<c:choose>
		<c:when test = "${t.status ne 'YN'}">
			<div >
				<div class="tiem mg"><h3>마감일까지</h3></div>
				<div class="time"><h1 id="d-day"></h1></div>
				<div class="time">초 남았습니다.</div>
				<h4 class = "mg">현재 참여율</h4>
				<div class="progress mg"  style="height:30px; border-radius: 20px;">
			  		<div class="progress-bar" role="progressbar" style="width : 0; height:30px;  background-color : #00003F;" aria-valuenow="${cntper}" aria-valuemin="0" aria-valuemax="100">${cntper}%</div>
				</div>	
			</div>
		</c:when>
		<c:otherwise>
			<div id = "noloaded">
				<img src = "<%=contextPath%>/assets/TgbAssets/truckpackage.png">
				<h3>아직 배송 등록이 안됐습니다.</h3>
			</div>
			<button type="button" onclick="loaded();">송장번호 등록</button>
			<iframe id="packAPI" hidden src="https://tracker.delivery/#/kr.chunilps/1111111111111" style="width:100%; height:300px"></iframe>
			<br><br>
		</c:otherwise>
	</c:choose>
	<script>
		function loaded(){
			window.open("${contextPath}/packLoadForm.do?tno=${t.tgbNo}", "배송정보 입력", "width=500, height=170 left=800, top=200" );
			
		};
	</script>
</div>
</div>
<div class="menu3">
	<jsp:include page = "tgbEnterView3.jsp">
		<jsp:param name="writer" value="${t.tgbWriter }"/>
	</jsp:include>
</div>	
	<script>
	
	$(document).ready(function(){
		var p = ${cntper};
		console.log(p);
		$('.progressbar').val(p);
		
		$('.progress-bar').css("width", p+"%");
		
		//메뉴3T숨기기
		$('.menu3').hide();
		
	})
	
	
	
		
	function remaindTime() {
		
	    var now = new Date(); //현재시간을 구한다. 
	    var t = new Date("${term}");
	    
	   
	  	t.setHours(00);
	    
	    var nt = now.getTime(); // 현재의 시간만 가져온다
	    var ot = t.getTime(); // 마감시간만 가져온다
	    
	  
	   if(nt<ot){ 
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
	     
	     var dday = days+":"+hour+":"+min+":"+sec
	    
	      $("#d-day").html(dday);
	      
	   } else{ //현재시간이 종료시간보다 크면
		  $("#d-day").html("00:00:00:00");
	   		
	   
	   }
	  }
	  setInterval(remaindTime,1000);
	  
	  function memberdata1(){
		  $('.menu1').hide();
		  $('.menu3').show();
		  memberdata();
		  
	  };
	  
	  function progressdata(){
		  $('.menu1').show();
		  $('.menu3').hide();
		  
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
	
	</script>

</body>
</html>