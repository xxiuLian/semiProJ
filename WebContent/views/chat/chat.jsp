<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="resources/bootstrap/css/bootstrap.css">
<link href="css/chat.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="resources/bootstrap/js/bootstrap.js"></script>
<title>채팅</title>
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
	                            <div class="mb-3">
									<select name="buyer" id="buyer" style="color:black;"onchange="changeUser()">
										<option value="000">참여자 선택</option>
										<c:forEach var="b" items="${buyer}">
			                           	 	<option value="${b}">${b}</option>
		                            	</c:forEach>
									</select>
								</div>
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
</body>
<script type="text/javascript">
	var toId = ''; //보낼사람 빈값으로 초기화
	var lastNo = 0;//마지막 채팅번호
	$("#buyer").change(function(){//공구진행자가 참여자를 고르면
		toId = $("option:selected").val();//보낼사람에 선택한 유저를 담아준다
		$("#chatList").html('');//다른 유저를 골랐으니 기존 채팅은 지워줌
		//console.log('바꾼 사람 ' + toId)
	})
	
	function changeUser(){// 그냥 onchange에 chagList('ten')을 할당하면 
		setTimeout(function(){//ajax가 onchage메소드보다 빨리 실행되어 채팅내역이 꼬이게된다
			chatList('ten'); //바뀐 유저니까 새로 10개의 리스트 받아옴
		}, 300);//따라서 0.3초후(toId가 바뀐 select옵션으로 바뀐뒤)에 chatList를 다시 불러와준다
	
	}
	
	
	function chatList(type) {
		var fromId = '${loginUser.userId}'; //보내는사람은 항상 현재 로그인된 유저
		if (${loginUser.userId != t.tgbWriter}){ //만약 공구 작성자가 아니면(참여자)
			toId = '${t.tgbWriter}'	//무조건 공구 작성자에게 채팅보내기
		}
		
		var chatContent = $("#chatContent").val();
		//console.log('타입 ' + type)
		//console.log('보내는 사람 ' + fromId)
		//console.log('받는사람 ' + toId)
		$.ajax({
			type : "POST",
			url : "${contextPath}/chatList.do",
			data : {
				fromId : fromId,
				toId : toId,
				listType : type
			},
			success : function(data) {
				//console.log(data)
				$.each(data, function(i) {
					addChat(data[i].fromId, data[i].chatContent, data[i].chatTime);//받아온 댓글을 화면부에 넣는 메소드
					if (data.length - 1 == i) {
						lastNo = Number(data[i].chatId)//마지막 채팅번호를 담아준다(갱신용)
					}
				})
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
		$("#chatList").scrollTop($("#chatList")[0].scrollHeight)//추가될때마다 스크롤 가장 아래로 내리기
	}
	
	function getInfiniteChat(){//상대방이 보낸 메세지 3초마다 갱신
		setInterval(function(){
			chatList(lastNo);//가장 마지막 채팅번호를 매개변수로 보냄
		}, 3000);
	}
	
	$(document).ready(function(){//처음 열리면 상위 10개만 불러올것
		chatList('ten');
		getInfiniteChat();//무한갱신 메소드
	})
	
	
	
	function chatSubmit() {
		var fromId = '${loginUser.userId}';
		if (${loginUser.userId != t.tgbWriter}){//진행자가 아니면(참여자면)
			toId = '${t.tgbWriter}'//보내는사람이 진행자로 고정
		}
		//console.log('보내는 사람 ' + fromId)
		//console.log('받는사람 ' + toId)
		var chatContent = $("#chatContent").val();

		$.ajax({
			type : "POST",
			url : "${contextPath}/chatSubmit.do",
			data : {
				fromId : fromId,
				toId : toId,
				chatContent : chatContent,
			},
			success : function(result) {
				//console.log('전송성공')
			},
			error:function(e){
				alert("채팅 전송 실패")
			}
		});
		$("#chatContent").val('');//전송뒤엔 실패하든 성공하든 작성된 채팅박스의 내용삭제
	}
	
</script>
</html>