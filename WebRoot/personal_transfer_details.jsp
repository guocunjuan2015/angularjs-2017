<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/common2.css" rel="stylesheet"/>
    <link href="css/more.css" rel="stylesheet"/>
    <link href="css/main.css" rel="stylesheet"/>
    <link href="css/touzistyle.css" rel="stylesheet">
    <script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/personal_transfer_details.js"></script>
    <script type="text/javascript" src="js/utils.js"></script>
    <%@ include file="config/header.jsp" %>
    <title>转让记录</title>
</head>
<body>
	<section>
		<h1 class="home_title red_bg">
			转让记录<span class="sp_titile_left" onclick="toBuyRecord()">认购记录</span>
		</h1>
	</section>
	<section class="touzi-details" style="width:100%;padding:2%;margin-top:2%;background:transparent;">
    <div class="touzi-title">
        <div class="purple-icon" id="pj_type"></div><div class="orange-icon">A</div>
        <span class="touzi-title-one" id="pj_title"></span>
    </div>
</section>
<ul>
    <li class="sz-details sz-font">
        <span class="span1">转让金额</span>
        <span class="span2" id="pj_account"></span>
    </li>
    <li class="sz-details  sz-span1-font2">
        <span class="span1">预期年化收益</span>
        <span class="span2" id="pj_rate"></span>
    </li>
    <li class="sz-details  sz-span1-font2">
        <span class="span1">期限</span>
        <span class="span2" id="pj_period"></span>
    </li>
    <li class="sz-details  sz-span1-font2">
        <span class="span1">到期日期</span>
        <span class="span2" id="pj_endDate"></span>
    </li>
    <li class="sz-details  sz-span1-font2">
        <span class="span1">折让金</span>
        <span class="span2" id="pj_discount"></span>
    </li>
    <li class="sz-details  sz-span1-font2">
        <span class="span1">转让说明</span>
        <span class="span2" id="pj_transfer_illus"></span>
    </li>
    <li class="sz-details  sz-span1-font2">
        <span class="span1">认购人数</span>
        <span class="span2" id="pj_amount"></span>
    </li>
    <li class="sz-details  sz-span1-font2">
        <span class="span1">转让开始时间</span>
        <span class="span2" id="pj_start_time"></span>
    </li>
</ul>
<p class="sz-font" style="text-align:right;padding:4% 2% 1%;">手续费：<strong style="color:#f64840;font-weight:normal;" id="pj_tips"></strong> 元</p>
<p class="sz-font" style="text-align:right;">转出金额：<strong style="color:#f64840;font-weight:normal;" id="pj_money"></strong>  元</p>
<div id="error_info" class="error_info"></div>
</body>
</html>