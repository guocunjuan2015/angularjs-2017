<%@page import="com.ultrapower.cloudup.utils.EmptyUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String account = (String) session.getAttribute("loginUser");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>瑞钱宝</title>
<meta name="viewport" content="width=device-width,initial-scale=1" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/reward2.css">
<link rel="stylesheet" type="text/css" href="css/points.css">
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/points_rank.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
</head>
<body huaban_collector_injected="true" style="background: #fff;">
	<header>
		<div class="home_title">
			<a class="icon-back" href="#"></a>排行榜
		</div>
	</header>

	<div class="container">
		<div id="vip_title_div">
			<table id="vip_rank_table">
				<tr id="vip_table_tr1">
					<th>排名</th>
					<th>用户名</th>
					<th>积分</th>
				</tr>
			</table>
		</div>
		<!--  <div  id="points_rank"><table id="points_rank_table" class="tb_3td"></table></div>-->
	</div>
	<div id="my_rank_div" style="display: none">
		你现在的排名是 <span id="sp_my_rank_value" class="font_red_bold"> </span>
		,再接再厉!
	</div>
	<div id="div_login_name" hidden="true"><%=account%></div>
	<div id="error_info" class="error_info"></div>
</body>
</html>