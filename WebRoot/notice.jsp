<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common.css" rel="stylesheet" />
<link href="css/common2.css" rel="stylesheet" />
<link href="css/more.css" rel="stylesheet" />
<script src="js/jquery-1.8.3.min.js"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/notice.js" type="text/javascript"></script>
<script src="js/bootstrap.min3.0.3.js"></script>
<%@ include file="config/header.jsp" %>
<title>公告</title>
</head>
<body>
	<div id="notice_container"></div>
	<div id="error_info" class="error_info"></div>
	<%@ include file="config/loading_anim.jsp" %>
    <div class="no-data">没有记录</div>
</body>
</html>