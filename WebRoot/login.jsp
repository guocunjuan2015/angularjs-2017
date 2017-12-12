<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
    String active = request.getParameter("active");
    if (active == null) { 
    	active = ""; 
    }
%>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    <title>瑞钱宝</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <link href="css/main.css" rel="stylesheet"/>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/common2.css" rel="stylesheet"/>
    <link href="css/login.css" rel="stylesheet"/>
	<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
	<script src="js/bootstrap.min.js" type="text/javascript"></script>
	<script src="js/utils.js" type="text/javascript"></script>
	<script src="js/json2.js" type="text/javascript"></script>
	<script src="js/ump_register.js" type="text/javascript"></script>
	<script  type="text/javascript" src="js/frame/vertical_prevent.js"> </script>
	<%@ include file="config/header.jsp" %>
    <title>登录</title>
</head>
<body>
	<header>
        <div class="home_title red_bg">
            <a class="icon-back" href="#"></a> 登录 <span class="sp_titile_left"
                 id="register_login">注册</span>
        </div>
    </header>
	<section >
	<input type="hidden" id="active" value="<%=active %>"/>
    <div class="login login-user">
        <span>用户名</span><input type="text" name="u" placeholder="昵称/手机号" id="u"
        onkeyup="inputKeyUp(this.value,this.id,2,'clear_name')"
        />
        <img class="input-clear" src="images/input_clear.png" id="clear_name" onclick="clearInput('u',this.id)"/>
    </div>
    <div class="login">
        <span>密码&nbsp;&nbsp;&nbsp;</span><input type="password" name="p" placeholder="瑞钱宝登录密码" id="p"
        onkeyup="inputKeyUp(this.value,this.id,2,'clear_password')"
        />
        <img class="input-clear" src="images/input_clear.png" id="clear_password" onclick="clearInput('p',this.id)"/>
    </div>
    <div id="showMess" style="text-align:center;color:red;margin-top: 2%">&nbsp;</div>
    <div style="margin: 0 6%"><button class="btn btn-lg btn-danger btn-block btn-red btn-next" id="login">登录</button></div>
    <button  class="pwd" id="lostPwd">忘记登录密码</button>
</section>
</body>
</html>