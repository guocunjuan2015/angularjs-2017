<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/wechat2.css">
<link rel="stylesheet" type="text/css" href="css/common.css">
<link href="css/common2.css" rel="stylesheet" />
<link href="css/login.css" rel="stylesheet" />
<link href="css/coupons_market.css" rel="stylesheet" />
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/points_exchange.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
<title>兑换瑞钱币</title>
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
	<section class="rulehead">
		<h1>兑换瑞钱币</h1>
	</section>
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