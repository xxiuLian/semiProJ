<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="loginUser" value="${sessionScope.loginUser}" />
<c:set var="contextPath" value="${sessionScope.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<style>
.listArea {
	border: 1px solid black;
	text-align: center;
}
input{
	width: 80px;
}	
</style>

</head>
<body>
	<h2>결제 정보 확인</h2>
	<form id="paySubmit" action="${contextPath}/paySubmit.do" method="post">
	<input type="hidden" name="bno" value="${t.tgbNo}">
		<table class="listArea" align="center">
			<tr>
				<th width="100">공구 글</th>
				<th width="50">썸네일</th>
				<th width="100">개당 가격</th>
				<th width="150">구매 수량</th>
				<th width="150">합계</th>
			</tr>
			<tr>
				<td>${t.tgbNo}</td>
				<td><img src="${contextPath}/assets/img_upfile/${thumbnail}" width="200px" height="150px"></td>
				<td>${t.tgb_Price} 원</td>
				<td><input id="amount" type="number" name="amount" value="1"> 개</td>
				<td><input id="totPrice" type="text" name="totPrice" value="${t.tgb_Price}" readonly> 원</td>
			</tr>
		</table>
		<div class="btns" align="center">
			<button type="button" onclick="pay()">결제</button>
		</div>
	</form>
</body>
<script>IMP.init('imp44891833') </script>
<script>
$("#amount").change(function(){
	
	$("#totPrice").val(${t.tgb_Price}*$("#amount").val())
	
	console.log($("#totPrice").val())
})
	function pay(){
	    IMP.request_pay({
	    	pg: "html5_inicis.INIBillTst",
	        pay_method : 'card',
	        merchant_uid: "order_${bno}_"+ Date.now(), //공구번호+현재시간을 붙여준다
	        name : '상품 결제',
	        amount: $("#totPrice").val(),
	        buyer_email: "${loginUser.email}",
	        buyer_name: "${loginUser.userName}",
	        buyer_tel: "${loginUser.phone}",
	        buyer_addr: "${loginUser.address1}${loginUser.address2}",
	        buyer_postcode: "${loginUser.post}",
	    }, function(rsp) {
	    	 if (rsp.success) {
	             // 결제 성공 시
	             $("#paySubmit").submit();
	             
	         } else {
	        	//결제 시작 페이지로 리디렉션되기 전에 오류가 난 경우
	             var msg = '오류로 인하여 결제가 시작되지 못하였습니다.';
	             msg += '에러내용 : ' + rsp.error_msg;
	
	             alert(msg);
	         }
	    	
	    });
	}
    </script>
</html>