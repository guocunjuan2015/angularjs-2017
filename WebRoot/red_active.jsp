<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common2.css" rel="stylesheet" />
<link href="css/utils.css" rel="stylesheet" />
<link href="css/activity/redActive.css" rel="stylesheet" />
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/red_active.js" type="text/javascript"></script>
<script src="js/zhuge_ini.js" type="text/javascript"></script>
<%@ include file="config/header.jsp"%>
<title>激活红包</title>

</head>
<body>
	<div id="bg"></div>
	<section class="ays" id="ays">
		<div class="ays_h5">
			<h5 id="title_info" style="color: #db3741"></h5>
			<img src="images/input_clear.png" onclick="dismissAys()" />
		</div>
		<p class="ays_content" id="jh_content"
			style="padding: 15px 0 5px 0; color: #5b5b5b">恭喜你激活成功！</p>
		<button class="btn btn-warning"
			style="background: #fff000; width: 80%; color: #d87301; font-size: larger;"
			id="checkCP" onclick="dismissAys()">&nbsp;&nbsp;</button>
	</section>

	<div class="activeBox">
		<section class="activebanner">
			<img src="images/activity/redactive/percentImg.jpg" title="安全理财就找瑞钱宝"
				alt="安全理财就找瑞钱宝">
		</section>
		<!--activebanner end-->
		<p class="clickMore">
			<a onclick="linkTo('new_hand_award.jsp')"
				style="color: #333; font-size: 18px; text-decoration: underline; color: #db353f">
				>点此快速了解瑞钱宝< </a>
		</p>
		<div class="activetop"></div>
		<!-- activetop end -->
		<div class="redBgTop"></div>
		<!-- redBg end -->
		<div class="redBgBottom">
			<form id="activeRed" action="" method="post">
				<p>
					<input type="tel" class="form-control"
						style="color: #333; text-align: left;" placeholder="输入手机号"
						name="phoneNum" id="phoneNum" />
				</p>
				<p>
					<input type="tel" class="form-control"
						style="color: #333; text-align: left;" placeholder="输入红包券号码"
						name="ticketNum" id="ticketNum" />
				</p>
				<p>
					<input type="tel" class="form-control"
						style="color: #333; text-align: left;" placeholder="输入红包券激活码"
						name="voucherActive" id="voucherActive" />
				</p>
				<div id="error_info" class="error_info"
					style="color: #fff; padding-top: 10px;"></div>
				<p>
					<button type="button" class="btn btn-danger" id="activeBtn"
						onclick="activeCoupon()">立即激活</button>
				</p>
			</form>
		</div>
		<!--redBgBottom-->

		<section class="copyrights">
			<p style="font-size: 15px; color: #333">本活动最终解释权归瑞钱宝所有</p>
			<p style="font-size: 15px; color: #333">客服热线：400-919-8555</p>
		</section>
	</div>
	<!-- branchBox end -->
</body>
</html>