<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
    String referrer = request.getParameter("referrer");
    System.out.println(referrer);
    request.setAttribute("referrer", referrer);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/login.css" rel="stylesheet" />
<link href="css/wechat2.css" rel="stssylesheet" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/common2.css"/>
<link href="css/utils.css" rel="stylesheet" />
<script src="js/jquery-1.8.3.min.js"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/bootstrap.min3.0.3.js"></script>
<script src="js/active_register.js" type="text/javascript"></script>
<title>瑞钱宝 - 注册</title>
</head>
<body>
<div id="bg"></div>
	<section class="ays" id="ays">
		<div class="ays_h5">
			<h5 style="color: #333;">注册成功</h5>
			<img src="images/input_clear.png" onclick="dismissAys()" />
		</div>
		<p style="padding: 5% 5% 3% 5%; color: #333; font-size: 1.6rem;"
			id="ays_content">立即下载瑞钱宝app，登陆后绑定银行卡领取奖励</p>
		<div><button class="btn btn-primary" onclick="downloadApp()">下载瑞钱宝app</button></div>
</section>
<button style="display: none" id="myModal" type="button"
        class="btn btn-danger mt20 ml20" data-toggle="modal"
        data-target=".bs-example-modal-lg">提示信息</button>
    <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog"
        aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">提示信息</h4>
                </div>
                <div class="modal-body">
                    <h4 class="text-success text-center" id="body_content_h4">注册成功!</h4>
                    <!-- <p>投资金额：<span class="text-danger" id="money_invest_modal">1000</span>元</p> -->
                </div>
                <div class="modal-footer" style="display:none">
                    <button type="button" onclick="gotoPage()"
                        class="btn btn-danger btn-block">登录</button>
                </div>
                <div class="modal-footer" id="phone_code_div" style="display: none">
                    <table style="width:100%">
                        <tr>
                            <td align="center" valign="middle" width="50%">
                                <button type="button" data-dismiss="modal" 
                                    id="bt_invite" class="btn btn-danger">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;取消&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
                            </td>
                            <td align="center" valign="middle" width="50%"><button type="button" data-dismiss="modal"
                                    onclick="getRadioCode()" id="bt_to_invest"
                                    class="btn btn-danger">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;接收&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <input data-role='none'  type="hidden" id="referrer" name="referrer"
                            value='<c:out value="${referrer}" escapeXml="true"></c:out>' />
	<section>
	<div id="myCarousel" class="carousel slide">
   <!-- 轮播（Carousel）指标 -->
   <div class="carousel-inner">
      <div class="item active">
         <img src="images/active_banner.png" alt="First slide">
      </div>
      </div>  </div>
		<!-- <img src="images/weixin-banner.png" width="100%" /> -->
		<div class="login">
			<span>手机号</span><input  data-role='none' type="text" id="m" name="m"
				placeholder="您的手机号码"
				onkeyup="this.value=this.value.replace(/\D/g,'')"
				onafterpaste="this.value=this.value.replace(/\D/g,'')" />
		</div>
		<div class="login">
			<span>密码&nbsp;&nbsp;&nbsp;</span><input data-role='none'  id="p" name="p"
				type="password" placeholder="6-16位,数字,字母,符号组成"
				 style="width: 60%"/>
		</div>
		<div class="login">
            <span>验证码&nbsp;&nbsp;&nbsp;</span> 
            <input data-role='none'  id="vc" name="vc"
                type="text" placeholder="图片验证码"
                 style="width: 27%;margin: 0 0 0 8%;padding: 0;"/>
            <span class="vcode"><img id="imgObj" alt="换一张"
                                title="点击图片换一张" src="register/verify/verifyCode.do"
                                onclick="changeVC()" /> <!-- <input type="button" value="验证" onclick = "checkVC()"/> -->
                            </span>
        </div>
		<div class="login">
			<span>验证码</span><input data-role='none'  type="text" id="c" name="c"
				placeholder="短信验证码" class="input-pin" /> <button 
				class="btn-pin get_code" id="getc" style="background: none;border:none;color:#f00;">获取验证码</button>
		</div>
		<a href="#" class="btn-no-pin"><span onclick="showGetRadioCode()">没有收到验证码</span></a>
		<div id="showMess" class="mt"
			style="color: red; text-align: center; ">&nbsp;</div>
		<div class="agreement mt" >
			<input data-role='none'  type="checkbox" checked="checked" id="agreeBox" onclick="onBoxClicked()"/> <span>我同意</span> <a
				href="#" onclick="proxy()">《瑞钱宝服务协议》</a>
		</div>
		<div class="container-fluid">
            <button type="button" class="btn btn-danger btn-block btn-red" id="step">注册</button>
        </div>
	</section>
</body>
</html>