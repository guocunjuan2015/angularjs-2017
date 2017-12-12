<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
 <%@ include file="/config/config.jsp" %>
<%@ include file="/config/global.jsp" %>
<!DOCTYPE html>
<html ng-app="indexApp">
<head>
    <meta charset="utf-8">    
    <meta content="telephone=no" name="format-detection">
    <meta name="viewport" content="width=device-width , initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <title>瑞钱宝-国企参股 华融天泽参股的互联网金融平台</title>
    <script src="js/jquery.bootstrap.newsbox.min.js"></script>
    <script src="js/swiper.min.js"></script>
    <script src="controllers/app.js" type="text/javascript"></script>
    <script src="js/rqbao_index.js"></script>
    <link href="css/font-awesome.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="css/swiper.min.css"> 
    <link href="css/rqbao_index.css" rel="stylesheet"/>
</head>
<body>    
<%@ include file="/config/globalHead.jsp" %>
    <!--轮播图start-->
   <div class="swiper-container" ng-controller="bannerListControll" id="bannerImage" style="width: 100%;">
      <div class="swiper-wrapper" style="height:auto;">
          <div class="swiper-slide" style="height:auto;" ng-repeat="bannerList in bannerLists | limitTo:7">
               <a href="{{bannerList.webUrl}}"><img ng-src="{{bannerList.bannerImageUrl}}"/></a>
          </div>
      </div>
      <!--右侧按钮-->
      <div class="swiper-pagination"></div>
  </div>
  <!--轮播图end-->
  <div ng-controller="announceController">
     <section class="totalAmount">
            <p class="col-lg-6 col-ms-6 col-sm-6 col-xs-6">累计成交(元) 
               <font>{{totalTradingAmount}}</font> 
            </p>
            <p class="col-lg-6 col-ms-6 col-sm-6 col-xs-6" style="float:right;text-align:right;">安全运营(天) 
            <font>{{operationDate}}</font> 
            </p><div class="clear"></div>
      </section>
      
      <section class="circle_nav_list" style="display:none;">
        <ul>
           <li class="col-lg-3 col-ms-3 col-sm-3 col-xs-3 new_hands" onclick="jumpPage(7)">
               <font><img  src="images/new_Guide1.png"/></font><span>新手指引</span> 
           </li>
           <li class="col-lg-3 col-ms-3 col-sm-3 col-xs-3 enterprises" onclick="jumpPage(8)">
             <font><img  src="images/new_Guide2.png"/></font><span>国企背景</span> 
           </li>
           <li class="col-lg-3 col-ms-3 col-sm-3 col-xs-3 security" onclick="jumpPage(9)">
              <font><img  src="images/new_Guide3.png"/></font><span>安全保障</span> 
           </li>
           <li  class="col-lg-3 col-ms-3 col-sm-3 col-xs-3 recommended" onclick="jumpPage(10)">
             <font><img  src="images/new_Guide4.png"/></font>
             <span>推荐有礼</span> 
           </li>
        </ul>
        <div class="clear"></div>
     </section>
  
     <section class="announceBox">
         <font  class="fa fa-volume-up"></font>
          <ul id="miniNewsRegion">
               <li ng-repeat="announce in announces">
                  <a href="{{announce.targetUrl}}"> 
                      {{announce.content}}
                    <!-- {{announce.content | limitTo :20}} 显示条数-->
                  </a>
               </li>
          </ul>
          <a href="{{operationReportUrl}}" class="btn btn-danger">运营报告</a>
          <div class="clear"></div>
    </section>
</div>  
<!--理财项目start -->
  <section class="financialManage" onclick="jumpPage(2)">
     <div class="financialTitle">
	       <span><img style="margin-top:1rem;"  src="images/projectIcon1.png"/></span>
	       <font>理财项目</font>
	       <p>优质资产＋理财精选</p>
     <div class="clear"></div>  
     </div> 
     <div class="financialList" >
       <span></span> 
       <font>11</font>
       <p>预期年化收益(%)</p>
       <div class="clear"></div>
     </div>
  </section>

  <section class="transferZone" onclick="jumpPage(2)" style="display:none ">
     <div class="financialTitle">
      <span><img  src="images/projectIcon.png"/></span>
       <font>转让专区</font>
       <p>周转灵活＋多重保障</p>
        <div class="clear"></div>
     </div> 
     <div class="financialList"> 
       <font>6.5~13</font>
       <p>预期年化收益(%)</p>
        <div class="clear"></div>
     </div>
  </section>
  <!--理财项目end -->
  <div class="aboutUsTitle">
    <span onclick="jumpPage(4)">查看更多</span>
     关于瑞钱宝
  </div>

  <section class="aboutUs" onclick="jumpPage(4)">
      <img  src="images/noticeImage.jpg"/>
      <p>北京瑞钱宝资产管理有限公司（简称“瑞钱宝”）是国企华融天泽旗下的综合金融服务平台，是国企华融天泽...
      </p>
      <div class="clear"></div>
  </section>

  <section class="active_list">
        <ul>
          <li  onclick="jumpPage(4)"><p><img style="max-width:none;width:1.5rem;" src="images/aboutUs/active_list1.png"/></p>品牌介绍</li>
          <li  onclick="jumpPage(4)"><p><img style="max-width:none;width:2.4rem;" src="images/aboutUs/active_list2.png"/></p>合作伙伴</li>
          <li onclick="jumpPage(5)"><p><img  style="max-width:none;width:2rem;" src="images/aboutUs/active_list3.png"/></p>最新活动</li>
        </ul>
      <div class="clear"></div>
  </section>
<%@ include file="/config/globalFooter.jsp" %>

   <!--  <div id="space_div"></div> -->
    <div id="error_info" style="display:none;" class="error_info"></div>
<script>
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        paginationClickable: true,
        continuous: true,
        direction: 'horizontal',
        loop : false, /*图片是否循环 */
        // 如果需要前进后退按钮
        nextButton: '.swiper-button-next',
        keyboardControl : true,
        mousewheelControl : true,
        direction:'horizontal',
        mousewheelForceToAxis : true,
        autoplay:3500,
        speed:800,
        observer:true,//修改swiper自己或子元素时，自动初始化swiper
        observeParents:true//修改swiper的父元素时，自动初始化swiper
    });
    
    /*最新公告效果 */
    $("#miniNewsRegion").bootstrapNews({
             newsPerPage: 8,
             autoplay: true,
             pauseOnHover: true,
             navigation: false,
             direction: 'down',
             newsTickerInterval: 3200,
             onToDo: function () {
               //console.log(this);
             }
    });
</script>
<script type="text/javascript" src="http://www.rqbao.com/rqb/js/99click/om_code.js">
</script>
</body>
</html>