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
   .center {position: absolute; top: 87%; left:50%; margin: -50px 0 0 -50px;}
   .me{
   width: 250px;
   height: 250px;
	position: absolute; top: 60%; left:47%; margin: -50px 0 0 -50px;
   }
</style>
</head>
<body>

   
   <p class="type_text" style="text-align:center; margin-top:180px; color:#d5d4f7; font-size:18pt"></p>
   <div><img class="me" src="assets/img/ohsun.png" alt="오선님"></div>
   
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
         var str1 = ["프로젝트를 하면서 api나 채팅같이 새로운 것을 구현할 때의 재미를 알게 됐고"];
         var str2 = ["ui까지 입혀 사용자에게 보일 부분을 신경 쓰는 것이 얼마나 어려운지,"];
         var str3 = ["DB나 코드를 고치다 보니 설계 단계가 얼마나 중요한지 등을 느꼈습니다. "];
         var str4 = ["아쉬운 점도 있었는데 먼저 ajax 관련 실력의 부족을 느껴 공부가 필요하다고 생각했고, "];
         var str5 = ["기능을 만들다 보니 얕게 많이 만든 느낌인데 다음에는 더 적은 기능이더라도 디테일하고 깊게 들어가 보고 싶습니다."];
         var str6 = ["그래도 이번에 깃허브도 많이 사용하면서 조금은 익숙해진 것 같아 다행이고"];
         var str7 = ["에러가 나거나 막히는 부분이 있을 때 팀원들이 고맙게도 도움을 많이 줘서 협업의 능률을 체감했던 것 같습니다."];
         
         
         
          $('.type_text').typeIt({
               strings: [str1,str2,str3,str4,str5,str6,str7],
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