<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="ngApp">
<head>
<meta charset="UTF-8">
<title>瑞钱宝</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<script src="js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/bootstrap.min3.0.3.js"></script>
<script type="text/javascript" src="js/angular.min.js"></script>
<script type="text/javascript" src="js/angular-route.min.js" ></script>
<script src="js/utils.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/reset.css">
<link rel="stylesheet" type="text/css" href="css/message.css">
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
<body>
<%@ include file="/config/globalHead.jsp" %>
	<input type="hidden" value="<%=basePath%>"  id="basePath">
	<input type="hidden" value="<%=localPath%>"  id="localPath">
	<input type="hidden" value="<%=userId%>"  id="userId">
	<section ng-controller="message" style="padding-top:6rem;">
		<div class="messages" onclick="changeMessageStatus(this)" ng-class="{{message.status}} == 1 ? 'read' : ''" ng-repeat="message in messageList">
			<div class="clearfix"><span class="fr">{{message.date}}</span><h3 class="fl"><b>{{message.subject}}</b><i></i></h3></div>
			<p>{{message.content}}</p>
		</div>
		<div class="errorTxt" ng-show="error()">{{errorTxt}}</div>
	</section>
<script src="js/message_center.js" type="text/javascript"></script>
</body>
</html>