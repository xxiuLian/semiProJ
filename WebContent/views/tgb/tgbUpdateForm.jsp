<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.uni.tgb.model.dto.*, java.util.ArrayList, com.uni.common.Attachment, com.uni.admin.dto.*"%>
<%
	Tgb t = (Tgb)request.getAttribute("t");
	ArrayList<Attachment> list = (ArrayList<Attachment>)request.getAttribute("list");

	System.out.println(t.getTgbContent()+"이거");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

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
		width:800px;
		height:300px;
		color:black;
		margin:auto;
		margin-top:50px;
		text-align : center;
		
	}
#titleImg{
	width:300px;
	height:400px;
	border: 0.2px solid black;
	overflow:hidden;
	margin : 0 auto;
	display:inline-block;
	float : left;
}
#thumb{
	max-width:100%;
	max-height: 100%;
	object-fit:cover;
}
.option{
	width:350px;
	height:400px;
	margin : 10px;
	display:inline-block;
}
.textarea{
	width:766px; 
	height:412px;
	overflow-y : scroll;
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
	overflow-y : scroll;
}
#fileinput{
	text-align: left;
	margin-top: 20px;
}
#contentArea{
	max-width: 100%;
}

</style>
</head>


<body>
<%@ include file="../common/menubar.jsp" %>



