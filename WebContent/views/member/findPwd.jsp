<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	String msg = (String)request.getAttribute("msg"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file= "../common/menubar.jsp" %>
<div class="container" style="text-align: center;">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header"><b>비밀번호 찾기</b></div>
                    <br><br>
                <div class="card-body">
                    <form name="pwdfindscreen" method = "POST">
                        <div class="form-group row">
                            <label for="phone" class="col-md-4 col-form-label text-md-right">아이디</label>
                            <div class="col-md-6">
                                <input type="text" class="form-control" name="userId" placeholder="아이디 입력" required autofocus>
                            </div>
                        </div>
                        <br>
                        <div class="form-group row">
                            <label for="userName" class="col-md-4 col-form-label text-md-right">이름</label>
                            <div class="col-md-6">
                                <input type="text" class="form-control" name="userName" placeholder="등록한 이름"
                                    required>
                            </div>
                        </div>
                        <br>
                        <div class="form-group row">
                            <label for="phone" class="col-md-4 col-form-label text-md-right">휴대전화</label>
                            <div class="col-md-6">
                                <input type="text" id="phone" class="form-control" name="phone" placeholder="'-' 없이 입력" required>
                            </div>
                        </div>
                            <br><br>
                        <div class="col-md-6 offset-md-3" style="text-align: center;">
                            <button type="submit" class="btn btn-primary" onClick="pwdSearch()">
                                찾기
                            </button>
                            <button type="button" class="btn btn-primary" onClick="history.back()">
                                취소
                            </button>
                        </div>
                            <br><br>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

 <script type="text/javascript">
 function pwdSearch() { 
	 	var frm = document.pwdfindscreen;
	 	if (frm.userId.value.length < 1) {
			  alert("아이디를 입력해주세요");
			  return;
			 }
	 	
	 	if (frm.userName.value.length < 1) {
		  alert("이름을 입력해주세요");
		  return;
		 }

		 if (frm.phone.value.length != 11) {
			  alert("핸드폰번호 11자리를 정확하게 입력해주세요");
			  return;
		 }

	 frm.method = "post";
	 frm.action = "<%=request.getContextPath()%>/findPwdResult.do" //넘어간화면
	 frm.submit();  
	 }
 </script>
</body>
</html>