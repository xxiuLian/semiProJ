<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.uni.tgb.model.dto.*, java.util.ArrayList, com.uni.common.Attachment"%>
<%
	Tgb t = (Tgb)request.getAttribute("t");
	ArrayList<Attachment> list = (ArrayList<Attachment>)request.getAttribute("list");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<style>
	.outer{
		width:1000px;
		height:650px;
		background:black;
		color:white;
		margin:auto;
		margin-top:50px;
	}
	
	#insertForm>table{
		border:1px solid white;
	}
	/*#insertForm input, #insertForm textarea{
		width:100%;
		box-sizing:border-box;
	}*/
	#insertForm img{
		border:1px dashed darkgray;
	}
	#contentArea, #guidArea{
        border: 1px solid black;
        width: 800px;
        height: 500px;
    }
</style>
</head>

<body>
	
	<div class="outer">
	
		<form method="post" id="updateForm" action="updateTgb.do" enctype="multipart/form-data">

			<%-- <input type="hidden" name="writer" value="<%= loginUser.getUserNo() %>">--%> 
			<table align="center">
				<tr>
					<td>
						카테고리 : 
					</td>
					<td> 
						<select name="category">
							<option value="1">식품</option>
							<option value="2">의류</option>
						</select>
							
					</td>
					<th width="100">제목</th>
					<td colspan="3"><input type="text" name="title" value="<%= t.getTgbTitle()%>"></td>
				</tr>
				<tr>
					<td>공구 기간 : <input type="date" name="term"></td>
					<td>공구 가격 : <input type="number" name="price" step="1000"></td>
				</tr>
			</table>
			<button type="button" id="ctnbtn" disabled>Content</button><button type="button" id="gidbtn">Guide</button>

			<div id="contentArea" contenteditable="true"><%=t.getTgbContent()%></div>
			<div id="guidArea" contenteditable="true" hidden><%=t.getTgbGuide() %></div>
			
			<textarea id="ctnhtml" name="content" hidden></textarea>
			<textarea id="gidhtml" name="guide" hidden></textarea>	
			<input type="text" name="tgbNo" value=<%=t.getTgbWriter() %> hidden>
		
			<br>

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
		<!--  이미지 첨부 표시-->
			<div id="originFile">
				<% for(Attachment at : list){ %>
				<div><input type="checkbox" class="ckoldFile" value=<%=at.getFileNo() %>><%=at.getOriginName()  %></div>
				
				<% } %>
			
			</div>	
			<div class="btns" align="center">
				<button id="btn1" onsubmit="fmdata()">수정 완료하기</button>
			</div>
			<input type="text" id="deletefile" name="deletefile" style="display:none"><!-- 지우고싶은 파일을 여기에 저장해준다. -->
		</form>
			<button type="button" onclick="deleteImg()">선택파일 삭제</button>
			<button type="button" id="fileinput">이미지 삽입</button>
				
	</div>
	
	<script>
	var atCnt = <%=list.size()%>//현재 파일 목록에 있는 파일 수
	var deletefile;
	
	function fmdata(){
        $('#contentArea').children('img').attr("src","");

        $('#gidhtml').val($('#guidArea').html());
        $('#ctnhtml').val($('#contentArea').html());
        
        $('#deletefile').val(deletefile);// delete 할때 값이 들어가는거 콘솔로 다 확인함
        console.log($('#deletefile').val());

        return false;

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
        
    });

	function deleteImg(){
		
		var ckoldFile = document.getElementsByClassName("ckoldFile");
		var cknewFile = document.getElementsByClassName("cknewfile");

		for(var i = 0; i<ckoldFile.length; i++){
			if($(ckoldFile[i]).is(":checked")){
				deletefile =","+$(ckoldFile[i]).val();
				console.log(deletefile)//콘솔에 deletefile value 받은거 출력
				$(ckoldFile[i]).parent().remove();//style disply:non
				atCnt--;
			}

		}
		
		for(var i = 0; i<cknewFile.length; i++){//새로 추가한 파일
			if($(cknewFile[i]).is(":checked")){
				$(cknewFile[i]).parent().remove();// 화면의 첨부파일 목록에서 없애주고
				
				var filename = "file"+atCnt;
				$(input[name=filename]).val("");// 해당 파일INPUT의 value만 지워준다. 
				atCnt--;
			}

		}

		
	};
    
    $('#fileinput').click(function(){
    	if(atCnt<10){
    		 $('#inputFileArea').children().eq(atCnt).click();
    		 atCnt++; // 파일 추가할때마다 목록 갯수 하나씩 늘림
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
                            $('#contentArea').append("<img id= file"+atCnt+" src="+dataURL+">");
                            $('#originFile').append("<div><input type=checkbox class=cknewfile>"+file.name+"</div>");

                        }
                        reader.readAsDataURL(file);
            })    
    }
	
	</script>

</body>
</html>