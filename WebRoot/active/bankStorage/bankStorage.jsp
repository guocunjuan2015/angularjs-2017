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
String utm_source = request.getParameter("utm_source");//渠道
%>
<!DOCTYPE html>
<html lang="en" style="font-size:10px;">
<head>
	<meta charset="UTF-8">
	<title>银行存管隆重上线  </title>
	<meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财">
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
	<link href="<%=basePath%>/css/common2.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/active/bankStorage/bankStorage.css" rel="stylesheet">
  <script src="<%=basePath%>/js/jquery-1.11.2.min.js" type="text/javascript"></script> 
  <script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
	<script src="${pageContext.request.contextPath}/js/utils.js" type="text/javascript"></script>
  <script> 
    /*标题 */
    function showShare(){
        IOSModel.changeWebTitle("银行存管隆重上线 ");
      }
    $(function(){
        title = "银行存管隆重上线，拥抱监管，安全升级";
        content 
        = "瑞钱宝—大型国企背景，多种优质项目，让您轻松理财！";
      icon = "<%=basePath %>/images/logo/bankStorage.png";
      url  = "<%=basePath %>/active/bankStorage/bankStorage.jsp?from=app&utm_source=<%=utm_source %>";
      _url = "<%=basePath %>/active/bankStorage/bankStorage.jsp?from=app&utm_source=<%=utm_source %>";
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
<body>
<input type="hidden" value="<%=basePath%>"  id="basePath">
<input type="hidden" value="<%=localPath%>"  id="localPath">
<input type="hidden" id="userId"  value="<%=userId%>"/>
  <input type="hidden" id="user"   value="<%=user%>">
  <img  src="<%=basePath%>/active/bankStorage/images/bankStorageImg1.png" alt="银行存管"/>
	<img  style="margin-top:-5px;" src="<%=basePath%>/active/bankStorage/images/bankStorageImg2.png" alt="银行存管"/>
	<div class="copyRight">
	     <p class="pWord pWord1">开通银行存管账户，资金安全保障系数更高</p>
	     <p class="pWord pWord2"><a href="javascript:;" id="opened" onclick="goOpen();">立即开通</a></p>
	     <p class="pWord pWord3"><span>客服电话：<a href="tel:400-919-8555">400-919-8555</a></span></p>
	</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/custodyJs.js"></script>	
</body> 
</html>
