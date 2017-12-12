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
        <base id="base" href="<%=basePath%>">
        
        <title>瑞钱宝</title>
        
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
        <meta http-equiv="description" content="This is my page">
            <link href="css/main.css" rel="stylesheet"/>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/common2.css" rel="stylesheet"/>
    <link href="css/login.css" rel="stylesheet"/>
        <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
        <script src="js/utils.js" type="text/javascript"></script>
        <script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
        <script src="js/retrieve_password.js" type="text/javascript"></script>
        <script src="js/register.js" type="text/javascript"></script>
        <%@ include file="config/header.jsp" %>
    </head>
    <body>
    <div id="step_layer1">
	<header>
        <div class="home_title red_bg">
            <a class="icon-back" href="#"></a>忘记密码  
        </div>
    </header>
	<section >
    <div class="login" style="margin-top: 2%">
        <span>手机号</span><input type="text" id="auth_m" name="auth_m" placeholder="您的手机号码" 
        onkeyup="inputKeyUp(this.value,this.id,1,'clear_phone')"
                />
    <img class="input-clear" src="images/input_clear.png" id="clear_phone" onclick="clearInput('auth_m',this.id)"/>
    </div>
    <div class="login">
        <span>验证码</span><input type="text"  id="auth_c" name="auth_c" style="width: 30%"
                placeholder="短信验证码"  IME-MODE: disabled"
                onkeyup="this.value=this.value.replace(/\D/g,'')">
                <button class="btn-pin get_code" style="float: right;margin-right: 2%;
                padding-left: 4%;border-left: 1px solid #f1f1f1" id="auth_getc">获取验证码</button>
    </div>
    <div id="showMess" style="text-align:center;color:red;margin-top: 2%">&nbsp;</div>
    <div style="margin: 0 6%"><button class="btn btn-lg btn-danger btn-block btn-red btn-next" id="step1">下一步</button></div>
</section>
</div>
<!-- 第二步，重置密码 -->
<div id="step_layer2" style="display: none;">
<header>
        <div class="home_title red_bg">
            <a class="icon-back" href="#"></a>重置密码  
        </div>
    </header>
    <section >
    <div class="login" style="margin-top: 2%">
        <input type="password" id="auth_p" name="auth_p" placeholder="输入新的登录密码" onkeyup="this.value=this.value.replace(/\W/g,'')"
                />
    </div>
    <div class="login" >
        <input type="password" id="auth_rep" name="auth_rep" placeholder="再次输入新登录密码" onkeyup="this.value=this.value.replace(/\W/g,'')"
                />
    </div>
    <div id="update_mess" style="text-align:center;color:red;margin-top: 2%">&nbsp;</div>
    <div style="margin: 0 6%"><button class="btn btn-lg btn-danger btn-block btn-red btn-next" id="update">立即修改</button></div>
</section>
</div>
<!-- 找回密码 step3-->
        <div id="step_layer3" style="display: none;">
            <div class="home_title red_bg">
            <a class="icon-back" href="#"></a>瑞钱宝-找回密码  
        </div>
            <div class="container-fluid mp0">
                <div class="logo-login row">
                    <div class="col-xs-8"><img class="img-responsive" src="images/rqbao.png"></div>
                    <div class="col-xs-4" style=" "><a class="btn btn-link" href="login.jsp" role="button">登录</a></div>
                </div>
            </div>
            <div class="container-fluid">
                <div class="clearfix">
                    <h6 class="pull-left lh500">温馨提示：</h6>
                    <h3 class="text-success pull-left">操作成功！</h3>
                </div>
                <p class="">重置密码操作成功，请重新登录！</p>
            </div>
            <div class="container-fluid mt20">
                <button type="button" class="btn btn-danger btn-block mt10 mb20" id="ok">确定</button>
                <button type="button" class="btn btn-primary btn-block mt10 mb20" id="gotop">返回投资页</button>
            </div>
        </div>
</body>
</html>