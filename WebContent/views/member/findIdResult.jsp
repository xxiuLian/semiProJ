<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    Member findUser = (Member)request.getAttribute("findUser");
    String userName = (String)request.getAttribute("userName");
    String userId = findUser.getUserId();
    %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.card-body{
	font-size: 35px
}
</style>
</head>
<body>
<%@ include file="../common/menubar.jsp" %>
<div class="container" style="text-align: center;">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header"><b>아이디 찾기 결과</b></div>
                        <br>
                    <div class="card-body" style="text-align: center;">
                        <label class="col-md-6 col-form-label text-md-right"><b><%=userName %>&nbsp;님</b>의<br><br>아이디는&nbsp;<b><%= userId %>&nbsp;</b>입니다.<br></label>
                    </div>
                    <br><br>
                    <div style="text-align: center">
                    	<button type="button" class="btn btn-primary" style="width: 210px" onclick= "location.href='<%=contextPath %>/login.do'">로그인</button>
                    	<button type="button" class="btn btn-primary" style="width: 210px" onclick= "location.href='<%=contextPath %>/findPwd.do'">비밀번호 찾기</button>
                    
                    </div>
                    <br><br>
                </div>
            </div>
        </div>
    </div>
   
     
       
</body>
</html>