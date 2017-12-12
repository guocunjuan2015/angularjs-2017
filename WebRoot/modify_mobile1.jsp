<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/main.css" rel="stylesheet" />
<link href="css/common2.css" rel="stylesheet" />
<link href="css/more.css" rel="stylesheet" />
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/modify_mobile.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
<title></title>
</head>
<body>
	<button style="display: none" id="myModal" type="button"
		class="btn btn-danger mt20 ml20" data-toggle="modal"
		data-target=".bs-example-modal-lg">提示信息</button>
	<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog"
		aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">提示信息</h4>
				</div>
				<div class="modal-body">
					<h4 class="text-success text-center" id="body_content_h4"></h4>
					<!-- <p>投资金额：<span class="text-danger" id="money_invest_modal">1000</span>元</p> -->
				</div>
				<div class="modal-footer" style="display: none" id="next_div">
					<button id="next_bt" type="button" onclick="gotoPage()"
						class="btn btn-danger btn-block">下一步</button>
				</div>
				<div class="modal-footer" id="phone_code_div" style="display: none">
					<table style="width: 100%">
						<tr>
							<td style="width: 50%; text-align: center">
								<button type="button" data-dismiss="modal" id="bt_invite"
									class="btn btn-danger">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;取
									消&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
							</td>
							<td style="width: 50%; text-align: center"><button
									type="button" data-dismiss="modal" onclick="sendRadioCode(1)"
									id="bt_to_invest" class="btn btn-danger">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;接
									收&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	<section class="bank-details">
		<header>
			<div class="home_title red_bg">
				<a class="icon-back" href="#"></a>修改手机号
			</div>
		</header>
		<ul>
			<li><span class="menus"> 手机号 </span><input type="tel"
				id="cur_tel" style="border: none" placeholder="输入当前手机号"
				onkeyup="clearError()" /></li>
			<li><span class="menus"> 验证码 </span><input type="text"
				id="cur_code" placeholder="短信验验证码" onkeyup="clearError()" /><button
				class="get_code" onclick="getCode(1)" id="getc">获取验证码</button></li>
			<li id="no_accept_code"><div onclick="getRadioCode(1)">没有收到验证码</div></li>
		</ul>
		<div style="margin: 0 15px;">
			<button type="button" class="btn btn-lg btn-danger btn-block "
				id="btn_modify" onclick="modifyStep1()">下一步</button>
		</div>
	</section>
	<div id="error_info" class="error_info"></div>
</body>
</html>