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
  <meta name="description" content="" />
  <link href="<%=basePath%>/css/common2.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/active/custodyOperation/css/custodyOperation.css" rel="stylesheet">
  <script src="<%=basePath%>/js/jquery-1.11.2.min.js" type="text/javascript"></script> 
  <script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
  <script> 
    /*标题 */
    function showShare(){
        IOSModel.changeWebTitle("银行存管操作指南");
      }
    $(function(){
        title = "瑞钱宝银行存管业务系统操作指南";
        content = "瑞钱宝—大型国企背景，多种优质项目，让您轻松理财！";
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
        
        function goAccountProcess(){ //开户流程
            
            window.location.href =" <%=basePath%>/active/custodyOperation/accountProcess.jsp";
          
        }
        
        function goActivateProcess(){ //激活流程
            
            window.location.href =" <%=basePath%>/active/custodyOperation/activateProcess.jsp";
          
        }
        
       function goRechargeProcess(){ //充值流程
            
            window.location.href =" <%=basePath%>/active/custodyOperation/rechargeProcess.jsp";
          
        }
       
       function goInvestProcess(){ // 投资流程
           
           window.location.href =" <%=basePath%>/active/custodyOperation/investProcess.jsp";
         
       }
       
      function goWithdrawProcess(){ // 充值流程
           
           window.location.href =" <%=basePath%>/active/custodyOperation/withdrawProcess.jsp";
         
       }
      
  </script>
</head>
<body style="background:#fff">
  <input type="hidden" value="<%=basePath%>"  id="basePath">
  <input type="hidden" value="<%=localPath%>"  id="localPath">
  <input type="hidden" id="userId"  value="<%=userId%>"/>
  <input type="hidden" id="user"   value="<%=user%>">
    <header>
       <img alt="" src="${pageContext.request.contextPath}/active/custodyOperation/image/banner.png">
    </header>
<div class="activeMain">    
    <div class="custodyTitle">
        <h4><span>银行存管上线啦</span></h4>   
        <p>瑞钱宝携手海口联合农商银行，已于2017年7月3日正式上线银行存管系统。 </p>
        <p>为了让您能够在银行存管上线后顺利完成相关操作，请仔细阅读以下操作指南。 </p>
    </div>
</div> 
<div class="activrBorder"></div>
     <div class="custodyList">
       <ul>
            <li onclick="goAccountProcess();"><font>开户流程</font><span class="fr clickImg"></span></li>
            <li onclick="goRechargeProcess();"><font>充值流程</font><span class="fr clickImg"></span></li>
            <li onclick="goInvestProcess();"><font>投资流程</font><span class="fr clickImg"></span></li>
            <li onclick="goWithdrawProcess();"><font>提现流程</font><span class="fr clickImg"></span></li>
       </ul>
    </div>
<div class="activrBorder"></div>
<div class="activeMain">
    <div class="custodyTitle">
        <h4><span class="titleIcon2">关于银行存管</span></h4>   
    </div>
    <!-- 关于银行存管 -->
    <div class="aboutCustody">
        <h4>Q1:不开通存管账户能够投资吗？</h4> 
        <p>A:不开通存管账户，仅能浏览账户信息和投资产品信息，不能做投资、充值、提现操作。</p>  
    </div>
    
    <div class="aboutCustody">
        <h4>Q2:绑定银行卡必须是本人银行卡吗？</h4> 
        <p>A:绑定银行卡必须为与开通账户的证件信息一致的银行卡，否则无法开通。</p>  
    </div>
    
    <div class="aboutCustody">
        <h4>Q3:一个用户可以绑定几张卡？</h4> 
        <p>A:一个用户只能绑定一张银行卡，且提现金额只能转入到绑定银行卡中。</p>  
    </div>
    
     <div class="aboutCustody" style="margin-bottom:1rem;">
        <h4>Q4:存管开通后，充值和提现会有哪些操作变化？</h4> 
        <p>A:存管开通后，充值和提现操作在输入金额后，需要跳转到海口联合农商银行存管页面上输入交易密码。</p>  
    </div>
</div>
 <p class="hotline">如有其他疑问，请咨询：<a href="tel:400-919-8555">400-919-8555</a></p>
<div class="fixedStyle">
<!--  <div class="activrBorder"></div> -->
 <p class="custodyBtn"><a href="javascript:;" id="goOpen" onclick="goOpen();">开通银行存管账户</a></p>
</div> 
<script type="text/javascript" src="${pageContext.request.contextPath}/js/custodyJs.js"></script> 
</body>
</html>
