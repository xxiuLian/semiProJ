<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.uni.tgb.model.dto.*, java.util.ArrayList, com.uni.common.Attachment"%>
 <%
 	Tgb t = (Tgb)request.getAttribute("t");
 	ArrayList<Attachment> alist = (ArrayList<Attachment>)request.getAttribute("aList");
 
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

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
#contentArea{
	height:50px;
}

.detail td{
	text-align:center;
	border:1px solid white;
}
.detailImgArea{
	width:220px;
	height:190px;
}
</style>
</head>
<body>
<%@ include file="../common/menubar.jsp" %>
<div class="outer">
	
		<br>
		<h2 align="center">공구 등록 글 상세 보기</h2>
		<br>
		<div id="titleImg">대표 이미지<img id="thumb"></div>
	
		
		<table class="option">
				<tr>
					<td class="tdfirst">카테고리  </td>
					<td class="tdsecond">
						<%=t.getTgbCategory() %>
					</td>
				</tr>
				<tr>
					<td class="tdfirst"> 제목  </td>
					<td class="tdsecond"><%=t.getTgbTitle() %></td>
				</tr>
				<tr>
					<td class="tdfirst">공구 인원  </td>
					<td class="tdsecond"><%=t.getCount() %> 명</td>
				</tr>
				<tr>
					<td class="tdfirst">공구 기간  </td>
					<td class="tdsecond"><%=t.getTgbTerm() %></td>
				</tr>
				<tr>
					<td class="tdfirst">가격  </td>
					<td class="tdsecond"><%=t.getTgb_Price() %> 원</td>
				</tr>
				<tr>
					
				</tr>

		</table>
		<div class="btns"><button type="button" id="ctnbtn" disabled>Content</button><button type="button" id="gidbtn">Guide</button></div>
		<div id="contentArea" class="textarea" ><%=t.getTgbContent() %></div>
    	<div id="guidArea" class="textarea" hidden><%=t.getTgbGuide() %></div>
	
		
		<table class="detail" align="center">
			<tr>
			
				<% for(int i=0; i<alist.size(); i++){ %>
				<td>
					<div class="detailImgArea" align="center">
						<img width="200px" height="150px" src="<%=request.getContextPath()%>/assets/img_upfile/<%=alist.get(i).getChangeName()%>"><br>
						<a download="<%=alist.get(i).getOriginName() %>" href="<%= request.getContextPath() %>/assets/img_upfile/<%=alist.get(i).getChangeName()%>">다운로드</a>
						
					</div>
				</td>
				<% } %>
			</tr>
		</table>
		
		<%if(loginUser != null &&loginUser.getUserId() == t.getTgbWriter()){ %><!-- 아이디를 갖고 오자 -->
		
		<button type="button" onclick="tgbUpdateForm(<%= t.getTgbNo()%>)">수정하기</button>
		<button type="button" onclick= "tgbDelete(<%= t.getTgbNo()%>)">삭제하기</button>
		
		<%} %>
		<button type="button" onclick="history.back();">목록으로</button>

		<script>
		
			$(document).ready(function(){
				alert("되냐")
				
				
			});
			function tgbUpdateForm(bno){
				location.href = "<%=request.getContextPath()%>/updateForm.do?bno="+bno;
			}
			
			function tgbDelete(bno){
				var a = confirm("정말 삭제하시겠습니까?");
				
				if(a){
					location.href = "<%=request.getContextPath()%>/deleteTgb.do?bno="+bno;
				}
				
			}
			
			 $('#ctnbtn').click(function(){
			       
			        $('#contentArea').attr("hidden", false);
			        $("#guidArea").attr("hidden", true);
			        $('#ctnbtn').attr("disabled", true);
					$('#ctnbtn').css({"background-color" : "rgb(2, 2, 59)", "color": "white"})
			        $("#gidbtn").attr("disabled", false);
					$('#gidbtn').css({"background-color" : "rgb(190, 190, 190)", "color": "rgb(199, 197, 197)"})

			    })
			    $('#gidbtn').click(function(){
			        
			        $('#guidArea').attr("hidden", false);
			        $("#contentArea").attr("hidden", true);
			        $("#gidbtn").attr("disabled", true);
					$('#gidbtn').css({"background-color" : "rgb(2, 2, 59)", "color": "white"})
			        $('#ctnbtn').attr("disabled", false);
					$('#ctnbtn').css({"background-color" : "rgb(190, 190, 190)", "color": "rgb(199, 197, 197)"})

			        
			    }) 

		</script>
		
	</div>
</body>
</html>