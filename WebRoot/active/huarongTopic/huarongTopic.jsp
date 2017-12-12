<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="UTF-8"%>
<%@ include file="/config/config.jsp" %>
<% 
    HttpSession hs = request.getSession();  
    String user = "";//用户名
    String userId = "";//用户userId
    String userHex = "";//hex编码的用户名，分享出去用到，app转进来需要解码
    
    String from = request.getParameter("from");
    if (from == null || !("app".equals(from))) {
        from = "";
    }
    System.out.println("aft:" + from);
/*     String referrer = request.getParameter("referrer");//获得的推荐人是Hex编码
    String referrer = "";
    if (referHex == null) {
      referrer = "";
    } else {
        //refer需要Hex解码
        if (referHex != null) {
            byte[] bs = Hex.decodeHex(referHex.toCharArray());
            referrer  = new String(bs);
        }
    }  */
    String userApp = request.getParameter("user");
    if (from != null && "app".equals(from) && userApp != null
            && userApp != "") {
        user = userApp;
        hs.setAttribute("loginUser", user);
        //app上无分享功能
    } else if (hs != null) {
        user = (String) hs.getAttribute("loginUser");
        if (user == null) {
            user = "";
        }
        if (user != null && user != "") {
            userHex = Hex.encodeHexString(user.getBytes());//将用户Hex编码，用于分享
            
        } else {
            userHex = "";
        }
    }
    String userAppId = request.getParameter("userId");
    if (from != null && "app".equals(from) && userId != null
            && userId != "") {
        userId = userAppId;
        hs.setAttribute("userId", userId);
        //app上无分享功能
    } else if (hs != null) {
        userId = (String) hs.getAttribute("userId");
        if (userId == null) {
            userId = "";
        }
    }
    String phone = request.getParameter("phone");
    String lotteryId = request.getParameter("lotteryId");
    String utm_source = request.getParameter("utm_source");//渠道
   // String phoneHex = Hex.encodeHexString(phone.getBytes());//将手机号Hex编码，用于分享

%>  
<script>
  var _url = "";
</script>

