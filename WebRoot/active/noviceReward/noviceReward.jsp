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
  <title>新手奖励再升级</title>
  <meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
  <meta name="description" content="瑞钱宝互联网金融平台投资越多惊喜越多,年收化率7%-13.5%，活动期间你可以选择适合您的理财产品，活动期间设置自动幸运抽奖区，投资理财奖品主要有三星电视、九阳榨汁机、iphone 6s 等，活动时间6月6日-6月24日。" />
  <link href="<%=basePath%>/css/common2.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/active/noviceReward/noviceReward.css" rel="stylesheet">
  <script src="<%=basePath%>/js/jquery-1.11.2.min.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
  <script> 
    /*标题 */
    function showShare(){
        IOSModel.changeWebTitle("新手奖励再升级");
      }
    $(function(){
        title = "依国企华融天泽背景，坐享稳健收益，欢迎投资瑞钱宝";
        content 
        = "瑞钱宝—大型国企参股，多种优质项目，让您轻松理财！";
      icon = "<%=basePath %>/images/logo/noviceReward.png";
      url  = "<%=basePath %>/active/noviceReward/noviceReward.jsp?from=app&utm_source=<%=utm_source %>";
      _url = "<%=basePath %>/active/noviceReward/noviceReward.jsp?from=app&utm_source=<%=utm_source %>";
       // getReferenceRank();
      /*分享好友*/
        weixinShare(title,content,icon,_url,'<%=basePath%>');
    });
    
    /*注册 */
    function goRegister(){
        window.location.href = "<%=basePath%>/ump_register.jsp"
      }
  
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
<body style="background:#FF7D49;">
  <input type="hidden" value="" name="types" id="types">
  <input type="hidden" value="<%=basePath%>"  id="basePath">
  <input type="hidden" value="<%=localPath%>"  id="localPath">
  <input type="hidden" value="<%=utm_source %>" id="channel"/>
  <input type="hidden" value="<%=userAppId %>" id="userId"/>
    <header>
        <img alt="" src="${pageContext.request.contextPath}/active/noviceReward/images/banner.png">
    </header>
    <section class="triple_gifts">
          <img alt="" src="${pageContext.request.contextPath}/active/noviceReward/images/activeBg.png">
    </section>
    <div class="activeRules">
          <h1>活动规则：</h1>
          <ul>
              <li>活动时间：3月27日10:00-4月26日17:00；</li>
              <li>注册成功最高可获得1G流量，流量随机发放，以最终收到的流量为准；流量根据注册后投资的时间顺序充值，第二个工作
                                                日到账。手机号前两位如14/17号段的运营商暂不支持充值，流量充值成功后当月有效，请及时使用。</li>
              <li>首投奖励现金以投资金额的1%计算，多投多得，最高可获1000元现金奖励，现金奖励于投资成功后第二个工作日发放到账户中心的余额；
              </li>
              <li>复投再奖励600元理财红包，分别为50元、150元、400元三张；</li>
              <li>在活动时间内进行注册&投资可领取相应奖励，活动时间外操作成功无上述奖励；</li>
              <li>新手标不参与投资送现金，债权转让项目不参与本次活动；</li>
              <li>如需帮助请及时联系瑞钱宝官方客服：400-919-8555。</li>
          
          </ul>
      </div>
       <div class="shareBox">
		            <p class="upRegister"><a class="btn btn-danger" onclick="goRegister();" href="javascript:;">立即注册</a></p>
       </div>  
</body>
</html>
