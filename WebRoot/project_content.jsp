<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<title>瑞钱宝</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/project.css">
<link rel="stylesheet" type="text/css" href="css/common.css">
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.2,user-scalable=no"/>
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/project_content.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
</head>
<body>
	<header>
		<div class="home_title">
			<a class="icon-back" href="#"></a>瑞钱宝-项目信息
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
					<!-- <p>投资金额：<span class="text-danger" id="money_invest_modal">1000</span>元</p> -->
				</div>
				<div class="modal-footer">
					<button type="button" style="display: none" onclick="gotoPage(0)"
						id="msg_btn_0" class="btn btn-primary btn-block">设置支付密码</button>
					<button type="button" style="display: none" onclick="gotoPage(1)"
						id="msg_btn_1" class="btn btn-primary btn-block">实名认证</button>
					<button type="button" style="display: none" onclick="gotoPage(2)"
						id="msg_btn_2" class="btn btn-primary btn-block">绑定银行卡</button>
					<button type="button" style="display: none" onclick="gotoPage(3)"
						id="msg_btn_3" class="btn btn-primary btn-block">充值</button>
				</div>
			</div>
		</div>
	</div>




	<div style="display: none">
		<span id="project_id"></span>
	</div>
	<div class="container-fluid mp0">
		<div class="licai-box">
			<h4>
				<span id="project_name"></span>
			</h4>
			<div class="row lc-list">
				<div class="col-xs-4 lc01">
					<p class="text-muted">预期年化收益</p>
					<p class="text-danger">
						<strong class="st01" id="project_loanRate"></strong><small>%</small>
					</p>
				</div>
				<div class="col-xs-2 lc01">
					<p class="text-muted">期限</p>
					<p class="">
						<strong class="st01" id="project_loanPeriod"></strong><small>个月</small>
					</p>
				</div>
				<div class="col-xs-3 lc01">
					<p class="text-muted">起投金额</p>
					<p class="">
						<strong class="st01" id="project_minNum"></strong><small>元</small>
					</p>
				</div>
			</div>
			<div class="progress-b" id="project_rate"></div>
			<div class="transfer_div_desc">
			<img class="transfer_img" src="images/transfer.png" />
			<span class="transfer_text" id="transfer_txt"></span>
			</div>
			<p class="readall text-danger clearfix" onclick="getDetail()">
				查看详情<span class="d-img pull-right"></span>
			</p>
		</div>
	</div>
	<div class="container-fluid mp0 mt10">
		<div class="licai-box">
			<table class="table">
				<tbody>
					<tr style="display:none">
						<td>募资总额</td>
						<td class="text-right text-muted"><span
							id="project_loanAmount"></span></td>
					</tr>
					<tr>
						<td>剩余金额</td>
						<td class="text-right text-muted"><span id="project_balance"></span>元</td>
					</tr>
					<tr style="display: none">
						<td>发起日期</td>
						<td class="text-right text-muted" id="project_createDate"></td>
					</tr>
					<tr>
						<td>到账时间</td>
						<td class="text-right text-muted" id="project_returnDate">T +
							0</td>
					</tr>
					<tr>
						<td>还款方式</td>
						<td class="text-right text-muted" id="project_repaymentWay"></td>
					</tr>
					<tr style="display:none">
						<td>最高投资</td>
						<td class="text-right text-muted"><span id="project_maxNum"></span>元</td>
					</tr>
				</tbody>
			</table>
			<table class="table" id="cash_table" style="display: none">
				<tbody>
					<!--  
				   	<tr>
						<td>账户余额</td>
						<td class="text-right text-muted"><span class="text-danger" id="account_balance"></span>元</td>
				    </tr> 
				    -->
					<tr>
						<td>投资预期收益</td>
						<td class="text-right text-muted"><span class="text-danger"
							id="invest_future_income"></span>元</td>
					</tr>
					<tr id="u_plan_peiz" style="display: none" >
						<td>配资金额</td>
						<td class="text-right text-muted" id="u_plan_peiz_td"><span class="text-danger"
							id="u_plan_peiz_value"></span>元</td>
					</tr>
					<tr id="choose_coupon" onClick="getCheckInfo(2)">
						<td>优惠券</td>
						<td class="text-right text-muted"><span id="coupon"></span><span
							class="d-img pull-right"></span></td>
					</tr>
					<tr>
						<td>投资金额</td>
						<td class="text-right text-muted"><input class="form-control"
							type="number" id="invest_number" onclick="getCheckInfo(3)"
							onkeyup="changeInvest(this.value)" placeholder="请填写投资的金额(元)"></input></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div>
		<FORM  id="form_save_cop_info">
			<input type="hidden" name="copType" id="copType" /> <input
				type="hidden" name="passValue" id="passValue" /> <input
				type="hidden" name="copId" id="copId" /> <input type="hidden" name="project_type" id="project_type" />
		</FORM>
	</div>
	<div id="error_info" class="error_info"></div>
	<div class="container-fluid mt20">
		<div id="div_invest_per10000">
			每投资一万，到期收益<span id="sp_per_income"> </span>元
		</div>
		<button type="button" id="button_invest" style="display: none"
			onclick="invest()" class="btn btn-danger btn-block mt10 mb20">马上赚钱</button>
		<button type="button" id="recharge_btn" onclick="recharge()"
			class="btn btn-primary btn-block mt10 mb20">充值</button>
		<!--
			<button type="button" id="button_login" onclick="login()" class="btn btn-primary btn-block mt10 mb20" style="display:none">登录/注册</button>
			<button type="button" id="button_auth" onclick="auth()" class="btn btn-primary btn-block mt10 mb20" style="display:none">实名认证</button>
 		-->
	</div>
	<div id="transfer_intro_div" style="display:none">债权持有一个月可转让 <span> 查看</span><span id="transfer_rool_sp" onclick="toTransferRool()">债权转让规则</span></div>
	
</body>
</html>