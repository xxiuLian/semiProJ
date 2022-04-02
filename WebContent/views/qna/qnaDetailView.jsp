<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR" import="com.uni.qna.model.dto.*, com.uni.common.Attachment"%>
<%
	Qna q = (Qna)request.getAttribute("q");
	//Attachment at = (Attachment)request.getAttribute("at");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../common/menubar.jsp" %>
	
	<div class="outer">
		<br>
		
		<h2 align="center">�Խ��� �󼼺���</h2>
		<br>
		
		<table align="center">
			<tr>
				<th width="100">�о�</th>
				<td><%= q.getCategory() %></td>
				<th>����</th>
				<td colspan="2"><%= q.getQnaTitle() %></td>
			</tr>
			<tr>
				<th>�ۼ���</th>
				<td><%= q.getQnaWriter() %></td><%-- 
				<th>��ȸ��</th>
				<td><%= b.getCount() %></td> --%>
				<th>�ۼ���</th>
				<td><%= q.getCreateDate() %></td>
			</tr>
			<tr>
				<th>����</th>
				<td colspan="3">
					<p><%= q.getQnaContent() %></p>
				</td>
			</tr>
			<%--
			<tr>
				<th>÷������</th>
				<td colspan="3">
					<% if(at != null){ %>
					<a download="<%= at.getOriginName() %>" href="<%=contextPath%>/resources/board_upfiles/<%=at.getChangeName()%>"><%= at.getOriginName() %></a>
					<% }else{ %>
					÷�������� �����ϴ�.
					<% } %>
				</td> 
			</tr> --%>
		</table>
		<br>
		
		<div class="btns" align="center">
			<button type="button" onclick="location.href='<%=contextPath%>/listBoard.do?currentPage=1';">�������</button>
			
			<% if(loginUser != null && loginUser.getUserId().equals(q.getQnaWriter())){ %>
				
				<button type="button" onclick="updateForm();">�����ϱ�</button>
				<button type="button" onclick="deleteBoard();">�����ϱ�</button>
			<% } %>
		</div>
		
		<form action="" id="postForm" method="post">
			<input type="hidden" name="bno" value="<%= q.getQnaNo() %>">
		</form>
		<script>
			function updateForm(){
				$("#postForm").attr("action", "<%=contextPath%>/updateFormBoard.do");
				$("#postForm").submit();
			}
			
			function deleteBoard(){
				$("#postForm").attr("action", "<%=contextPath%>/deleteBoard.do");
				$("#postForm").submit();
			}
		</script>
	</div>
	
	<div class="replyArea">
		<!-- ��� �ۼ��ϴ� div -->
		<table border="1" align="center">
			<tr>
				<th>����ۼ�</th>
				<%if(loginUser != null) {%>
				<% if(loginUser.getUserId().equals("admin")){ %>
				<td><textarea rows="3" cols="60" id="replyContent" style="resize:none;"></textarea></td>
				<td><button id="addReply">��۵��</button></td>
				<% } %>
				<% }else { %>
				<td><textarea readonly rows="3" cols="60" id="replyContent" style="resize:none;">�����ڸ� �ۼ� �����մϴ�.</textarea></td>
				<td><button disabled>��۵��</button></td>
				<% } %>
			</tr>
		</table>
		<!-- ��� ����Ʈ�� �����ִ� div -->
		<div id="replyListArea">
			<table id="replyList" border="1" align="center">
				<!-- <tr>
					<td width="100px">admin</td>
					<td width="330px">����ۼ�����</td>
					<td width="150px">2020�� 1�� 23��</td>
				</tr>
				<tr>
					<td width="100px">user01</td>
					<td width="330px">����ۼ�����</td>
					<td width="150px">2020�� 1�� 22��</td>
				</tr>
				<tr>
					<td width="100px">test01</td>
					<td width="330px">����ۼ�����</td>
					<td width="150px">2020�� 1�� 20��</td>
				</tr> -->
			</table>
		</div>
	</div>
	<script>
	$(function(){
		selectReplyList();
		$("#addReply").click(function(){
			var content = $("#replyContent").val();
			var qId = <%=q.getQnaNo()%>;
			
			
			$.ajax({
				url:"rinsert.do",
				type:"post",
				data:{
						content:content,
					    qId:qId
				},
				success:function(status){
					if(status =="success"){
						selectReplyList();
						$("#replyContent").val("");
					}
				},
				error:function(){
					console.log("ajax ��Ž��� -��۵��")
				}
				
			})
			
		})
		
	})
	function selectReplyList(){
			$("#replyList").empty();
			$.ajax({
				url:"rlist.do",
				data:{bId:<%=q.getQnaNo()%>},
				type:"get",
				success:function(list){
					console.log(list)
				/*	var value="";
					for(var i in list){
						value += '<tr>'+
									'<td width="100px">'+ list[i].replyWriter+'</td>'+ 
									'<td width="330px">'+ list[i].replyContent+'</td>'+ 
									'<td width="150px">'+ list[i].createDate+'</td>'+ 
								'</tr>';
					}
					$("#replyList").html(value);
					
					
					//2����� 
					var value="";
					$.each(list,function(index,obj){
						value += '<tr>'+
								'<td width="100px">'+ obj.replyWriter+'</td>'+ 
								'<td width="330px">'+ obj.replyContent+'</td>'+ 
								'<td width="150px">'+ obj.createDate+'</td>'+ 
						'</tr>';
					})
					$("#replyList").html(value);*/
					
					
					// 3�� ���
					$.each(list, function(index, obj){
						
						var writerTd = $("<td>").text(obj.replyWriter).attr("width", "100px");
						var contentTd = $("<td>").text(obj.replyContent).attr("width", "330px");
						var dateTd = $("<td>").text(obj.createDate).attr("width", "150px");
						
						var tr = $("<tr>").append(writerTd, contentTd, dateTd);
						
						$("#replyList").append(tr);
						
					});
				},
				error:function(){
					console.log("ajax ��Ž��� -�����ȸ")
				}
				
			})
		}
	</script>
</body>
</html>