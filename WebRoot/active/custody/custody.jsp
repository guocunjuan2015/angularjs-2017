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
  <title>返现无上限2%加息劵</title>
  <meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
  <meta name="description" content="瑞钱宝互联网金融平台投资越多惊喜越多,年收化率7%-13.5%，活动期间你可以选择适合您的理财产品，活动期间设置自动幸运抽奖区，投资理财奖品主要有三星电视、九阳榨汁机、iphone 6s 等，活动时间6月6日-6月24日。" />
  <link href="<%=basePath%>/css/common2.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/active/custody/custody.css" rel="stylesheet">
  <script src="<%=basePath%>/js/jquery-1.11.2.min.js" type="text/javascript"></script> 
  <script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/json2.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.slotmachine.js"></script>
  <script> 
    /*标题 */
    function showShare(){
        IOSModel.changeWebTitle("返现无上限2%加息劵");
      }
    $(function(){
        title = "依国企华融天泽背景，坐享稳健收益，欢迎投资瑞钱宝";
        content 
        = "瑞钱宝—大型国企参股，多种优质项目，让您轻松理财！";
      icon = "<%=basePath %>/images/logo/custody.png";
      url  = "<%=basePath %>/active/custody/custody.jsp?from=app&utm_source=<%=utm_source %>";
      _url = "<%=basePath %>/active/custody/custody.jsp?from=app&utm_source=<%=utm_source %>";
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
<body style="background:#FCE8DD">
  <input type="hidden" value="" name="types" id="types">
  <input type="hidden" value="<%=basePath%>"  id="basePath">
  <input type="hidden" value="<%=localPath%>"  id="localPath">
  <input type="hidden" id="user" value="<%=user%>" />
  <input type="hidden" id="userId"  value="<%=userId%>"/>
  <input type="hidden" value="" id="code"/>
    <header>
       <img alt="" src="${pageContext.request.contextPath}/active/custody/image/custodyBanner.png">
    </header>
	    <div class="checkbox-slider">
	                   <section class="model-2">
	                      <div class="checkbox">
	                         <span>弹幕：</span>
	                         <input checked="checked" id="checkedbtn" type="checkbox"/>
	                          <label></label>
	                      </div>
	                  </section> 
	                 
	    </div>
	   <p class="getNum">已有 <span id="getNum"></span>人领取加息券</p> 
     <p class="titleImg"><img alt="" src="${pageContext.request.contextPath}/active/custody/image/titleImg1.png"></p>
     <p class="custody_title">2%的加息劵用完了？别担心，还能领</p>
    <div class="dynBackground">
        <div class="textScroll">
            <!--onmouseout=this.start() onmouseover=this.stop()-->
		          
        </div><!--textScroll end  -->
    </div>
     <p><img id="rateBtn" alt="" src="${pageContext.request.contextPath}/active/custody/image/rateBg.png"></p>
     <p class="titleImg"><img alt="" src="${pageContext.request.contextPath}/active/custody/image/titleImg2.png"></p>
     <p class="custody_title" style="margin-bottom:1rem;color:#F12755;">您可获得：返现金＋加息劵收益＋项目收益＋本金</p>
    <img alt="" src="${pageContext.request.contextPath}/active/custody/image/activeBg.png">
    <!--活动说明 -->
    <p class="titleImg"><img  src="image/titleImg3.png"/></p>
    <div class="activeBg">
            <div class="active_rule">
                <div><span>1</span><p>活动时间：7月03日10：00-7月20日17：00；</p></div>
                <div><span>2</span><p>所获加息券自领取之日至7月20日23:59:59之前有效；</p></div>
                <div><span>3</span><p>现金奖励于项目满标后7个工作日内发至瑞钱宝账户余额，可提现；</p></div>
                <div><span>4</span><p>投资金额≥10000元享返现，返现和加息同享，与特约标加息不同享；</p></div>
                <div><span>5</span><p>如需帮助请联系瑞钱宝官方客服热线:400-919-8555（工作日9:00-18:00）。</p></div>
                <div class="clear"></div>
            </div>
    </div>
    <p class="copyRight">＊本次活动最终解释权归瑞钱宝所有</p> 
    <div class="joinBox">
       <p style="text-align:center;"> <a class="joinBtn btn btn-danger clickPro"  href="javascript:;">立即投资</a></p>
    </div>
  <%--弹出框 --%>
<div class="bg"></div>
<!-- 可以领取-->
    <div class="dialog dialog1">
        <div class="close_btn">×</div>
        <h4>恭喜您</h4>
        <p class="mid_p">您已成功领取一张<span id="couponsNum"></span>的加息劵，<br/>今日还可领取<span id="remaNum"></span>张</p>
        <p class="checkoutRate"><a href="javascript:;" id="goMyGift">查看加息劵</a></p>
        <p class="use_coupons"><a href="javascript:;"  class="another_one">再领一张</a><a href="javascript:;" onclick="toProject();">立即使用</a></p>
    </div>
    <!-- 加息券已领完 -->
    <div class="dialog dialog2">
        <div class="close_btn">×</div>
        <h4>对不起</h4>
        <p class="mid_p">您今日领取加息劵的机会已用完请明日再来</p>
        <p class="use_coupons"><a href="javascript:;" onclick="toProject();">立即使用</a></p>
    </div>
    <!-- 未登录-->
    <div class="dialog dialog3">
    <div class="close_btn">×</div>
    <h4>请登录</h4>
     <p class="mid_p">请登录瑞钱宝账户，即可领取加息券</p>
    <p class="use_coupons"><a href="javascript:;" onclick="toLogin();"  style="margin-top:3rem;">马上登录</a></p>
    </div>
 <script>
      $(function(){
		    	    var user = $("#user").val();
		          var userId = $("#userId").val();
    	        //点击领取加息券
              $("#rateBtn").click(function(){
                    	if ((userId == "" || userId == null || userId == "null") && (user == "" || user == null || user == "null")){
                          $(".bg").show();
                          $(".dialog").hide();
                          $(".dialog3").show();
                          
                      } else {
                        /*点击领取加息券  */
                         receiveCoupons();
                        
                      } 
              })
              
              //再领取一次
                $(".another_one").click(function(){
                  
                  receiveCoupons();
                
                })
              
              //判断弹幕是否显示 
              $("#checkedbtn").click(function(){
                
                $(".textScroll").toggle();
                
              })
              
               /*点击进入投资列表 */
                $(".clickPro").click(function () {
                    if (isAndroidOrIos()) {
                        IOSModel.toIosInvest();
                        appFunction('invest');
                      } else {
                        window.location.href = "<%=basePath %>/project.jsp";
                      }
                  }) 
              
              
              //关闭遮罩层
              $(".close_btn").click(function(){
                
                 $(".dialog").hide();
                 $(".bg").hide();
              })
              
              /*初始化加息券个数 */
                $.ajax({
                          url:'<%=localPath%>/activity/morerateUserLt.do',
                          contentType: 'application/json;charset=utf-8',
                          type:"post",
                          dataType:"json",
                          success:function(data){
                        	   var info = data.result;
                              var str = "";
                              var _info = data.resultObject;
                              if (info == "1") {
                                 $("#getNum").text(data.errInfo);
                                   str+='<MARQUEE   scrollAmount=4 scrollDelay=100 direction=left behavior="scroll"  height="140">';
                                   $.each(_info,function(obj,_data){
                                     
                                       str+='<span> 用户  <font class="phoneCheck">'+ _data.login_name +' </font>  已领取1张加息劵</span>'; 
                                                
                                    });
                                   $(".textScroll").html(str);
                                 str+= '</MARQUEE>';
                                } else {
                                  
                                  alert("请联系管理员");
                                  
                                } 
                           
                         }
                          
                    }) 
      })
      

    /*进入登录 页面 */
    function toLogin() {
            if (isAndroidOrIos()) {
                IOSModel.login();
            appFunction('login');
            } else {
                window.location.href = "<%=basePath%>/login.jsp?active=custody";
            }
    }
      
      /*点击领取加息券  */
      function receiveCoupons(){
        $(".bg").show();
          $(".dialog").hide();
         $.ajax({
             url:'<%=localPath%>/activity/morerate.do',
             contentType: 'application/json;charset=utf-8',
             type:"post",
             dataType:"json",
             data : JSON.stringify({
            	 userId : '<%=user%>',
             }),
             success:function(data){
               var info = data.result;
               var _info = data.resultObject-1;
               if(info == "1" && _info !="0"){
                   $(".dialog1").show();
                   $("#remaNum").text(_info);/*剩余加息券个数  */
               } else {
                 $(".dialog2").show();
               }
             },
             error : function (data) {
            	 alert("请联系管理员 ");
             }
         })
        
        
      }
      /*去我的礼物页面 */
      $("#goMyGift").click(function (){
    	    var userId = $("#userId").val();
    	    if (isAndroidOrIos()) {
    	      IOSModel.investFinishToMyGift();
    	      appFunction('investFinishToMyGift');
    	    } else { 
    	      window.location.href ="<%=basePath %>/sys/user/award/myGift.jsp?userId=" + userId + "#/voucher";
    	    }
    	  })
    	  
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
    
    
</body>
</html>
