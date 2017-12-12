<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>瑞钱宝</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/real_name.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
</head>
<body>
	<header>
	<div class="home_title">
		<a class="icon-back" href="#"></a>瑞钱宝-实名认证
	</div>
	</header>
	<div class="container-fluid mp0 mt10">
		<div class="licai-box">
			<table class="table">
				<tbody>
					<tr>
						<td class="w25">姓名</td>
						<td class="text-left text-muted9"><input type="text"
							class="form-control" id="real_name" name="real_name"
							placeholder="本人真实姓名"></td>
					</tr>
					<tr>
						<td class="w25">身份证</td>
						<td class="text-left text-muted9"><input type="text"
							class="form-control" id="real_code" name="real_code"
							placeholder="本人身份证号码"></td>
					</tr>
					<tr>
						<td class="w25"></td>
						<td class="text-left text-muted9">
							<div id="showMess" style="color: red;"></div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div class="container-fluid mt20">
		<button type="button" class="btn btn-danger btn-block mt10 mb20"
			id="next_btn">认证(下一步充值)</button>
		<button type="button" class="btn btn-primary btn-block mt10 mb20"
			id="ok" style="display: none">完成</button>
		<button type="button" class="btn btn-primary btn-block mt10 mb20"
			onclick="cancel()">暂不认证</button>
	</div>
</body>
</html>