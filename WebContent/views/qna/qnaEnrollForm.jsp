<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/smarteditor/js/HuskyEZCreator.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="//code.jquery.com/jquery-1.11.0.min.js"></script>
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
						<option value="20">회원</option>
						<option value="30">주문/결제</option>
						<option value="40">배송</option>
						<option value="50">취소/반품/교환</option>
						<option value="60">이벤트</option>
						<option value="70">기타</option>
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
					<button type="button" id="save">등록</button>
					<button type="reset">취소</button>
					
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
		    sSkinURI: "<%=request.getContextPath()%>/resources/smarteditor/SmartEditor2Skin.html", //martEditor2Skin.html 경로 입력
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
		
		if($("#boardCategory").val() == 000){
			alert("카테고리를 선택해주세요");
			return;
		}
		if($("#boardTitle").val() == ""){
			alert("제목을 입력해주세요");
			return;
		}
		
		var contentVal = $("#ir1").val();
		console.log(contentVal);
		contentVal = contentVal.replace(/<p><br><\/p>/gi, "<br>");
		contentVal = contentVal.replace(/<\/p><p>/gi, "<br>")
		if(contentVal == "" || contentVal == "<p>&nbsp;</p>"){
			alert("글 내용을 입력해주세요");
			return;
		}
		
		
		$("#insertForm").submit();
	})
	
</script>

</html>