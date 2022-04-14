<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.uni.tgb.model.dto.*, com.uni.common.*"%>
<%
   ArrayList<Tgb> bestItem =(ArrayList<Tgb>)request.getAttribute("bestItem");
   ArrayList<Tgb> newItem =(ArrayList<Tgb>)request.getAttribute("newItem");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Agency - Start Bootstrap Theme</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <style>
        #popups {
          display: none;
          position: fixed; 
          left: 0; right: 0; top: 0; bottom: 0;
          background: rgba(0,0,0,0.5); z-index:1;
      }
      .modals {
         margin-top:140px;
         margin-left:600px;
          position: relative;
      }
      .close {
          position: absolute;
         margin-left:1020px; top:140px;
          color: #fff; border: none; 
          padding: 10px 20px;
      }
      
      #slider {
          width: 1600px;
          height: 700px; 
          margin: 0 auto;
          position: relative; 
          overflow: hidden;
      }
      .slide{ width: 4830px; position: absolute; left: 0px; top: 0; }
      .slide li { width: 1600px; float: left; }
      .slide li img { width: 100%;}

       </style>
    </head>      
    <body id="page-top">
    <!-- Navigation-->
    <%@ include file="views/common/menubar.jsp" %>
        <header>
            <div id="popups">
               <div class="modals" >
            <img alt="" src="https://cdn.imweb.me/upload/S20191226f354293cbbefc/7ff814128b9fa.png" width="500px" height="500px">
              </div>
              <div class="close"><button >X</button></div>
           </div> 
            <!-- 홈페이지 열리면 띄우는 팝업창 -->
           <script>
           window.onload=function(){ //팝업 오픈
              $("#popups").fadeIn();
           }
           $("#popups").click(function(){ //다른곳을 클릭하면 닫기
               $(this).fadeOut();
           })
           $(".close").click(function(){ //x버튼 눌러도 닫기
               $("#popups").fadeOut();
           })
           </script>
           
           
           <!--  setInterval을 통한 이벤트 배너 넘기기 -->
           <div id="slider">
               <ul class="slide">
                   <li><img src="assets/img/slide/slide1.jpg" alt="슬라이드1"></li>
                   <li><img src="assets/img/slide/slide2.jpg" alt="슬라이드2"></li>
                   <li><img src="assets/img/slide/slide3.jpg" alt="슬라이드3"></li>
               </ul>
           </div>
           <script type="text/javascript">
           let imgNum = $(".slide li").length;
           let imgWidth = $(".slide li").width();
           $(".slide").width( imgNum * imgWidth);
   
           setInterval(roll, 4000);
   
           function roll() { //imgwidth만큼 값을 빼줌 왜? 차례대로 이미지를 배치하기 위해
               $(".slide").animate({left:-imgWidth}, 1000, "swing", function(){
                   $(".slide li:nth-child(1)").appendTo(".slide")
                   $(".slide").css("left", 0)//0부터 다시 시작 appendTo로 다시붙임
               })
           }
           </script>
        </header>
        <!-- Portfolio Grid-->
        <section class="page-section bg-light" id="portfolio">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">Best 공동 구매</h2>
                    <h3 class="section-subheading text-muted">╰( ´•ω•)つ──☆ °.*•。♥ 오늘의 Best 아이템 •。♥</h3>
                </div>
                <div class="row">
                    <div class="col-lg-4 col-sm-6 mb-4">
                        <!-- Portfolio item 1-->
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-bs-toggle="modal" href="#portfolioModal1">
                                <div class="portfolio-hover">
                                    <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                                </div>
                                <img class="img-fluid" src="<%=contextPath %>/assets/img_upfile/<%=bestItem.get(0).getThumnail()%>" alt="..." />
                            </a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading"><%=bestItem.get(0).getTgbTitle() %></div>
                                <div class="portfolio-caption-subheading text-muted"><%=bestItem.get(0).getTgbTerm() %></div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-sm-6 mb-4">
                        <!-- Portfolio item 2-->
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-bs-toggle="modal" href="#portfolioModal2">
                                <div class="portfolio-hover">
                                    <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                                </div>
                                <img class="img-fluid" src="<%=contextPath %>/assets/img_upfile/<%=bestItem.get(1).getThumnail()%>"  alt="..." />
                            </a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading"><%=bestItem.get(1).getTgbTitle() %></div>
                                <div class="portfolio-caption-subheading text-muted"><%=bestItem.get(1).getTgbTerm() %></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6 mb-4">
                        <!-- Portfolio item 3-->
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-bs-toggle="modal" href="#portfolioModal3">
                                <div class="portfolio-hover">
                                    <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                                </div>
                                <img class="img-fluid" src="<%=contextPath %>/assets/img_upfile/<%=bestItem.get(2).getThumnail()%>" alt="..." />
                            </a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading"><%=bestItem.get(2).getTgbTitle() %></div>
                                <div class="portfolio-caption-subheading text-muted"><%=bestItem.get(2).getTgbTerm() %></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Portfolio Grid-->
        <section class="page-section bg-light" id="portfolio">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">NEW 공동 구매</h2>
                    <h3 class="section-subheading text-muted">♫•* 새로 등록된 가치사의 상품을 확인해보세요(~˘▾˘)~♫•*¨*•.¸¸♪</h3>
                </div>
                <div class="row">
                    <div class="col-lg-4 col-sm-6 mb-4 mb-lg-0">
                        <!-- Portfolio item 4-->
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-bs-toggle="modal" href="#portfolioModal4">
                                <div class="portfolio-hover">
                                    <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                                </div>
                                <img class="img-fluid" src="<%=contextPath %>/assets/img_upfile/<%=newItem.get(0).getThumnail()%>" alt="..." />
                            </a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading"><%=newItem.get(0).getTgbTitle() %></div>
                                <div class="portfolio-caption-subheading text-muted"><%=newItem.get(0).getTgbTerm() %></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6 mb-4 mb-sm-0">
                        <!-- Portfolio item 5-->
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-bs-toggle="modal" href="#portfolioModal5">
                                <div class="portfolio-hover">
                                    <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                                </div>
                                <img class="img-fluid" src="<%=contextPath %>/assets/img_upfile/<%=newItem.get(1).getThumnail()%>" alt="..." />
                            </a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading"><%=newItem.get(1).getTgbTitle() %></div>
                                <div class="portfolio-caption-subheading text-muted"><%=newItem.get(1).getTgbTerm() %></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <!-- Portfolio item 6-->
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-bs-toggle="modal" href="#portfolioModal6">
                                <div class="portfolio-hover">
                                    <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                                </div>
                                <img class="img-fluid" src="<%=contextPath %>/assets/img_upfile/<%=newItem.get(2).getThumnail()%>" alt="..." />
                            </a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading"><%=newItem.get(2).getTgbTitle() %></div>
                                <div class="portfolio-caption-subheading text-muted"><%=newItem.get(2).getTgbTerm() %></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Portfolio Modals-->
        <!-- Portfolio item 1 modal popup-->
        <div class="portfolio-modal modal fade" id="portfolioModal1" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-bs-dismiss="modal"><img src="assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project details-->
                                    <h2 class="text-uppercase"><%=bestItem.get(0).getTgbTitle() %></h2>
                                    <p class="item-intro text-muted"><%=bestItem.get(0).getTgbTerm() %></p>
                                    <img class="img-fluid d-block mx-auto" src="<%=contextPath %>/assets/img_upfile/<%=bestItem.get(0).getThumnail()%>" alt="..." />
                                    <p><b><상품 가이드></b></p>
                                    <p><%=bestItem.get(0).getTgbGuide() %></p>
                                    <ul class="list-inline">
                                        <li>
                                            <strong>Client:</strong>
                                            Threads
                                        </li>
                                        <li>
                                            <strong>Category:</strong>
                                            <%=bestItem.get(0).getTgbCategory() %>
                                        </li>
                                    </ul>
                                    <button class="btn btn-primary btn-xl text-uppercase" data-bs-dismiss="modal" type="button" onclick="location.href='<%=contextPath %>/detailTgb.do?bno=<%=bestItem.get(0).getTgbNo()%>'">
                                        이동하기
                                    </button>
                                    <button class="btn btn-primary btn-xl text-uppercase" data-bs-dismiss="modal" type="button">
                                        <i class="fas fa-xmark me-1"></i>
                                        Close
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Portfolio item 2 modal popup-->
        <div class="portfolio-modal modal fade" id="portfolioModal2" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-bs-dismiss="modal"><img src="assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project details-->
                                    <h2 class="text-uppercase"><%=bestItem.get(1).getTgbTitle() %></h2>
                                    <p class="item-intro text-muted"><%=bestItem.get(1).getTgbTerm() %></p>
                                    <img class="img-fluid d-block mx-auto" src="<%=contextPath %>/assets/img_upfile/<%=bestItem.get(1).getThumnail()%>" alt="..." />
                                    <p><b><상품 가이드></b></p>
                                    <p><%=bestItem.get(1).getTgbGuide() %></p>
                                    <ul class="list-inline">
                                        <li>
                                            <strong>Client:</strong>
                                            Explore
                                        </li>
                                        <li>
                                            <strong>Category:</strong>
                                            <%=bestItem.get(1).getTgbCategory() %>
                                        </li>
                                    </ul>
                                     <button class="btn btn-primary btn-xl text-uppercase" data-bs-dismiss="modal" type="button" onclick="location.href='<%=contextPath %>/detailTgb.do?bno=<%=bestItem.get(1).getTgbNo()%>'">
                                        이동하기
                                    </button>
                                    <button class="btn btn-primary btn-xl text-uppercase" data-bs-dismiss="modal" type="button">
                                        <i class="fas fa-xmark me-1"></i>
                                        Close
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Portfolio item 3 modal popup-->
        <div class="portfolio-modal modal fade" id="portfolioModal3" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-bs-dismiss="modal"><img src="assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project details-->
                                    <h2 class="text-uppercase"><%=bestItem.get(2).getTgbTitle() %></h2>
                                    <p class="item-intro text-muted"><%=bestItem.get(2).getTgbTerm() %></p>
                                    <img class="img-fluid d-block mx-auto" src="<%=contextPath %>/assets/img_upfile/<%=bestItem.get(2).getThumnail()%>" alt="..." />
                                    <p><b><상품 가이드></b></p>
                                    <p><%=bestItem.get(2).getTgbGuide() %></p>
                                    <ul class="list-inline">
                                        <li>
                                            <strong>Client:</strong>
                                            Finish
                                        </li>
                                        <li>
                                            <strong>Category:</strong>
                                            <%=bestItem.get(2).getTgbCategory() %>
                                        </li>
                                    </ul>
                                     <button class="btn btn-primary btn-xl text-uppercase" data-bs-dismiss="modal" type="button" onclick="location.href='<%=contextPath %>/detailTgb.do?bno=<%=bestItem.get(2).getTgbNo()%>'">
                                        이동하기
                                    </button>
                                    <button class="btn btn-primary btn-xl text-uppercase" data-bs-dismiss="modal" type="button">
                                        <i class="fas fa-xmark me-1"></i>
                                        Close
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Portfolio item 4 modal popup-->
        <div class="portfolio-modal modal fade" id="portfolioModal4" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-bs-dismiss="modal"><img src="assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project details-->
                                    <h2 class="text-uppercase"><%=newItem.get(0).getTgbTitle() %></h2>
                                    <p class="item-intro text-muted"><%=newItem.get(0).getTgbTerm() %></p>
                                    <img class="img-fluid d-block mx-auto" src="<%=contextPath %>/assets/img_upfile/<%=newItem.get(0).getThumnail()%>" alt="..." />
                           <p><b><상품 가이드></b></p>
                                    <p><%=newItem.get(0).getTgbGuide() %></p>                                    
                                    <ul class="list-inline">
                                        <li>
                                            <strong>Client:</strong>
                                            Lines
                                        </li>
                                        <li>
                                            <strong>Category:</strong>
                                            Branding
                                        </li>
                                    </ul>
                                    <button class="btn btn-primary btn-xl text-uppercase" data-bs-dismiss="modal" type="button" onclick="location.href='<%=contextPath %>/detailTgb.do?bno=<%=newItem.get(0).getTgbNo()%>'">
                                        이동하기
                                    </button>
                                    <button class="btn btn-primary btn-xl text-uppercase" data-bs-dismiss="modal" type="button">
                                        <i class="fas fa-xmark me-1"></i>
                                        Close
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Portfolio item 5 modal popup-->
        <div class="portfolio-modal modal fade" id="portfolioModal5" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-bs-dismiss="modal"><img src="assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project details-->
                                    <h2 class="text-uppercase"><%=newItem.get(1).getTgbTitle() %></h2>
                                    <p class="item-intro text-muted"><%=newItem.get(1).getTgbTerm() %></p>
                                    <img class="img-fluid d-block mx-auto" src="<%=contextPath %>/assets/img_upfile/<%=newItem.get(1).getThumnail()%>" alt="..." />
                           <p><b><상품 가이드></b></p>
                                    <p><%=newItem.get(1).getTgbGuide() %></p>   
                                    <ul class="list-inline">
                                        <li>
                                            <strong>Client:</strong>
                                            Southwest
                                        </li>
                                        <li>
                                            <strong>Category:</strong>
                                            Website Design
                                        </li>
                                    </ul>
                                    <button class="btn btn-primary btn-xl text-uppercase" data-bs-dismiss="modal" type="button" onclick="location.href='<%=contextPath %>/detailTgb.do?bno=<%=newItem.get(1).getTgbNo()%>'">
                                        이동하기
                                    </button>
                                    <button class="btn btn-primary btn-xl text-uppercase" data-bs-dismiss="modal" type="button">
                                        <i class="fas fa-xmark me-1"></i>
                                        Close
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Portfolio item 6 modal popup-->
        <div class="portfolio-modal modal fade" id="portfolioModal6" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-bs-dismiss="modal"><img src="assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project details-->
                                    <h2 class="text-uppercase"><%=newItem.get(2).getTgbTitle() %></h2>
                                    <p class="item-intro text-muted"><%=newItem.get(2).getTgbTerm() %></p>
                                    <img class="img-fluid d-block mx-auto" src="<%=contextPath %>/assets/img_upfile/<%=newItem.get(2).getThumnail()%>" alt="..." />
                           <p><b><상품 가이드></b></p>
                                    <p><%=newItem.get(2).getTgbGuide() %></p>                                       
                                    <ul class="list-inline">
                                        <li>
                                            <strong>Client:</strong>
                                            Window
                                        </li>
                                        <li>
                                            <strong>Category:</strong>
                                            Photography
                                        </li>
                                    </ul>
                                    <button class="btn btn-primary btn-xl text-uppercase" data-bs-dismiss="modal" type="button" onclick="location.href='<%=contextPath %>/detailTgb.do?bno=<%=newItem.get(2).getTgbNo()%>'">
                                        이동하기
                                    </button>
                                    <button class="btn btn-primary btn-xl text-uppercase" data-bs-dismiss="modal" type="button">
                                        <i class="fas fa-xmark me-1"></i>
                                        Close
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer-->
        <%@ include file="views/common/footer.jsp" %>
        
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <!-- * *                               SB Forms JS                               * *-->
        <!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
    </body>
</html>