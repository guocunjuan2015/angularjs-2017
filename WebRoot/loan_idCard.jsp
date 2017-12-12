<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>认证中心</title>
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
<section class="idCard">
	<form id="formIdCard" action="<%=basePath%>/user/credit/uploadImg.do" method="post" enctype="multipart/form-data">
		<h1>身份证认证</h1>
		<div class="idCardPhoto clearfix">
			<p>必须提供的资料<span>（上传的资料须清晰/完整,如果发现资料系伪造或有人工修改痕迹，瑞钱宝将把您列入黑名单，取消您的借款资格）</span></p>
				<div class="fl w49">
					<input type="file" id="fileElem" name="fileElem" accept="image/*" value="" onchange="handleFiles(this)">
					<div id="fileList" style="width:100%;height:100%;"><img id="image"src=""/></div>
				</div>
				<div class="fr w49">
					<img style="display:block;" src="<%=basePath%>/images/loan9.png">
				</div>
				<div class="fl w49">
					<input type="file" id="fileElem2" name="fileElem2" accept="image/*" value="" onchange="handleFiles2(this)">
					<div id="fileList2" style="width:100%;height:100%;"><img id="image2"src=""/></div>
				</div>
				<div class="fr w49">
					<input type="file" id="fileElem3" name="fileElem3" accept="image/*" value="" onchange="handleFiles3(this)">
					<div id="fileList3" style="width:100%;height:100%;"><img id="image3"src=""/></div>
				</div>
		</div>
		<div class="bottomBtn">
			<input type="button" id="idCardBtn" class="idCardBtn" value="立即认证">
		</div>
	</form>
</section>
<div class="prompt"></div>
<div class="loading">
	<img src="<%=basePath%>/active/farm/images/loading.gif">
</div>
</body>
<script type="text/javascript" src="js/loan_authentication.js"></script>
</html>