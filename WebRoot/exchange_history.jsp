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
<link rel="stylesheet" type="text/css" href="css/points.css">
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/exchange_history.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
</head>
<body huaban_collector_injected="true" style="background: #fff;">
	<header>
		<div class="home_title">
			<a class="icon-back" href="#"></a>积分兑换瑞钱币
		</div>
	</header>
		<div class="container mt20" id="jif_exchange_history">
	</div>
	<div class="div_no_record" id="div_exchange_no_record" style="display: none">你还没有积分兑换瑞钱币记录！</div>
	<div id="error_info" class="error_info"></div>
</body>
</html>