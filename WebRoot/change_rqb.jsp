<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta charset="UTF8"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport" />
<title>瑞钱宝</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/points.css">
<link rel="stylesheet" type="text/css" href="css/common.css">
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/change_rqb.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
</head>
<body huaban_collector_injected="true" style="background: #fff;">
	<header>
		<div class="home_title">
			<a class="icon-back" href="#"></a>积分兑换瑞钱币
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
						class="btn btn-danger btn-block" onclick="refresh()">返回</button>
				</div>
			</div>
		</div>
	</div>

	<div class="container">
		<div id="choose_num_illustrate">
			<p id="p_titile">选择瑞钱币金额</p>
			<p id="p_content">
				你现在是<span class="sp_jifen_num" id="VIP_type"> </span>，可用积分<span
					class="sp_jifen_num" id="num_total"> </span>个，最多可以兑换<span
					class="sp_jifen_num" id="num_can_change"> </span>个瑞钱币,每<span
					class="sp_jifen_num" id="num_change_one"> </span>个积分可以兑换一个瑞钱币。
			</p>

		</div>
		<div class="choose_num">
			<table>
				<tr class="choose_num_tr">
					<td><span class="input_box" id="input_5"
						onclick="chooseNum5()">5个</span></td>
					<td><span class="input_box" id="input_10"
						onclick="chooseNum10()">10个</span></td>
					<td><span class="input_box" id="input_50"
						onclick="chooseNum50()">50个</span></td>
				</tr>
			</table>
		</div>
		<div class="choose_num" id="table_div_bottom">
			<table>
				<tr class="choose_num_tr">
					<td><span class="input_box" id="input_100"
						onclick="chooseNum100()">100个</span></td>
				</tr>
			</table>
		</div>
		<div id="div_change_now">
			<button class="btn btn-danger " id="bt_change_now"
				onclick="toChange()">立即兑换</button>
		</div>
		<div class="change_div" id="change_conditions">
			<p>兑换条件 ：已在瑞钱宝投资并且达到一定条件的用户</p>
		</div>
		<div class="change_div" id="change_rools">
			<span id="p_change_rools" onclick="toChangeRools()">积分规则 >></span>
		</div>
		<div class="change_div" id="change_details">
			<span id="p_change_details" onclick="toChangeDetail()">积分兑换明细>>
			</span>
		</div>
		<div class="change_div" id="change_details_history">
			<span id="p_change_details_history" onclick="toChangeDetailHistory()">积分明细>>
			</span>
		</div>
	</div>
	<div id="error_info" class="error_info error-info-margin-bottom"></div>
</body>
</html>