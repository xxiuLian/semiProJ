<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/smarteditor/js/service/HuskyEZCreator.js"
	charset="utf-8"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script>

function save(){
	oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);  
    		//스마트 에디터 값을 텍스트컨텐츠로 전달
	var content = document.getElementById("smartEditor").value;
	alert(document.getElementById("ir1").value); 
    		// 값을 불러올 땐 document.get으로 받아오기
	return; 
}

</script>
</head>
<body>
	<%@ include file="../common/menubar.jsp"%>

	<div class="outer">
		<br>

		<h2 align="center">문의게시판 작성하기</h2>
		<br>
		<div class="container" role="main">
			<form id="insertForm" action="${contextPath}/insertQna.do"
				method="post" enctype="multipart/form-data">

				<div class="mb-3">
					<select name="category" id="boardCategory">
						<option value="000">카테고리 선택</option>
						<option value="10">공통</option>
						<option value="20">JAVASCRIPT</option>
						<option value="30">SPRING</option>
						<option value="40">HTML/CSS</option>
						<option value="50">ALGORISM</option>
						<option value="60">GIT</option>
						<option value="70">시사</option>
					</select>
				</div>
				<br>
				<div class="mb-3">
					<input type="text" class="form-control" name="title"
						id="boardTitle" placeholder="제목을 입력해 주세요">
				</div>
				<div class="mb-3">
					<textarea class="form-control" id="ir1" rows="15" name="content"
						style="width: 100%;" placeholder="내용을 입력해 주세요"></textarea>
				</div>

				<div id="se2_sample" style="margin: 10px 0;">
					<input type="button" onclick="save();" value="본문 내용 가져오기">
					<button type="submit" id="save">등록</button>
					<button type="reset">취소</button>
				</div>
			</form>
		</div>
</body>
<script id="smartEditor" type="text/javascript"> 
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors,
	    elPlaceHolder: "ir1",  //textarea ID 입력
	    sSkinURI: "<%=request.getContextPath()%>/resources/smarteditor/SmartEditor2Skin.html",  //martEditor2Skin.html 경로 입력
	    fCreator: "createSEditor2",
	    htParams : { 
	    	// 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
	        bUseToolbar : true, 
		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
		bUseVerticalResizer : false, 
		// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
		bUseModeChanger : false 
	    }
	});
</script>
<script type="text/javascript">
	$("#save").click(function() {
		oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
		$("#frm").submit();
	})
</script>

</html>