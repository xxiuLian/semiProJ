<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                <div class="card-header"><b>카테고리 추가</b></div>
                    <br><br>
                <div class="card-body">
                    <form id="addCategory" action="${contextPath}/addCategory.do?keyword=${keyword}" method="post">
                        <div class="form-group row">
                            <label for="cno" class="col-md-4 col-form-label text-md-right">카테고리 이름</label>
                            <div class="col-md-6">
                                <input type="text" class="form-control" name="cno" placeholder="번호를 입력하세요"
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
                            <button type="submit" class="btn btn-primary">
                                추가
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
</html>