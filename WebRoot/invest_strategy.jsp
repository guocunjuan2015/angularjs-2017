<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/common2.css" rel="stylesheet"/>
    <link href="css/inverstdetails.css" rel="stylesheet"/>
<script src="js/jquery-1.11.2.min.js"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/frame/ios_js.js" type="text/javascript"></script>
<script type="text/javascript">
function toProject(){
    if(isAndroidOrIos()){
        toIosInvest();
        appFunction('invest');
    }else{
        window.location.href = "project.jsp";
    }
}
</script>
<%@ include file="config/header.jsp"%>
<title>投资攻略</title>
    <style type="text/css">
        body{background:#fc3343 url('images/strategy/strategybg.png') repeat-y;background-size:100%;  }
    </style>
</head>
<body>
  <section>
      <div style="text-align:center;margin-top:5%;">
          <img src="images/strategy/invert-banner.png" width="96%" />
      </div>
      <div class="step">
          <img src="images/strategy/stepbg.png" width="100%" />
         <h3>第一步</h3>
          <h4 style="line-height:50px;text-align:center;"><strong>新手注册</strong> 得3000体验金</h4>
          <img class="step-img" src="images/strategy/step_01.jpg" width="50%" >
      </div>
      <div class="step">
          <img src="images/strategy/stepbg2.png" width="100%"/>
          <h3>第二步</h3>
          <h4 style="line-height:50px;text-align:center;">实名认证自动开通第三方资金托管</h4>
          <img class="step-img" src="images/strategy/step_02.jpg" width="50%" >
      </div>
      <div class="step">
          <img src="images/strategy/stepbg.png" width="100%"/>
          <h3>第三步</h3>
          <h4><strong>绑定银行卡</strong>  同卡进出，方便、快捷，保障您的资金安全</h4>
          <img class="step-img" src="images/strategy/step_03.jpg" width="50%" >
      </div>
      <div class="step">
          <img src="images/strategy/stepbg2.png" width="100%"/>
          <h3>第四步</h3>
          <h4><strong>充值</strong>  支持15家银行快捷支付,实时到账</h4>
          <img class="step-img" src="images/strategy/step_04.jpg" width="50%" >
      </div>
      <div class="step">
          <img src="images/strategy/stepbg.png" width="100%"/>
          <h3>第五步</h3>
          <h4><strong>投资</strong>  5大理财产品,多种投资期限,100起投</h4>
          <img class="step-img" src="images/strategy/step_05.jpg" width="50%" >
      </div>
      <div class="step">
          <img src="images/strategy/stepbg2.png" width="100%"/>
          <h3>第六步</h3>
          <h4><strong>提现</strong>  0管理费,工作日16点前提现当天到账</h4>
          <img class="step-img" src="images/strategy/step_06.jpg" width="50%" >
      </div>
      <div class="step">
          <img src="images/strategy/stepbg.png" width="100%"/>
          <h3>第七步</h3>
          <h4><strong>复投</strong>  这么好的平台，你有什么理由不复投!</h4>
          <img class="step-img" src="images/strategy/step_07.png" width="50%" >
      </div>
      <div style="text-align:center;margin-bottom:4%;"> 
            <button class="btn-step-invest" onclick="toProject()">马上去投资</button> 
            <p style="color:#333;">如有疑问请拨打客服热线：<span style="text-decoration: underline;">400－0827-002</span></p> 
        </div>
  </section>
</body>
<script type="text/javascript" src="js/frame/rqbaoappshare.js"></script>
</html>