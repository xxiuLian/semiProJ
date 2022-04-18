<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
   *{box-sizing:board-box;}
   .video-film {box-shadow: rgba(0, 7, 15, 0.7) 0 0 0 9999px; z-index: 100;}
   .video-background {
      background: #000; position: fixed;
      top: 0; right: 0; bottom: 0; left: 0; z-index: -99;
   }
   .video-foreground, .video-background iframe {
      position: absolute; top: 0; left: 0;
      width: 100%; height: 100%; pointer-events: none;
   }
   @media ( min-aspect-ratio : 16/9) {
      .video-foreground {height: 300%; top: -100%;}
   }
   @media ( max-aspect-ratio : 16/9) {
      .video-foreground {width: 300%; left: -100%;}
   }
   h1 {color: white;}
   #visual-btn {
      z-index: 50; color: #fff; font-size: 20px; border: 2px solid #fff;
      padding: 12px 24px; border-radius: 5px; cursor: pointer; background-color: rgba(0, 0, 0, 0);
   }
   #visual-btn:hover {
      color: #ff6868; font-size: 20px; border: 2px solid #ff6868;
      padding: 12px 24px; border-radius: 5px; cursor: pointer;
   }
   #indexBtn {position: fixed; text-align: center}
   .center {position: absolute; top: 85%; left:50%; margin: -50px 0 0 -50px;}
   .me{
   width: 250px;
   height: 250px;
	position: absolute; top: 60%; left:47%; margin: -50px 0 0 -50px;
   }
</style>
</head>
<body>

   
   <p class="type_text" style="text-align:center; margin-top:180px; color:#d5d4f7; font-size:18pt"></p>
   <div><img class="me" src="assets/img/seoyoung.png" alt="서영님"></div>
   
   <div id="indexBtn" class="center">
      <button id="visual-btn" onclick="location.href='<%=request.getContextPath() %>'">목록으로!</button>
   </div>
   
   <div class="video-background">
      <div class="video-foreground">
         <div id="muteYouTubeVideoPlayer"></div>
      </div>
   </div>
   
   <div class="video-film"></div>
   
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
      <script  src="https://cdn.jsdelivr.net/jquery.typeit/4.4.0/typeit.min.js"></script>
   
   <script>
      $(function(){
         var str1 = ["이정도 규모의 프로그램을 만드는 것은 처음이다 보니 설계할 때부터 많이 허둥지둥했던 것 같습니다. "];
         var str2 = ["머릿속에 그린 그림과 달리 구체화하는 과정에서 부족한 점들이 생겨 아쉬움도 많았습니다.  "];
         var str3 = ["그래도 팀원들과 함께 이만큼 만들어 낸 결과물을 보니 한편으론 뿌듯하기도 합니다. "];
         var str4 = ["많은 걸 배울 수 있었던 프로젝트였고 이번에 배운 것을 바탕으로 나중엔 더 완성도가 높은 프로그램을 만들어 보고 싶습니다. "];
         
         
          $('.type_text').typeIt({
               strings: [str1,str2,str3,str4],
               speed: 90,
               autoStart: true
               //loop:true
               });
          
      });
   </script>
   

   
   <script defer src="https://www.youtube.com/iframe_api"></script>
   <script type="text/javascript">
      var player;
      
      function onYouTubePlayerAPIReady(){
         player = new YT.Player('muteYouTubeVideoPlayer', {
            videoId : '7fy1eFEkrpU',
            playerVars : {
               autoplay : 1,       // Auto-play the video on load // 자동 재생 (유)
               controls : 0,       // Show pause/play buttons in player // 컨트롤러의 유무 (무)
               rel : 0,         // 해당 영상이 종료된 후 관련 동영상 표시할지
               start : 105,
               end : 301,
               showinfo : 0,       // Hide the video title // 재생 영상에 대한 정보 유무
               modestbranding : 1, // Hide the Youtube Logo
               loop : 1,          // Run the video in a loop // 반복 재생에 대한 여부
               playlist : '7fy1eFEkrpU',
               fs : 0,          // Hide the full screen button
               cc_load_policy : 0, // Hide closed captions
               iv_load_policy : 3, // Hide the Video Annotations
               autohide : 1      // Hide video controls when playing
            },
            events:{
               onReady:function(e){
                  e.target.mute();
               }
            }
         });
      }
   </script>
   
   
</body>
</html>