<%@ include file="../../config/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport"
  content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <title>华融天泽</title>
    <meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
    <meta name="description" content="瑞钱宝互联网金融平台投资越多惊喜越多,年收化率7%-13.5%，
      活动期间你可以选择适合您的理财产品，活动期间设置自动幸运抽奖区，投资理财奖品主要有三星电视、九阳榨汁机、iphone 6s 等，活动时间6月6日-6月24日。" />
  <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/bootstrap.min.css">
    <link href="<%=basePath%>/css/common2.css" rel="stylesheet"/>
    <link href="<%=basePath%>/active/huarongTopic/huarongTopic.css" rel="stylesheet">
    <script src="<%=basePath%>/js/jquery-1.11.2.min.js" type="text/javascript"></script>
   <script src="<%=basePath%>/js/jweixin-1.0.0.js" type="text/javascript"></script>
   <script src="<%=basePath%>/js/frame/ios_js.js" type="text/javascript"></script>
    <script src="<%=basePath%>/js/weixin_share.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%=basePath%>/js/frame/rqbaoappshare.js"></script>
  <script> 
  $(function(){
      $("#joinBtn2").click(function() {
        if (isAndroidOrIos()) {
            toProject();
        } else {
          window.location.href="<%=basePath%>/download_app.jsp";
        }
      });
      /*点击进入投资列表 */
      $(".clickPro").click(function () {
    	    if (isAndroidOrIos()) {
    	        IOSModel.toIosInvest();
    	        appFunction('invest');
    	      } else {
    	        window.location.href = "<%=basePath %>/project.jsp";
    	      }
    	  }) 
    })
    
    function toProject() {
      IOSModel.toIosInvest();
      if (isAndroidOrIos()) {
        toIosInvest();
        appFunction('invest');
      }
    }
  
  
  
  $(function(){
    /*关闭遮罩层 */
    $(".closeWindow").click(function(){
      $("#divshows").hide();
    })
     /*判断是安卓或者是IOS*/
      var browser = {
        versions : function() {
          var u = navigator.userAgent, app = navigator.appVersion;
          return { //移动终端浏览器版本信息
            ios : !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
            android : u.indexOf('Android') > -1
                || u.indexOf('Linux') > -1, //android终端或uc浏览器
            weixin : u.indexOf('MicroMessenger') > -1, //是否微信 （2015-01-22新增）
          };
        }(),
        language : (navigator.browserLanguage || navigator.language)
            .toLowerCase()
      }
  })
    /*标题 */
    function showShare(){
        IOSModel.changeWebTitle("华融天泽");
      }
    $(function(){
        title = "依国企华融天泽背景，坐享稳健收益，欢迎投资瑞钱宝";
        content 
        = "瑞钱宝—大型国企参股，多种优质项目，让您轻松理财！";
      icon = "<%=basePath %>/images/logo/huarongTopic.png";
      url  = "<%=basePath %>/active/huarongTopic/huarongTopic.jsp?from=app&utm_source=<%=utm_source %>";
      _url = "<%=basePath %>/active/huarongTopic/huarongTopic.jsp?from=app&utm_source=<%=utm_source %>";
       // getReferenceRank();
      /*分享好友*/
        weixinShare(title,content,icon,_url,'<%=basePath%>');
     <%--    
        if("<%=userApp %>" != null && 
            "<%=userApp%>" != "" && 
            "<%=userApp%>" != "null") {
       
        }
         --%>
    });
  
    /*分享 */
      function shareClick() {
       var shareUrl=url;
         if("<%=userApp %>" != null &&  
              "<%=userApp %>" != "" && 
              "<%=userApp %>" != "null"){
               if(shareUrl.indexOf("&referrer")>=0)
               {
                 
               }
               else
               {
               shareUrl=shareUrl+"&referrer="+$("#m").val();
               url=shareUrl;
               }
        }
        var uu = '<%=userApp%>';
        if(!uu){
          showAys3("您还没有登录，需要登录后才可以分享，现在去登录？");
        }else{ 
          if (isAndroidOrIos()) {
                  IOSModel.noticeShare({
                      "url" : shareUrl,
                      "title" : title,
                      "content" : content,
                      "icon" : icon
                  });
                  iosShare(title, content, icon, shareUrl);
                  appFunction('share');
              } else {
                weixinShare(title,content,icon,_url,'<%=basePath%>');
                 showShareBox();
              }
        }
      }
        function showShare() {
          IOSModel.showShareBtn();
        }
        
        function shareWithType() {
          var shareUrl=url;
          if("<%=userApp %>" != null && 
            "<%=userApp %>" != "" && 
            "<%=userApp %>" != "null"){
              shareUrl=url+"&referrer="+$("#m").val();
              
            }
          IOSModel.noticeShare({
            "url" : shareUrl,
            "title" : title,
            "content" : content,
            "icon" : icon
          });
        }
        
        function login(){
            window.location.href = "<%=basePath%>/login.jsp?active=redEnvelope"
          }
          
        function dismissAys3(){
            $("#bg")[0].style.display = "none";
            $("#ays3")[0].style.display = "none";
        }
        function showAys3(value){
            $("#ays_content3")[0].innerHTML = value;
            $("#bg").css("height", document.body.scrollHeight);
            $("#bg")[0].style.display = "block";
            $("#ays3")[0].style.display = "block";
        }
      
    </script>
    
