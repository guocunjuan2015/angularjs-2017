<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String from = request.getParameter("from");
if(from !=null && "app".equals(from)){
    String user = request.getParameter("user");
    String userId = request.getParameter("userId");
    HttpSession s = request.getSession();
    if(user!=null && user!= ""){
        s.setAttribute("loginUser", user);
    }
    if(userId!= null && userId != ""){
        s.setAttribute("userId", userId);
    }
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <title>积分商城</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/common.css" rel="stylesheet"/>
    <link href="css/common2.css" rel="stylesheet"/>
    <link href="css/coupons_market.css" rel="stylesheet"/>
    <script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/coupon_market.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
</head>
<body>
    <section>
        <div class="coupons-banners">
            <img src="images/banner_02.png" width="100%">
            <ul>
                <li onclick="toCouponRecord()" class="coupons"><i>&nbsp;</i><span id="user_points"></span></li>
                <li class="records"><a href="#" onclick="toExchangeRecord()"><i>&nbsp;</i>兑换记录</a></li>
            </ul>
        </div>
        <div style="clear:both;"></div>
        <p id="user_update" class="user-coupons"></p>
    </section>
    <!--哪一个是hot，直接把coupon-type类放到相应的li中，如第一个li所示-->
    <section class="coupon-type">
        <ul id="market_container">
        </ul>
    </section>
    <div id="no-data" class="no-data">暂无项目,敬请期待</div>
    <div id="loading_anim" style="display: none">
        <div class="spinner">
            <div class="rect1"></div>
            <div class="rect2"></div>
            <div class="rect3"></div>
            <div class="rect4"></div>
            <div class="rect5"></div>
        </div>
        <div id="loading_text">数据加载中...</div>
    </div>
    <div id="error_info" class="error_info"></div>
</body>
</html>