<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../common/menubar.jsp" %>
<jsp:include page = "tgbEnterView.jsp"/>

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


	<script>
	
	$(document).ready(function(){
		var p = ${cntper};
		console.log(p);
		$('.progressbar').val(p);
		
		$('.progress-bar').css("width", p+"%");
		
		
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

<%@ include file="../chat/chat.jsp" %>

</body>
</html>