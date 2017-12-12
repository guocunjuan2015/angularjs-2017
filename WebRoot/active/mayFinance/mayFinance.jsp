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
  <title>五月理财节</title>
  <meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
  <link href="<%=basePath%>/css/common2.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/active/mayFinance/mayFinance.css" rel="stylesheet">
  <script src="<%=basePath%>/js/jquery-1.11.2.min.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
  <script> 
    /*标题 */
    function showShare(){
        IOSModel.changeWebTitle("五月理财节");
      }
    $(function(){
        title = "五月理财节";
        content = "瑞钱宝—大型国企参股，多种优质项目，让您轻松理财！";
      icon = "<%=basePath %>/images/logo/mayFinance.png";
      url  = "<%=basePath %>/active/mayFinance/mayFinance.jsp?from=app&utm_source=<%=utm_source %>";
      _url = "<%=basePath %>/active/mayFinance/mayFinance.jsp?from=app&utm_source=<%=utm_source %>";
       // getReferenceRank();
      /*分享好友*/
        weixinShare(title,content,icon,_url,'<%=basePath%>');
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
        
        /*进入我的理财页面 */
        function toProject() {
          if (isAndroidOrIos()) {
            IOSModel.toIosInvest();
            toIosInvest();
            appFunction('invest');
          } else {
            window.location.href = "<%=basePath%>/project.jsp";
          }
        }

       
  </script>
</head>
<body style="background:#FF7D49;">
  <input type="hidden" value="" name="types" id="types">
  <input type="hidden" value="<%=basePath%>"  id="basePath">
  <input type="hidden" value="<%=localPath%>"  id="localPath">
  <input type="hidden" value="<%=utm_source %>" id="channel"/>
  <input type="hidden" value="<%=userAppId %>" id="userId"/>
  <div class="may">
		<img class="maybanner" src="<%=basePath%>/active/mayFinance/images/banner.png" alt="五月理财节">
		<div class="clearfix maybg">
			<h3 class="mayTitle"><img src="<%=basePath%>/active/mayFinance/images/maytit1.png" alt="活动加息"></h3>
			<div class="mayProject">
				<img onclick="toProject();" src="<%=basePath%>/active/mayFinance/images/may1.png" alt="30天项目">
			</div>
			<div class="mayProject">
				<img onclick="toProject();" src="<%=basePath%>/active/mayFinance/images/may2.png" alt="90天项目">
			</div>
			<div class="mayProject">
				<img onclick="toProject();" src="<%=basePath%>/active/mayFinance/images/may3.png" alt="180天项目">
			</div>
			<div class="mayProject">
				<img onclick="toProject();" src="<%=basePath%>/active/mayFinance/images/may4.png" alt="360天项目">
			</div>
			<h3 class="mayTitle"><img src="<%=basePath%>/active/mayFinance/images/maytit2.png" alt="举例说明"></h3>
			<img class="mayExample" alt="" src="<%=basePath%>/active/mayFinance/images/may5.png">
			<h3 class="mayTitle"><img src="<%=basePath%>/active/mayFinance/images/maytit3.png" alt="活动说明"></h3>
			<div class="maytxt">
				<ul>
					<li>1. 活动时间：2017年4月28日-5月30日；</li>
					<li>2. 2017年4月28日-5月30日上标的项目即为活动的加息项目；</li>
					<li>3. 小额贷项目不参与加息活动；</li>
					<li>4. 加息标的可以使用优惠券；</li>
					<li>5. 特约标参与加息活动。</li>
				</ul>
			</div>
			<p class="mayPrompt">＊本次活动最终解释权归瑞钱宝所有</p>
		</div>
	</div>
</body>
</html>
