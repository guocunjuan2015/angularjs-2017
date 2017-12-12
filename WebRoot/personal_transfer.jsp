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
<script src="js/personal_transfer.js" type="text/javascript"></script>
<script src="js/om_code.js" type="text/javascript"></script>
</head>
<body>
	<header>
		<div class="home_title">
			<a class="icon-back" href="#"></a>瑞钱宝-债权转让
		</div>
	</header>
	<div class="container">
		<div class="row tab">
			<div class="col-xs-4 tab1 tab-bod tabactive"
				onclick="changeType(1, this)">可以转让</div>
			<div class="col-xs-4 tab1 tab-bod" onclick="changeType(2, this)">正在转让</div>
			<div class="col-xs-4 tab1 tab-bod" onclick="changeType(3, this)">已经转让</div>
		</div>
		<div class="licai-box mt10" id="transfer_1" style="display: none">
			<table class="table">
				<tbody id="transfer_table_1"></tbody>
			</table>
		</div>
		<div class="licai-box mt10" id="transfer_2" style="display: none">
			<table class="table">
				<tbody id="transfer_table_2"></tbody>
			</table>
		</div>
		<div class="licai-box mt10" id="transfer_3" style="display: none">
			<table class="table">
				<tbody id="transfer_table_3"></tbody>
			</table>
		</div>
	</div>
	<div id="error_info" class="error_info"></div>
</body>
</html>