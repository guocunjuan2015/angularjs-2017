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
String lotteryId = request.getParameter("lotteryId");
String utm_source = request.getParameter("utm_source");//渠道
%>
<!DOCTYPE html>
<html style="font-size:10px;">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="maximum-scale=1.0,minimum-scale=1.0,user-scalable=0,width=device-width,initial-scale=1.0"/>
  <title>银行存管操作指南</title>
  <meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
  <meta name="description" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
  <link href="<%=basePath%>/css/common2.css" rel="stylesheet"/>
   <link rel="stylesheet" href="${pageContext.request.contextPath}/active/custodyOperation/css/swiper.min.css"> 
  <link href="${pageContext.request.contextPath}/active/custodyOperation/css/custodyOperation.css" rel="stylesheet">
  <script src="<%=basePath%>/js/jquery-1.11.2.min.js" type="text/javascript"></script> 
   <script src="<%=basePath%>/js/swiper.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/json2.js"></script>
  <script> 
    /*标题 */
    function showShare(){
        IOSModel.changeWebTitle("银行存管指南");
      }
    $(function(){
        title = "依国企华融天泽背景，坐享稳健收益，欢迎投资瑞钱宝";
        content 
        = "瑞钱宝—大型国企参股，多种优质项目，让您轻松理财！";
      icon = "<%=basePath %>/images/logo/custodyOperation.png";
      url  = "<%=basePath %>/active/custodyOperation/custodyOperation.jsp?from=app&utm_source=<%=utm_source %>";
      _url = "<%=basePath %>/active/custodyOperation/custodyOperation.jsp?from=app&utm_source=<%=utm_source %>";
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
  <style>
     .custodyProcessStep li:first-child +li+li+li+li{background:#0473EE;} 
  </style>
</head>
<body style="background:#Fff">
  <input type="hidden" value="<%=basePath%>"  id="basePath">
  <input type="hidden" value="<%=localPath%>"  id="localPath">
<div class="custodyProcess">
     <div class="swiper-container swiper-container-horizontal">
        <div class="swiper-wrapper">
                <div class="swiper-slide swiper-slide-active">
                    <div class="title">提现流程</div>
                    <div class="subtitle">部分数据已同步至海口联合农商银行</div>
                    <div class="swiperImg">
                        <p><img alt="" src="${pageContext.request.contextPath}/active/custodyOperation/image/process6.png"></p>
                    </div>
                    <p class="step step1">第一步：在瑞钱宝账户中心，点击［提现］。</p>
              </div>  
             <!-- 激活流程  -->
                  <div class="swiper-slide swiper-slide-next">
                      <div class="title">提现流程</div>
                      <div class="subtitle">部分数据已同步至海口联合农商银行</div>
                      <div class="swiperImg">
                          <p><img alt="" src="${pageContext.request.contextPath}/active/custodyOperation/image/process11.png"></p>
                      </div>
                       <p class="step step2">第二步：输入提现金额，点击［下一步］。</p>
            </div>
            <!-- 充值流程  -->
                <div class="swiper-slide">
                   <div class="title">投资流程</div>
                    <div class="subtitle">部分数据已同步至海口联合农商银行</div>
                    <div class="swiperImg">
                        <p><img alt="" src="${pageContext.request.contextPath}/active/custodyOperation/image/process12.png"></p>
                    </div>
                    <p class="step step3">第三步：输入交易密码，点击［确认提现］。
</p>
            </div>    
             <!-- 投资流程  -->
              <div class="swiper-slide">
                 <div class="title">提现流程</div>
                  <div class="subtitle">部分数据已同步至海口联合农商银行</div>
                  <div class="swiperImg">
                      <p><img alt="" src="${pageContext.request.contextPath}/active/custodyOperation/image/process13.png"></p>
                  </div>
                   <p class="step step4">第四步：提现申请提交成功。</p>
            </div>  
        </div>
        <!-- Add Pagination -->
        <div class="swiper-pagination swiper-pagination-white swiper-pagination-clickable swiper-pagination-bullets">
        <span class="swiper-pagination-bullet swiper-pagination-bullet-active"></span>
        <span class="swiper-pagination-bullet"></span>
        <span class="swiper-pagination-bullet"></span></div>
        <!-- Add Navigation -->
        <div class="swiper-button-prev swiper-button-white swiper-button-disabled"></div>
        <div class="swiper-button-next swiper-button-white"></div>
    </div> 
</div>
<%@ include file="/active/custodyOperation/publiclBottom.jsp" %>
</body>
</html>
