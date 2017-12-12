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
	<title>新用户注册奖励-瑞钱宝</title>
    <meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
    <meta name="description" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
 	  <link href="<%=basePath%>/css/common2.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/active/novice/novice.css" rel="stylesheet">
    <script src="<%=basePath%>/js/jquery-1.11.2.min.js" type="text/javascript"></script> 
	  <script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
	  <script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
	  <script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/json2.js"></script>
<script> 
    /*标题 */
    function showShare(){
        IOSModel.changeWebTitle("新用户注册奖励-瑞钱宝");
      }
    $(function(){
        title = "新用户注册奖励-瑞钱宝";
        content = "108元投资返现红包（限新用户注册）点击注册";
      icon = "<%=basePath %>/images/logo/novice.png";
      url  = "<%=basePath %>/active/novice/novice.jsp?from=app&utm_source=<%=utm_source %>";
      _url = "<%=basePath %>/active/novice/novice.jsp?from=app&utm_source=<%=utm_source %>";
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
<body style="background:#141038;max-width: 100%;">
	<input type="hidden" value="" name="types" id="types">
	<input type="hidden" value="<%=basePath%>"  id="basePath">
	<input type="hidden" value="<%=localPath%>"  id="localPath">
	<input type="hidden" value="<%=referrer %>"  id="referrer">
	<input type="hidden" value="<%=from%>"  id="from">
	<input type="hidden" value="<%=utm_source %>" id="channel"/>
	<input type="hidden" value="<%=userAppId %>" id="userId"/>
	<input type="hidden" value="" id="code"/>
		<section class="bannerBox">
		   <img alt="" class="novicebanner" src="${pageContext.request.contextPath}/active/novice/images/novicebanner.png">
		    <%--注册 --%>
		    <div class="form_box clearfix">
		          <p>
		            <input type="text"  placeholder="请输入手机号码" name="mobile" id="mobile">
		            <button type="button"  id="registerBtn">立即抢</button>
		          </p>
		          <p id="error_info"></p>
		    </div>
		    <section class="registerSucc">
		        <p>已放入<span id="phone"></span>的号码名下</p>
		        <p><img alt="" class="novicebanner" src="${pageContext.request.contextPath}/active/novice/images/novice2.png"></p>
		         <p> <button type="button"  onclick="toLogin();">登陆查看</button></p>
		    </section>
		     <div class="getSucc">
            
            <p>领取成功</p>  
             
         </div>
		</section>
		<div class="rule">
			<h3>活动说明</h3>
			<p>1.活动时间：9月4日-9月30日；</p>
			<p>2.中奖结果以短信形式发送，也可关注公众号“瑞钱宝财富街”了解； </p>
			<p>3.王者荣耀的皮肤每日随机发放一个皮肤，每日限时限量抢购；</p>
		  <p>4.新用户获赠的108元红包为投资返现红包，即投资成功满标计息后，红包对应金额返现到瑞钱宝账户余额；使用投资红包可投≥30天项目，有效期为30天；</p>
		  <p>5.用户获赠的加息券分别为首投和复投加息券。加息券可投≥30天项目，1000元起投，有效期30天。 </p>
		</div>
	<script>
	$(function(){
		//点击注册  
        $("#registerBtn").click(function(){
           var mobile = $("#mobile").val();//手机号码
           var pattern = /^0?(13[0-9]|15[0-9]|18[0-9]|14[0-9]|17[0-9])[0-9]{8}$/;//手机号码校验
           var deviceId = SMSdk.getDeviceId();
           var utm_source = $("#utm_source").val();
           if(mobile == "" || mobile == null){
             $("#error_info").show();
             $("#error_info").html("手机号码不能为空");
              return;
           }
         //手机号码输入校验
           if(pattern.test(mobile)){
             $("#error_info").hide();
             var objData = {
                mobile : mobile,
                deviceId : deviceId,
                referrer : '',
                channel : utm_source
             };
             $.ajax({
                      url:'<%=localPath%>/activity/reg/p?date='+new Date(),
                      type:'POST',
                      dataType:'json',
                      data: JSON.stringify(objData),
                      contentType: "application/json",
                      success:function(data){
                        if(data.result=="1"){
                        	  $(".form_box").hide();
                        	  $(".getSucc").show();
                        	  setTimeout(function(){ $(".getSucc").hide(); }, 1500);
                            setTimeout(function(){ $(".registerSucc").show(); }, 1600);
                            $("#phone").text(mobile);
                        	
                         } else {
                             $("#error_info").show();
                             $("#registerDiv").css("height","12.8rem");
                             $("#error_info").html(data.errInfo); 
                             return;
                           
                         }
                         
                        
                      },
                      error:function(){
                        
                        $("#error_info").html("注册失败 ");   
                        
                      }
                    
                  })
             
           } else {
                   $("#error_info").show();
                   $("#error_info").html("请输入格式正确的手机号! ");
             
           }
          
          
         }); 
        
        //动态监听zhuce输入框的边框 
        $("#mobile").bind('input propertychange',function(){
           var mobile = $("#mobile").val();//手机号码
           if(mobile == "" || mobile == null){
                 $("#error_info").show();
                 $("#error_info").html("手机号码不能为空");
                  return;
           } else {
             
                $("#error_info").hide();
           }
          
        })	
		
	})
	
	  /*进入登录 页面 */
     function toLogin() {
          if (isAndroidOrIos()) {
              IOSModel.login();
            appFunction('login');
          } else {
            window.location.href = "<%=basePath%>/login.jsp?active=novice";
          }
    }
	
	
	
	</script>
	 <script type="text/javascript" src="<%=basePath%>/js/shumei/ishumei.js"></script> 	
</body>
</html>
