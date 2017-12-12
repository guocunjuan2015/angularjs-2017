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
	<meta name="viewport"
  content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
	 <title>注册即送180元红包</title>
   <meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
  <meta name="description" content="瑞钱宝互联网金融平台投资越多惊喜越多,年收化率7%-13.5%，" />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
  <link href="${pageContext.request.contextPath}/css/common2.css" rel="stylesheet"/>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wechat2.css">
  <link href="${pageContext.request.contextPath}/active/registerToMoney/css/registerToMoney.css" rel="stylesheet">
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
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
			  IOSModel.changeWebTitle("注册即送180元红包");
			}
		$(function(){
		    title = "注册即送180元红包";
		    content = "瑞钱宝—大型国企参股，多种优质项目，让您轻松理财！";
			icon = "<%=basePath %>/images/logo/registerToMoney.png";
			url  = "<%=basePath %>/active/registerToMoney2/red_envelopeOffLine.jsp?from=app&utm_source=<%=utm_source %>";
			_url = "<%=basePath %>/active/registerToMoney2/red_envelopeOffLine.jsp?from=app&utm_source=<%=utm_source %>";
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
	      
	      function goToRegister(){
	    	    window.location.href = "<%=basePath%>/ump_register.jsp"
	    	  }
	    	  
		</script>
		
</head>
<body>
	<%@ include file="../../config/show_share.jsp" %>
	<div class="lotteryBanner"><img src="<%=basePath%>/active/registerToMoney/images/banner.png"/></div>
   <section class="tTitle" onclick="goToRegister();" style="padding-top:1rem;">
       <p><img src="<%=basePath%>/active/registerToMoney/images/tTitle.png"/></p>
  </section>
  <section class="registerProcess">
      <img src="<%=basePath%>/active/registerToMoney/images/registerProcess.png"/>
  </section>
   <section class="toRedEnvelope">
      <p class="fTitle"><img src="<%=basePath%>/active/registerToMoney/images/fTitle.png"/></p>
      <div class="redEnvelopeL">
           <ul>
                <li class="col-xs-6 col-sm-6 col-md-6  col-lg-6">
                    <div>
                      <b>10元</b>
                      <font>理财红包</font>
                    </div>
                    <p>投资金额：投资1000元</p>
                    <p>投资期限：90天及以上</p>
                </li>
                   <li class="col-xs-6 col-sm-6 col-md-6  col-lg-6">
                    <div>
                      <b>20元</b>
                      <font>理财红包</font>
                    </div>
                    <p>投资金额：投资800元</p>
                    <p>投资期限：30天及以上</p>
                </li>
                 <li class="col-xs-6 col-sm-6 col-md-6  col-lg-6">
                    <div>
                      <b>50元</b>
                      <font>理财红包</font>
                    </div>
                    <p>投资金额：投资5000元</p>
                    <p>投资期限：90天及以上</p>
                </li>
                
                 <li class="col-xs-6 col-sm-6 col-md-6  col-lg-6">
                    <div>
                      <b>100元</b>
                      <font>理财红包</font>
                    </div>
                    <p>投资金额：投资5000元</p>
                    <p>投资期限：180天及以上</p>
                </li>
           </ul><div class="clear"></div>
      </div>
      <p class="sTitle" style="margin-top:3rem;"><img src="<%=basePath%>/active/registerToMoney/images/sTitle.png"/></p>
            <div class="activeRuless">
               <p>1.红包领取方式:将“注册手机号”发送到瑞钱宝财富街微信公众号:rqbcfj即可。 </p> 
               <p>2.活动所有奖励以红包形式发放至用户“我的帐户－我的奖励－红包（查看红包使用规则和红包有效期）”中，可在用户投资时使用； </p> 
               <p>3.投资成功标满计息，红包对应金额会返到“我的帐户－可用帐户余额”中； </p> 
               <p>4.活动时间：2017年3月15日－2017年3月19日； </p> 
               <p>5.红包发放时间：当天注册顺延到下一个工作日发放，如遇节假日顺延到下一个工作日发放； </p> 
               <p>6.此活动仅针对微信端新注册用户； </p> 
               <p>7.最终解释权瑞钱宝所有。 </p> 
           </div>
    <p class="code"><img class="clearfix" src="<%=basePath%>/active/registerToMoney/images/code.png"/></p>
  
  </section> 
  
  <section class="copyRights">
      <p>*本次活动最终解释权归瑞钱宝所有，如有疑问请咨询400-919-8555</p>
  </section>
   
</body>
</html>
