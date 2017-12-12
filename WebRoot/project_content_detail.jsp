<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>瑞钱宝</title>
<meta name="viewport" content="width=device-width,initial-scale=1" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/common.css">
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/project_content_detail.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
</head>
<body>
	<header>
		<div class="home_title">
			<a class="icon-back" href="#"></a>瑞钱宝-项目详情
		</div>
	</header>
	<div class="container">
		<div class="row tab" id="xq_tab_div" style="display: none">
			<div id="xqtb1_div" class="col-xs-3 tab1 tab-bod tabactive"
				onclick="changeType(1,this)">产品描述</div>
			<div id="xqtb2_div" class="col-xs-3 tab1 tab-bod"
				onclick="changeType(2,this)">产品详情</div>
			<div id="xqtb3_div" class="col-xs-3 tab1 tab-bod"
				onclick="changeType(3,this)">安全保障</div>
			<div id="xqtb4_div" class="col-xs-3 tab1 tab-bod"
				onclick="changeType(4,this)">最新投资</div>
		</div>
		<div class="mt10" id="detail_1" style="display: none"></div>
		<div class="mt10" id="detail_2" style="display: none"></div>
		<div class="mt10" id="detail_3" style="display: none"></div>
		<div class="licai-box mt10" id="detail_4" style="display: none">
			<table class="table">
				<tbody id="detail_table_4"></tbody>
			</table>
		</div>
	</div>
	<div id="error_info" class="error_info"></div>
</body>
</html>