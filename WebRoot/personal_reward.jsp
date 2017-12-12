<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>瑞钱宝</title>
<meta name="viewport" content="width=device-width,initial-scale=1" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/reward1.css">
<link rel="stylesheet" type="text/css" href="css/reward2.css">
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/personal_reward.js" type="text/javascript"></script>
<script src="js/om_code.js" type="text/javascript"></script>
</head>
<body huaban_collector_injected="true" style="background: #fff;">
	<header>
		<div class="home_title">
			<a class="icon-back" href="#"></a>我的奖励
		</div>
	</header>

	<div class="container">
		<div class="head_2">
			<div class="tab_1 fl" onclick="changeType(1,this)">代金券</div>
			<div class="tab_2 fr" onclick="changeType(2,this)">投资券</div>
		</div>
		<div class="container mt20" id="coupon_table_1" style="display: none"></div>
		<div class="container mt20" id="coupon_table_2" style="display: none"></div>
	</div>
	<div id="error_info" class="error_info"></div>
</body>
</html>