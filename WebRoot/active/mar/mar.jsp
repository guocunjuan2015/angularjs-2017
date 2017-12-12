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
	<title>春季三月暖，小瑞为你加息</title>
    <meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
    <meta name="description" content="大型国企背景，多种优质项目，让您轻松理财！" />
 	  <link href="<%=basePath%>/css/common2.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/active/mar/mar.css" rel="stylesheet">
    <script src="<%=basePath%>/js/jquery-1.11.2.min.js" type="text/javascript"></script> 
	  <script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
	  <script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
	  <script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/json2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.slotmachine.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/active/mar/mar.js"></script>
    <script type="text/javascript">
    /*标题 */
    function showShare(){
    	  IOSModel.changeWebTitle("春季三月暖，小瑞为你加息");
    	}
    /*分享好友*/
    $(function(){ 
        title = "春季三月暖，小瑞为你加息";
        content = "大型国企背景，多种优质项目，让您轻松理财！ ";
        icon = "<%=basePath %>/images/logo/mar.jpg";
        url  = '<%=basePath %>/active/mar/mar.jsp';
       // getReferenceRank();
        weixinShare(title,content,icon,url,'<%=basePath%>');
    });
    </script>
</head>
<body>
	<input type="hidden" value="" name="types" id="types">
	<input type="hidden" value="<%=basePath%>"  id="basePath">
	<input type="hidden" value="<%=localPath%>"  id="localPath">
	<input type="hidden" value="<%=referrer %>"  id="referrer">
	<input type="hidden" value="<%=utm_source %>" id="channel"/>
	<input type="hidden" value="<%=userId %>" id="userId"/>
	<input type="hidden" value="<%=userApp %>" id="userApp"/>
	<input type="hidden" value="" id="code"/>
	<div class="mar_main">
		<header><img alt="" src="${pageContext.request.contextPath}/active/mar/images/mar1.png"></header>
		<div class="mar">
			<div class="mar_choice">
				<img class="mar_img1" alt="" src="${pageContext.request.contextPath}/active/mar/images/mar3.png">
				<div class="mar_form">
					<p class="mb1">
						<img class="fl" style="padding-left:1.8rem;" alt="" src="${pageContext.request.contextPath}/active/mar/images/mar6.png">
						<input type="text" id="money" placeholder="请输入您打算投资的金额" value="">
					</p>
					<p>
						<img class="fl" alt="" src="${pageContext.request.contextPath}/active/mar/images/mar7.png">
						<select id="month">
							<option>90</option>
							<option>180</option>
							<option>360</option>
						</select>
					</p>
					<p class="msg" id="msg"></p>
					<p><input type="button" id="submit_btn" value=""></p>
				</div>
			</div>
		</div>
		<div class="mar_txt">
			<h3><img alt="" src="${pageContext.request.contextPath}/active/mar/images/mar8.png"></h3>
			<p>活动时间：2017年3月22日10:00-4月10日17:00</p>
			<p>用户登录后方可生成优惠券，通过本次活动生成的优惠券可在账户中心查询，您生成的优惠券请于有效期（领取后三日）内使用；</p>
			<p>最高可获1.5%加息+258元红包；</p>
			<p>活动期间每个账户可生成领取优惠券的上限为6次；</p>
			<p>一月标、新手标及投资债权转让的项目不参与本次活动。</p>
			<p>本次活动最终解释权归瑞钱宝所有</p>
		</div>
	</div>
	<div class="loading">
		<img src="${pageContext.request.contextPath}/active/mar/images/loading.gif"/>
	</div>
	<div class="loanDirlog"></div>
	<div class="msgTxt">
		<p class="p1"></p>
		<p class="p3"><a class="fl closeMsg" href="javascript:;">关闭</a><a  class="fr" id="goMyGift" href="javascript:;">查看奖励</a></p>
	</div>
	<div class="msgTxt2">
		<p class="p1"></p>
		<p class="p3"><a class="fl closeMsg" href="javascript:;">关闭</a></p>
	</div>
</body>
</html>
