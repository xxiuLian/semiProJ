<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.uni.qna.model.dto.*, com.uni.common.Attachment"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"
	src="${contextPath}/resources/smarteditor/js/HuskyEZCreator.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<title>상품 신고</title>
<style>
 #save:hover{
	background-color:#eee;
	}
#backBtn:hover{
	background-color:#eee;
	}
 #backBtn{
	background:rgb(216, 216, 216); 
	color:rgb(85, 85, 85); 
	font-size:20px; 
	width: 200px; 
	height: 50px;
	border-radius:5px;
	border: 0.2px solid rgb(216, 216, 216);
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 700;
	font-size: 25px;
   }
   
  #save{
   background:rgb(11, 100, 159); 
   color:white; 
   width: 200px; 
   height: 50px;
   border-radius:5px;
   border: 0.2px solid rgb(216, 216, 216);
   font-family: 'Noto Sans KR', sans-serif;
   font-weight: 700;
   font-size: 25px;
	}
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp"%>

	<div class="outer">
		<br>

		<h2 align="center">상품 신고</h2>
		<br>
		<div class="container" role="main">
			<form id="reportTgb" action="${contextPath}/reportTgb.do" method="post">
				<input type="hidden" name="bno" value="${bno}">
				<div class="mb-3">
					<a>신고 내용</a>
					<textarea class="form-control" id="ir1" rows="15" name="content"
						style="width: 100%;" placeholder="내용을 입력해 주세요"></textarea>
				</div>
				<br>
				<div id="se2_sample" align="center">
					<button type="button" id="save">신고</button>
					<button type="button" id="backBtn" onclick="history.back()">취소</button>

				</div>
			</form>
		</div>
	</div>
</body>
<script id="smartEditor" type="text/javascript"> 
		var oEditors = [];
		nhn.husky.EZCreator.createInIFrame({
		    oAppRef: oEditors,
		    elPlaceHolder: "ir1",  //textarea ID 입력
		    sSkinURI: "${contextPath}/resources/smarteditor/SmartEditor2Skin.html", //martEditor2Skin.html 경로 입력
				fCreator : "createSEditor2",
				htParams : {
					// 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
					bUseToolbar : true,
					// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
					bUseVerticalResizer : true,
					// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
					bUseModeChanger : true
				}
			});

	$("#save").click(function() {
		oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);

		var contentVal = $("#ir1").val();
		contentVal = contentVal.replace(/<p><br><\/p>/gi, "<br>");
		contentVal = contentVal.replace(/<\/p><p>/gi, "<br>")
		if (contentVal == "" || contentVal == "<p>&nbsp;</p>") {
			alert("글 내용을 입력해주세요");
			return;
		}

		$("#reportTgb").submit();
	})
</script>
</html>