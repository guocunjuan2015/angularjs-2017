<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/config/config.jsp" %>
<%@ include file="/config/global.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>绑定银行卡</title>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common2.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="css/main.css">
<link href="css/more.css" rel="stylesheet" />
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script type="text/javascript">
function addCard(){
	window.location.href = "ump_bind_card.jsp";
}

</script>
<%@ include file="/config/globalHead.jsp" %>
</head>
<body>
	<header>
<!-- 	<div class="home_title_red">
		<a class="icon-back" style="display:inline-block;width:2rem;float: left;color:#fff;" href="#" onclick="history.back(-1)"> < </a>绑定银行卡
	</div> -->
	</header>
	<section class="about_info bank">
	<!-- 	<p class="bank-tips">【温馨提示】</p>
		<p>1.目前仅支持添加一张银行卡</p> -->
		<p class="bank-img" style="width: 40%;margin: 0 auto;margin-top: 10%; text-align:center;" onclick="addCard()">
			<img src="images/bank.png" style="width: 100%;"/>
			<span style="margin-top:1rem;display: inline-block;font-size:1.2rem;"><font style="margin-right:4px;width:20px;height:20px;line-height:20px;color:#A2A2A2;border-radius:50%;border:1px solid #ccc;display: inline-block;">!</font>还没有绑定银行卡银行卡哦！</span>
		</p>
		
	</section>
</body>
</html>