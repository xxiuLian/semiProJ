<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
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
		
		<h2 align="center">���ǰԽ��� �ۼ��ϱ�</h2>
		<br>
		
		<form id="insertForm" action="<%= contextPath %>/insertQna.do" method="post" enctype="multipart/form-data">
			<table align="center">
				<tr>
					<th width="100">�о�</th>
					<td width="500">
						<select name="category">
							<option value="10">����</option>
							<option value="20">�</option>
							<option value="30">���</option>
							<option value="40">����</option>
							<option value="50">����</option>
							<option value="60">�丮</option>
							<option value="70">��Ÿ</option> 
						</select>
					</td>
				</tr>
				<tr>
					<th>����</th>
					<td><input type="text" name="title"></td>
				</tr>
				<tr>
					<th>����</th>
					<td>
						<textarea rows="15" name="content" style="resize:none;"></textarea>
					</td>
				</tr>
				<tr>
					<th>÷������</th>
					<td><input type="file" name="upfile"></td>
				</tr>
			</table>
			<br>
			
			<div class="btns" align="center">
				<button type="reset">����ϱ�</button>
				<button type="submit">����ϱ�</button>
			</div>
		</form>
	</div>
</body>
</html>