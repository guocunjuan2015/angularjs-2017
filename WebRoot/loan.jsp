<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>我要借款</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/reset.css">
<link rel="stylesheet" type="text/css" href="css/loan.css" />
<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min3.0.3.js"></script>
<script type="text/javascript" src="js/utils.js" type="text/javascript"></script>
<%@ include file="/config/config.jsp" %>
<%@ include file="config/header.jsp"%>
<%
	String userName = (String) request.getSession().getAttribute("loginUser");
%>
</head>
<body>
<%@ include file="/config/globalHead.jsp" %>
<input type="hidden" value="<%=basePath%>"  id="basePath">
<input type="hidden" value="<%=localPath%>"  id="localPath">
<input type="hidden" value="<%=userId%>"  id="userId">
<input type="hidden" value="<%=userName%>" id="userName">
<section class="loan">
	<h1>我要借款</h1>
	<ul class="loanUl clearfix">
		<li>
			<img style="width:2.8rem;height:4.3rem;" alt="" src="<%=basePath%>/images/loan1.png">
			<p>产品多样</p>
			<p>低门槛 轻松借款</p>
		</li>
		<li>
			<img style="width:1.9rem;height:4.3rem;" alt="" src="<%=basePath%>/images/loan2.png">
			<p>借款快</p>
			<p>当天核实 当天出借</p>
		</li>
		<li>
			<img style="width:2.8rem;height:4.3rem;" alt="" src="<%=basePath%>/images/loan3.png">
			<p>额度高</p>
			<p>个人最高20万</p>
		</li>
	</ul>
	<div class="loanBox">
		<div class="loanOperation">
			<h3 id="scrollBarTxt">1000</h3>
			<p>借款金额(元)</p>
			<ul class="loanUl2 clearfix">
				<li>
					<p id="period">21</p>
					<p>借款期限(天)</p>
				</li>
				<li>
					<p id="money">100</p>
					<p>手续费(元)</p>
				</li>
			</ul>
			<p class="moneyP clearfix"><span class="fl reviewMoney"></span><span class="fr pathMoney"></span></p>
			<p class="moneyP clearfix"><span class="fl interestMoney"></span></p>
			<div class="loanHref">
				<input type="button" id="loanBtn" onclick="keyBorrowing();" value="一键借款">
			</div>
		</div>
	</div>
	
</section>
<div class="loanDirlog"></div>
<div class="msgTxt">
	<p class="p1">请先进行实名认证</p><%-- 还有一步之遥，请绑定银行卡 --%>
	<p class="p2"><a href="">立即认证</a></p><%--绑定银行卡 --%>
</div>
<div class="msgTxt2">
	<p class="p1">没有开通还款免密协议，请先开通免密协议</p><%-- 还有一步之遥，请绑定银行卡 --%>
	<p class="p3"><a class="fl closeMsg" href="javascript:;">取消</a><a  class="fr" href="javascript:;" onclick="gorepaymentPasswordFree()">立即开通</a></p><%--绑定银行卡 --%>
</div>
<div class="loading">
	<img src="<%=basePath%>/active/farm/images/loading.gif">
</div>
<!-- 金额提示 -->
<div class="promptMoney">
	<p class="loanMoneyP">借款金额：<span></span>元</p>
	<p class="actualArrival">实际到帐：<span></span>元</p>
	<p class="due">到期应还：<span></span>元</p>
	<p class="p3"><a class="fl closeMsg4" href="javascript:;">再看一下</a><a class="fr" href="javascript:;" onclick="fixedLoan()">确定借款</a></p>
</div>
<div class="success">
	<img src="<%=basePath%>/images/loan13.png">
	<p class="sucP">借款申请已提交，请耐心等待审核！</p>
	<p class="p3"><a class="fl closeMsg2" href="javascript:;">取消</a><a class="fr" href="javascript:;" onclick="seeMyLoan()">查看我的申请</a></p>
</div>
<div class="fail">
	<img src="<%=basePath%>/images/loan14.png">
	<p class="failP">对不起，您的借款申请提交失败！</p>
	<p class="p2"><a class="closeMsg3" href="javascript:;">关闭</a></p>
</div>
</body>
<script type="text/javascript" src="js/loan.js"></script>
</html>