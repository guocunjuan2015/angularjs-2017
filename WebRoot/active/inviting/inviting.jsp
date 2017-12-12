<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="UTF-8"%>
<%@ include file="/config/config.jsp" %>
<%@ include file="/config/show_share.jsp" %>
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

String phone = request.getParameter("phone");
String lotteryId = request.getParameter("lotteryId");
String number = request.getParameter("number");
%>  
<!DOCTYPE html>
<html style="font-size:62.5%;">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
	<title>新用户注册奖励-瑞钱宝</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wechat2.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
  <link href="${pageContext.request.contextPath}/css/common2.css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/active/inviting/css/inviting.css" rel="stylesheet">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/json2.js"></script>
  <script src="${pageContext.request.contextPath}/js/shake_sign.js" type="text/javascript"></script>
	<script>
		/*标题 */
		function showShare(){
			IOSModel.changeWebTitle("新用户注册奖励-瑞钱宝 ");
		}
		/*分享好友*/
		$(function(){ 
			title = "新用户注册奖励-瑞钱宝";
			content = "108元投资返现红包（限新用户注册）点击注册";
			icon = "<%=basePath %>/images/logo/inviting.png";
			url  = '<%=basePath %>/ump_register.jsp?referrer=<%=user%>';
			_url = "<%=basePath %>/ump_register.jsp?referrer=<%=user%>";
	       // getReferenceRank();
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
	   });
		/*安卓下载页面  */
        function goAndroid(){
           window.location.href = "http://o7yy4xew2.bkt.clouddn.com/ruiqianbao_ruiqianbao_v3.7.5_release.apk";
        }
        /*IOS下载活动页面 */
        function goIos(){
           window.location.href = "http://a.app.qq.com/o/simple.jsp?pkgname=com.dyxd.rqt&g_f=991653";
        }
		/*分享 */
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
               shareUrl=shareUrl;
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
			if("<%=userApp %>" != null && "<%=userApp %>" != "" && "<%=userApp %>" != "null"){
				shareUrl=url;
		    }
			IOSModel.noticeShare({
			    "url" : shareUrl,
			    "title" : title,
			    "content" : content,
			    "icon" : icon
		  	});
		};
		
		//隐藏分享   
		function dismissAys3(){
		    $("#bg")[0].style.display = "none";
		    $("#ays3")[0].style.display = "none";
		}
		
	 /*进入登录 页面 */
	   function toLogin() {
	        if (isAndroidOrIos()) {
	            IOSModel.login();
	          appFunction('login');
	        } else {
	          window.location.href = "<%=basePath%>/login.jsp?active=inviting";
	        }
	  }
	</script>

</head>
<body class="invitingBody">
<section class="alert-dialog" id="ays3">
    <h5 class="alert-dialog-title">提示信息</h5>
    <div class="alert-dialog-content" id="ays_content3"></div>
    <ul class="alert-dialog-button">
        <li onclick="dismissAys3()">取消</li>
        <li onclick="login()">确定</li>
    </ul>
</section>
	<input type="hidden" id="user" value="<%=user%>" />
	<input type="hidden" id="number" name="number" value=""/>
	<input type="hidden" value="${message}" id="url">
	<input type="hidden" value="<%=userAppId %>" id="userId">
	<input type="hidden" value="<%= lotteryId %>" id="lotteryId">
	<img  alt="邀请好友" src="<%=basePath%>/active/inviting/image/invite_banner.png"/>
	<img  alt="举例子" src="<%=basePath%>/active/inviting/image/friendImg.png"/>
	<p id="inviteBtn"><img  alt="举例子" src="<%=basePath%>/active/inviting/image/investBtn.png"/></p>
	<img  alt="举例子" src="<%=basePath%>/active/inviting/image/exampleImg.png"/>
	<img  alt="好友福利" src="<%=basePath%>/active/inviting/image/invtingWelfare.png"/>
	<section class="activeBg">
	   <h4><img  alt="活动规则" src="<%=basePath%>/active/inviting/image/activeTitle.png"/></h4>
	   <p>1. 活动时间：11月6日-12月31日；</p>
	   <p>2.邀请人是平台用户即可邀请好友注册；</p>
	   <p>3.每邀请一位好友注册，邀请人获60元投资红包，红包有效期为90天，活动期间最高可获1200元红包。被邀请人注册后30日内的投资均享邀请返现1%(年化投资额的1%)，返现无上限；</p>
	   <p>4.被邀请人投资成功后7个工作日内，一次性返现到邀请人的账户余额</p>
	   <p>5.债权转让和小额贷项目不参与返现；</p>
	   <p>6.邀请好友所获奖励可在个人中心-邀请好友中查看。</p>
	</section>
	<script>
	  
	 $(function(){
	      /*立即获得按钮 */
	        var  userId = $("#userId").val();
	        var  user = $("#user").val();
	           if ((userId == "" || userId == null || userId == "null") && (user == "" || user == null || user == "null")){
	             
	             $("#inviteBtn img").attr("onclick","toLogin();");
	             
	           }  else {
	             
	             $("#inviteBtn img").attr("onclick","shareClick();");
	             
	           }
	        
	      
	    })
	
	
	</script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
</body> 
</html>
