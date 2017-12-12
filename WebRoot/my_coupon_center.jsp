<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/main.css" rel="stylesheet" />
<link href="css/common2.css" rel="stylesheet" />
<link href="css/common.css" rel="stylesheet" />
<link href="css/couponstyle.css" rel="stylesheet" />
<link href="css/bottom_munu.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/my_coupon_center.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
<title></title>
</head>
<body>
<section  >
	<section>
		<h1 class="home_title red_bg">
			我的优惠<span class="sp_titile_left" onclick="showBg()">使用说明</span>
		</h1>
	</section>
	<div>
		<table class="coupon_table">
			<tr>
				<td class="red_border_btm" id="cop_tab1" onclick="clickTab(1)">优惠券</td>
				<!-- <td id="cop_tab2" onclick="clickTab(2)">瑞钱币</td> -->
				<td id="cop_tab3" onclick="clickTab(3)">红包</td>
			</tr>
		</table>
	</div>
</section>
	<div id="ticket_outter">
		<div class="coupon_tab" style="display: none">
			<table class="cop_table">
				<tr>
					<td id="tab_unused" class="tab_choosed" onclick="changeTab(1)">未使用(<span
						id="cop_unuse_count"></span>)
					</td>
					<!-- <td id="tab_used" onclick="changeTab(2)">已使用</td> -->
					<td id="tab_over_due" onclick="changeTab(3)">已过期</td>
				</tr>
			</table>
		</div>
		<div id="coupon_content1"></div>
		<div id="no_data" class="no-data" style="display: none">没有记录!</div>
	</div>

	<div id="coupon_outter" style="display: none">
		<div class="cop_div">
			<table class="cop_table">
				<tr>
					<td class="td-border-right" id="cop_total"></td>
					<td class="td-border-right" id="cop_useful"></td>
					<td id="cop_overdue"></td>
				</tr>
				<tr>
					<td class="td-border-right">总数</td>
					<td class="td-border-right">可用</td>
					<td>过期</td>
				</tr>
			</table>
		</div>
		<div class="coupon-more" onclick="toCouponDetails()">瑞钱币明细</div>
		<div class="coupon-more" onclick="toActiveCoupon(1)">激活瑞钱币</div>
	</div>
	<div id="red_package" style="display: none">
	<div id="coupon_content2"></div>
        <div id="no_red" class="no-data" style="display: none">没有记录!</div>
	</div>
	
	<div id="bg" onclick="showBg()"></div>
	<div id="coupon_illus" class="illus">
		<p>1. 体验券自生效起，使用期限为一个月</p>
        <p>2. 体验券只可投资一个月的项目</p>
        <p>3. 单次投资只能使用一张体验券,体验券和瑞钱币不能同时使用</p>
        <p>4. 体验券不可作为现金使用，投资需搭配最低100元现金方使用</p>
	</div>
	<div id="error_info" class="error_info"></div>
	<div class="space_div_ticket"></div>
	<div id="footpanel" style="height: 50px;margin-left:auto;margin-right:auto;max-width: 750px;">
		<div id="foot-div" class="right-more" >我有优惠券号</div>
	</div>
</body>
</html>