<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="css/styles.css" rel="stylesheet"/>
<link href="css/chat.css" rel="stylesheet"/>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />
<title>Insert title here</title>

</head>
<body>
<div class="container bootstrap snippet">	
<div class="row">
    <div class="col-xs-12">
        <div class="card chat-app">
            <div id="plist" class="people-list ">
                <div class="input-group">
                <input type="text" class="form-control" placeholder="검색...">
                    <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fa fa-search"></i></span>
                    </div>
                </div>
                <ul class="list-unstyled chat-list mt-2 mb-0">
                    <li class="clearfix">
                        <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="avatar">
                        <div class="about">
                            <div class="name">곽트</div>
                            <div class="status"> <i class="fa fa-circle offline"></i> left 7 mins ago </div>                                            
                        </div>
                    </li>
                    <li class="clearfix active">
                        <img src="https://bootdey.com/img/Content/avatar/avatar2.png" alt="avatar">
                        <div class="about">
                            <div class="name">Aiden Chavez</div>
                            <div class="status"> <i class="fa fa-circle online"></i> online </div>
                        </div>
                    </li>
                    <li class="clearfix">
                        <img src="https://bootdey.com/img/Content/avatar/avatar3.png" alt="avatar">
                        <div class="about">
                            <div class="name">Mike Thomas</div>
                            <div class="status"> <i class="fa fa-circle online"></i> online </div>
                        </div>
                    </li>                                    
                    <li class="clearfix">
                        <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="avatar">
                        <div class="about">
                            <div class="name">Christian Kelly</div>
                            <div class="status"> <i class="fa fa-circle offline"></i> left 10 hours ago </div>
                        </div>
                    </li>
                    <li class="clearfix">
                        <img src="https://bootdey.com/img/Content/avatar/avatar8.png" alt="avatar">
                        <div class="about">
                            <div class="name">Monica Ward</div>
                            <div class="status"> <i class="fa fa-circle online"></i> online </div>
                        </div>
                    </li>
                    <li class="clearfix">
                        <img src="https://bootdey.com/img/Content/avatar/avatar3.png" alt="avatar">
                        <div class="about">
                            <div class="name">Dean Henry</div>
                            <div class="status"> <i class="fa fa-circle offline"></i> offline since Oct 28 </div>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="chat" class="parlet-body chat-widget" style="overflow-y:auto; width:auto; height:600px;">
                <div class="chat-header clearfix">
                    <div class="row">
                        <div class="col-sm-2">
                            <a href="javascript:void(0);" data-toggle="modal" data-target="#view_info">
                                <img src="https://bootdey.com/img/Content/avatar/avatar2.png" alt="avatar">
                            </a>
                            <div class="chat-about">
                                <h6 class="m-b-1">곽트</h6>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="chat-history">
                    <ul class="m-b-0">
                        <li class="clearfix">
                            <div class="message-data text-right">
                                <span class="message-data-time">10:10 AM, Today</span>
                                <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="avatar">
                            </div>
                            <div class="message other-message float-right"> Hi Aiden, how are you? How is the project coming along? </div>
                        </li>
                        <li class="clearfix">
                            <div class="message-data">
                                <span class="message-data-time">10:12 AM, Today</span>
                            </div>
                            <div class="message my-message">Are we meeting today?</div>                                    
                        </li>                               
                        <li class="clearfix">
                            <div class="message-data">
                                <span class="message-data-time">10:15 AM, Today</span>
                            </div>
                            <div class="message my-message">Project has been already finished and I have results to show you.</div>
                        </li>
                    </ul>
                </div>
                <div class="chat-message clearfix">
                    <div class="input-group mb-0">
                        <textarea id="chatContent" class="form-control" style="resize: none;" placeholder="메시지를 입력하세요..." maxlength="100"></textarea>    
                        <div class="input-group-prepend">
                            <span class="input-group-text" onclick="chatSubmit();"><i class="fa fa-send"></i></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>

</body>
<script type="text/javascript">
	function autoClosingAlert(selector, delay){
		var alert = $(selector).alert();
		alert.show();
		window.setTimeout(function() {alert.hide() }, delay);
	}
	function chatSubmit(){
		var fromId = ${loginUser.userId}
		var toId;
		var chatContent = $("#chatContent").val();
		
		$.ajax({
			type:"POST",
			url: "${contextPath}/chatSubmit.do",
			data: {
				fromId: encodeURIComponent(fromId),
				toId: encodeURIComponent(toId),
				chatContent: encodeURIComponent(chatContent),
			},
			success: function(result){
				if(result == 1){
					autoClosingAlert("#successMessage", 2000);
				}else if(result == empty){
					autoClosingAlert("#dangerMessage", 2000);
				}else{
					autoClosingAlert("#warningMessage", 2000);
				}
			}
		});
		$("#chatContent").val('');
	}
</script>
</html>