<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>瑞钱宝</title>
<meta name="viewport" content="width=device-width,initial-scale=1" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/reward1.css">
<link rel="stylesheet" type="text/css" href="css/reward2.css">
<link rel="stylesheet" type="text/css" href="css/points.css">
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/my_ruiqb.js" type="text/javascript"></script>
<script src="js/om_code.js" type="text/javascript"></script>
</head>
<body huaban_collector_injected="true" style="background: #fff;">
	<header>
		<div class="home_title">
			<a class="icon-back" href="#"></a>我的奖励
		</div>
	</header>

	<div class="container">
		<div class="head_2">
			<div id="head_tab1" class="tab_1 fl" onclick="changeType(1,this)">瑞钱币</div>
			<div id="head_tab2" class="tab_2 fl" onclick="changeType(2,this)">投资券</div>
			<div id="head_tab3" class="tab_3 fl" onclick="changeType(3,this)">我的推荐</div>
		</div>
		<div class="container ruiqb" id="coupon_table_1" style="display: none">
			<table id="rqb_table">
				<tr>
					<td>可用瑞钱币</td>
					<td>已用瑞钱币</td>
					<td>过期瑞钱币</td>
				</tr>
				<tr id="ruiqb_value_tr">
					<td id="keyong_rqb"></td>
					<td id="yiyong_rqb"></td>
					<td id="guoqi_rqb"></td>
				</tr>
			</table>
			<div class="div_click" id="mingxi" onclick="RQBDetail()">
				<span>明细</span><span class="d-img pull-right"></span>
			</div>
			<div class="line_space"></div>
			<div class="div_click" id="duihuan" onclick="changeRQB()">
				<span>兑换</span><span class="d-img pull-right"></span>
			</div>

			<div id="div_rqb_illustrate">
				<table class="content_table" id="tb_content">
					<tr>
						<td>瑞钱币用于瑞钱宝用户投资抵用现金</td>
					</tr>
					<tr>
						<td>1个瑞钱币=1元钱。</td>
					</tr>
					<tr>
						<td>适用于投资6个月以上项目，只能抵扣投资总额的5%。</td>
					</tr>
					<tr>
						<td>使用瑞钱币进行投资的项目将不可进行债券转让。</td>
					</tr>
					<tr>
						<td>瑞钱币从到账日期起有效期为一个月。</td>
					</tr>
				</table>
			</div>
		</div>
		<div id="coupon_table_3" style="display: none">
			<p>推荐奖励规则</p>
			<table class="my_refer_tb">
				<tr>
					<th>任务</th>
					<th>积分</th>
					<th>瑞钱币</th>
					<th>体验券</th>
					<th>返现</th>
				</tr>
				<tr>
					<td>推荐好友注册成功并投资(首次)</td>
					<td>-</td>
					<td>+18个</td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td>推荐好友注册成功并投资(转让标除外)</td>
					<td>每投资10000元(年化)+200积分</td>
					<td></td>
					<td></td>
					<td>详见下图返回比例表</td>
				</tr>
			</table>
			<p>返现比例表(根据推荐好友的投资金额及投资期限返现,按月发放)</p>
			<table class="refer_tb2">
				<tr>
					<th>好友投<br />资期限
					</th>
					<th>返现<br />比例
					</th>
					<th>好友投<br />资金额
					</th>
					<th>返现<br />金额
					</th>
					<th id="anli_th">案例</th>
				</tr>
				<tr>
					<td>1</td>
					<td>0.14%</td>
					<td>10000</td>
					<td>14</td>
					<td class="anli_td">你推荐好友投资1个月项目10000元,可获得返现10000x0.14%=14元</td>
				</tr>
				<tr>
					<td>3</td>
					<td>0.425%</td>
					<td>10000</td>
					<td>42.5</td>
					<td class="anli_td">你推荐好友投资3个月项目10000元,可获得返现10000x0.425%=42.5元</td>
				</tr>
				<tr>
					<td>6</td>
					<td>0.86%</td>
					<td>10000</td>
					<td>86</td>
					<td class="anli_td">你推荐好友投资6个月项目10000元,可获得返现10000x0.86%=86元</td>
				</tr>
				<tr>
					<td>12</td>
					<td>1.80%</td>
					<td>10000</td>
					<td>180</td>
					<td class="anli_td">你推荐好友投资12个月项目10000元,可获得返现10000x1.80%=180元</td>
				</tr>
			</table>
			<p>好友统计</p>
			<div id="count_div">
				<!-- <table id="count_tb">
       <tr><th>推荐注册人数</th><th>实名人数</th><th>投资人数</th><th>投资总额</th></tr>
        <tr><td>1</td><td>22</td><td>33</td><td>44</td></tr>
        </table>-->
			</div>
			<p>收益统计(好友投资的返现奖励,将于每月最后的一天发放到账户)</p>
			<div id="income_rate_div">
				<!-- <table id="income_rate_tb">
          <tr><th>用户名</th><th>实名认证</th><th>投资金额</th><th>注册日期</th><th>奖励返现</th></tr>
        <tr><td>weidaishan</td><td>否</td><td>0.00元</td><td>2015-09-09 10:10:07.0</td><td>0元</td></tr>
        </table>-->
			</div>
		</div>
		<div class="container mt20" id="coupon_table_2" style="display: none"></div>
	</div>
	<div class="div_no_record" id="div_ticket_record" style="display: none">你没有投资券记录哦！</div>
	<div id="error_info" class="error_info"></div>
</body>
</html>