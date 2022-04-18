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
   <div><img class="me" src="assets/img/sooyeon.png" alt="수연"></div>
   
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
         var str1 = ["세미 프로젝트를 진행하면서 수업 때 배운 개념들의 이해가 확실해졌고 활용하면서 사고가 좀 더 넓어진 것 같습니다!"];
         var str2 = ["저는 꼭 안보이는 오타는 죽어도 안보이는 편이라 팀원들과 공유하면서 실수를 캐치하고 약점을 보완할 수 있었습니다. "];
         var str3 = ["팀원들의 비상한 머리와 열정으로 오류를 잡아 해결해나가는 과정도 배울 수 있었습니다. 아직 나는 멀었고 배울 것은 무진장 많다는 것을 깨달았습니다. "];
         var str4 = ["다음에 시도하고 싶은 기능들을 위해 또 많이 배워야겠다는 다짐 합니다."];
         var str5 = ["스터디와 프로젝트 기간동안 부족한 팀장 알려주시고 서포트하느라 고생하신 팀원들 너무 감사합니다!!!!!"];
         var str6 = ["재욱님이 결제하신걸로 같이 카페 데이트해요!!!♡"];
         var str7 = ["디스코드가 넘 그리울거에요 남은 정처기도 홧띵입니다(๑•̀ㅅ•́)و✧"];         
         
         
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