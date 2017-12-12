<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>瑞钱宝</title>
<meta name="viewport"
    content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/common2.css">
<link rel="stylesheet" type="text/css" href="css/project.css">
<link href="css/couponstyle.css" rel="stylesheet" />
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/use_red_evp.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
</head>
<body   style="background: #fff;">
	<header>
		<div class="home_title red_bg">
			<a class="icon-back" href="#"></a>红包<span class="sp_titile_right smaller-font"
				id="sp_save_use" onclick="saveExit()">取消使用</span>
		</div>
	</header>
	<button style="display:none" id="myModal" type="button" class="btn btn-danger mt20 ml20" data-toggle="modal" data-target=".bs-example-modal-lg">提示信息</button>
	<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">提示信息</h4>
				</div>
				<div class="modal-body">
					<h4 class="text-success text-center" id="msg_content"></h4>
				</div>
				<div class="modal-footer">
					<button type="button" data-dismiss="modal" class="btn btn-danger btn-block" >返回</button>
				</div>
			</div>
		</div>
	</div>
		<div class="mt10" id="coupon_table"></div>
	<div>
		<FORM action="project_invest.jsp" method="post" id="choose_cop_form">
			<input type="hidden" name="copType" id="copType" /> <input
				type="hidden" name="passValue" id="passValue" />
				<input
                type="hidden" name="valueNeed" id="valueNeed" /> <input
				type="hidden" name="copId" id="copId" /> <input type="hidden"
				name="periodBack" id="periodBack" /> <input type="hidden"
				name="projectIdBack" id="projectIdBack" /> <input type="hidden"
				name="rateBack" id="rateBack" />
		</FORM>
	</div>
	<div id="div_no_cop_record"></div>
	<div id="show_choose_div">已选择 <span id="sp_cop_count">0</span> 个 <span id="sp_cop_type"></span>,共 <span id="sp_cop_value">0.00</span></div>
	<div id="error_info" class="error_info"></div>
</body>
</html>