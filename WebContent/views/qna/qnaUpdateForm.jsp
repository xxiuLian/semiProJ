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
<title>문의 글 수정</title>
<style>
#deleteBtn {
	color: gray;
}

#deleteBtn:hover {
	cursor: pointer
}
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp"%>

	<div class="outer">
		<br>

		<h2 align="center">문의게시판 수정하기</h2>
		<br>
		<div class="container" role="main">
			<form id="updateForm" action="${contextPath}/updateQna.do"
				method="post">
				<input type="hidden" name="qno" value="${q.qnaNo}">

				<div class="mb-3">
					<select name="category" id="boardCategory">
						<option value="non">카테고리 선택</option>
						<c:forEach items="${category}" var="c">
							<option value="${c.categoryNo}" <c:if test="${q.category eq c.categoryName}">selected</c:if>>${c.categoryName}</option>
						</c:forEach>
					</select>
				</div>

				<div class="mb-3">
					<input type="text" class="form-control" name="title"
						id="boardTitle" value="${q.qnaTitle}">
				</div>

				<div class="mb-3">
					<textarea class="form-control" id="ir1" rows="15" name="content"
						style="width: 100%;">${q.qnaContent}</textarea>
				</div>
				<br>
				<div id="se2_sample" style="margin: 10px 0;">
					<button type="button" id="save">수정</button>
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

		if ($("#boardCategory").val() == 'non') {
			alert("카테고리를 선택해주세요");
			return;
		}
		if ($("#boardTitle").val() == "") {
			alert("제목을 입력해주세요");
			return;
		}

		var contentVal = $("#ir1").val();
		contentVal = contentVal.replace(/<p><br><\/p>/gi, "<br>");
		contentVal = contentVal.replace(/<\/p><p>/gi, "<br>")
		if (contentVal == "" || contentVal == "<p>&nbsp;</p>") {
			alert("글 내용을 입력해주세요");
			return;
		}

		$("#updateForm").submit();
	})
</script>
</html>