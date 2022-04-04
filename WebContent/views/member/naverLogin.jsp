<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
<script type="text/javascript">
	//접근 토큰 값
	var naver_id_login = new naver_id_login("ZncfIzzOzACjfv58Qta_", "http://localhost:8070/");
	
	naver_id_login.get_naver_userprofile("naverSigninCallback()");
	//네이버 사용자 프로필 조회 후 프로필 정보를 처리할 콜백함수
	function naverSigninCallback(){
		alert(naver_id_login.getProfileData('email'));
		var user_email = naver_id_login.getProfileData('email');
		window.location.href='/valueSa/naverLogin?user_email='+user_email
	}
</script>
</body>
</html>