</head>
<body id="huarongTopicBox">
<div class="assetsBanner" onclick="myHome()"><img src="<%=basePath%>/active/huarongTopic/images/banner.png"/></div>
<div class="centerdiv">
  <!--企业基本信息 start  -->
  <div class="corporateInfors">
     <div class="corTopic companyIntro" style="margin-top:2.5rem;"><div class="enterInfor_l"><hr/><hr/></div><b>企业介绍</b><div class="enterInfor_r"><hr/><hr/></div></div>
     <div class="corTopic_li">  
       <p>瑞钱宝是国企华融天泽参股的综合金融服务平台，致力于为个人、企业提供金融交易信息服务。</p>
     </div>
  </div>
  <!--企业基本信息end  -->
  
    <!--资产特点 start  -->
  <div class="corporateInfors" style="margin-top:2rem;">
     <div class="corTopic assetsFeatures"><div class="enterInfor_l"><hr/><hr/></div><b>国企参股</b><div class="enterInfor_r"><hr/><hr/></div></div>
            <%--  <div class="riskProtection">
                  <img src="<%=basePath%>/active/huarongTopic/images/listBg.png"/>
             </div> --%>
    
  </div>
  <div class="developDiv"> 
       <p class="boldTitle1" style="margin-top:1.8rem;"><span class="span01"></span>华融天泽简介<span class="span02"></span></p>
       <p class="develoInfor">华融天泽投资有限公司（简称“华融天泽”）是中国四大资产管理公司之一——中国华融之控股子公司，经中国证监会批准，由华融证券股份有限公司（以下简称“华融证券”）于2012年11月设立，专门从事直接投资业务的全资子公司。</p>
  </div> 
    <div class="developDiv"> 
       <p class="boldTitle1" style="margin-top:1.8rem;"><span class="span01"></span>业务模式<span class="span02"></span></p>
       <p class="develoInfor">
                                   华融天泽使用自有资金或者对外募资对未上市企业进行股权投资，
                                   并综合运用中国华融各项资源优势对企业提供一揽子增值服务，
                                   同时也通过委托贷款等方式使用自有资金或者对外募集资金进行债权投资。
                                   另外，公司根据依托股东背景和自身资源等情况，积极开展了财务顾问、海外并购、资产收购等业务。
      </p>
  </div>
   <div class="developDiv"> 
       <p class="boldTitle1" style="margin-top:1.8rem;"><span class="span01"></span>风控体系<span class="span02"></span></p>
       <p class="develoInfor">
                                         华融天泽建立了由董事会、投资决策委员会、财务风控部及各部门负责人组成的全面风险控制体系。
                                         公司董事会是公司风险控制的最高决策机构，担负公司风险控制的最终责任。
                                         投资决策委员会在董事会的授权下承担风控审查责任。
                                         财务风控部负责拟订风险管理政策、制度或规定，评估日常经营活动的合法合规性以及经营风险，
                                         设计风险管理模式和风险管理指标，进行风险识别和测量，并进行事前与事中监控、评析和处置。
      </p>
  </div>  

  <!--资产特点end  -->
    <!--资质展示 start  -->
  <div class="corporateInfors">
       <div class="developDiv" style="margin-top:2rem;border:none;"> 
               <p class="boldTitle1"><span class="span01"></span>华融天泽简介<span class="span02"></span></p>
      </div> 
         <div class="carousel-inner carousel-inner1 "  id="businessLicense" style="margin-top:2rem;    margin-bottom: 7rem;">
               <ul style="margin-left:0.5rem;">
                   <li class="col-xs-4 col-sm-4 col-md-4  col-lg-4"> <a id="gallery1" href="images/bigLicense1.png"><img src="images/license1.png" alt=""></a></li>
                   <li class="col-xs-4 col-sm-4 col-md-4  col-lg-4"><a id="gallery2" href="images/bigLicense2.png"><img src="images/license2.png" alt=""></a></li>
                   <li class="col-xs-4 col-sm-4 col-md-4  col-lg-4"><a id="gallery3" href="images/bigLicense3.png"><img src="images/license3.png" alt=""></a></li>
                   <li class="col-xs-4 col-sm-4 col-md-4  col-lg-4"><a id="gallery8" href="images/bigLicense8.png"> <img src="images/license8.png" alt=""></a></li>
                   <li class="col-xs-4 col-sm-4 col-md-4  col-lg-4"><a id="gallery9" href="images/bigLicense9.png"><img src="images/license9.png" alt=""></a></li>
                  <li class="col-xs-4 col-sm-4 col-md-4  col-lg-4"><a id="gallery10" href="images/bigLicense10.png"><img src="images/license10.png" alt=""></a></li>
             </ul> 
          </div>
           <!-- 轮播（Carousel）导航 -->
  </div>
  <!--资质展示end  -->
 
  <!--精彩回顾 start  -->
<!-- <div class="carousels purpleBg" style="padding-bottom:10rem;">
       <div class="centerdiv">
            <div class="corTopic developPath">
                <div class="enterInfor_l"><hr/><hr/></div>
                <b>精彩回顾</b>
                <div class="enterInfor_r"><hr/><hr/></div>
            </div>
           <img src="images/infor7.png" />
     </div>   
</div> -->
 <!--精彩回顾 end  -->
 

</div>
<div class="joinBox">
  <p style="text-align:center;"> <a class="joinBtn btn btn-danger clickPro"  href="javascript:;">立即投资</a></p>
</div>
  </body>
</html>
