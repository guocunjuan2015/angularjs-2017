<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="ngApp">
<head>
<meta charset="UTF-8">
<title>我的投资｜回款计划明细</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<script src="js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/angular.min.js"></script>
<script type="text/javascript" src="js/angular-route.min.js" ></script>
<script type="text/javascript" src="js/bootstrap.min3.0.3.js"></script>
<script src="js/utils.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/reset.css">
<link rel="stylesheet" type="text/css" href="css/investStyle.css">
<%@ include file="/config/config.jsp" %>
<%@ include file="config/header.jsp" %>
<%
	String userName = (String) request.getSession().getAttribute("loginUser");
	String userId = (String) request.getSession().getAttribute("userId");
	String loanId = (String) request.getSession().getAttribute("loanId");
%>
</head>
<body style="background: #fff;">
<input type="hidden" value="<%=userId%>" id="userId">
<input type="hidden" value="<%=loanId%>" id="loanId">
<input type="hidden" value="<%=localPath%>" id="localPath">
<input type="hidden" value="<%=basePath%>" id="basePath">
<section class="paymentPlan">
	<div class="paymentPlanList" ng-controller="paymentPlan">
		<table class="table">
	      <thead>
	        <tr>
	          <th>日期</th>
	          <th>本金(元)</th>
	          <th>利息(元)</th>
	        </tr>
	      </thead>
	      <tbody>
	        <tr ng-class="'{{payment.status}}' == '1' ? '' : 'active'" ng-repeat="payment in paymentList">
	          <td>{{payment.due_date}}</td>
	          <td>{{payment.principal}}</td>
	          <td>{{payment.interest}}<span ng-show="'{{payment.ratesInterest}}' != '0'">+<font color="#ff5555">{{payment.ratesInterest}}</font><img alt="" src="images/page1.png"></span></td>
	        </tr>
	      </tbody>
	    </table>
	</div>
	<div ng-show="showLoadMsg" class="loading">{{loadMsg}}</div>
	<div class="errorTxt" ng-show="error()">{{errorTxt}}</div>
</section>
<script src="js/paymentPlan.js" type="text/javascript"></script>
</body>
</html>