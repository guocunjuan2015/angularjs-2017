<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common2.css" rel="stylesheet" />
<link href="css/more.css" rel="stylesheet" />
<title>公告详情</title>
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/notice_details.js" type="text/javascript"></script>
<script src="js/frame/ios_js.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/jweixin-1.0.0.js" type="text/javascript"></script>
<script type="text/javascript" src="js/weixin_share.js"></script>
<%@ include file="config/header.jsp" %>
<style type="text/css">
body {
	background: #fff;
	max-width: 750px;
}
</style>
</head>
<body>
<%@ include file="config/show_share.jsp" %>
	<section class="notice_details">
		<div class="notice_details_title">
			<h5 id="details_title"></h5>
			<p>
				<span id="details_time"></span><span>瑞钱宝团队</span>
			</p>
		</div>
		<div class="notice_details_info">
			<span class="notice_details_indent"  id="details_content"></span>
		</div>
		<div id="error_info" class="error_info"></div>
	</section>
	<div style="text-align: center;" id="share_btn"><button type="button" style="text-align: center;margin-bottom: 15px;" 
	class="btn btn-info mt10 mb20"   onclick="shareClick()">&nbsp;&nbsp;分享&nbsp;&nbsp;</button></div>
</body>
<script type="text/javascript" src="js/frame/rqbaoappshare.js"></script>
</html>