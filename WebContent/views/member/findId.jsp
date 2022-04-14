<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.container{
text-align: center;
width: 1000px
}
</style>
</head>
<body>
<%@ include file= "../common/menubar.jsp" %>


<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">아이디 찾기</div>
                    <br><br>
                <div class="card-body">
                    <form name="idfindscreen" method="POST">
                        <div class="form-group row">
                            <label for="email_address" class="col-md-4 col-form-label text-md-right">이름</label>
                            <div class="col-md-6">
                                <input type="text" class="form-control" name="userName" placeholder="등록한 이름"
                                    required autofocus>
                            </div>
                        </div>
                        <br><br><br>
                        <div class="form-group row">
                            <label for="password" class="col-md-4 col-form-label text-md-right">휴대전화</label>
                            <div class="col-md-6">
                                <input type="text" id="phone" class="form-control" name="phone" placeholder="'-' 없이 입력" required>
                            </div>
                        </div>
                            <br><br>
                        <div class="col-md-6 offset-md-4" style="text-align: center;">
                            <button type="submit" class="btn btn-primary" onClick="idSearch()">
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
 function idSearch() { 
	 	var frm = document.idfindscreen;

	 	if (frm.userName.value.length < 1) {
		  alert("이름을 입력해주세요");
		  return;
		 }

		 if (frm.phone.value.length != 11) {
			  alert("핸드폰번호를 정확하게 입력해주세요");
			  return;
		 }

	 frm.method = "post";
	 frm.action = "<%=request.getContextPath()%>/findIdResult.do" //넘어간화면
	 frm.submit();  
	 }
 </script>
</body>
</html>