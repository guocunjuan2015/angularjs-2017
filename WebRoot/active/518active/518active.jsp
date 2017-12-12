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
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
  <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
  <title>嗨翻518</title>
  <meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
  <meta name="description" content="瑞钱宝互联网金融平台投资越多惊喜越多,年收化率7%-13.5%，" />
  <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/common2.css" rel="stylesheet"/>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wechat2.css">
  <link href="${pageContext.request.contextPath}/active/518active/518active.css" rel="stylesheet">
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/global_register.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/utils.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
  <script>
  /*标题 */
    function showShare(){
      IOSModel.changeWebTitle("投资领出行装备");
    }
    /*分享好友*/
    $(function(){ 
      title = "嗨翻518";
      content = "瑞钱宝—大型国企背景，多种优质项目，让您轻松理财！";
      icon = "<%=basePath %>/images/logo/518active.png";
      url  = '<%=basePath %>/active/518active/518active.jsp';
       // getReferenceRank();
       weixinShare(title,content,icon,url,'<%=basePath%>');
   });
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
   
    /*进入网贷天眼  */
    function toChannel() {
        window.location.href = "http://t.cn/RahbSF2";
    }
   
    $(function(){
    	
        $(".active518_dialog").click(function(){
           $(".active518_dialog").hide();
          $(".bg").hide();
        })
        
        if("<%=userId%>" == "" || "<%=userId%>" == null || "<%=userId%>" == "null"){
        	
        	 $(".active518_dialog").hide();
             $(".bg").hide();
        	
        } else {
        	
        	$(".active518_dialog").show();
          $(".bg").show();
        }
        
        
      })
  </script>
</head>
<body style="background:#FFF1AB;">
<input type="hidden" id="basePath" value="<%=basePath%>">
<input type="hidden" id="local" name="localPath" value="<%=localPath%>"/>
<input type="hidden" id="userId" name="userId" value="<%=userId%>"/>
	<script>
	 var basePath = $("#basePath").val();
	 var local = $("#local").val();
	 
	</script>
	<div class="activityBanner">
	     <img id="register_btn" src="<%=basePath%>/active/518active/images/activity.jpg"/>  
	</div>
	     <div class="activityBg1">
	         <div class="activeForm">
	                 <div id="showMess">&nbsp;</div>
		               <ul> 
		                   <li>
		                       <input type="text" class="form-control"  id="m" placeholder="请输入您的手机号码" onkeyup="inputKeyUp(this.value,this.id,1,'clear_phone')"/>
		                       <img class="input-clear" src="<%=basePath%>/images/input_clear.png" id="clear_phone" onclick="clearInput('m',this.id)"/>
		                   </li>
		                   <li>
		                      <input data-role='none' class="form-control" id="p" name="p" onkeyup="inputKeyUp(this.value,this.id,2,'clear_psw')"type="password" placeholder="请输入登录密码"/>
		                        <img class="input-clear" src="<%=basePath%>/images/input_clear.png" id="clear_psw" onclick="clearInput('p',this.id)"/>
		                   </li>
		                   <li>
		                      <input data-role='none'  class="form-control" id="vc" name="vc" type="text" placeholder="图片验证码" style="float:left;width:60%;"/>
					                <span class="vcode">
					                  <img id="imgObj" alt="换一张" title="点击图片换一张" src="<%=localPath%>/servlet/validateCodeServlet?'+new Date().getTime()" 
					                  onclick="changeVCode()" />
					                </span>
                       </li>
                       <li style="display: none">
                          <input type="text" style="width:100%;" id="referrer" name="referrer" placeholder="推荐手机号（可不填）">
                       </li>
                       <li class="verCode">
                          <input type="text"  class="form-control" id="c"  placeholder="手机验证码"  IME-MODE: disabled"
						              onkeyup="this.value=this.value.replace(/\D/g,'')">
						              <button class="btn-pin get_code" id="getc">获取验证码</button>
                       </li>
                       <li><img id="step"  src="<%=basePath%>/active/518active/images/activityBtn.jpg"/></li>
		               </ul><div class="clear"></div>   
	         </div>
       </div>
        <div class="activityBg2">
            <div class="activityRule">
                <p>1、活动时间：2017年5月5日10:00-2017年5月31日18:00；</p>
                <p>2、活动期间所获积分可在网贷天眼进行礼品兑换；</p>
                <p>3、在瑞钱宝平台单笔投资100元送1个积分、投资500到999元送5个积分、投资1000元及以上送10个积分；</p>
                <p>4、用户所获的积分会以短信形式通知,用户可进行复投获取积分；</p>
                <p>5、本活动限定在官方活动时间内新注册并投资的用户才可以获得积分。</p>
            </div> 
       </div>
       <p class="activityBtn1"><img onclick="toChannel();" id="register_btn" src="<%=basePath%>/active/518active/images/activityBtn1.jpg"/></p>
	    <%--  <div class="fixed_slide">
	       <p><a href="${ctx}/loan/loanQueryList2">投资获积分</a></p>
	       <p><a href="${ctx}/point/pointVip">查积分</a></p>
	     </div> --%>
	
	<div class="bg"></div>
      <div class="active518_dialog">
            <font></font>
            <h4>恭喜您</h4>  
            <p>恭喜你参加嗨翻518活动并获得1积<br/>分，获得更多积分</p>
            <p class="activityBtn2"><img onclick="toProject();"  src="<%=basePath%>/active/518active/images/activityBtn2.jpg"/></p>
      </div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>      
</body>
</html>
