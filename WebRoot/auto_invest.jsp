<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/main.css" rel="stylesheet" />
<link href="css/common.css" rel="stylesheet" />
<link href="css/common2.css" rel="stylesheet" />
<link href="css/bottom_munu.css" rel="stylesheet" type="text/css" />
<link href="css/zdtb.css" rel="stylesheet" />
</head>

<body onload="main()">
	<header>
		<div class="home_title red_bg">
			<a class="icon-back" href="#"></a> 自动投标 
			<span class="go-back"
                onclick="linkTo('personal_center.jsp')"></span>
			<span class="sp_titile_left"
				onclick="showBg()">编辑</span>
		</div>
	</header>
	<section class="zdtbs" id="container"></section>
	<section  onclick="toAddRule()" id="add_new_rule">
		<div class="zdtb" style="margin:0 0;">
			<i class="add-icon"></i>
			<div class="zdtb-center add-rule-text font-grey">添加新规则</div>
		</div>
	</section>
	<div id="bg" onclick="showBg()"></div>
	
	<div id="error_info" class="error_info"></div>
    <div id="footpanel" style="border: none;display:none;border-radius:none">
         <div class="edit_item" onclick="clearAll(event)">清空</div>
         <div class="edit_item" onclick="showBg()">取消</div>
    </div>
</body>

<script src="js/jquery-1.11.2.min.js"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/utils.js"></script>
<script src="js/auto_invest.js"></script>
<script src="js/frame/my_swipe.js"></script>
<script src="js/frame/shake.js"></script>
</html>