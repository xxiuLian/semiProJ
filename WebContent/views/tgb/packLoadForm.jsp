<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
console.log("${sTag}")
var sTag = "${sTag}";
var msg = "${msg}";
	if(sTag == 'Y'){
		alert(msg);
		$(opener.document).find('#packAPI').attr("src", "https://tracker.delivery/#/${com}/${num}");
		$(opener.document).find('#packAPI').attr("hidden", false);
		$(opener.document).find('#noloaded').hide();
		window.close() 

	}

	
</script>
</head>
<body>
<form action="<%=request.getContextPath() %>/packLoad.do" method="post">
	<table>
		<tr>
			<td><input type="text" name="tno" value="${tno}" hidden></td>
		</tr>
		<tr>
			<td><label>현재 비밀번호</label>
			<td>
				<select name="company">
					<option value="kr.cjlogistics">CJ 대한통운</option>
					<option value="kr.epost">우체국 택배</option>
					<option value="kr.hanjin">한진 택배</option>
				</select>
			</td>
		</tr>
		<tr>
			<td><label>송장 번호</label></td>
			<td><input type="text" name="number"></td>
		</tr>
		
	</table>
	
<button>등록하기</button>
</form>
	


</body>
</html>