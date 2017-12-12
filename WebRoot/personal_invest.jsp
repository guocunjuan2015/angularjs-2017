<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="ngApp">
<head>
<meta charset="UTF-8">
<title>账户中心｜我的投资</title>
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
<style>
.index-header1 {
    position: fixed !important;
    width: 100%;
    z-index: 99;
}
</style>
<%
	String userName = (String) request.getSession().getAttribute("loginUser");
%>
</head>
<body>
<%@ include file="/config/globalHead.jsp" %>
<input type="hidden" value="<%=userId%>" id="userId">
<input type="hidden" value="<%=localPath%>" id="localPath">
<input type="hidden" value="<%=basePath%>" id="basePath">
<section class="investList">
	<nav>
		<ul>
			<li><a href="#bid">投标中</a></li>
			<li><a href="#return">回款中</a></li>
			<li><a href="#settled">已结清</a></li>
		</ul>
	</nav>
	<div class="space"></div>
	<div ng-view=""></div>
</section>
<script src="js/userInvest.js" type="text/javascript"></script>
</body>
</html>