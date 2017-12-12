﻿<%@page import="java.text.SimpleDateFormat"%>
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
	<title>寻找属于您的奖励</title>
    <meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
    <meta name="description" content="瑞钱宝互联网金融平台投资越多惊喜越多,年收化率7%-13.5%，活动期间你可以选择适合您的理财产品，活动期间设置自动幸运抽奖区，投资理财奖品主要有三星电视、九阳榨汁机、iphone 6s 等，活动时间6月6日-6月24日。" />
 	  <link href="<%=basePath%>/css/common2.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/active/barbecueMeal/barbecueMeal.css" rel="stylesheet">
    <script src="<%=basePath%>/js/jquery-1.11.2.min.js" type="text/javascript"></script> 
	<script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/json2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.slotmachine.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/active/barbecueMeal/barbecueMeal.js"></script>
</head>
<body style="background:#e02518;max-width: 100%;">
	<input type="hidden" value="" name="types" id="types">
	<input type="hidden" value="<%=basePath%>"  id="basePath">
	<input type="hidden" value="<%=localPath%>"  id="localPath">
	<input type="hidden" value="<%=referrer %>"  id="referrer">
	<input type="hidden" value="<%=from%>"  id="from">
	<input type="hidden" value="<%=utm_source %>" id="channel"/>
	<input type="hidden" value="<%=userAppId %>" id="userId"/>
	<input type="hidden" value="" id="code"/>
	<div class="barbecueMeal_main">
		<header><img alt="" src="${pageContext.request.contextPath}/active/barbecueMeal/images/barbecueMeal1.png"></header>
		<%--注册 --%>
		<form class="form_box clearfix">
			<p><input type="text" value="" id="m" name="m" placeholder="请输入手机号" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/></p>
			<p><input type="text" value="" id="vc" name="vc" placeholder="输入验证码"/><input type="button" id="getc" value="点击获取"/></p>
			<p id="prompt_txt"></p>
			<p><input class="checkbtn" type="button" value="我要领取"/></p>
			
		</form>
		<%--刮奖 --%>
		<div class="ggl_box clearfix">
			<div class="ggl" id="top">
				<span id="prompt">恭喜您获得<a href=""><font></font></a></span>
			</div>
			<div class="ggl" id="top2">
				<span id="prompt2">恭喜您获得<a href=""><font></font></a></span>
			</div>
		</div>
		<div class="barbecueMeal_txt">
			<h3>活动说明</h3>
			<p>1. 填写手机号最高获取88元Kao!烤肉饭代金券及瑞钱宝赠送的1G流量</p>
			<p>2. 代金券及流量查看及使用规则详情：</p>
			<p><b>A</b>瑞钱宝APP，登录瑞钱宝APP在“个人中心-我的奖励”</p>
			<p><b>B</b>微信公众号rqbcfj，“马上赚钱-登录-个人中心-我的礼物”</p>
			<p>3. Kao!烤肉饭代金券使用规则：</p>
			<p><b>a</b>凭代金券兑换码购买Kao!烤肉饭美食，点餐时请出示或填写本券编码</p>
			<p><b>b</b>本券直接消费，不设找赎，不可转售、不得用于兑换其他礼券、礼品卡</p>
			<p><b>c</b>本券只能在瑞钱宝及Kao!烤肉饭认可的正规途径获得，谨防假冒</p>
			<p><b>d</b>本券仅限Kao!烤肉饭北京、天津餐厅使用</p>
			<p><b>e</b>Kao!烤肉饭可在法律允许的范围内对活动细则作出适当的调整</p>
			<p><b>f</b>代金券有效期截止于2017年1月15日</p>
			<p>4. 输入手机号（每个手机号限一次），获取Kao!烤肉饭代金券（可直接消费）和瑞钱宝赠送的1G流量</p>
			<p>5. 瑞钱宝账号是其注册手机号，密码会以短信形式通知用户</p>
			<p>6. 瑞钱宝咨询电话：4009-198-555</p>
			<p style="text-indent:1.2rem;">Kao!烤肉饭客服电话：13321154536</p>
		</div>
	</div>
	<div class="downLoad navbar-fixed-bottom">
	      <p>
	      <a id="downs" href="#">下载APP领取每日惊喜大礼</a>
	      </p>
	</div>
	<div class="loading">
		<img src="${pageContext.request.contextPath}/active/barbecueMeal/images/loading.gif"/>
	</div>
</body>
</html>
