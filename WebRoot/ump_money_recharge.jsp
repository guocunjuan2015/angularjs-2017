<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>账户中心 | 充值</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/yeepay.css">
<link href="css/common2.css" rel="stylesheet" />
<link href="css/projectstyle.css" rel="stylesheet" />
<link href="css/accountcenterstyle.css" rel="stylesheet" />
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/ump_recharge.js" type="text/javascript"></script>
<%@ include file="/config/config.jsp" %>
<style type="text/css">
body {  
  background: rgb(245,244,244);
}

.projectcontent h2 {
  color: #666;
  float: none;
  margin: 0 auto;
}

.projectcontent .secondsdd {
  padding-left: 10%;
  text-align: left;
}
</style>
</head>
<body>
<%@ include file="/config/globalHead.jsp" %>
<input type="hidden" value="<%=basePath%>" id="basePath">
<%@ include file="/config/dirlog.jsp" %>
	<button style="display: none" id="myModal" type="button"
    class="btn btn-danger mt20 ml20" data-toggle="modal"
    data-target=".bs-example-modal-lg">温馨提示</button>
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
          <h4 class="text-success text-center" id="tip_content"></h4>
        </div>
        <div class="modal-footer">
          <button type="button" style="display: none" onclick="gotoPage(0)"
            id="msg_btn_0" class="btn btn-primary btn-block">设置支付密码</button>
          <button type="button" style="display: none" onclick="gotoPage(1)"
            id="msg_btn_1" class="btn btn-primary btn-block">实名认证</button>
          <button type="button" style="display: none" onclick="gotoPage(2)"
            id="msg_btn_2" class="btn btn-primary btn-block">绑定银行卡</button>
          <button type="button" style="display: none" onclick="gotoPage(3)"
            id="msg_btn_3" class="btn btn-primary btn-block">充值</button>

          <button type="button" style="display: none" onclick="gotoPage(4)"
            id="msg_btn_4" class="btn btn-danger btn-block">马上赚钱</button>
          <button type="button" style="display: none" onclick="gotoPage(5)"
            id="msg_btn_5" class="btn btn-primary btn-block">个人中心</button>
          <button type="button" style="display: none" id="msg_btn_6"
            class="btn btn-primary btn-block" onclick="doOpenPayment()">开通快捷支付</button>
          <button type="button" style="display: none" onclick="gotoPage(6)"
            id="msg_btn_7" class="btn btn-primary btn-block"
            data-dismiss="modal">绑定银行卡(联动优势)</button>
          <div id="check_epay_result" style="display: none">
            <button type="button" onclick="gotoPage(7)"
              class="btn btn-danger btn-block" data-dismiss="modal">立即操作</button>
          </div>
        </div>

      </div>
    </div>
  </div>
	<section class="banks-info"  style="position: relative;display:none" id="bank_info"> 
	    <%--  <span class="alopen" id="alopen" style="display:none">已开通</span>
	     <img class="alopen_img" id="alopen_img" src="${pageContext.request.contextPath}/images/kjzf.png" style="display:none" /> --%>
	</section>
	<section class="rechargeBox">
	   <p>确认支付</p>
	   <div class="rechangeLi">
	       <div class="bankIcon">
	         <p style="padding-top:0.5rem;"><img id="bank_logo" src=""/></p>
	         <span class="bank-name" id="bank_name"></span> 
           <span class="bank-card" id="bank_code"></span> 
	       </div>
	       <p style="float:left;width:45%;text-align:center;"><img style="margin:2rem 0 0 1rem;" src="${pageContext.request.contextPath}/images/arrowRight.png"/> 
	       </p>
	       <p class="account_cash">
	            <img  src="${pageContext.request.contextPath}/images/accountIcon.png"/>
	                  账户余额
	       </p>
	   </div>
	</section>
	
	<section class="rechargeList">
        <ul>
          <li>当前账户余额：<span id="account_balance"></span>元</li>
           <li><input class="form-control"
              onkeyup="changeRecharge()" type="number" id="recharge_money"
              placeholder="请输入充值金额(100元起)"></input><font>元</font></li>
        </ul><div class="clear"></div>
  </section>
  
    <!-- <section class="paymentLi">
       <p>
          <button class="openFastBtn" id="openFastBtn" onclick="doOpenPayment()">开通快捷支付</button>
                         使用的银行卡
       </p>   
   </section> -->
  
<!--   <section class="rechargeList bankZone">
    <img id="bank_logo" src=""/> 
       <div class="banks"> 
           <span class="bank-name" id="bank_name"></span> 
           <span class="bank-card" id="bank_code"></span> 
       </div> <div class="clear"></div>
  </section> -->
	
  <div style="display: none">
    <form action="" method="post" id="ump_recharge_form"></form>
  </div>
  <div style="display: none">
    <form action=""
      method="post" id="request_form">
      <ul>
        <li><input type="hidden" name="req_data" id="req_data" /></li>
      </ul>
    </form>
    <form action=""
            method="post" id="payment_form">
            <ul>
                <li><input type="hidden" name="payment_data" id="payment_data" /></li>
            </ul>
        </form>
  </div>
  <div id="error_info" class="error_info"></div>
 <p style="margin-top:5rem;text-align:center;">
    <button type="button"  class="btn btn-danger"
      id="recharge_btn" onclick="recharge()">下一步</button>
  </p>
  <p style="text-align: center;margin-top:15px;
  font-size: 1.4rem;color: #333;">如有疑问请致电：<font style="color:#7fdcff;
  text-decoration: underline;">400-919-8555</font></p>
  <%@ include file="/config/dirlog.jsp" %>
</body>
</html>