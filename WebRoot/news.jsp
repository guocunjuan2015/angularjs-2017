<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String from = request.getParameter("from");
if(from !=null && "app".equals(from)){
    String user = request.getParameter("user");
    String userId = request.getParameter("userId");
    HttpSession s = request.getSession();
    if(user!=null && user!= ""){
        s.setAttribute("loginUser", user);
    }
    if(userId!= null && userId != ""){
        s.setAttribute("userId", userId);
    }
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>最新活动</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/common.css" rel="stylesheet"/>
    <link href="css/common2.css" rel="stylesheet"/>
    <link href="css/news.css" rel="stylesheet"/>
    <script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/news.js" type="text/javascript"></script>
<script src="js/frame/ios_js.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
</head>
<body>
 
<div id="outter_div"></div>
<%@ include file="config/loading_anim.jsp"%>   
</body>
<script src="js/frame/rqbaoappshare.js" type="text/javascript"></script>
</html>