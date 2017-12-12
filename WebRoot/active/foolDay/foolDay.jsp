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
    String referHex = request.getParameter("referrer");//获得的推荐人是Hex编码
    String refer = "";
    if (referHex == null) {
    refer = "";
} else { 
        //refer需要Hex解码
        if (referHex != null) {
        byte[] bs = Hex.decodeHex(referHex.toCharArray());
        refer = new String(bs);
    }
}
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
String number = request.getParameter("number");
%>  
<%@ include file="/config/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
  <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
  <title>微信投资“三重好礼”送不停！</title>
  <meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
  <meta name="description" content="瑞钱宝互联网金融平台投资越多惊喜越多,年收化率7%-13.5%，" />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
  <link href="${pageContext.request.contextPath}/css/common2.css" rel="stylesheet"/>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wechat2.css">
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
  <script>
    /*标题 */
    function showShare(){
      IOSModel.changeWebTitle("微信投资“三重好礼”送不停！");
    }
    /*分享好友*/
    $(function(){ 
      title = "微信投资“三重好礼”送不停！";
      content = "瑞钱宝—大型国企参股，多种优质项目，让您轻松理财！";
      icon = "<%=basePath %>/images/logo/foolDay.png";
      url  = '<%=basePath %>/active/foolDay/foolDay.jsp';
       // getReferenceRank();
       weixinShare(title,content,icon,url,'<%=basePath%>');
   });


  /**
  * item 第几个奖品
  * truntable 第几个转盘
  */
  /*获取项目根路径*/
  function getRootPath(){
    var path = "<%=localPath %>";
    return path;  
  }  
  
  
  /*分享 */
  function shareClick() {
    var uu = '<%=userApp%>';
    if(!uu){
      showAys3("您还没有登录，需要登录后才可以分享，现在去登录？");
    }else{ 
      if (isAndroidOrIos()) { 
        //alert(title);
        IOSModel.noticeShare({
          "url" : url,
          "title" : title,
          "content" : content,
          "icon" : icon
        });
        iosShare(title, content, icon, url);
        appFunction('share');
    } else {
              // showShareBox(); 
          }
      }
  }
  function showShare() {
    IOSModel.showShareBtn();
  }
  function shareWithType() {
    IOSModel.noticeShare({
      "url" : url,
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

    
  function toRegister() {
    if (isAndroidOrIos()) {
        IOSModel.login();
      appFunction('login');
    } else {
      window.location.href = "<%=basePath%>/ump_register.jsp";
    }
  }
</script>   

</head>
<body>
 <img onclick="toProject()" src="${pageContext.request.contextPath}/active/foolDay/images/foolBanner.png" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
</body> 
</html>
