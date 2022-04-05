<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<style>
    #contentArea, #guidArea{
        border: 1px solid black;
        width: 800px;
        height: 500px;
    }
</style>
<body>
<%@ include file="../common/menubar.jsp" %>
<form method="post" action="tgbInsertServlet.do" enctype="multipart/form-data">
<div>카테고리 : 
    <select name="category">
        <option value="1">식품</option>
        <option value="2">의류</option>
    </select>
</div>
    <div>제목 : <input type="text" name="title"></div>
    <div>공구 기간 : <input type="date" name="term"></div>
    <div>공구 가격 : <input type="number" name="price" step="1000"></div>
    <div id="contentArea" contenteditable="true"></div>
    <div id="guidArea" contenteditable="true"></div>

</div>
<input type="file" id="inputFile" name="file" multiple>
<input type="text" name="writer" value="<%=loginUser.getUserNo() %>" hidden><!--writer_NO-->
<textarea name="content" hidden></textarea>
<textarea name="guide" hidden></textarea>
<button type="button" onclick="onsubmit()">작성완료</button>
</form>
<script>
    var i = 0;

    $(document).ready(function(){
        $('#inputFile').on("change", fileInputArea)
    });

    function fileInputArea(event){
        let fileInputControl = event.target;
        let files = fileInputControl.files;

        while(i < files.length){
            FormData.append('files', files[i]);
            i++;
        }

         

    }


</script>





</body>
</html>