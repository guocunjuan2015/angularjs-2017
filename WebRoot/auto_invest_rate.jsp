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
<link href="css/zdtb.css" rel="stylesheet" />
</head>

<body>
	<header>
		<div class="home_title red_bg">
			<a class="icon-back" href="#"></a>预期年化收益
			<span class="sp_titile_left" onclick="saveExit()">保存</span>
		</div>
	</header>
	<section id="container">
	<div class="auto_item" onclick="itemClick('item0')"><span>不限制</span><i class="item_i" id="item0"></i></div>
	<div class="auto_item">
	<span>自定义</span>
	 <div style="display:inline;margin-left: 20%">
    <input class="form-control input-number" type="tel" id="input_from" onclick="clickInput()"
     />
    <span style="margin-left: 0">%~ </span>
    <input class="form-control input-number" type="tel" id="input_to" onclick="clickInput()"
      />
    <span style="margin-left: 0">%</span></div>
    </div>
	</section>
	<div id="error_info" class="error_info"></div>
</body>

<script src="js/jquery-1.11.2.min.js"></script>
<script src="js/utils.js"></script>
<script src="js/auto_invest_rate.js"></script>
</html>