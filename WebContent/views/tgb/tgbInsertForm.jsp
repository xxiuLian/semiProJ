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
    <button type="button" id="ctnbtn" disabled>Content</button><button type="button" id="gidbtn">Guide</button>

 
    <div id="contentArea" contenteditable="true"></div>
    <div id="guidArea" contenteditable="true" hidden></div>

</div>

<button type="button" id="fileinput">이미지 삽입</button>
<input type="text" name="writer" value="<%=loginUser.getUserNo() %>" hidden><!--writer_NO-->
<textarea id="ctnhtml" name="content" hidden></textarea>
<textarea id="gidhtml" name="guide" hidden></textarea>
<button id="btn1" onsubmit="fmdata()">작성완료</button>

<div id = "inputFileArea" hidden>
    <input type="file" class="inputFile" name="file1" onchange="loadImg(event)">
    <input type="file" class="inputFile" name="file2" onchange="loadImg(event)">
    <input type="file" class="inputFile" name="file3" onchange="loadImg(event)">
    <input type="file" class="inputFile" name="file4" onchange="loadImg(event)">
    <input type="file" class="inputFile" name="file5" onchange="loadImg(event)">
    <input type="file" class="inputFile" name="file6" onchange="loadImg(event)">
    <input type="file" class="inputFile" name="file7" onchange="loadImg(event)">
    <input type="file" class="inputFile" name="file8" onchange="loadImg(event)">
    <input type="file" class="inputFile" name="file9" onchange="loadImg(event)">
    <input type="file" class="inputFile" name="file10" onchange="loadImg(event)">
</div>


</form> 


<script>
    function fmdata(){
        $('#contentArea').children('img').attr("src","");

        $('#gidhtml').val($('#guidArea').html());
        $('#ctnhtml').val($('#contentArea').html());

        return true;

    }

    $('#ctnbtn').click(function(){
        $('#gidhtml').val($('#guidArea').html());

        $('#contentArea').attr("hidden", false);
        $("#guidArea").attr("hidden", true);
        $('#ctnbtn').attr("disabled", true);
        $("#gidbtn").attr("disabled", false);

    })
    $('#gidbtn').click(function(){
        $('#ctnhtml').val($('#contentArea').html());
        
        $('#guidArea').attr("hidden", false);
        $("#contentArea").attr("hidden", true);
        $("#gidbtn").attr("disabled", true);
        $('#ctnbtn').attr("disabled", false);
        
    })  
    var i = 0;
   

    $('#fileinput').on("click", function(){
    if(i<10){
        $('#inputFileArea').children().eq(i).click();
        i++;
    }else{
        alert("사진은 10이하 삽입이 가능합니다.")
           
        }
    });



    function loadImg(event){
        
        let fileInputControl = event.target;
        let files = Array.from(fileInputControl.files);

             files.forEach((file, index) => {
                 
                        var reader = new FileReader();
                        reader.onload = function(){
                            var dataURL = reader.result;
                            $('#contentArea').append("<img id= file"+i+" src="+dataURL+">");

                        }
                        reader.readAsDataURL(file);
            })    
    }
     

    
</script>





</body>
</html>