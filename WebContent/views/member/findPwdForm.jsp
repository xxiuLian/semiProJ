<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String msg = (String)request.getAttribute("msg");
	String sTag = (String)request.getAttribute("sTag");
	String originPwd = (String)session.getAttribute("originPwd");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/styles.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	var msg="<%= msg %>";
	var sTag="<%= sTag %>";
	var originPwd = "<%= originPwd %>";
	$(function(){
		if(msg != "null"){
			
			alert(msg) //msg가 있으면 띄워주고
		}
		
		if(sTag == "Y"){
			
			opener.document.getElementById("originPwd").value = originPwd;
			//이 페이지를 연 부모창의 originPwd값을 찾아 바꿔주고
			window.close() //창 닫기
		}
		
	})
	
</script>
</head>
<body>
<br><br><br><br><br><br><br><br>
<div class="container" style="text-align: center;">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header"><b>비밀번호 변경</b></div>
                    <br><br>
                <div class="card-body">
                   <form id="findPwdUpdateForm" action="<%= request.getContextPath() %>/findPwdUpdate.do" method="post">
                        <div class="form-group row">
                            <label for="userName" class="col-md-4 col-form-label text-md-right">변경할 비밀번호</label>
                            <div class="col-md-6">
                                <input type="password" class="form-control" name="newPwd" placeholder="새 비밀번호"
                                    required autofocus>
                            </div>
                        </div>
                        <br><br><br>
                        <div class="form-group row">
                            <label for="phone" class="col-md-4 col-form-label text-md-right">변경할 비밀번호 확인</label>
                            <div class="col-md-6">
                                <input type="password" id="phone" class="form-control" name="checkPwd" placeholder="새 비밀번호 확인" required>
                            </div>
                        </div>
                            <br><br>
                        <div class="col-md-6 offset-md-3" style="text-align: center;">
                            <button type="submit" class="btn btn-primary" onClick="fnCheckPwd()">
                                변경
                            </button>
                        </div>
                            <br><br>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
	
	<script>
		function fnCheckPwd(){
			var newPwd = $("input[name='newPwd']");
			var checkPwd = $("input[name='checkPwd']");
			
			if(newPwd.val().trim() === "" || checkPwd.val().trim() === ""){
				alert("비밀번호를 입력하세요") //빈 칸이 하나라도 있으면 입력하라고 창
				return false;
			}
			
			if(newPwd.val() != checkPwd.val()){
				alert("비밀번호가 다릅니다.") //바꿀 비번과 확인 비번이 다르면 X
				checkPwd.val(''); //확인 비번 리셋해서
				checkPwd.focus(); //포커스 두고 다시 입력하게 하기
				return false;
			}
			
			$("#findPwdUpdateForm").submit();
		}
	</script>
</body>
</html>