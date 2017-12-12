<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet"/>
    <link href="css/common2.css" rel="stylesheet"/>
    <link href="css/login.css" rel="stylesheet"/>
    <link href="css/accountcenterstyle.css" rel="stylesheet" />
    <script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
    <script src="js/zhuge_ini.js"></script>
    <%@ include file="config/header.jsp" %>
    <title>注册成功</title>
    <script type="text/javascript">
   function toIndex(){
       window.location.href = "index.jsp";
   }
   function toRealRegister(){
       window.location.href = "ump_real_register.jsp";
   }
</script>
<style>

.realNameOrCard,.fixedDirlog{display: none !important}

</style>
</head>
<body>
<%@ include file="/config/dirlog.jsp" %>
<header>
        <div class="home_title red_bg">
            <a class="icon-back" href="#"></a> 注册成功
        </div>
</header>
<section >
   <p style="text-align:center;margin:12% 0 7%;"><img src="images/register.png"/></p>
    <p class="register-success-info">恭喜您，注册成功!</p>
    <!--注册成功无托管时显示-->
    <p class="no-register-info">你尚未注册第三方资金托管账户，不能进行投资</p>
    <!--注册成功无托管时显示end-->
    <p class="btns-info">
        <span style="color:#666;margin-right:6%;" onclick="toIndex()">稍后开通</span>
        <!--如果未托管，开通按钮显示-->
        <a class="button btn-red btn-middle" style="color:#fff;height:4rem;line-height:4rem;" onclick="goRealname();">马上开通</a>
        <!--如果未托管，开通按钮显示end-->
        <!--如果已托管，投资按钮显示-->
        <a class="button btn-red btn-middle"  style="color:#fff;display:none;">投资</a>
        <!--如果已托管，投资按钮显示end-->
    </p>
</section>
</body>
</html>