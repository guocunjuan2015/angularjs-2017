<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String baseUrlPC = "http://member.yeepay.com/member/bha/";
    String baseUrl = "http://member.yeepay.com/member/bhawireless/";
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>瑞钱宝</title>

<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/security_center.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
</head>
<body>
	<header>
	<div class="home_title">
		<a class="icon-back" href="#"></a>瑞钱宝-安全中心
	</div>
	</header>
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
					<h4 class="text-success text-center" id="msg_content"></h4>
					<!-- <p>投资金额：<span class="text-danger" id="money_invest_modal">1000</span>元</p> -->
				</div>
				<div class="modal-footer">
					<button type="button" data-dismiss="modal"
						class="btn btn-danger btn-block" onclick="toEPayRegister()">前往易宝开户</button>
				</div>
			</div>
		</div>
	</div>
	<div class="licai-box">
		<table class="table">
			<tbody>
				<tr onclick="modifyPassword()">
					<td style="width: 12%" class=""><img class="img-responsive"
						src="images/safe.png"></td>
					<td class="">修改登录密码</td>
					<td class="text-right"><span class="d-img"></span></td>
				</tr>
				<tr onclick="modifyPayPassword()">
					<td style="width: 12%" class=""><img class="img-responsive"
						src="images/safe.png"></td>
					<td class="">修改支付密码</td>
					<td class="text-right"><span class="d-img"></span></td>
				</tr>
				<tr onclick="checkEPayRegister()" style="display:none">
					<td style="width: 12%" class=""><img class="img-responsive"
						src="images/safe.png"></td>
					<td class="">修改易宝交易密码</td>
					<td class="text-right"><span class="d-img"></span></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div id="error_info" class="error_info"></div>
	<div style="display:none">
		<FORM action="<%=baseUrl %>toRegister"
			method="post" id="epayForm">
			<input type="hidden" name="req" id="req" /> <input type="hidden"
				name="sign" id="sign" />
		</FORM>
	</div>
	<div style="display:none">
		<FORM action="<%=baseUrlPC %>toResetPassword"
			method="post" id="epayModifyPswForm">
			<input type="hidden" name="req" id="req1" /> <input type="hidden"
				name="sign" id="sign1" />
		</FORM>
	</div>
</body>
</html>