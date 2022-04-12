<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="resources/bootstrap/css/bootstrap.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="css/chat.css" rel="stylesheet" />
<script src="resources/bootstrap/js/bootstrap.js"></script>
<title>Insert title here</title>

</head>
<body>
	<div class="container bootstrap snippets">
	    <div class="row">
	        <div class="col-md-4 col-md-offset-4">
	            <div class="portlet portlet-default">
	                <div class="portlet-heading">
	                    <div class="portlet-title">
	                        <h4><i class="fa fa-circle text-green"></i>채팅</h4>
	                    </div>
	                    <div class="portlet-widgets">
							<c:if test="${loginUser.userId eq t.tgbWriter}">                   
	                        <div class="btn-group">
	                            <button type="button" class="btn btn-white dropdown-toggle btn-xs" data-toggle="dropdown">
	                                <i class="fa fa-circle text-green"></i> 참여자
	                                <span class="caret"></span>
	                            </button>
	                            <ul class="dropdown-menu" role="menu">
	                            	<c:forEach var="b" items="${buyer}">
		                            	<li><a href="#"><i class="fa fa-circle text-green"></i>${buyer.userId}</a>
		                                </li>
	                            	</c:forEach>
	                            </ul>
	                        </div>
	                        </c:if> 
	                        
	                        <span class="divider"></span>
	                        <a data-toggle="collapse" data-parent="#accordion" href="#chat"><i class="fa fa-chevron-down"></i></a>
	                    </div>
	                    <div class="clearfix"></div>
	                </div>
	                <div id="chat" class="panel-collapse collapse in">
	                    <div>
	                    <div class="portlet-body chat-widget" id="chatList" style="overflow-y: auto; width: auto; height: 300px;">
	                      
	                     
	                       
	                    </div>
	                    </div>
	                    <div class="portlet-footer">
	                        <form role="form">
	                            <div class="form-group">
	                                <textarea class="form-control" id="chatContent" style="resize: none;" placeholder="채팅 입력..." maxlength="100"></textarea>
	                            </div>
	                            <div class="form-group">
	                                <button type="button" class="btn btn-default pull-right" onclick="chatSubmit()">전송</button>
	                                <div class="clearfix"></div>
	                            </div>
	                        </form>
	                    </div>
	                </div>
	            </div>
	        </div>
	        <!-- /.col-md-4 -->
	    </div>
	</div>
<button type="button" class="btn btn-default pull-right" onclick="chatList('today');">추가</button>   
</body>
<script type="text/javascript">
	function chatSubmit() {
		var fromId = '${loginUser.userId}';
		var toId = '';
		if (${loginUser.userId eq t.tgbWriter}){
			toId = 'user02'//드롭다운으로 선택한 유저로 바꿔야함
		}else{
			toId = '${t.tgbWriter}'
		}
		var chatContent = $("#chatContent").val();

		$.ajax({
			type : "POST",
			url : "${contextPath}/chatSubmit.do",
			data : {
				fromId : encodeURIComponent(fromId),
				toId : encodeURIComponent(toId),
				chatContent : encodeURIComponent(chatContent),
			},
			success : function(result) {
				if (result == 1) {
					console.log('채팅 보내졌는지 확인')
					chatList('ten')
				}
			}
		});
		$("#chatContent").val('');
	}
	var lastId = 0;
	function chatList(type) {
		console.log(type)
		var fromId = '${loginUser.userId}';
		var toId = 'user02';
		$.ajax({
			type : "POST",
			url : "${contextPath}/chatList.do",
			data : {
				fromId : fromId,
				toId : toId,
				listType : type
			},
			success : function(data) {
				console.log(data)
				if (data == "")
					return;
				$.each(data, function(i) {
					addChat(data[i].fromId, data[i].chatContent, data[i].chatTime);
					if (data.length - 1 == i) {
						lastId = Number(data[i].chatId)
					}
				})
				console.log(lastId)
			}
		})

	}
	function addChat(chatName, chatContent, chatTime) {

		$("#chatList").append('<div class="row">'
								+ '<div class="col-lg-12">'
								+ '<div class="meidia">'
								+'<a class="pull-left" href="#">'
								+'<img class="media-object img-circle" style="width:30px; height:30px" src="assets/img/chat.jpg" alt="">'
								+'</a>'
								+'<div class="media-body">'
								+'<h4 class="media-heading">'
								+ chatName
								+ '<span class="small pull-right">'
								+ chatTime
								+ '</span>'
								+ '</h4>'
								+ '<p>'
								+ chatContent
								+ '</p>'
								+ '</div>'
								+ '</div>'
								+ '</div>'
								+ '</div>'
								+ '<hr>');
		console.log($("chatList").height())

		$("#chatList").scrollTop($("chatList").height());
	}
	
	function getInfiniteChat(){
		setInterval(function(){
			chatList(lastId);
		}, 3000);
	}
	
	$(document).ready(function(){
		chatList('ten');
		getInfiniteChat();
	})
</script>
</html>