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
<button id="btn1">작성완료</button>
</form>
<script>

    $(function(){
        $('#btn1').click(function(){

            $.ajax({
                        type: "POST",
                        enctype: 'multipart/form-data',
                        url:'/tgbInsertServlet.do',
                        data: FormData,
                        processData:false,
                        contentType: false,
                        cache: false,
                        success:function(result){

                        },
                        error:function(e){

                        }
                    })

        })
    })    


    
    var i = 0;

    $(document).ready(function(){
        $('#inputFile').on("change", fileInputArea)
    });

    function fileInputArea(event){
        let fileInputControl = event.target;
        let files = Array.from(fileInputControl.files);

        if(i<=10){

            files.forEach((file, index) => {
                FormData.append("file"+i, file);
                i++;

                var reader = new FileReader();
                reader.onload = function(){
                    var dataURL = reader.result;
                    $('#contentArea').append("<img src="+dataURL+">");

                }
                reader.readAsDataURL(file);

            })
            

           
        }else{
            alert("사진은 10장까지 삽입이 가능합니다.");
        }


         

    }


</script>





</body>
</html>