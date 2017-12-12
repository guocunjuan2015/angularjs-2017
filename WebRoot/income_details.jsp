<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="ngApp">
<head>
<meta charset="UTF-8">
<title>资金明细</title>
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
%>
<style>
.index-header1 {
    position: fixed !important;
    width: 100%;
    z-index: 99;
}
</style>
</head>
<body style="background:#fff;">
<%@ include file="/config/globalHead.jsp" %>
<input type="hidden" value="<%=userId%>" id="userId">
<input type="hidden" value="<%=localPath%>" id="localPath">
<input type="hidden" value="<%=basePath%>" id="basePath">
<section class="capital">
	<div class="capitalList" ng-controller="fundDetails">
		<h1>全部</h1>
		<div class="space"></div>
		<div class="capital" ng-repeat="capital in capitalList">
			<h3>{{capital.type}}<span> ({{capital.remarks}})</span></h3>
			<p>{{capital.create_date}}</p>
			<h4 ng-show="isColor1($index)">{{capital.invest_amount}}</h4>
			<h4 ng-show="isColor2($index)" class="green">{{capital.invest_amount}}</h4>
			<h4 ng-show="isColor3($index)" class="red">{{capital.invest_amount}}</h4>
		</div>
	</div>
	<div ng-show="showLoadMsg" class="loading">{{loadMsg}}</div>
	<div class="errorTxt" ng-show="error()">{{errorTxt}}</div>
</section>
<script src="js/fundDetails.js" type="text/javascript"></script>
</body>
</html>