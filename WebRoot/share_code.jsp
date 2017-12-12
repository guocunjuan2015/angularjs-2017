<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="UTF-8">
<title>关注瑞钱宝公众号</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="pragma" content="no-cache">
    <link rel="stylesheet" type="text/css" href="css/intro-friend.css">
    <script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
    <%@ include file="config/header.jsp" %>
</head>
<body>
<h4 style="color: #607fa6;text-align: center;font-size: 1.1rem">瑞钱宝财富街</h4>
<p style="text-align:center;margin-top: 3%; padding-bottom: 0;
margin-bottom: 0;color: #333;font-size: 1.25rem">微信公众平台：<font style="font-size: 1.3rem">rqbcfj</font></p>
      <p style="text-align: center;margin: 1% 0 0 0;padding: 0;"><img  
src="share/encoderQRCoder.do?content=http://weixin.qq.com/r/pjq3r5fEJcpardPM92_0"
            width="52%" style="max-width: 320px"/> </p>
            <p style="text-align: center;color: #607fa6">扫描或长按识别二维码</p>
</body>
</html>
