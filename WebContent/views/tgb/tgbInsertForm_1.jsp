<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
/*.editer{
	border: 1px solid black;
    width: 1000px;
    height: 1000px;
}*/

img{
    border: 1px dashed black;
}
</style>
<body>

<form method="post" action="tgbInsertServlet.do" enctype="multipart/form-data">
    <select name="category">
        <option value="1">식품</option>
        <option value="2">의류</option>
    </select><br>
제목 : <input type="text" name="title"><br>
제품 이미지 : 
<div><img id="Img1" width="150" height="150"><img id="Img2" width="150" height="150"><img id="Img3" width="150" height="150"></div>
제품 설명 : <div><textarea rows="10 cols="40" name="content"></textarea></div>
공구 설명 : <div><textarea rows="10" cols="40" name="guide"></textarea><br></div>
공구 기간 : <input type="date" name="term"><br>
공구 가격 : <input type="text" name="price"><br>
writer_no<input type="text" name="writer" value="5" hidden><br>
<div id="fileArea" hidden>
    <input type="file" name="file1" id="file1" onchange="loadImg(this, 1);">
    <input type="file" name="file2" id="file2" onchange="loadImg(this, 2);">
    <input type="file" name="file3" id="file3" onchange="loadImg(this, 3);">
</div>

<script>
    $("#Img1").click(function(){
        $("#file1").click();
    });
    $("#Img2").click(function(){
        $("#file2").click();
    });
    $("#Img3").click(function(){
        $("#file3").click();
    });

    function loadImg(input, num){
        if(input.files.length == 1){
            var reader = new FileReader();
            reader.readAsDataURL(input.files[0]);
            reader.onload = function(e){
                switch(num){
                    case 1 : $("#Img1").attr("src", e.target.result); break; 
                    case 2 : $("#Img2").attr("src", e.target.result); break; 
                    case 3 : $("#Img3").attr("src", e.target.result); break; 
                }
            }
        }
    }

</script>

<!--<div class="editer" name="content2" contenteditable="true" spellcheck="false">sdf
    <img src="https://sir.kr/data/editor/2008/3739827612_1596626375.8311.png">
</div>-->
<button type="submit">등록</button>
</form>

</body>
</html>