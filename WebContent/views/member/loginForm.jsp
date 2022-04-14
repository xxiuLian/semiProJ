<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.uni.member.model.dto.Member"%>
    <%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<% String msg = (String)session.getAttribute("msg"); %>
<!-- 네이버 -->
<%
    String clientId = "ZncfIzzOzACjfv58Qta_";//가치사 아이디값";
    String redirectURI = URLEncoder.encode("http://localhost:8100/valueSa/naverLogin.do", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
    apiURL += "&client_id=" + clientId;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&state=" + state;
    session.setAttribute("state", state);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="${contextPath}/css/loginForm.css" rel="stylesheet" />
<title>Insert title here</title>
<style>

.findEnroll {
        box-sizing: border-box;
        float: left;
    }

    #kakao-login-btn {
        box-sizing: border-box;
        float: right;
    }

    .form-control {
        width: 100% !important;
        height: 50px;
    }
</style>
<!-- 카카오 -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<script type="text/javascript">

	$(function(){
		let msg = "<%=msg %>"
		if(msg != "null"){
			alert(msg);
			<% session.removeAttribute("msg");%> //메세지 띄우고 삭제
		}
	})
	function loginValidate(){
		if($("#userId").val().trim().length === 0){
			alert("아이디를 입력하세요");
			$("#userId").focus();
			return false;
		}
		if($("#userPwd").val().trim().length === 0){
			alert("비밀번호를 입력하세요");
			$("#userPwd").focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>
<%@ include file= "../common/menubar.jsp" %>
  <div class="container">
  <% if(loginUser == null){ %>
        <div class="kpx_login">
            <h3 class="kpx_authTitle"><a id="loginBtn">로그인</a></h3>
            <div class="row kpx_row-md-offset-md-3">
                <div class="col-12 col-md-6">
                    <hr />
                    <form id="loginForm" action="<%=request.getContextPath()%>/loginMember.do" method="post">
                        <div class="input-group">
                            <span class="input-group-addon">아이디 </span>
                            <input type="text" class="form-control" name="userId" placeholder="아이디를 입력하세요">
                        </div>
                        <br>
                        <div class="input-group">
                            <span class="input-group-addon">비밀번호</span>
                            <input type="password" class="form-control" name="userPwd" placeholder="비밀번호를 입력하세요">
                        </div>
                        <br>
                        <button class="btn btn-lg btn-outline-primary btn-block" type="submit"><i
                                class="fa fa-sign-in"></i> 로그인</button>
                    </form>
                </div>
            </div>
            <br>
            <div class="row kpx_row-md-offset-md-3">
                <div class="col-6 col-md-6">
                    <div class="findEnroll" style="width: 50%;">
                        <a href="<%=request.getContextPath()%>/findId.do">아이디</a>/
                        <a href="<%=request.getContextPath()%>/findPwd.do">비밀번호 찾기</a>
                    </div>

                    <div class="findEnroll" style="width: 50%; text-align: right;">
                        <a style="text-align: right;" href="javascript:void(0);" onclick="enrollPage();">회원가입</a>
                    </div>
                </div>
            </div>
            <div class="row kpx_row-md-offset-md-3 kpx_loginOr">
                <div class="col-12 col-md-6">
                    <hr class="kpx_hrOr">
                    <span class="kpx_spanOr">또는</span>
                </div>
            </div>
            <div class="row kpx_row-lg-offset-lg-3 kpx_socialButtons">
                <div class="col-lg-3">
                   <a href="<%=apiURL%>"><img width="220" height="48" src="<%=contextPath%>/resources/smarteditor/img/naver.png"></a>
                </div>
                <div class="col-lg-3">
                    <a id="kakao-login-btn"></a>
                    <a href="http://developers.kakao.com/logout"></a>
                </div>
            </div><br>
        </div>
		<% }else{ %> 
			<div id = "userInfo">
				<b style = "color:black;"><%=loginUser.getUserName() %> 님 </b> 의 방문을 환영합니다.
				<br><br>
				<div class ="btns" align="center">
					<a href = "<%= contextPath %>/mypageMember.do">마이페이지</a>
					<a href = "<%= contextPath %>/logoutMember.do">로그아웃</a>
				</div>
			</div>
			
		<% } %>
	</div>	
</body>
<script>
	function enrollPage(){
		location.href="<%=request.getContextPath()%>/enroll.do";
	}
	
</script>

		<script type='text/javascript'>
    	//가치사 javascript키
    	Kakao.init('9fb8871864e8f093d41c5c8020df9c37');
    	// 카카오 로그인 버튼을 생성합니다.
    	Kakao.Auth.createLoginButton({
      		container: '#kakao-login-btn',
     		success: function(authObj) {
          
          //로그인 성공시, 카카오 API를 호출한다.(카카오에 있는 데이터 불러옴)
          Kakao.API.request({
              url: '/v2/user/me',
              success: function(res){
                  console.log(res);
                  console.log(res.id);
                  console.log(JSON.stringify(res.properties.nickname));
                  console.log(JSON.stringify(res.kakao_account.email));
                 $.ajax({
                    url:"<%=request.getContextPath()%>/kakaoLogin.do",
                    data:{ //kakaologin 서블릿으로 던질 데이터들
                    	"userId":res.id, 
                    	"name":JSON.stringify(res.properties.nickname),
                    	"email":JSON.stringify(res.kakao_account.email)
                    	},
                    Type:"post",
                    success:function(data){
                        //로그인을 성공적으로 연결하고나면 이동할 메인 url
                        location.href="<%=request.getContextPath()%>";
                    }
                    
                 });
              },
              fail: function(error){
                  alert(JSON.stringify(error));
              }
          });
         //접속이 잘 된다면 회원의 토큰값 출력됨
        //alert(JSON.stringify(authObj));
        
      },
      fail: function(err) {
         alert(JSON.stringify(err));
      }
    });
</script>  

</html>