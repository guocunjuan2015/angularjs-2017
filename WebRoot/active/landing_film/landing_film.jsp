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
  <title>【爱】从一场免费电影开始 </title>
  <meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
  <meta name="description" content="瑞钱宝互联网金融平台投资越多惊喜越多,年收化率7%-13.5%，活动期间你可以选择适合您的理财产品，活动期间设置自动幸运抽奖区，投资理财奖品主要有三星电视、九阳榨汁机、iphone 6s 等，活动时间6月6日-6月24日。" />
  <link href="<%=basePath%>/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%=basePath%>/css/common2.css" rel="stylesheet"/>
  <link href="<%=basePath%>/css/main.css" rel="stylesheet"/>
  <link href="<%=basePath%>/css/register.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/active/landing_film/landing_film.css" rel="stylesheet">
  <script src="<%=basePath%>/js/jquery-1.11.2.min.js" type="text/javascript"></script> 
  <script src="<%=basePath%>/js/bootstrap.min.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
  <script src="<%=basePath%>/js/utils.js" type="text/javascript"></script> 
  <script src="<%=basePath%>/js/zhuge_ini.js" type="text/javascript"></script>
      <script>
      /*标题 */
        function showShare(){
             IOSModel.changeWebTitle("【爱】从一场免费电影开始 ");
        }
      
        $(function() {
          var _referrer = getURLParam('referrer');
          if (_referrer && _referrer != 'null') {
            
             $('#referrer').val("<%=referrer%>");
          }
    
          title = "【爱】从一场免费电影开始 ";
          content = "瑞钱宝—大型国企参股，多种优质项目，让您轻松理财！";
          icon = "<%=basePath %>/images/logo/landing_film.png";
          url  = "<%=basePath %>/active/landing_film/landing_film.jsp?utm_source=<%=utm_source %>";
             // getReferenceRank();
          /*分享好友*/
          weixinShare(title,content,icon,url,'<%=basePath%>');
          
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
            language : (navigator.browserLanguage || navigator.language).toLowerCase()
          }
          })
          /**
           * 从URL中获取参数
           * @param {Object} name
           */
           function getURLParam(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if(r != null) return unescape(r[2]);
            return null;
           }
           
           
  </script>
</head>
<body style="background:#FCEBDF">
  <input type="hidden" value="<%=basePath%>"  id="basePath">
  <input type="hidden" value="<%=localPath%>"  id="localPath">
  <input type="hidden" id="user" value="<%=user%>" />
  <input type="hidden" id="userId"  value="<%=userId%>"/>
  <input type="hidden" value="<%=utm_source%>" id="utm_source"/>
    <header>
         <img alt="" src="${pageContext.request.contextPath}/active/landing_film/image/banner.png">
    </header>
      <section class="registerBg toRight" style="padding:0.6rem 0 1.5rem 0;">
          <div id="showMess" style="clear:both;color:#ff5555; text-align: center;">&nbsp;</div>
          <div class="login">
              <input type="text"  id="m" placeholder="您的手机号码" onkeyup="inputKeyUp(this.value,this.id,1,'clear_phone')"/>
              <img class="input-clear" src="<%=basePath%>/images/input_clear.png" id="clear_phone" onclick="clearInput('m',this.id)"/>
          </div>
          <div class="login">
              <input data-role='none' id="p" name="p" onkeyup="inputKeyUp(this.value,this.id,2,'clear_psw')"
              type="password" placeholder="请输入登录密码"/>
              <img class="input-clear" src="<%=basePath%>/images/input_clear.png" id="clear_psw" onclick="clearInput('p',this.id)"/>
          </div>
          <div class="login">
              <input type="text" style="width:100%;" id="referrer" name="referrer" placeholder="推荐手机号（可不填）">
          </div>
          <div class="login" style="border:none;background:none;">
              <input data-role='none'  id="vc" name="vc" type="text" placeholder="图片验证码" style="float:left;width:54%;"/>
                <span class="vcode">
                  <img id="imgObj" alt="换一张" title="点击图片换一张" src="<%=localPath%>/servlet/validateCodeServlet?'+new Date().getTime()" 
                  onclick="changeVCode()" />
              </span>
              <div class="clear"></div>
            </div>
            <div class="login">
              <input type="text"  id="c" style="width:50%;" placeholder="手机验证码"  IME-MODE: disabled"
              onkeyup="this.value=this.value.replace(/\D/g,'')">
              <button class="btn-pin get_code" id="getc">获取验证码</button>
              <div class="clear"></div>
            </div>
            <!-- <button class="btn-no-pin" onclick="showGetRadioCode()">没有收到验证码</button> -->
            <div class="agreement">
		            <div class="squaredTwo bg" onclick="onBoxClicked()">
		            <input type="checkbox" id="agreeBox" value="None" name="check" checked>
		            <label for="squaredTwo"></label>
          </div>
                <span>我同意并接受</span>
                <a onclick="toProxy()">《瑞钱宝服务协议》</a>
            </div>
            <p>
                <button class="btn btn-next " id="step" ></button>
            </p>
    </section>
    <!-- 领取方式start -->
    <section class="getWays">
         <img alt="领取方式 "  class="title" src="${pageContext.request.contextPath}/active/landing_film/image/title1.png">
         <img alt="领取方式 "  class="getWaysImg" src="${pageContext.request.contextPath}/active/landing_film/image/getWaysImg.png">
    </section>
    <!-- 惊喜不断start -->
     <section class="getWays">
         <img alt="" class="title"  src="${pageContext.request.contextPath}/active/landing_film/image/title2.png">
         <img alt="" class="bring" src="${pageContext.request.contextPath}/active/landing_film/image/bring.png">
    </section>
    
     <footer>
          <div class="regtel">瑞钱宝客服热线：<a href="tel:400-919-8555">400-919-8555</a></div>
          <p>瑞钱宝资产管理服务有限公司  版权所有</p>
          <p><span>京ICP备14024431号</span><span>京ICP证160571号</span></p>
          <p>市场有风险  投资需谨慎</p>
   </footer>
  <script src="<%=basePath%>/js/ump_register.js" type="text/javascript"></script>  
</body>
</html>
