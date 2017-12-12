<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
<script src="js/friends_refer_detail.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
</head>
<body>
	<section>
		<h1 class="home_title red_bg">
			推荐明细 <span class="sp_titile_left" onclick="toFriendsRule()">规则</span>
		</h1>
	</section>
	<section>
	<div id="refer_detail_table" class="refer_table">
		</div>
		<div class="recommand no-bg-url" >好友投资总额 <span id="friends_total_invest"> </span> 元</div>
	</section>
	<section class="join-type"></section>
<div id="error_info" class="error_info"></div>
</body>
</html>