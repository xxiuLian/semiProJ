<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

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

				<div>
					<button type="submit" id="save">등록</button>
					<button type="reset">취소</button>
				</div>
			</form>
		</div>
</body>
<script type="text/javascript">
var oEditors = [];
$(function(){
      nhn.husky.EZCreator.createInIFrame({
          oAppRef: oEditors,
          elPlaceHolder: "ir1", //textarea에서 지정한 id와 일치해야 합니다. 
          //SmartEditor2Skin.html 파일이 존재하는 경로
          sSkinURI: "<%=request.getContextPath()%>/resources/smarteditor/SmartEditor2Skin.html",
					htParams : {
						// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
						bUseToolbar : true,
						// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
						bUseVerticalResizer : true,
						// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
						bUseModeChanger : true,
						fOnBeforeUnload : function() {

						}
					},
					fOnAppLoad : function() {
						//기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
						oEditors.getById["ir1"].exec("PASTE_HTML",
								[ "내용을 입력하여 주세요" ]);
					},
					fCreator : "createSEditor2"
				});
	});
</script>
<script type="text/javascript">
	$("#save").click(function() {
		oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
		$("#frm").submit();
	})
</script>


<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/smarteditor/js/HuskyEZCreator.js"
	charset="utf-8"></script>
</html>