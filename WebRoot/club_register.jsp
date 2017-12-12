<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="config/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
    String referrer = request.getParameter("referrer");
    request.setAttribute("referrer", referrer);
    String marny_id=request.getParameter("marny_id");
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
<script src="js/club_register.js" type="text/javascript"></script>
<script>
/*关闭活动遮罩层  */
function shutshow(){
  $('html,body').animate({scrollTop: '0px'}, 800); 
  //弹出抽奖页面
  $("#divshow").hide(); 
  $("body").css("ohideverflow","auto");
}

/*注册成功弹框 */
function showAys(){
	   apxDataHub.push({"event": "register"});/*注册成功 */
	  //$("#ays_content")[0].innerHTML = value;
	  $("#bg").css("height", document.body.scrollHeight);
	  $("#bg")[0].style.display = "block";
	  $("#ays")[0].style.display = "block";
	}
</script>


</head>
 <!-- 首页弹窗START-->
  <div  id="divshow" style="width:100%; height:100%; background-color:rgba(0,0,0,0.5);
  position:fixed; left:0px; top:0px; z-index:9999; display:block;" >
      <div class="christmas" id="christmas1" style="background:transparent;width:100%;height:100%;border:0;">    
          <a href="javascript:;" onclick="shutshow()"><img style="position:absolute;bottom:80px;" src="images/show_image1.png"/></a>
        <!--    <input class="close1"   type="button" id="getValidateBank"  onclick="shutshow()"/> -->  
    </div> 
  </div> 
 <!-- 首页弹窗END-->
<body style="background:#F05749;">
<script>(function(w,d,h){w[h]=w[h]||[];var f=d.getElementsByTagName('script')[0],j=d.createElement('script');j.async=true;j.src='//tms.chinapex.com.cn/container_files/container_b57jxh5.js';f.parentNode.insertBefore(j,f);})(window,document,'apxDataHub');</script>
<div id="bg"></div>
  <section class="ays" id="ays">
    <div class="ays_h5">
      <h5 style="color: #333;">注册成功</h5>
      <img src="images/input_clear.png" onclick="dismissAys()" />
    </div>
    <p style="padding: 5% 5% 3% 5%; color: #333; font-size: 1.6rem;"
      id="ays_content">立即下载瑞钱宝app</p>
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
  <section id="clubRegister" style="background:#F05749;"> 
  <div id="myCarousel" class="carousel slide">
   <!-- 轮播（Carousel）指标 -->
   <div class="carousel-inner">
      <div class="item active">
        <!--  <img src="images/reg-banner05.jpg" alt="First slide"> -->
          <img src="images/newNav.jpg" alt="First slide">
      </div>
      </div>
      </div>
      
         <section class="newBanner">
       <a href="http://www.rqbao.com/rqb/index.jsp"> <img src="images/newBanner.jpg" width="100%"/></a>
       </section>
    <!-- <img src="images/weixin-banner.png" width="100%" /> -->
    <div class="login">
      <!-- <span>手机号</span> --><input  data-role='none' type="text" id="m" name="m"
        placeholder="输入手机号码" class="form-control"
        onkeyup="this.value=this.value.replace(/\D/g,'')"
        onafterpaste="this.value=this.value.replace(/\D/g,'')" />
    </div>
      <!-- <span>密码&nbsp;&nbsp;&nbsp;</span> --><input data-role='none' value="123456"  id="p" name="p"
        type="hidden" placeholder="6-16位,数字,字母,符号组成" class="form-control"
         style="width:60%"/>
    <!-- <div class="login">
            <span>验证码&nbsp;&nbsp;&nbsp;</span> 
            <input data-role='none'  id="vc" name="vc"
                type="text" placeholder="图片验证码"
                 style="width: 60%;margin: 0 1% 0 1%; height:45px;line-height:45px;"/>
            <span class="vcode"><img id="imgObj" alt="换一张"
                                title="点击图片换一张" src="register/verify/verifyCode.do"
                                onclick="changeVC()" /> <input type="button" value="验证" onclick = "checkVC()"/>
                            </span> 
        </div> -->
    <div class="login">
      <!-- <span>验证码</span> --><input data-role='none' style="float:left;width:55%;" class="form-control" type="text" id="c" name="c"
        placeholder="短信验证码" class="input-pin" /> <button 
        class="btn-pin get_code" id="getc" style="float:left;padding:6px 12px;margin-left:1%;width:40%;/* height:45px;line-height:45px; */background:#FFA740;border:none;color:#fff;">获取验证码</button>
    </div>
    <!-- <a href="#" class="btn-no-pin"><span onclick="showGetRadioCode()">没有收到验证码</span></a> -->
  <!--  <div class="agreement mt" >
      <input data-role='none'  type="checkbox" checked="checked" id="agreeBox" onclick="onBoxClicked()"/> <span>我同意</span> <a
        href="#" onclick="proxy()">《瑞钱宝服务协议》</a>
    </div> -->
  <div class="referrals" style="margin:1.5rem 0 0 0;"><span>推荐人：</span><input type="text" id="referrer" 
      name="referrer" value="<%=referrer==null?"":referrer%>" placeholder="请填写推荐人"/></div>
<!--        <div id="" class="mt"
      style="color:#fff; text-align: left;margin-top:0.5rem;margin-left:15px;padding-left:5rem; ">没有推荐人，可不填。</div> -->
    <div id="showMess" class="mt"
      style="padding-left:15px;margin:0.5rem 0 0 0;color:#fff;  ">&nbsp;</div>
    <div class="container-fluid">
            <button type="button" class="btn btn-danger btn-block btn-red" id="step" style="background:#FFA740">注册领取</button>
            <input type="hidden" id="marny_id" value="<%=marny_id%>"/>
        </div>
        <a href="login.jsp"  style="margin:2% 0 2% 3%;color:#fff; display: inline-block;">已有帐号?立即登录？</a>
  </section>
  
    <section class="marquee">
<img src="images/newBottom.png" />
      </section>
</body>
</html>