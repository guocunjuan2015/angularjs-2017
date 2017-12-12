<%@page import="java.text.SimpleDateFormat"%>
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
String referrer = request.getParameter("referrer");//获得的推荐人是Hex编码
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
//         userHex = Hex.encodeHexString(user.getBytes());//将用户Hex编码，用于分享
        
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
String utm_source = request.getParameter("utm_source");//渠道
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="maximum-scale=1.0,minimum-scale=1.0,user-scalable=0,width=device-width,initial-scale=1.0"/>
  <title>国庆中秋双节同庆，京东E卡大放送</title>
  <meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
  <meta name="description" content="瑞钱宝互联网金融平台投资越多惊喜越多,年收化率7%-13.5%，活动期间你可以选择适合您的理财产品，活动期间设置自动幸运抽奖区，投资理财奖品主要有三星电视、九阳榨汁机、iphone 6s 等，活动时间6月6日-6月24日。" />
  <link href="<%=basePath%>/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="<%=basePath%>/active/custodyOperation/css/swiper.min.css"> 
  <link href="<%=basePath%>/css/common2.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/active/jdBring/jdBring.css" rel="stylesheet">
  <script src="<%=basePath%>/js/jquery-1.11.2.min.js" type="text/javascript"></script> 
  <script src="<%=basePath%>/js/bootstrap.min.js" type="text/javascript"></script>
  <script src="<%=basePath%>/js/swiper.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
  <script src="<%=basePath%>/js/json2.js"></script>
  <script> 
    /*标题 */
    function showShare(){
        IOSModel.changeWebTitle("国庆中秋双节同庆，京东E卡大放送");
      }
    $(function(){
        title = "国庆中秋双节同庆，京东E卡大放送";
        content 
        = "瑞钱宝—大型国企参股，多种优质项目，让您轻松理财！";
      icon = "<%=basePath %>/images/logo/jdBring.png";
      url  = "<%=basePath %>/active/jdBring/jdBring.jsp?from=app&utm_source=<%=utm_source %>";
      _url = "<%=basePath %>/active/jdBring/jdBring.jsp?from=app&utm_source=<%=utm_source %>";
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

       
  </script>
</head>
<body style="background:#FFF">
  <input type="hidden" value="" name="types" id="types">
  <input type="hidden" value="<%=basePath%>"  id="basePath">
  <input type="hidden" value="<%=localPath%>"  id="localPath">
  <input type="hidden" id="user" value="<%=user%>" />
  <input type="hidden" id="userId"  value="<%=userId%>"/>
  <input type="hidden" value="<%=utm_source%>" id="utm_source"/>
    <header>
         <img alt="" src="${pageContext.request.contextPath}/active/jdBring/image/activeLogo.png">
          <a href="javascript:;" onclick="toLogin();">已注册</a>
    </header>
    <section>
        <img alt="" src="${pageContext.request.contextPath}/active/jdBring/image/banner.png">
    </section>
 <div class="activeBox">	   
	   <!-- 新手专享banner -->
    <div class="swiper-container" id="activeBanner">
        <div class="swiper-wrapper">
            <div class="swiper-slide"> <img alt="" src="${pageContext.request.contextPath}/active/jdBring/image/samllBanner1.png"></div>
            <div class="swiper-slide"> <img alt="" src="${pageContext.request.contextPath}/active/jdBring/image/smallBanner3.png"></div>
            <div class="swiper-slide"> <img alt="" src="${pageContext.request.contextPath}/active/jdBring/image/smallBanner4.png"></div>
            <div class="swiper-slide"> <img alt="" src="${pageContext.request.contextPath}/active/jdBring/image/samllBanner5.png"></div>
            <div class="swiper-slide"> <img alt="" src="${pageContext.request.contextPath}/active/jdBring/image/smallBanner2.png"></div>
        </div>
        <!-- Add Arrows -->
        <div class="swiper-button-next"></div>
        <div class="swiper-button-prev"></div>
    </div> 
    
    <!-- 参与方法 -->
    <section class="joinWay">
        <p><img alt="" class="title1" src="${pageContext.request.contextPath}/active/jdBring/image/title1.png"></p>
        <p><img alt="" class="smallTitle1" src="${pageContext.request.contextPath}/active/jdBring/image/smallTitle1.png"></p>
        <p><img alt="" class="freeImg" src="${pageContext.request.contextPath}/active/jdBring/image/freeImg.png"></p>
    </section>
 </div>   
    <p><img alt="" class="borderImg" src="${pageContext.request.contextPath}/active/jdBring/image/borderImg.png"></p>
     <!-- 投资有礼 -->
    <section class="investToGift">
        <p><img alt="" class="smallTitle1" src="${pageContext.request.contextPath}/active/jdBring/image/smallTitle2.png"></p>
        <p class="investImg"><img alt="投资有礼"  src="${pageContext.request.contextPath}/active/jdBring/image/investImg.png"></p>
    </section>
    
    <!-- 活动规则 -->
    <section class="activeRule">
       <p><img alt="活动规则" onclick="onClickRule();" src="${pageContext.request.contextPath}/active/jdBring/image/activeRuleImg.png"></p>
       <p><img alt="" style="margin-top:1rem;"  src="${pageContext.request.contextPath}/active/jdBring/image/borderImg.png"></p>
    </section>
     <!-- 瑞钱宝四大优势 -->
    <section class="advantage">
         <p><img alt="" class="title2" src="${pageContext.request.contextPath}/active/jdBring/image/title2.png"></p>
         <ul class="clearfix advantageLi">
              <li class="col-xs-6 col-sm-6 col-md-6  col-lg-6">
                   <p><img alt=""  src="${pageContext.request.contextPath}/active/jdBring/image/advantage1.png"></p>
                  <p>国企参股</p>
              </li>
              
              <li class="col-xs-6 col-sm-6 col-md-6  col-lg-6">
              
                  <p><img alt=""  src="${pageContext.request.contextPath}/active/jdBring/image/advantage2.png"></p>
                  <p>风控资质</p>
              </li>
              <li class="col-xs-6 col-sm-6 col-md-6  col-lg-6">
                  <p><img alt="" src="${pageContext.request.contextPath}/active/jdBring/image/advantage3.png"></p>
                  <p>银行存管</p>
              </li>
              <li class="col-xs-6 col-sm-6 col-md-6  col-lg-6">
                  <p><img alt=""src="${pageContext.request.contextPath}/active/jdBring/image/advantage4.png"></p>
                  <p>易保全合同</p>
              </li>
          </ul>
    </section>
    <section class="tip clearfix">
         <p><img alt="" class="borderImg" src="${pageContext.request.contextPath}/active/jdBring/image/borderImg.png"></p>
         <p>市场有风险 投资需谨慎 最终收益以实际为准</p>
   </section>
   <!-- 注册 -->
   <footer id="registerDiv">
      <p>领取<b>108元</b>红包+<b>2000元</b>京东E卡</p> 
      <div class="clearfix">
          <p>
            <input type="text"  placeholder="输入手机号码" name="mobile" id="mobile">
            <button type="button"  id="registerBtn">注册送108元红包</button>
          </p>
          <p id="error_info"></p>
      </div>   
   </footer>
  <%--弹出框 --%>
<div class="bg"></div>
<!-- 可以领取-->
 <div class="dialog">
        <div class="close_btn">×</div>
        <h4>参与规则</h4>
        <p >1、活动有效期：2017年10月1日至2017年10月31日期间内，在本链接完成注册且首次单笔投资满足以上条件的用户，可获
得对应奖励。</p>
        <p >2、投资成功后10个工作日内发放，数量有限，送完即止，逾期不作补发。</p>
        <p >3、本活动最终解释权归瑞钱宝所有。</p>
</div>
 <script type="text/javascript" src="<%=basePath%>/js/shumei/ishumei.js"></script> 
 <script>
 $(function(){
   	    var user = $("#user").val();
        var userId = $("#userId").val();
        //点击注册  
        $("#registerBtn").click(function(){
        	 var mobile = $("#mobile").val();//手机号码
           var pattern = /^0?(13[0-9]|15[0-9]|18[0-9]|14[0-9]|17[0-9])[0-9]{8}$/;//手机号码校验
        	 var deviceId = SMSdk.getDeviceId();
        	 var utm_source = $("#utm_source").val();
       	   if(mobile == "" || mobile == null){
       		   $("#error_info").show();
       		   $("#error_info").html("手机号码不能为空");
       		    return;
       	   }
       	 //手机号码输入校验
       	   if(pattern.test(mobile)){
       		   $("#error_info").hide();
       		   var objData = {
       				  mobile : mobile,
                deviceId : deviceId,
                referrer : '',
                channel : utm_source
       		   };
       		   $.ajax({
                      url:'<%=localPath%>/activity/reg/p?date='+new Date(),
                      type:'POST',
                      dataType:'json',
                      data: JSON.stringify(objData),
                      contentType: "application/json",
                      success:function(data){
                    	  if(data.result=="1"){
	                           location.href = "<%=basePath%>/download/download.jsp";
	                   	   } else {
		                   		   $("#error_info").show();
		                   		   $("#registerDiv").css("height","12.8rem");
		                   		   $("#error_info").html(data.errInfo); 
		                   		   return;
	                   		   
	                   	   }
	                   	   
                        
                      },
                      error:function(){
                        
                    	  $("#error_info").html("注册失败 ");   
                        
                      }
                    
                  })
       		   
       	   } else {
       		         $("#error_info").show();
       		         $("#error_info").html("请输入格式正确的手机号! ");
       		   
       	   }
       	  
       	  
         }); 
        
        //动态监听zhuce输入框的边框 
        $("#mobile").bind('input propertychange',function(){
        	 var mobile = $("#mobile").val();//手机号码
        	 if(mobile == "" || mobile == null){
                 $("#error_info").show();
                 $("#error_info").html("手机号码不能为空");
                  return;
           } else {
        	   
        	      $("#error_info").hide();
           }
        	
        })
        
              
         //关闭遮罩层
         $(".close_btn").click(function(){
            $(".dialog").hide();
            $(".bg").hide();
         })
      })
      

    /*进入登录 页面 */
    function toLogin() {
        if (isAndroidOrIos()) {
            IOSModel.login();
        appFunction('login');
        } else {
            window.location.href = "<%=basePath%>/login.jsp?active=jdBring";
        }
    }
      
      /*点击活动规则   */
     function onClickRule(){
       $(".bg").show();
       $(".dialog").show();
     }
    
    /*去注册*/
    function toRegister(){
        if(isAndroidOrIos()){
          IOSModel.iosRegist();
            appFunction('regist');
        }else{
          IOSModel.iosRegist();
            window.location.href = "<%=basePath%>/ump_register.jsp";
        }
    }
    
    /*轮播效果 */
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        paginationClickable: '.swiper-pagination',
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
        spaceBetween: 30
    });
   
</script>   
</body>
</html>
