<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ng-app="ngApp">
<head>
<meta charset="UTF-8">
<title>产品列表页面 | 理财项目</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/reset.css">
<link rel="stylesheet" type="text/css" href="css/project.css" />
<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="js/angular.min.js"></script>
<script type="text/javascript" src="js/angular-route.min.js" ></script>
<script type="text/javascript" src="js/bootstrap.min3.0.3.js"></script>
<script type="text/javascript" src="js/utils.js" type="text/javascript"></script>
<%@ include file="/config/config.jsp" %>
<%@ include file="config/header.jsp"%>
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
<section class="projectList" style="padding-top:6rem">
	<nav style="height:auto;">
		<ul>
		<!-- 	<li><a href="#financialProject">理财项目</a></li> -->
			<!-- <li><a href="#transferProject">转让专区</a></li> -->
		</ul>
	</nav>
	<!-- <div class="space"></div> -->
	<div ng-view=""></div>
</section>
</body>
<script type="text/javascript" src="js/projectang.js"></script>
</html>