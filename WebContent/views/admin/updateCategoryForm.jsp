<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String msg = (String)request.getAttribute("msg");
	String sTag = (String)request.getAttribute("sTag");
	String originCname = (String)request.getAttribute("originCname");
	System.out.println("msg = " +msg);
	System.out.println("sTag = " +sTag);
	System.out.println("originCname = " +originCname);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
 <!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico"/>
<link href="css/styles.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	
	<div class="container" style="text-align: center;">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header"><b>카테고리 수정</b></div>
                    <br><br>
                <div class="card-body">
                    <form id="updateCategory" action="<%= request.getContextPath() %>/updateCategory.do?keyword=${keyword}" method="post">
                       <input type="hidden" name="originCno" value="${category.categoryNo}">
                        <div class="form-group row">
                            <label for="cno" class="col-md-4 col-form-label text-md-right">이름</label>
                            <div class="col-md-6">
                                <input type="text" id="cno" class="form-control" name="cno" placeholder="번호를 입력하세요"
                                    required autofocus>
                            </div>
                        </div>
                        <br><br><br>
                        <div class="form-group row">
                            <label for="cname" class="col-md-4 col-form-label text-md-right">카테고리 번호</label>
                            <div class="col-md-6">
                                <input type="text" id="cname" class="form-control" name="cname" placeholder="카테고리를 입력하세요" required>
                            </div>
                        </div>
                            <br><br>
                        <div class="col-md-6 offset-md-3" style="text-align: center;">
                            <button type="button" class="btn btn-primary" onclick="updateCategory()">
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
	
	
	
</body>
<script>
var msg="<%= msg %>";
var sTag="<%= sTag %>";
var originCname = "<%= originCname %>";
	$(function(){
		if(${category.categoryNo} != null){
			console.log('진입');
			$("#cno").val(${category.categoryNo});
			$("#cname").val('${category.categoryName}');
		}
		
		
	})
		
	function updateCategory(){
		if($("#cno").val().trim() === "" || $("#cname").val().trim() === ""){
			alert("카테고리 정보를 입력하세요")
			return false;
		}
		if(isNaN($("#cno").val().trim())){
			alert("카테고리번호는 숫자만 입력 가능합니다.")
			return false;
		}
		$("#updateCategory").submit();
	}
</script>
</html>