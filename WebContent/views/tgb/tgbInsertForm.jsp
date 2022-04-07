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

div tr td{

}
td{
	height: 50px;
	text-align: left;
}
.tdfirst{
	width: 100px;
	border-right: 0.5px solid black;
}
.tdsecond{
	padding-left: 10px;
}
.outer{
		width:800PX;
		height:300px;
		color:black;
		margin:auto;
		margin-top:50px;
		text-align : center;
	}
.option{
	margin : 30px;
}
.textarea{
	width:766px; 
	height:412px;
	overflow : scroll;
	text-align : left;
	border : 1px solid black;
	padding : 30px;
}
.btns{
	text-align: left;
}
#ctnbtn{
	background-color: rgb(2, 2, 59);
	color: white;
}
#gidbtn{
	background-color: rgb(190, 190, 190);
	color: rgb(199, 197, 197);
}
#uploaded{
	width:766px; 
	height:80px;
	border : 1px solid rgb(110, 110, 110);
	margin-top: 20px;
	overflow : scroll;
}
#fileinput{
	text-align: left;
	margin-top: 20px;
}
#contentArea{
	max-width: 100%;
}

</style>

<body>
<%@ include file="../common/menubar.jsp" %>


<div class="outer">
<br>
<h2>공동구매 등록</h2>
<hr>
	<form action="<%= contextPath %>/tgbInsertServlet.do" method="post" id="frm" enctype="multipart/form-data"> 
		
		
		<div class="option">
			<table>
				<tr>
					<td class="tdfirst">카테고리  </td>
					<td class="tdsecond">
						<select name="category">
							<option value="1">식품</option>
							<option value="2">의류</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="tdfirst"> 제목  </td>
					<td class="tdsecond"><input type="text" name="title"></td>
				</tr>
				<tr>
					<td class="tdfirst">공구 인원  </td>
					<td class="tdsecond"><input type="number" name="pcont"> 명</td>
				</tr>
				<tr>
					<td class="tdfirst">공구 기간  </td>
					<td class="tdsecond"><input type="date" name="term"></td>
				</tr>
				<tr>
					<td class="tdfirst">가격  </td>
					<td class="tdsecond"><input type="number" name="price"> 원</td>
				</tr>
				<tr>
					
				</tr>

			</table>

		</div>
		

		<div class="btns"><button type="button" id="ctnbtn" disabled>Content</button><button type="button" id="gidbtn">Guide</button></div>
		<div id="contentArea" class="textarea" contenteditable="true"></div>
    	<div id="guidArea" class="textarea" contenteditable="true" hidden></div>
		
		<textarea name="content" id="content" hidden></textarea> 
		<textarea name="guide" id="guide" hidden></textarea> 

		<div class="btns"><button type="button" id="fileinput">이미지 삽입</button></div>
		
		<div id="uploaded"></div>
		
		<input type="hidden" name="writer" value=<%=loginUser.getUserNo() %> ><!--writer_NO-->
		<textarea id="ctnhtml" name="content" hidden></textarea>
		<textarea id="gidhtml" name="guide" hidden></textarea>
		<button id="btn1" type="submit">작성완료</button>
		
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
		$('#btn1').click(function(){
		$('#contentArea').children('img').attr("src","");
		var a =  $('#contentArea').html();
		
		alert($('input[type=hidden]').val());
		

        $('#gidhtml').val($('#guidArea').html());
        $('#ctnhtml').val($('#contentArea').html());

		
		
		})


		 $('#ctnbtn').click(function(){
	        $('#guide').val($('#guidArea').html());

	        $('#contentArea').attr("hidden", false);
	        $("#guidArea").attr("hidden", true);
	        $('#ctnbtn').attr("disabled", true);
			$('#ctnbtn').css({"background-color" : "rgb(190, 190, 190)", "color": "rgb(199, 197, 197)"})
	        $("#gidbtn").attr("disabled", false);
			$('#gidbtn').css({"background-color" : "rgb(2, 2, 59)", "color": "white"})

	    })
	    $('#gidbtn').click(function(){
	        $('#content').val($('#contentArea').html());
	        
	        $('#guidArea').attr("hidden", false);
	        $("#contentArea").attr("hidden", true);
	        $("#gidbtn").attr("disabled", true);
			$('#gidbtn').css({"background-color" : "rgb(190, 190, 190)", "color": "rgb(199, 197, 197)"})
	        $('#ctnbtn').attr("disabled", false);
			$('#ctnbtn').css({"background-color" : "rgb(2, 2, 59)", "color": "white"})

	        
	    })  

	var i = 0;
   

    $('#fileinput').on("click", function(){
    if(i<10){
        $('#inputFileArea').children().eq(i).click();
		//console.log("i : "+i);
        i++;
    }else{
        alert("사진은 10이하 삽입이 가능합니다.")
           
        }
    });

    function loadImg(event){
        
        let fileInputControl = event.target;
        let files = Array.from(fileInputControl.files);
		//console.log(files);

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
</div>
<script>
</script>

</body>
</html>