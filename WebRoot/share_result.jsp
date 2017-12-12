<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
	<meta charset="UTF-8">
	<title>瑞钱宝</title>
	<meta name="viewport" content="width=device-width,initial-scale=1" />
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
	<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
	<script src="js/utils.js" type="text/javascript"></script>
	<script src="js/share_result.js" type="text/javascript"></script>
	<%@ include file="config/header.jsp" %>
</head>

<body>
	<header>
		<div class="home_title"><a class="icon-back" href="#"></a>瑞钱宝-分享点击排行</div>
	</header>
	<div class="container-fluid mp0">
		<div class="logo-login row">
			<div class="col-xs-8"><img class="img-responsive" src="images/rqbao.png"></div>
			<div class="col-xs-4">
				<span>Top</span>
				<input type="number" style="width:40px" value=10 id="top_n"></input>
				<a class="btn btn-link" href="#" onclick="refresh()" role="button">刷新</a></div>
		</div>
	</div>
	<div id="error_info" class="error_info"></div>
	<table class="table">
		<thead><tr>
			<td hidden="hidden">微信号</td>
			<td style="width:40%;min-width:60px;">微信昵称</td>
			<td style="width:40%;min-width:60px;">分享时间</td>
			<td style="width:20%;min-width:30px;">点击</td>
		</tr></thead>
		<tbody id="result_table"></tbody>
	</table>
</body>
</html>
