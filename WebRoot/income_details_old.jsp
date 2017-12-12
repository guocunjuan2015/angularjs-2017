<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common2.css" rel="stylesheet" />
<link href="css/main.css" rel="stylesheet" />
<link href="css/more.css" rel="stylesheet" />
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/income_details.js" type="text/javascript"></script>
<script src="js/personal_record.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
<title>收支明细</title>
</head>
<body>
	<header>
		<div class="home_title_red">
			<a class="icon-back" href="#"></a>收支明细
		</div>
	</header>
	<section class="sz-details">
		<span class="span1 sz-span1-font">账户总资产</span> <span class="sz-money"><strong id="total_finc"> </strong>元</span>
	</section>
	<section class="sz-details sz-font">
		<span class="span1">可用余额</span> <span class="span2" id="rest_useable">元</span>
	</section>
	<section class="sz-details  sz-span1-font2">
		<span class="span1">待收本金</span> <span class="span2" id="will_income">元</span>
	</section>
	<section class="sz-details  sz-span1-font2">
		<span class="span1">待收利息</span> <span class="span2" id="will_lix">元</span>
	</section>
	<section class="sz-details sz-span1-font2">
		<span class="span1">冻结金额</span> <span class="span2" id="money_frozen">元</span>
	</section>
	<section class="sz-details sz-margin">
		<span class="span1 sz-span1-font1">累计收益</span> <span
			class="sz-money"><strong id="lj_income"></strong>元<i class="sz-details-arrow">&nbsp;</i></span>
	</section>
	<section class="sz-details sz-margin" style="margin-top: 3px" onclick="toFincDetails()">
        <span class="span1 sz-span1-font1">资金明细</span> <span
            class="sz-money"><strong  ></strong><i class="sz-details-arrow">&nbsp;</i></span>
    </section>
	
	<!-- <section class="zj-details" onclick="toFincDetails()">
		<span class="line-grey left-line-grey">&nbsp;</span>
		<span class="span1 sz-span1-font1">资金明细</span>
		<span class="line-grey right-line-grey">&nbsp;</span>
	</section>
	
	<div class="container-fluid">
        <p class="">
            一共 <span class="text-danger" id="record_count"></span> 条交易记录
        </p>
        <div class="licai-box">
            <table class="table">
                <tbody id="record_table"></tbody>
            </table>
        </div>
    </div> -->
    <div id="error_info" class="error_info"></div>
</body>
</html>