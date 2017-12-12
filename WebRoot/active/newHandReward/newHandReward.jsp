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
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="maximum-scale=1.0,minimum-scale=1.0,user-scalable=0,width=device-width,initial-scale=1.0"/>
	<title>新手奖励领取三步曲</title>
  <meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
  <meta name="description" content="瑞钱宝互联网金融平台投资越多惊喜越多,年收化率7%-13.5%，活动期间你可以选择适合您的理财产品，活动期间设置自动幸运抽奖区，投资理财奖品主要有三星电视、九阳榨汁机、iphone 6s 等，活动时间6月6日-6月24日。" />
 	<link href="<%=basePath%>/css/common2.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/active/newHandReward/newHandReward.css" rel="stylesheet">
  <script src="<%=basePath%>/js/jquery-1.11.2.min.js" type="text/javascript"></script> 
	<script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/json2.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.slotmachine.js"></script>
  <script> 
    /*标题 */
    function showShare(){
        IOSModel.changeWebTitle("新手福利奖励领取三部曲");
      }
    $(function(){
        title = "依国企华融天泽背景，坐享稳健收益，欢迎投资瑞钱宝";
        content 
        = "瑞钱宝—大型国企参股，多种优质项目，让您轻松理财！";
      icon = "<%=basePath %>/images/logo/newHandReward.png";
      url  = "<%=basePath %>/active/newHandReward/newHandReward.jsp?from=app&utm_source=<%=utm_source %>";
      _url = "<%=basePath %>/active/newHandReward/newHandReward.jsp?from=app&utm_source=<%=utm_source %>";
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
<body style="background:#fff;max-width: 100%;">
	<input type="hidden" value="" name="types" id="types">
	<input type="hidden" value="<%=basePath%>"  id="basePath">
	<input type="hidden" value="<%=localPath%>"  id="localPath">
	<input type="hidden" value="<%=referrer %>"  id="referrer">
	<input type="hidden" value="<%=from%>"  id="from">
	<input type="hidden" value="<%=utm_source %>" id="channel"/>
	<input type="hidden" value="<%=userAppId %>" id="userId"/>
	<input type="hidden" value="" id="code"/>
	<div class="newHandReward_main">
		<header><img alt="" src="${pageContext.request.contextPath}/active/newHandReward/images/newHandReward1.png"></header>
		<%--注册 --%>
		<div class="registerBox">
			<form class="form_box clearfix">
				<p><input type="text" value="" id="m" name="m" placeholder="请输入手机号" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/></p>
				<p><input type="text" value="" id="vc" name="vc" placeholder="输入验证码"/><input type="button" id="getc" value="点击获取"/></p>
				<p id="prompt_txt"></p>
				<p><input class="checkbtn" type="button" value="我要领取"/></p>
				
			</form>
			<div class="newHandReward_txt">
				<h3 style="padding-left:15px;color:#51C3FF;">活动说明</h3>
				<p>1.注册完成后即赠送100M流量（此步骤不含实名认证）。</p>
				<p>2.绑卡成功后即赠送100M流量（此步骤含实名认证和绑卡）。</p>
				<p>3.投资成功后即赠送20元话费（首次投资后）</p>
				<p>4.若未立即到账，请耐心等待，客服人员将再次充值到账。非工作时间未立即到账，第二个工作日到账。</p>
				<p>5.请在“账户中心->我的奖励->奖品”中查看奖励</p>
			</div>
		</div>
		<div class="nextRgister">
		     <div class="awardDiv">
		        <p>恭喜您获得<font>100M</font></p>
		     </div>
		     <p class="ngClicks">查看流量：<a id="viewGift" href="javascript:;">点击这里</a></p>
		     <div class="downLoad navbar-fixed-bottom">
		        <p>
		        <a id="downs" href="javascript:;">下载瑞钱宝APP</a>
		        </p>
        </div>
		</div>	
	</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/active/newHandReward/newHandReward.js"></script>
</body>
</html>