<div class="outer">
<br>
<h2>공동구매 등록</h2>
<hr>
	<form action="${contextPath }/updateTgb.do" method="post" id="frm" enctype="multipart/form-data"> 
		<div id="titleImg">대표 이미지<img id="thumb" src="<%=contextPath%>/assets/img_upfile/${list[0].changeName}"></div>
		<input type="text" name = "tno" value="${t.tgbNo}" hidden>
		<div class="option">
		<input type="file" id="thumbImg" name="file0" onchange="loadThumbImg(event)" hidden>
			<table>
				<tr>
					<td class="tdfirst">카테고리  </td>
					<td class="tdsecond">
						<div>
							<select name="category" id="tgbCategory">
								<c:forEach items="${catelist}" var="category" varStatus="st">
									<option value="${category.categoryNo}"><c:out value="${category.categoryName}"/></option>
								</c:forEach>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdfirst"> 제목  </td>
					<td class="tdsecond"><input type="text" name="title" id="titleId" value="${t.tgbTitle}"></td>
				</tr>
				<tr>
					<td class="tdfirst">공구 인원  </td>
					<td class="tdsecond"><input type="number" name="pcont" value="${t.count}"> 명</td>
				</tr>
				<tr>
					<td class="tdfirst">공구 기간</td>
					<td class="tdsecond"><input type="date" name="term" value="${t.tgbTerm}"></td>
				</tr>
				<tr>
					<td class="tdfirst">가격 </td>
					<td class="tdsecond"><input type="number" name="price" value="0" step ="1000" id="priceId" value="${t.tgb_Price}"> 원</td>
				</tr>
				<tr>
					
				</tr>

			</table>

		</div>
	

		<div class="btns"><button type="button" id="ctnbtn" disabled>Content</button><button type="button" id="gidbtn">Guide</button></div>
		<div id="contentArea" class="textarea" contenteditable="true">${t.tgbContent}</div>
    	<div id="guidArea" class="textarea" contenteditable="true" hidden>${t.tgbGuide}</div>
		
		<textarea name="content" id="content" hidden></textarea> 
		<textarea name="guide" id="guide" hidden></textarea> 

		<div class="btns"><button type="button" id="fileinput">이미지 삽입</button></div>
		
		<div id="uploaded"></div>
		<button type="button" onclick="deleteImg();">선택파일 삭제</button>
		
		<input type="hidden" name="writer" value=<%=loginUser.getUserNo() %> ><!--writer_NO-->
		
		<button id="btn1" type="button">작성완료</button>
		
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
		<inptu type="text" name = "deleteAt" id="deleteAt" hidden>
		
		
	</form>
	</div>
	
	

	
	<script>

	var arr = [false, false, false, false, false, false, false, false, false, false];
	$(document).ready(function(){

		var num= 0;
		
		<%for(int i = 1; i < list.size() ;i++){%>//content 본문에 이미지 추가
		
		$('#contentArea').children('img').eq(num).attr("src","<%=request.getContextPath()%>/assets/img_upfile/<%=list.get(i).getChangeName()%>");
		$('.inputFile').eq(num).attr("disabled", true);
		$('#uploaded').append("<div><input type=checkbox class=uploadfile>"+"<%=list.get(i).getOriginName()%>"+"</div>")
		arr[num] = true;
		num++;
		<%};%>
		
		
			
	});
	
	
	
	$(function(){
		$('#titleImg').click(function(){
			$("#thumbImg").click();
		})
	});
	
	function loadThumbImg(event){

        let fileInputControl = event.target;
        let files = Array.from(fileInputControl.files);
		//console.log(files);

             files.forEach((file, index) => {
                 
                        var reader = new FileReader();
                        reader.onload = function(){
                            var dataURL = reader.result;
                            $('#thumb').attr("src", dataURL);

                        }
                        reader.readAsDataURL(file);
            })  
            
     
	};
	
	
	
	$('#btn1').click(function(){
		$('#contentArea').children('img').attr("src","");
	
        $('#guide').val($('#guidArea').html());
        $('#content').val($('#contentArea').html());
        
        $('#frm').submit();

	
	})
	
	
	
	 $('#ctnbtn').click(function(){
	        $('#guide').val($('#guidArea').html());

	        $('#contentArea').attr("hidden", false);
	        $("#guidArea").attr("hidden", true);
	        $('#ctnbtn').attr("disabled", true);
			$('#ctnbtn').css({"background-color" : "rgb(2, 2, 59)", "color": "white"})
	        $("#gidbtn").attr("disabled", false);
			$('#gidbtn').css({"background-color" : "rgb(190, 190, 190)", "color": "rgb(199, 197, 197)"})

	    })
	    $('#gidbtn').click(function(){
	        $('#content').val($('#contentArea').html());
	        
	        $('#guidArea').attr("hidden", false);
	        $("#contentArea").attr("hidden", true);
	        $("#gidbtn").attr("disabled", true);
			$('#gidbtn').css({"background-color" : "rgb(2, 2, 59)", "color": "white"})
	        $('#ctnbtn').attr("disabled", false);
			$('#ctnbtn').css({"background-color" : "rgb(190, 190, 190)", "color": "rgb(199, 197, 197)"})

	        
	    })  
	
	
	
	$("#fileinput").click(function(){
		
		for(var i = 0; i<arr.length; i++){
			
			if(!arr[i]){
				$(".inputFile").eq(i).click();
				break;
			}
			
		}
		
	})
	
	
	
	
	
	function loadImg(event){
        
        let fileInputControl = event.target;
        let files = Array.from(fileInputControl.files);
		console.log(files);

             files.forEach((file, index) => {
                 
                        var reader = new FileReader();
                        reader.onload = function(){
                            var dataURL = reader.result;
                            for(var i = 0; i<arr.length; i++){
                            	if(arr[i]){
                            		arr[i] = true;
		                            $('#contentArea').append("<img id= file"+i+" src="+dataURL+">");
		                            $('#uploaded').append("<div><input type=checkbox class=uploadfile>"+file.name+"</div>");
                    			}
                            	
                            }
                            

                        }
                        reader.readAsDataURL(file);
            })    
    }
	
	
	 function deleteImg(){// 배열 TRUE FALSE 로 파일 입력 수정 중간을 지우고 나중에 다시 삽입할때 밀린다. 
	    	
	    	var uploadFile = document.getElementsByClassName('uploadfile');
	    	
	    	for(var j = 0; j<uploadFile.length; j++){
	    		
				if($(uploadFile[j]).is(":checked")){
					arr[j] = false;
					var filename = "file"+(j+1);
					
				if(!$('input[name='+filename+']').val("")){	
					console.log($('input[name='+filename+']').val());
					$('input[name='+filename+']').val("");
					
				}else{
					console.log($(uploadFile[j]).parent().text());
					$('#deleteAt').val($(uploadFile[j]).parent().text()+",");
					console.log($('#deleteAt').val());// 값이 찍히는데도 서블릿으로 파라미터가 넘어가지 않는다. 
					
					}
					$(uploadFile[j]).parent().remove();
				
				
				
				}
			}

			};
	
	
	
	</script>

</body>
</html>