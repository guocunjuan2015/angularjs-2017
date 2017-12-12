<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String utm_source = request.getParameter("utm_source");
	String iosUrl = "http://a.app.qq.com/o/simple.jsp?pkgname=com.dyxd.rqt&g_f=991653";
	String url = "http://o7yy4xew2.bkt.clouddn.com/ruiqianbao_ruiqianbao_v3.7.5_release.apk";
%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>瑞钱宝App</title>
	<meta name="keywords" content="">
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
	<link rel="shortcut icon" href="/static/favicon.ico" type="image/x-icon">
	<link rel="stylesheet" href="css/p2p.css">
	<script type="text/javascript" src="../js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript">
		$(function(){
			var ua = navigator.userAgent.toLowerCase();
			if (/iphone|ipad|ipod/.test(ua)) {
	            $("#download").click(function(){
	                window.location.href = '<%=iosUrl%>';
	            });
	        } else {
	             /*  alert("android");   */ 
	            $("#download").click(function(){
	                window.location.href = '<%=url%>';
	            });
	        }
		});
	</script>
</head>
<body>
<section>
	<img src="images/annular.png" alt="logo"/>
	<a href="<%=iosUrl%>"><img src="images/ios.png" alt="ios"/></a>
	<a href="<%=url%>"><img src="images/android.png" alt="android"/></a>
</section>
</body>
</html>