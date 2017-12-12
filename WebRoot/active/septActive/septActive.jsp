<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*,java.net.URLDecoder"
    pageEncoding="UTF-8"%>
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
        System.out.println("referHex:" + referHex);
        //refer需要Hex解码
//         if (referHex != null) {
//         byte[] bs = Hex.decodeHex(referHex.toCharArray());
//         refer = new String(bs);
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

    String utm_source = request.getParameter("utm_source");//渠道
%> 

<script>
  var _url = "";
</script>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
  <meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
  <meta name="description" content="瑞钱宝互联网金融平台投资越多惊喜越多,年收化率7%-13.5%，" />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
  <link href="${pageContext.request.contextPath}/active/septActive/css/animate.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/common2.css" rel="stylesheet"/>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wechat2.css">
  <link href="${pageContext.request.contextPath}/active/septActive/css/septActive.css" rel="stylesheet">
  <script src="${pageContext.request.contextPath}/js/jquery-1.11.2.min.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
<script> 
  $(function(){
    
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
      if (browser.versions.android == true) {
        $('#downs').attr('href','http://file.rqbao.com/android/latest/ruiqianbao_ditui_red.apk');
      }
      if (browser.versions.ios == true) {
         $('#downs').attr('href','http://a.app.qq.com/o/simple.jsp?pkgname=com.dyxd.rqt&g_f=991653');
      }
      else{
        $("#downs").attr('href','http://file.rqbao.com/android/latest/ruiqianbao_ditui_red.apk');
      };
      
  })
    /*标题 */
    function showShare(){
        IOSModel.changeWebTitle("玩转9月 抖抖小手抢福利");
      }
    $(function(){
        title = "玩转9月 抖抖小手抢福利";
        content = "用力疯摇抢福利，各种优惠券和周大福30g金条在等你哦！";
      icon = "<%=basePath %>/images/logo/septActive.png";
      url  = "<%=basePath %>/active/septActive/septActive.jsp?from=app&utm_source=<%=utm_source %>";
      _url = "<%=basePath %>/active/septActive/septActive.jsp?from=app&utm_source=<%=utm_source %>";
       // getReferenceRank();
      /*分享好友*/
        weixinShare(title,content,icon,_url,'<%=basePath%>');
        
        if("<%=userApp %>" != null && 
            "<%=userApp%>" != "" && 
            "<%=userApp%>" != "null") {
        }
        
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
<body class="septActiveBody">
<input type="hidden" id="utm_source" value="<%=utm_source %>">
<input type="hidden" value=" <%=localPath%>" id="localPath">
<input type="hidden" value="<%=basePath%>" id="basePath">
<input type="hidden" value="<%=user%>" id="user">
<input type="hidden" value="<%=userId %>" id="userId">
 <section class="activybanner">
       <img src="<%=basePath%>/active/septActive/images/acticeBanner.png" alt="8月新手"/>
  </section>  
  <!-- 摇一摇活动部分 -->
  <section class="banner-shake">
      <img src="images/bg-shake.png">
        <div class="shake-box">
          <div class="circle">
                <img class="circle-b" src="images/circle-b.png">
                <!--摇一摇图片-->
                <div class="hand-panda" id="animationSandbox">
                  <img src="images/hand-panda.png">
                </div>
            </div>
        </div>
    </section>
   <!-- 1、活动规则 -->
  <section>
      <p class="activeTitle"> <img alt="活动规则" src="images/ruleTile.png"></p>
      <div  class="activeRule">
        <p>1.活动时间：9月4日-9月30日；</p>
        <p>2.每位用户每天有1次摇奖机会，活动期间可摇8次，新用户首次投资成功后可参与摇一摇。摇奖获得的优惠券请在我的奖励中查看，优惠券有效期至9月30日23:59:59，实物奖品10个工作日内发放；</p>
        <p>3.活动期间用户每天均可投抢标项目；</p>
        <p>4.如有疑问，请拨打客服热线：400-919-8555。</p>
      </div>
  </section> 
 <!-- 遮罩层 --> 
<section class="layer">
		<div class="bg"></div>
		<div class="dialog succ"><!--æå-->
				<div class="result-hd">
					    <h4>恭喜您</h4>
					    <p class="tip">获得 <span>100</span><font></font></p>
				 </div><!--hd-->
				<div class="lottery-msg">
				      <img src="images/lotteryBg.png">
		          <div class="lotteryImg">
		              <span></span>
		          </div>		
				</div>
				<p class="txtMsg"></p>
				<p class="lotteryBtn"><a href="javascript:void(0);" class="btns" onClick="$('.bg').hide();$('.succ').hide();">确认</a></p>
				<div class="lotteryProject">
				    <p class="borderStyle"></p>
				    <img class="" src="images/clockBg.png">
				</div>
		</div>
		<div class="login">
		    <img class="" onclick="toLogin();" src="images/login_img.png">
		</div>
</section>
<script type="text/javascript">
  var utm_source=$("#utm_source").val();
	  /*进入登录 页面 */
	  function toLogin() {
	      if (isAndroidOrIos()) {
	          IOSModel.login();
	      appFunction('login');
	      } else {
	          window.location.href = "<%=basePath%>/login.jsp?active=jdBring";
	      }
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
<script src="${pageContext.request.contextPath}/active/septActive/active.js" type="text/javascript"></script>   
</body>
</html>
