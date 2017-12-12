<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common2.css" rel="stylesheet" />
<link href="css/YJHstyle.css" rel="stylesheet" />
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/project_edu_content.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
<title>优计划</title>
</head>
<body>
	<section class="yjhhead">
		<div class="yjh-head">
			<h1 id="project_name"></h1>
		</div>
		<div>
			<div class="nlvdiv nlvsy">
				<span><strong class="qxmoney" id="project_loanRate">
				</strong><span class="prespan">%</span></span> <span>预期年化收益</span>
			</div>
			<div class="nlvdiv">
				<span><strong id="project_loanPeriod"></strong><span
					class="qxspan">个月</span></span> <span>封闭期限</span>
			</div>
			<div class="nlvdiv lastnlv">
				<span><strong id="project_minNum"> </strong><span
					class="qxspan">元</span></span> <span>起投金额</span>
			</div>
		</div>
		<div class="progressdiv">
			<p>
				<span style="float: left">本息保障</span><span style="float: right"
					id="project_repaymentWay"></span>
			</p>
			<div class="progressbars">
				<div class="progress-bar progressbar-jdt" role="progressbar"
					aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
			</div>
			<p>
				<span style="float: left">已有23023人加入</span><span
					style="float: right" id="project_balance">剩余金额 元</span>
			</p>
			<div class="lastday">还剩0天12小时00分00秒</div>
		</div>
	</section>
	<section class="yjhcontent">
		<div class="plandiv">
			<ul>
				<li class="firstli" onclick="getDetail()"><img
					src="images/projectincr.png" />
					<p>计划介绍</p></li>

				<li><img src="images/addrecord.png" />
					<p>加入记录</p></li>
			</ul>
		</div>

	</section>
	<section class="project">
		<div class="projectlx">
			<ul>
				<li><span>预告阶段</span> <span class="projectlx-secondspan">2015-09-25</span>
				</li>
				<li><span>开放加入</span> <span class="projectlx-secondspan">2015-09-25</span>
				</li>
				<li><span>锁定期</span> <span class="projectlx-secondspan">2015-09-25</span>
				</li>
				<li class="projectlx-lastli"><span>到期退出</span> <span
					class="projectlx-secondspan">2015-09-25</span></li>
			</ul>
		</div>
		<div id="error_info" class="error_info"></div>
	</section>
	<section class="tzAdd">
		<div id="baozh_div">
			<span>投资有风险,我们有保障</span><span>[<a href="#">详情</a>]
			</span>
		</div>
		<div id="yue_div" style="display: none">
			可用余额： <span id="yue_span">3000.00</span>元 <span id="to_recharge">去充值>></span>
		</div>
		<div id="epxt_div" style="display: none">
			预期收益： <span id="epxt_income">53.26</span>元
		</div>
		<div class="Addinfo">
			<span id="input_span"> <input class="form-control"
				type="number" id="invest_number" min="0"
				onkeyup="changeInvest(this.value)" placeholder="请填写投资的金额(元)"></input></span>
			<span class="btnjoin">立即加入</span>
		</div>
	</section>
	<div>
		<FORM id="form_save_cop_info">
			<input type="hidden" name="copType" id="copType" /> <input
				type="hidden" name="passValue" id="passValue" /> <input
				type="hidden" name="copId" id="copId" /> <input type="hidden"
				name="project_type" id="project_type" />
		</FORM>
	</div>
	<div style="display: none">
		<span id="project_id"></span>
	</div>
</body>
</html>