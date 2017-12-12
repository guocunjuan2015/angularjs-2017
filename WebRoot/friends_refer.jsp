<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName()
            + path + "/";
    basePath = "http://www.rqbao.com/rqb";
    //basePath = "http://test.rqbao.com/rqb";
    Logger log = Logger.getLogger(this.getClass());
    log.info(request.getQueryString());
    String referrer = request.getParameter("referrer");
    String from = request.getParameter("from");
    String refer2 = null;
    if("weixin".equals(from)){
        byte[] bs = Hex.decodeHex(referrer.toCharArray());
        refer2 = new String(bs);
    }else{
        refer2 = referrer;
        from = "others";
    }
    request.setAttribute("refer2", refer2);
    request.setAttribute("referrer", referrer);
    log.info(referrer);
    
    
    log.info(refer2);
    //referrer = new String(referrer.getBytes("ISO8859-1"),"UTF-8");
    // String referrer = new String(request.getParameter("referrer"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common2.css" rel="stylesheet" />
<link href="css/main.css" rel="stylesheet" />
<link href="css/Friendstyle.css" rel="stylesheet" />
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/friends_refer.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/jweixin-1.0.0.js" type="text/javascript"></script>
<script type="text/javascript" src="js/weixin_share.js"></script>
<script src="js/utils.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
<script  type="text/javascript">
icon = '<%=basePath%>/images/getheadimg.jpg'; // 200*200大小
url = '<%=basePath%>/register_referrer.jsp?referrer=<c:out value="${refer2}" escapeXml="true"></c:out>';
content = '20年金融团队经验，安全靠谱的理财产品，100元起投，7%-22%高收益，快来跟我一起赚钱吧！';
title ='理财就选瑞钱宝';
weixinShare(title,content,icon,url,'<%=basePath%>');
</script>
</head>
<body>
<%@ include file="config/show_share.jsp" %>
	<section>
		<h1 class="home_title red_bg">
			好友推荐 <span class="sp_titile_left" onclick="toFriendsRule()">规则</span>
		</h1>
	</section>
	<section>
		<div class="friend-title ">
			<span class="friend-title-one">已获得积分</span> <span
				class="friend-title-two" id="points_get"></span>
		</div>
		<div class="friend-title">
			<span class="friend-title-one">已获得瑞钱币</span> <span
				class="friend-title-two" id="coupon_get"></span>
		</div>
		<div class="friend-title">
			<span class="friend-title-one">已获得返现(元）</span> <span
				class="friend-title-two" id="reward_get"></span>
		</div>
		<div class="recommand" onclick="toRecommand()">推荐明细</div>
		<div class="recommand" onclick="showShareBox() ">马上推荐</div>
	</section>
	<section class="join-type"></section>
<div id="error_info" class="error_info"></div>
</body>
</html>