<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>瑞钱宝</title>
<meta name="viewport" content="width=device-width,initial-scale=1" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/main.css" />
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/personal_record.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
</head>
<body>
	<header>
		<div class="home_title_red">
			<a class="icon-back" href="#"></a>瑞钱宝-资金明细
		</div>
	</header>
	<div>
		<!-- <p class="">
			一共 <span class="text-danger" id="record_count"></span> 条交易记录
		</p> -->
		<div class="licai-box">
			<table class="table">
				<tbody id="record_table" class="record_body"></tbody>
			</table>
		</div>
	</div>
	<div id="error_info" class="error_info"></div>
</body>
</html>