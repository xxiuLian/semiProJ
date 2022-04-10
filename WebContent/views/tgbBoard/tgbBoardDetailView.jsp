<%@ page import="com.uni.tgb_board.model.dto.TgbBoard_dto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="com.uni.tgb_board.model.dto.*, com.uni.common.Attachment" %>
<%@page import="com.uni.member.model.dto.Member" %>
<% String contextPath = request.getContextPath();
	Member loginUser = (Member)session.getAttribute("loginUser");
%>
<%
	TgbBoard_dto b = (TgbBoard_dto)request.getAttribute("b");
	Attachment at = (Attachment)request.getAttribute("at");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
	.replyArea{
		width:800px;
		color:white;
		background:black;
		margin:auto;
	}
</style>
</head>
<body>
	
	<%= b.getTgbBoardTitle() %>
	<%= b.getTgbBoardContent() %>
 	<%= b.getTgbBoardCategory() %>

 	<table>
 		<th>첨부파일3</th>
		<td>
			<% if(at != null){ %>
				<a download="<%= at.getOriginName() %>" href="<%=request.getContextPath()%>/assets/tgbBoard_upfiles/<%=at.getChangeName()%>"><%= at.getOriginName() %></a>
			<% }else{ %>
				첨부파일이 없습니다.
			<% } %>
		</td>
 	</table>
 	
	<div class="btns" align="center">
	<% if(loginUser != null && loginUser.getUserId().equals(b.getTgbBoardWriter())){ %>
		<button type="button" onclick="updateForm();">수정하기</button>
		<button type="button" onclick="deleteTgb();">삭제하기</button>
	<% } %>
		<button type="button" onclick="location.href='<%=request.getContextPath()%>/tgbBoardSelect.do'">목록으로</button>
	</div>
	
	<form action="" id="postForm" method="post">
		<input type="hidden" name="bno" value="<%= b.getTgbBoardNo() %>">
	</form>
		
	<script>
		function updateForm(){
			$("#postForm").attr("action", "<%=request.getContextPath()%>/tgbBoardUpdateForm.do");
			$("#postForm").submit();
		}
		
		function deleteTgb(){
			$("#postForm").attr("action", "<%=request.getContextPath()%>/tgbBoardDelete.do");
			$("#postForm").submit();
		}

	</script>
	
	<!-- 댓글창 -->
	<div class="replyArea">
		<table border="1" >
			<tr>
				<th>댓글작성</th>
				<% if(loginUser != null){ %>
				<td><textarea rows="3" cols="60" id="replyContent" style="resize:none;"></textarea></td>
				<td><button id="addReply">댓글등록</button></td>
				<% }else{ %>
				<td><textarea readonly rows="3" cols="60" id="replyContent" style="resize:none;">로그인한 사용자만 가능한 서비스입니다. 로그인 후 이용해주세요</textarea></td>
				<td><button disabled>댓글등록</button></td>
				 <% } %>
			</tr>
		</table>
		
		<!-- 댓글 리스트 -->
		<div id="replyListArea">
			<table id="replyList" border="1" align="center">
			</table>
		</div>
		
	</div>
	
	<script type="text/javascript">
	
	//댓조회
	function selectReplyList(){
		
			$("#replyList").empty();
			
			$.ajax({
				url:"rTgbBoardList.do",
				data:{bno:<%=b.getTgbBoardNo()%>},
				type:"get",
				success:function(list){
						console.log(list)
					/*
					$.each(list, function(index, obj){
						
						var writerTd = $("<td>").text(obj.replyWriter).attr("width", "100px");
						var contentTd = $("<td>").text(obj.replyContent).attr("width", "330px");
						var dateTd = $("<td>").text(obj.createDate).attr("width", "150px");
						//var dateTd2 = $("<td onclick='fdelete(index)';>").text("삭제").attr("width", "150px");
						var tr = $("<tr>").append(writerTd, contentTd, dateTd);
						$("#replyList").append(tr);
						
					});
					*/
				
					/*
						var value="";
						for(var i in list){
							value += '<tr>'+
										'<td width="100px">'+ list[i].replyWriter+'</td>'+ 
										'<td width="330px">'+ list[i].replyContent+'</td>'+ 
										'<td width="150px">'+ list[i].createDate+'</td>'+ 
										'<td width="150px" fdelete(i)> 삭제 </td>'+
									'</tr>';
						}
						$("#replyList").html(value);
					*/
					
					
		
				},
				error:function(){
					console.log("ajax 통신실패 -댓글조회")
				}
			
		})
	}
	
	//댓등록
	$(function(){
		selectReplyList();
		$("#addReply").click(function(){
			var content = $("#replyContent").val();
			var bno = <%= b.getTgbBoardNo() %>;
			
			$.ajax({
				url:"rTgbBoardInsert.do",
				type:"post",
				data:{
						content : content,
						bno : bno
				},
				success:function(status){
					if(status =="success"){
						selectReplyList();
						$("#replyContent").val("");
					}
				},
				error:function(){
					console.log("ajax 통신실패 -댓글등록")
				}
				
			})
		})
	})
	</script>
	<script>
	/*
	function fdelete(e){
		alert("댓글 삭제 되었습니다 : " + e)
		$("td:eq(0)").css({"background":"black","color":"red"})
	}
	*/
	
	//$(function(){
		//$(".listArea>tbody>tr").click(function(){
		//	var bno = $(this).children().eq(0).text();
		//	location.href = "<%=request.getContextPath()%>/detailBoard.do?bno="+bno;
	//	})
//	})
	
	</script>
</body>
</html>