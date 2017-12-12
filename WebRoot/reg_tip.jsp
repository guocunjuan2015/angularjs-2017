<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common2.css" rel="stylesheet" />
<link href="css/more.css" rel="stylesheet" />
<title>重要提示</title>
<style type="text/css">
.btn {
	width: 130px;
	padding: 2% 0;
	background: #f64840;
	color: #fff !important;
	font-size: 1.7rem;
}

.btn-left {
	margin-left: 10%;
}

@media screen and (max-width:320px) {
	.btn-left {
		margin-left: 5%;
	}
	.btn {
		font-size: 1.5rem;
	}
}
</style>
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script type="text/javascript">
function modefyMobile(){
	window.location.href = "modify_mobile1.jsp";
}
function umpReg(){
	window.location.href = "ump_real_register.jsp";
}
</script>
<%@ include file="config/header.jsp" %>
</head>
<body>
	<section class="important-tip">
		<p style="text-align: center; margin: 10% auto 8%;">
			<img src="images/warning.png" width="20%" />
		</p>
		<div class="tips">
			<p style="margin-bottom: 7%;">
				尊敬的用户，银行存管业务要求交易同卡进出，<span>同时注册时使用的手机号必须与即将绑定的银行卡在银行预留的手机号一致。</span>
			</p>
			<p>如果不一致，你可以选择如下两种解决方案</p>
			<dl>
				<dt>
					1.<span>修改注册时使用的手机号</span>
				</dt>
				<dd>将注册时使用的手机号修改为在银行预留的手机号</dd>
			</dl>
			<dl style="margin-bottom: 7%;">
				<dt>
					2.<span>到银行柜台修改预留手机号</span>
				</dt>
				<dd>到银行柜台将预留的手机号改为注册时使用的手机号</dd>
			</dl>
			<p>若您的手机号已经保持一致，请忽略以上文字直接进行下一步</p>
		</div>
		<p style="text-align: center; margin-top: 7%;">
			<input type="button" class="btn circle_btn" value="修改手机号" onclick="modefyMobile()"> <input
				type="button" class="btn btn-left circle_btn" onclick="umpReg()" value="下一步">
		</p>
	</section>
</body>
</html>