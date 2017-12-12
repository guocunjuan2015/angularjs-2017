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
    String utm_source = request.getParameter("utm_source");//渠道

%>  
<script>
  var _url = "";
</script>

<%@ include file="../../config/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
  <title>注册领红包</title>
  <meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
  <meta name="description" content="瑞钱宝互联网金融平台投资越多惊喜越多,年收化率7%-13.5%，" />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
  <link href="${pageContext.request.contextPath}/css/common2.css" rel="stylesheet"/>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wechat2.css">
  <link href="${pageContext.request.contextPath}/active/red_packet/red_packet.css" rel="stylesheet">
  <script src="<%=basePath%>/js/jquery-1.11.2.min.js" type="text/javascript"></script>
  <script src="<%=basePath%>/js/remChange.js" type="text/javascript"></script>  
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
        IOSModel.changeWebTitle("注册领红包");
      }
    $(function(){
      title = "注册领红包";
      content = "注册瑞钱宝即享108元红包，复投立享2%加息券，立即参与";
      icon = "<%=basePath %>/images/logo/red_packet.png";
      url  = "<%=basePath %>/active/red_packet/red_packet.jsp?from=app&utm_source=<%=utm_source %>";
      _url = "<%=basePath %>/active/red_packet/red_packet.jsp?from=app&utm_source=<%=utm_source %>";
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
<body class="red_packetBody">
<input type="hidden" id="utm_source" value="<%=utm_source %>">
<input type="hidden" id="userId"  value="<%=userId%>"/>
<input type="hidden" value="<%=localPath%>" id="localPath">
<input type="hidden" value="<%=basePath%>" id="basePath">
<input type="hidden" value="<%=user%>" id="user">
<input type="hidden" value="<%=userApp %>" id="userApp"/>
  <section class="activybanner">
       <img src="<%=basePath%>/active/red_packet/images/activeBanner.png" alt="8月新手"/>
       <img src="<%=basePath%>/active/red_packet/images/coupon1.png" alt="新手注册即送108红包"/>
       <img src="<%=basePath%>/active/red_packet/images/coupon2.png" alt="首复投成功即送1.6%加息券"/>
       <img src="<%=basePath%>/active/red_packet/images/coupon3.png" alt="新手享受预期收益12%"/>
       <img src="<%=basePath%>/active/red_packet/images/coupon6.png" alt="活动说明"/>
  </section>
  <section class="activeRule">
        <p>1.活动时间：2017年11月1日－2017年12月31日;</p>
        <p>2.活动发放的红包和加息券请在“账户中心－我的奖励”中查看，用户可在投资时使用;</p>
        <p>3.投资成功标满计息，红包对应金额会返到“账户中心－账户余额”中。</p>
  </section> 
  <img src="<%=basePath%>/active/red_packet/images/coupon4.png" alt="活动说明"/>
  <img class="coupon5" src="<%=basePath%>/active/red_packet/images/coupon5.png" alt="活动说明"/>  
  <section class="registerZone">
	    <p class="registerBtn"><img onclick="goToRegister();" src="<%=basePath%>/active/red_packet/images/registerBtn.png" alt="注册领红包"/></p>
	    <p class="investBtn"><img onclick="toProject();" src="<%=basePath%>/active/red_packet/images/investBtn.png" alt="立即投资"/> </p>
  </section>   
</body>
<script type="text/javascript">
	var utm_source=$("#utm_source").val();
	 /*进入注册  */
	function goToRegister(){
		   IOSModel.iosRegist();
	       if (isAndroidOrIos()) {
	    	   
		        iosRegist();
		        appFunction('regist');
		        
	      } else { 
		    	  if(utm_source =='2017' || utm_source =='2018' || utm_source =='2019'|| utm_source =='2021' || utm_source =='2022' || utm_source =='2024' || utm_source =='2026' || utm_source =='2027'|| utm_source =='2029'|| utm_source =='2030'|| utm_source =='2031'|| utm_source =='2032' || utm_source =='2033'){
					
		    		  window.location.href = "<%=basePath%>/register.jsp?utm_source=<%=utm_source %>";
					} else {
						
						window.location.href = "<%=basePath%>/ump_register.jsp?utm_source=<%=utm_source %>";
					
					}
	        
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
	  
	$(function(){
	    /*注册按钮  */
	      var  userId = $("#userId").val();
	      var  user = $("#user").val();
	         if ((userId == "" || userId == null || userId == "null") && (user == "" || user == null || user == "null")){
	           
	          $(".registerBtn").show();
	          $(".investBtn").hide();
	           
	         }  else {
	           
	        	 $(".registerBtn").hide();
	           $(".investBtn").show();
	           
	         }
	      
	    
	  })

</script>
</html>
