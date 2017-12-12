<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
String channel = request.getParameter("channel");
String utm_source = request.getParameter("utm_source");
String iosUrl = "http://a.app.qq.com/o/simple.jsp?pkgname=com.dyxd.rqt&g_f=991653";
String url = "http://a.app.qq.com/o/simple.jsp?pkgname=com.dyxd.rqt&g_f=991653";

if (utm_source != null && !"".equals(utm_source.trim())) {
	url = "http://file.rqbao.com/android/latest/ruiqianbao_" + utm_source + ".apk";
} else if (channel != null && "ditui1".equals(channel)){
    url = "http://www.rqbao.com/static/download/ruiqianbao_3.4.2_ditui1.apk";
} else {
	url = "http://file.rqbao.com/android/latest/ruiqianbao.apk";
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport"
    content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common2.css" rel="stylesheet" />
<link href="css/more.css" rel="stylesheet" />
<title>下载</title>
<style type="text/css">
body { 
    background: #fef5e9;
}
.download{overflow:hidden;padding:10% 0 0;background:#fef5e9; }
.download ul, .download li {
	height:80px;
}
.ios-download,.android-download{
 	display:block;
	margin:0 auto;
	width:40%;
	height:45px;
	border:0;
	background:none;
} 
.ios-download{
background-repeat:no-repeat;
	background-size:100%;
} 
.android-download{
	background: url(../images/download2_03.png) no-repeat;
	background-size:100%;
}
</style>
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function(){
		var ua = navigator.userAgent.toLowerCase();
        if (/iphone|ipad|ipod/.test(ua)) {
        	$("#ios").css("background-image","url(images/download2_02.png)");
        	
        } else {
        	$("#ios").css("background-image","url(images/download2_03.png)");
        }
	    userAgent();
	});
     function iosDownload() {
        window.location.href = '<%=iosUrl%>';
    } 
     function androidDownload() {
        window.location.href = '<%=iosUrl%>';
    }  
    function userAgent(){
        var ua = navigator.userAgent.toLowerCase(); 
        if (/iphone|ipad|ipod/.test(ua)) {
            $("#ios").click(function(){
                window.location.href = '<%=iosUrl%>';
            });
            
            $("#android").click(function(){
                window.location.href = '<%=iosUrl%>';
            });
             /* alert("iphone"); */
        } else if (/android/.test(ua)) {
             /*  alert("android");   */ 
            $("#ios").click(function(){
                window.location.href = '<%=url%>';
            });
            $("#android").click(function(){
                window.location.href = '<%=url%>';
            });
        }else{
            $("#ios").click(function(){
                window.location.href = '<%=url%>';
            });
            $("#android").click(function(){
                window.location.href = '<%=url%>';
                /* fef5e9*/
            });
        }
    }
</script>
<%@ include file="config/header.jsp" %>
</head>
<body>
    <section style="max-width: 750px;"> 
        <!--<i class="download_top">&nbsp;</i>-->
        <img src="images/downloadNew0.png" />
        <div id = "channel_value" style="display:none"></div>
        <div class="download">
            <ul>
                <li><button id="ios" class="ios-download"></button></li>
<!--                 <li><button id="android" class="android-download"></button></li> -->
            </ul>
        </div>
    </section>
</body>
</html>