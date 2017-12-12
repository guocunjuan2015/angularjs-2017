<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>瑞钱宝</title>
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/wechat2.css">
<link rel="stylesheet" type="text/css" href="css/common.css">
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/points_details.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
</head>
<body>
	<header>
		<div class="home_title">
			<a class="icon-back" href="#"></a>积分明细 <span class="sp_titile_left"
				onclick="toPointsRule()">积分规则</span>
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
					<h4 class="text-success text-center" id="tip_content"></h4>
				</div>
				<div class="modal-footer">
					<button type="button" style="display: none"
						onclick="refreshOrNot()" id="msg_btn_0"
						class="btn btn-danger btn-block">返回</button>
				</div>
			</div>
		</div>
	</div>
	<div class="points_container">
		<div class="my_points" id="my_total_points">&nbsp;</div>
		<div class="points_illus1">小积分，有大用，多囤一点总没错</div>
		<div class="points_tab">
			<table>
				<tr>
					<td id="points_tab1" onclick="changeTab(1)" class="tab-clicked">兑换瑞钱币</td>
					<td id="points_tab2" onclick="changeTab(2)">兑换记录</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="points_item" id="points_item" style="display: none"></div>
	<div id="container1">
		<div class="change_page" id="change_page">
			<table>
				<tr>
					<td class="change_table_td1"><img class="jinbi_img"
						src="images/jinbi.png" /></td>
					<td class="change_table_td2">瑞钱币可以用于抵扣投资金额的1%，适用于平台上的所有项目，有效期为1个月</td>
				</tr>
			</table>
		</div>
		<div class="change_body_div">
			<div>
				<span class="change_rqb_sp1">兑换数量</span><span class="change_rqb_sp2"><input
					type="text" min=0 placeholder="请输入兑换数量" id="exchange_count"
					onkeyup="changeCount()" /></span>
			</div>
			<div>
				<span class="change_rqb_sp1">所需积分</span><span class="change_rqb_sp3"
					id="points_ava"></span>
			</div>
		</div>
		<p id="change_btn">
			<button type="button" class="btn btn-danger btn-block mt10 mb20"
				id="exchange_btn" onclick="changeCoupon()">兑换</button>
		</p>
	</div>
	<div id="error_info" class="error_info"></div>
</body>
</html>