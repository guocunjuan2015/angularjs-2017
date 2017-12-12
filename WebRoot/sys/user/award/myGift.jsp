<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ng-app="ngApp">
<head>
<meta charset="UTF-8">
<title>账户中心｜我的礼物</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/sys/user/award/css/myGift.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/angular.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/angular-route.min.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min3.0.3.js"></script>
<%@ include file="/config/config.jsp" %>
<%@ include file="/config/header.jsp"%>

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
<section class="projectList">
	<nav>
		<ul>
			<li><a href="#red">红包</a></li>
			<li><a href="#voucher">加息券</a></li>
			<li><a href="#prize">奖品</a></li>
			<li><a href="#withdraw_cash">提现券</a></li>
		</ul>
	</nav>
	<div class="space"></div>
	<div ng-view=""></div>
</section>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/sys/user/award/js/myGift.js"></script>
</html>