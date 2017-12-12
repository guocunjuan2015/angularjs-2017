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
	<title>投资领出行装备</title>
	<meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
	<meta name="description" content="瑞钱宝互联网金融平台投资越多惊喜越多,年收化率7%-13.5%，" />
	<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/common2.css" rel="stylesheet"/>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wechat2.css">
	<link href="${pageContext.request.contextPath}/active/aprilOuting/aprilOuting.css" rel="stylesheet">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.min.js"></script>
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
      title = "四月踏青来，累计投资速来领，出行必备装备";
      content = "瑞钱宝—大型国企背景，多种优质项目，让您轻松理财！";
      icon = "<%=basePath %>/images/logo/aprilOuting.png";
      url  = '<%=basePath %>/active/aprilOuting/aprilOuting.jsp';
       // getReferenceRank();
       weixinShare(title,content,icon,url,'<%=basePath%>');
   });
	 /*进入登录 页面 */
	 function toLogin() {
		    if (isAndroidOrIos()) {
		        IOSModel.login();
		      appFunction('login');
		    } else {
		      window.location.href = "<%=basePath%>/login.jsp?active=aprilOuting";
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
</head>
<body  class="aprilOutingBody">
	<input type="hidden" id="userId"  value="<%=userId%>"/>
	 <input type="hidden" value="<%=localPath%>" id="localPath">
	 <input type="hidden" value="<%=basePath%>" id="basePath">
	 <input type="hidden" value="<%=utm_source %>" id="channel"/>
	 <input type="hidden" value="<%=user%>" id="user">
	 <input type="hidden" value="<%=userApp %>" id="userApp"/>
	
		 <div class="activybanner">
	       <img src="<%=basePath%>/active/aprilOuting/images/banner.jpg"/>
	  </div>  
	  <div class="looteryTitle">
	         <p class="actviyTitle2">
                  <span></span>
                  <font class="isLoginNum"></font>
            </p>
            <p class="actviyTitleFont"></p> 
     </div>   
        <div class="prizeBox clearfix">
            <div class="prizeM">
                <div class="therm clearfix">
                      <div class="therm50">
                          <p class="therm50p">
                              
                          </p>
                          <b class="span4500">4500</b>
                      </div>
                      <div class="therm110">
                          <p class="therm110p">
                              
                          </p>
                          <b class="span9000">9000</b>
                      </div>
                      <div class="therm2w">
                         <p class="therm2wp">
                              
                          </p>
                          <b class="span2w">2.4万</b>
                      </div>
                      <div class="therm6w">
                          <p class="therm6wp">
                              
                          </p>
                          <b class="span6w">6万</b>
                      </div>
                      <div class="therm13w">
                         <p class="therm13wp">
                              
                          </p>
                          <b class="span13w">13万</b>
                      </div>
                      
                      <div class="therm40w">
                          <p class="therm40wp">
                              
                          </p>
                          <b class="span40w">40万</b>
                      </div>
                
                </div>
            </div>
       </div>
        <div class="prize_col">
              <p class="prize_colTit"> 
                  <span id="receiveClick">
                                                            领取我的奖品                                   
                   </span>
                   <span class="isLogin" onclick="toLogin();">
                                                          请登录
                   </span>
              </p> 
              <p class="prize_tip"><img src="<%=basePath%>/active/aprilOuting/images/flowerTitle.jpg"/></p>
              <p style="padding:1rem 2rem 0 2rem;line-height:2.4rem;font-size:1.2rem;">例如：您若想领取IPhone 7 128g的手机，需累计投资360天项目40.6万元，方可达到年化40万元，领取该奖品。</p>
              
        </div> 
        
         <div class="myEquip">
              <p class="equipTit"><img src="<%=basePath%>/active/aprilOuting/images/equipTit.jpg"/></p> 
              <div class="myEquip_list">
                  <ul id="myEquip_list">
                     
                  </ul><div class="clear"></div>
              
              </div>
        </div> 
        
         
        <p class="actviyTitle3">
        
            <img src="<%=basePath%>/active/aprilOuting/images/title2.jpg"/>
        </p>
            <div class="actviyRule">
                <p>1、活动时间：2017年4月13日10:00-4月27日17:00； </p>
                <p>2、投资越多，奖品越大。在累计投资过程中，用户领取奖品后将清零并开启新一轮累计。封顶奖品为iPhone7 plus 128g（除红色），若用户年化投资额大于40万，则爆表“出行装备”，用户领取后继续累计；</p>
                <p>3、 活动结束后，若用户未主动领取奖品，发放年化投资额对应的一个最大奖品；</p>
                <p>4、奖品确认后，显示在账户中心－我的奖励中（奖品可八折折现，用户在奖品获得的次日23:59前可折现，请在PC端“我的奖励－奖品”中进行折现）； </p>
                <p>5、债转项目和小贷项目不参与本次活动，使用红包加息券等优惠券的项目不参与本次活动；</p>
                <p>6、所有奖品自活动结束后7个工作日内发放，活动结束后3个工作日内未填写收货地址或未联系上的用户将视为自动弃奖；</p>
                <p>7、如有疑问，请咨询平台官方客服热线：400-919-8555。</p>
            </div>
              <p class="copyRight">＊本次活动最终解释权归瑞钱宝所有</p>
  <%--弹出框 --%>
  <div class="bg"></div>     
  <div class="dialog dialog1">
       <div class="lotteryHeight">
          <div style="height:2rem;">
            <p class="font1">恭喜您已获得 <font></font</p>
            <p class="font2"></p>
            <p><img id="dialogImg" src="<%=basePath%>/active/aprilOuting/images/1.png"/></p>
          </div>
          <div class="boatBox">
              <div class="boat2" style="margin:0 0 0 30%;">
                   <p class="startUp initShow">开始新一轮投资</p>
              </div>
          </div>
        <!--   <p><a href="javascript:;" id="startUp" class="startUp">开启新一轮累计</a></p> -->
      </div>
  </div>
  
   <div class="dialog dialog2">
       <div class="lotteryHeight" style="margin-top:8rem;">
          <div class="lotteryDiv">
            <p class="font1">您的投资累计到<span class="amountNum"></span></p>
            <p class="font2">您再年化投资<span class="totalNum"></span>元可以领到下一个 <font class="nextGift"></font></p>
            <p class="overFont">(结束累计后，重新开始新一轮累计)</p>
          </div>
           <div id="lotteryNew" style="height:10rem;display: none">
            <p class="font1">恭喜您 <font></font</p>
            <p class="font2"></p>
              <p><img id="dialogImg1" src="<%=basePath%>/active/aprilOuting/images/1.png"/></p>
          </div>
          <div class="boatBox">
              <div class="boat1">
                  <p id="receiveLootery">确定结束累计</p> 
              </div>
              <div class="boat2">
                   <p>后悔了 继续累计</p>
              </div>
          </div>
        <!--   <p><a href="javascript:;" id="startUp" class="startUp">开启新一轮累计</a></p> -->
      </div>
  </div>
  <div class="dialog dialog3">
        <div class="lotteryHeight" style="padding-top:14rem;">
            <div class="lotteryDiv">
               <p class="font1"><b>您还未获得奖品</b></p>
              <p class="font2">年化投资4500元就能得到</p>
              <p><img  src="<%=basePath%>/active/aprilOuting/images/coverAward1.png"/></p>
          </div>
      </div>
      <div class="boatBox">
              <div class="boat2" style="margin:10% 0 0 4%;">
                   <p style="text-align:center;" onclick="toProject();">继续投资</p>
              </div>
      </div>
  </div>
  <script type="text/javascript" src="${pageContext.request.contextPath}/active/aprilOuting/aprilOuting.js"></script>  
<script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
</body> 
</html>
