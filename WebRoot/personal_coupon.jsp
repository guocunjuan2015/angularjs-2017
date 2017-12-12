<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>瑞钱宝</title>
<meta name="viewport" content="width=device-width,initial-scale=1" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/personal_coupon.js" type="text/javascript"></script>
<script src="js/om_code.js" type="text/javascript"></script>
</head>
<body>
	<header>
		<div class="home_title">
			<a class="icon-back" href="#"></a>瑞钱宝-优惠券
		</div>
	</header>
	<div class="container">
		<div class="row tab">
			<div class="col-xs-4 tab1 tab-bod tabactive"
				onclick="changeType(1,this)">未使用</div>
			<div class="col-xs-4 tab1 tab-bod" onclick="changeType(2,this)">已使用</div>
			<div class="col-xs-4 tab1 tab-bod" onclick="changeType(3,this)">已过期</div>
		</div>
		<div class="mt10" id="coupon_table_1" style="display: none"></div>

		<div class="mt10" id="coupon_table_2" style="display: none"></div>

		<div class="mt10" id="coupon_table_3" style="display: none"></div>
	</div>
	<div id="error_info" class="error_info"></div>
</body>
</html>