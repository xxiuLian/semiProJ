<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 글 작성</title>
<script type="text/javascript"
	src="${contextPath}/resources/smarteditor/js/HuskyEZCreator.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<style>
 .btnsArea{
	   width: 100%;
	   height: 150px;
	   justify-content: center;
	   display: flex;
	   align-items: center;
	   
   }
   .btn{
	   margin-right: 30px;
	   display: inline-block;
   }
    #goBack{
	 
	background:rgb(216, 216, 216); 
	color:rgb(85, 85, 85); 
	font-size:20px; 
	width: 180px; 
	height: 50px;
	border-radius:5px;
	border: 0.2px solid rgb(216, 216, 216);
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 700;
	font-size: 25px;
   }
   #save{
	   background:rgb(11, 100, 159); 
	   color:white; font-size:20px; 
	   width: 180px; 
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

		<h2 align="center">문의게시판 작성하기</h2>
		<br>
		<div class="container" role="main">
			<form id="insertForm" action="${contextPath}/insertQna.do" method="post">
				<div class="mb-3">
					<select name="category" id="boardCategory">
							<option value="non">카테고리 선택</option>
							<c:forEach items="${category}" var="c">
								<option value="${c.categoryNo}">${c.categoryName}</option>
							</c:forEach>
					</select>
				</div>
				<br>
				<div class="mb-3">
					<input type="text" class="form-control" name="title"
						id="boardTitle" placeholder="제목을 입력해 주세요">
				</div>
				<div class="mb-3">
					<span>내용</span>
					<textarea placeholder="내용을 입력해 주세요" class="form-control" id="ir1" rows="15" name="content"
						style="width: 100%;"></textarea>
				</div>
				
				<div id="btnsArea" align="center">
					<div class="btn"><button type="button" id="save">등록</button></div>
					<div class="btn"><button type="button" id="goBack" onclick="history.back()">취소</button></div>
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
		
		if($("#boardCategory").val() == 'non'){
			alert("카테고리를 선택해주세요");
			return;
		}
		if($("#boardTitle").val() == ""){
			alert("제목을 입력해주세요");
			return;
		}
		
		var contentVal = $("#ir1").val();
		console.log(contentVal);
		//contentVal = contentVal.replace(/<p>/gi,"");
		//contentVal = contentVal.replace(/<\/p>/gi,"<br>");
		//contentVal = contentVal.replace(/<p><br><\/p>/gi,"<br>");
		//contentVal = contentVal.replace(/<\/p><p>/gi, "<br>");
		if(contentVal == "" || contentVal == "<p>&nbsp;</p>"){
			alert("글 내용을 입력해주세요");
			return;
		}
		
		
		$("#insertForm").submit();
	})
</script>

</html>