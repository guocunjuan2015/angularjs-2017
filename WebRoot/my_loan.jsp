<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>我要借款</title>
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
<section class="myLoan">
	<img src="<%=basePath%>/images/loan6.png">
	<p>请您移驾至瑞钱宝官网(www.rqbao.com)或者下载瑞钱宝App进行查看</p>
	<input id="down" type="button" value="下载瑞钱宝App">
</section>
</body>
<script type="text/javascript">
//页面定义html字体大小
(function (doc,win) {
	var clientWidth;
	var docEl = doc.documentElement,
        resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
    recalc = function (){
        clientWidth = docEl.clientWidth;
        if (!clientWidth) {return ;}
    	docEl.style.fontSize = 10 * (clientWidth / 375) +"px";
    };
    if(!doc.addEventListener) return;
    win.addEventListener(resizeEvt,recalc,false);
    doc.addEventListener('DOMContentLoaded',recalc,false);
})(document,window);
var userId = $("#userId").val();
if(userId == "null" || userId  == ""){
	window.location.href = "login.jsp";
};
$("#down").click(function (){
	window.location.href = "download_app.jsp";
})
</script>
</html>