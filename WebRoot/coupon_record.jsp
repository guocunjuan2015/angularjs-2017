<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common.css" rel="stylesheet" />
<link href="css/common2.css" rel="stylesheet" />
<link href="css/vantagesstyle.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="css/wechat2.css">
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/coupon_record.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
<title>积分明细</title>
</head>
<body>
	<section class="rulehead">
		<h1>积分明细</h1>
	</section>
	<div class="points_item" id="points_item"></div>
	<div id="no-data" class="no-data">暂无记录!</div>
	<div id="error_info" class="error_info"></div>
</body>
</html>