<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.uni.tgb.model.dto.*, java.util.ArrayList, com.uni.common.Attachment"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%
 	Tgb t = (Tgb)request.getAttribute("t");
 	ArrayList<Attachment> alist = (ArrayList<Attachment>)request.getAttribute("aList");
 	boolean wish = (boolean)request.getAttribute("wish");
	String admin = (String)request.getAttribute("admin");	
 	ArrayList<Member> listMem = (ArrayList<Member>)request.getAttribute("listMem");
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="css/styles.css" rel="stylesheet" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
 <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
<style>
td{
	height: 50px;
	text-align: left;
}
.tdfirst{
	width: 100px;
	border-right: 0.5px solid rgb(170, 170, 170);
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: bold;
	text-align: right;
	padding-right: 20px;
}
.tdsecond{
  padding-left: 10px;
  font-family: "Montserrat", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
  font-size: 0.95rem;
  color: #495057;
  letter-spacing: 0.0625em;
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
	height: 300px;
	width: 300px;
	border: 1px solid rgb(223, 220, 220);
	border-radius: 7px;
	overflow:hidden;
	margin : 0 auto;
	
	float : left;
	color: rgb(128, 128, 128);
	display: flex;
    align-items: center;
    margin-top:30px;
	
}
/*#titleImg img{
	position:absolute;
	top: 0;
	left: 0;
	width:100%;
	height: 100%;
}*/
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
	border: 0px solid white;
	border-top-right-radius: 5px;
	border-top-left-radius: 5px;
	width: 80px;
	height: 40px;
	font-weight: bold;
}
#gidbtn{
	background-color: rgb(190, 190, 190);
	color: rgb(241, 241, 241);
	border: 0px solid white;
	border-top-right-radius: 5px;
	border-top-left-radius: 5px;
	width: 80px;
	height: 40px;
	font-weight: bold;
}
#contentArea{
	border-radius:5px;
	border: 1px solid grey;
}
#guidArea{
	border-radius:5px;
	border: 1px solid grey;
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
	margin-left:-100px;
	
}
#wish>img{
	width:30px;
	height:30px;
	margin-right:20px;
}
#ptici{
  	font-family: "Montserrat", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
	  font-size: 0.95rem;
  	color: #495057;
  	letter-spacing: 0.0625em;
	background-color: rgb(11, 100, 159);
	border-radius: 7px;
	border: 1px solid rgb(255, 255, 255);
	color: white;
	margin-top: 30px;
	width: 130px;
	height: 60px;
}
.bottombtns{
  	font-family: "Montserrat", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
	  font-size: 0.95rem;
  	color: #495057;
  	letter-spacing: 0.0625em;
	background-color: rgb(11, 100, 159);
	border-radius: 7px;
	border: 1px solid rgb(255, 255, 255);
	color: white;
	margin-top: 30px;
	width: 120px;
	height: 40px;
}
#delete{
	background-color: #c2c3c4;
}
#sos{
	width: 80px;
	height: 30px;
	background-color: #c2c3c4;
	margin-left:-25px;
	margin-top: 10px;
}
</style>
</head>
<body>
<%if(admin == null){ %>
		 <%@ include file="../../views/common/menubar.jsp" %>
	<%}%>
<div class="outer">
	<br>
	<h2 align="center">공구 등록 글 상세 보기</h2>
	<hr>
	<input type="hidden">
	<div id="titleImg"><img id="thumb" src="${contextPath}/assets/img_upfile/<%=alist.get(0).getChangeName()%>"></div>
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
		<%if(admin == null){ %>
		<button type="button" id="wish" value=""><img src="${contextPath}/assets/TgbAssets/undib.png"></button>
		<button type="button" id="ptici" onclick="participation();">참여하기</button><br>
		<button type="button" class="bottombtns" id="sos" onclick="reportTgb();">신 고</button>
		<%}%>
	</div>
	<div class="btns"><button type="button" id="ctnbtn" disabled>Content</button><button type="button" id="gidbtn">Guide</button></div>
	<div id="contentArea" class="textarea" ><%=t.getTgbContent() %></div>
   	<div id="guidArea" class="textarea" hidden><%=t.getTgbGuide() %></div>
	

	<%//if(loginUser != null && loginUser.getUserId().equals(t.getTgbWriter())){ %><!-- 아이디를 갖고 오자 -->
	<c:if test="${loginUser.userId eq t.tgbWriter}">
	<button type="button" class="bottombtns" onclick="tgbUpdateForm(<%= t.getTgbNo()%>)">수정하기</button>
	<button type="button" class="bottombtns" id="delete" onclick= "tgbDelete(<%= t.getTgbNo()%>)">삭제하기</button>
	</c:if>
	<%//} %>
	<%if(admin == null){ %><button type="button" class="bottombtns" onclick="history.back();">목록으로</button>	<%}%>
	
	
	<script>
	
		$(document).ready(function(){
			
			//console.log('되냐');
			
			var num= 0;
			
			<%for(int i = 1; i < alist.size() ;i++){%>//content 본문에 이미지 추가
				
				$('#contentArea').children('img').eq(num).attr("src","<%=request.getContextPath()%>/assets/img_upfile/<%=alist.get(i).getChangeName()%>");
			num++;
			<%};%>
			
			<%if(wish){%>
			$('#wish').children('img').attr("src", "${contextPath}/assets/TgbAssets/dib.jpg");
			$('#wish').val('true');// 찜한 내역이면 TRUE
			<%}else{%>
			$('#wish').val('false');
			<%}%>
		});
		
		
		$('#wish').click(function(){
			var loginUser = "${loginUser}";
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
			
		<%	//if(loginUser != null){%>
		if(${loginUser != null}){
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
						$('#wish').children('img').attr("src", "${contextPath}/assets/TgbAssets/dib.jpg");
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
							$('#wish').children('img').attr("src", "${contextPath}/assets/TgbAssets/undib.png");
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
			
			}else{
		<%	//}else{%>
				var a = confirm("로그인을 해야 합니다. 로그인창으로 이동하시겠습니까?");
				
				if(a){
					location.href="${contextPath}/login.do";
				}
				
				}	
			<%//}%>
				
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
						location.href="${contextPath}/login.do";
					}
			 }else{
				 location.href="${contextPath}/tgbEnter.do?tmenu=1&tno=${t.tgbNo}";
				 
			 }
		 }
	</script>
	
</div>
</body>
</html>