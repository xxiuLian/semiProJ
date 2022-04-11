<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.uni.tgb.model.dto.*, java.util.ArrayList, com.uni.common.Attachment"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%
 	Tgb t = (Tgb)request.getAttribute("t");
 	ArrayList<Attachment> alist = (ArrayList<Attachment>)request.getAttribute("aList");
 	boolean wish = (boolean)request.getAttribute("wish");
 
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
	overflow: hidden;
	height : auto;
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

.detail td{
	text-align:center;
	border:1px solid white;
}
.detailImgArea{
	width:220px;
	height:190px;
}
#wish{
	border:0px;
	background-color:white;
	margin : 10px;
}
#wish>img{
	width:100px;
	height:100px;

}
#ptici{
	width:150px;
	height:100px;
	margin:10px;
}
</style>
</head>
<body>
<%@ include file="../common/menubar.jsp" %>
<div class="outer">

	<br>
	<h2 align="center">공구 등록 글 상세 보기</h2>
	<br>
	<input type="hidden">
	<div id="titleImg">대표 이미지<img id="thumb" src="<%=contextPath%>/assets/img_upfile/<%=alist.get(0).getChangeName()%>"></div>

	<div class="option">
		<table >
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
			
		</table>
		
		<button type="button" id='wish' value=""><img src="<%=contextPath%>/assets/TgbAssets/undib.png"></button>
		<button type="button" id="ptici" onclick="participation();">참여하기</button>
		<button type="button" onclick="reportTgb();">상품 신고</button>
	</div>
	<div class="btns"><button type="button" id="ctnbtn" disabled>Content</button><button type="button" id="gidbtn">Guide</button></div>
	<div id="contentArea" class="textarea" ><%=t.getTgbContent() %></div>
   	<div id="guidArea" class="textarea" hidden><%=t.getTgbGuide() %></div>

	
	
	<%if(loginUser != null &&loginUser.getUserId() == t.getTgbWriter()){ %><!-- 아이디를 갖고 오자 -->
	
	<button type="button" onclick="tgbUpdateForm(<%= t.getTgbNo()%>)">수정하기</button>
	<button type="button" onclick= "tgbDelete(<%= t.getTgbNo()%>)">삭제하기</button>
	
	<%} %>
	<button type="button" onclick="history.back();">목록으로</button>
	
	
	<script>
	
		$(document).ready(function(){
			
			//console.log('되냐');
			
			var num= 0;
			
			<%for(int i = 1; i < alist.size() ;i++){%>//content 본문에 이미지 추가
				
				$('#contentArea').children('img').eq(num).attr("src","<%=request.getContextPath()%>/assets/img_upfile/<%=alist.get(i).getChangeName()%>");
			num++;
			<%};%>
			
			<%if(wish){%>
			$('#wish').children('img').attr("src", "<%=contextPath%>/assets/TgbAssets/dib.png");
			$('#wish').val('true');// 찜한 내역이면 TRUE
			<%}else{%>
			$('#wish').val('false');
			<%}%>
			
	
		});
		
		
		
		
		$('#wish').click(function(){
			var loginUser = "<%=loginUser%>";
			<%--
			console.log(typeof(loginUser));//String
			console.log(loginUser);//null, 객체 toString
			console.log(loginUser !== null);//t//t
			console.log(!loginUser);//f//f
			console.log(loginUser != null);//t//t
			console.log(loginUser === "");//f//f
			console.log(loginUser.lenght === 0);//f/f
			--%>
			
			//스트릿태그에서 선언한 자바변수를 자바스트립트 if문에서 비교할 수 없는 건가? 
			
		<%	if(loginUser != null){%>	
		var tgbNo = "<%=t.getTgbNo()%>";
			
				console.log("tgbNO :"+tgbNo);

			
			if($('#wish').val() === 'false'){//안찜한 거였으면
				
				$.ajax({
					url:"wish.do",
					data : {
						
						tgbNo : tgbNo
					},
					type : "post",
					success : function(result){
						console.log("찜 결과 :"+result)
						if(result){
						$('#wish').children('img').attr("src", "<%=contextPath%>/assets/TgbAssets/dib.png");
						$('#wish').val('true');
							alert("찜한 내역에 저장되었습니다.");
						}else{
							alert("실패");
						}
					},
					error : function(){
						
					}
				});
				}else if($('#wish').val() === 'true'){//찜한거였으면
					$.ajax({
						url:"deleteWish.do",
						data : {
							
							tgbNo : tgbNo
						},
						type : "post",
						success : function(result){
							console.log("찜 결과 :"+result);
							if(result){
							$('#wish').children('img').attr("src", "<%=contextPath%>/assets/TgbAssets/undib.png");
							$('#wish').val('false');
								alert("찜한 내역에서 삭제되었습니다.");
							}else{
								alert("실패");
							}
						},
						error : function(){
							
						}
					});
		
				}
				
		<%	}else{%>
				var a = confirm("로그인을 해야 합니다. 로그인창으로 이동하시겠습니까?");
				
				if(a){
					location.href="<%=contextPath%>/login.do";
				}
				
				
			<%}%>
		
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

		    
		    function reportTgb(){
			 if(${loginUser == null}){
				 alert("로그인 한 유저만 신고할 수 있습니다.")
				 return false;
			 }
			 location.href = "<%=request.getContextPath()%>/reportTgbForm.do?bno=${t.tgbNo}";
		 }
		 
		 
		 function participation(){
			 if(${loginUser == null}){
				 var a = confirm("로그인을 해야 합니다. 로그인창으로 이동하시겠습니까?");
					
					if(a){
						location.href="<%=contextPath%>/login.do";
					}
			 }else{
				 location.href="<%=contextPath%>/tgbEnter.do?tno=${t.tgbNo}";
				 
			 }
		 }
	</script>
	
</div>
</body>
</html>