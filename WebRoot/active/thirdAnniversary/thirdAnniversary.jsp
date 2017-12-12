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
 String referrer = request.getParameter("referrer");//获得的推荐人是Hex编码
 String userApp = request.getParameter("user");
 if (from != null && "app".equals(from)) {
     user = userApp;
     hs.setAttribute("loginUser", user);
     //app上无分享功能
 } else if (hs != null) {
     user = (String) hs.getAttribute("loginUser");
     if (user == null) {
         user = "";
     }
     if (user != null && user != "") {
//          userHex = Hex.encodeHexString(user.getBytes());//将用户Hex编码，用于分享
         
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
    userId = (String) hs.getAttribute("userId");
    user = (String) hs.getAttribute("loginUser");
%>
<%@ include file="/config/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
	<title>见证3周年，全场加息</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wechat2.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
  <link href="${pageContext.request.contextPath}/css/common2.css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/active/thirdAnniversary/thirdAnniversary.css" rel="stylesheet">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
	<script>
		/*标题 */
		function showShare(){
			IOSModel.changeWebTitle("见证3周年，全场加息 ");
		}
		/*分享好友*/
		$(function(){ 
			title = "见证3周年，全场加息 ";
			content = "除了全场加息，充值还送红包哦！！！";
			icon = "<%=basePath %>/images/logo/thirdAnniversary.png";
			url  = '<%=basePath %>/active/thirdAnniversary/thirdAnniversary.jsp?referrer=<%=user%>';
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
		/*分享 */
		  function shareClick() {
		    var uu = '<%=userApp%>';
		    var uu2 = '<%=user%>';
		    if(uu =='null' && ( uu2 =='null' || uu2 =='')){
		      showAys3("您还没有登录，需要登录后才可以分享，现在去登录？");
		    }else{
		      if (isAndroidOrIos()) {
		              IOSModel.noticeShare({
		                  "url" : url,
		                  "title" : title,
		                  "content" : content,
		                  "icon" : icon
		              });
					   
		              iosShare(title, content, icon, url);
		              appFunction('share');
		          } else {
		        	  if (browser.versions.android == true) {
		  				goAndroid();
		  		        if(navigator.userAgent.indexOf('MicroMessenger') > -1){
		  		        	showShareBox();
		  		        }
		  		      }
		  		      else if (browser.versions.ios == true) {
		  		    	  goIos()
		  		      } 
		  		      else{
		  		    	  goAndroid();
		  		      }
		          }
		    }
		  }
	      function showShare() {
		      IOSModel.showShareBtn();
	      }
		function shareWithType() {
			var shareUrl=url;
			if("<%=userApp %>" != null && "<%=userApp %>" != "" && "<%=userApp %>" != "null"){
				shareUrl=url+"?referrer="+$("#loginName").val();
		    }
			IOSModel.noticeShare({
			    "url" : shareUrl,
			    "title" : title,
			    "content" : content,
			    "icon" : icon
		  	});
		};
		
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
	          window.location.href = "<%=basePath%>/login.jsp?active=518active";
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
   
    /*进入充值页面  */
    function toReaharge() {
      if (isAndroidOrIos()) {
        	IOSModel.toAccountCenter();
          appFunction('toAccountCenter');
      } else {
        window.location.href = "<%=basePath%>/personal_center.jsp";
      }
     
    }
   
 
	</script>

</head>
<body class="thirdAnniversaryBody">
	<input type="hidden" id="user" value="<%=user%>" />
	<input type="hidden" id="userId"  value="<%=userId%>"/>
	<img alt="瑞钱宝三周年" src="<%=basePath%>/active/thirdAnniversary/image/activeBanner.png"/>
	<img alt="项目"  src="<%=basePath%>/active/thirdAnniversary/image/projectImg.png"/>
	<img alt="投资享加息" onclick="toProject();" src="<%=basePath%>/active/thirdAnniversary/image/title1.png"/>
	<img alt="充值送红包" src="<%=basePath%>/active/thirdAnniversary/image/red_packetImg.png"/>
	<p id="goRecharge"><img alt="充值送红包"  src="<%=basePath%>/active/thirdAnniversary/image/title2.png"/></p>
	<img alt="活动规则" style="margin-top:1rem;" src="<%=basePath%>/active/thirdAnniversary/image/title3.png"/>
	<section class="activeRule">
	   <p>1.活动时间：2017年8月4日18:00-8月31日17:00。</p>
	   <p>2.用户在活动期间每充值一次即获一张对应的投资返现红包。红包在活动期间有效，投资成功后2个工作日内返现到账户。</p>
	   <p>3.活动期间，加息和红包可同享。</p>
	   <p>4.如有疑问，请拨打官方客服热线:400-919-8555。</p>
	</section>
	<script>
	
	   $(function(){
		      
		     /*立即获得按钮 */
		       var  userId = $("#userId").val();
		       var  user = $("#user").val();
		       if ((userId == "" || userId == null || userId == "null") && (user == "" || user == null || user == "null")){
		         
		         $("#goRecharge img").attr("onclick","toLogin();");
		         
		       }  else {
		         
		         $("#goRecharge img").attr("onclick","toReaharge();");
		         
		       }
		         
		       
		     })
	
	</script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
</body> 
</html>
