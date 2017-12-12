<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/config/config.jsp" %>
<%@ include file="/config/global.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<link href="css/projectstyle.css" rel="stylesheet" />
	<link href="css/accountcenterstyle.css" rel="stylesheet" />
	<title>提现</title>
</head>
<body> 
<input type="hidden" value="<%=basePath%>" id="basePath">  
<%@ include file="/config/globalHead.jsp" %>
<!-- 	<header>
		<div class="home_title red_bg">
			<a class="icon-back" href="#"></a>提现
			<span class="sp_titile_left" onclick="showCashRecord()">提现记录</span>
		</div>
	</header> -->
<h1 class="topTit"><a class="fa fa-angle-left" href="javascript:;" onclick="history.back(-1)"></a>提现</h1>
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
					<h4 class="modal-title" id="myModalLabel">温馨提示</h4>
				</div>
				<div class="modal-body">
					<h4 class="text-success text-center" id="tip_content"></h4>
					<!-- <p>5分钟内现金会转到您绑定的银行卡上</p> -->
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
<!-- <section class="banks-info"  style="position: relative;display:none" id="bank_info"> 
     <img id="bank_logo" src=""/> 
     <div class="banks"> 
         <span class="bank-name" id="bank_name"></span> 
         <span class="bank-card" id="bank_code"></span> 
     </div> 
     <span class="alopen" id="alopen" style="display:none">已开通</span>
     <img class="alopen_img" id="alopen_img" src="images/kjzf.png" style="display:none" />
     <button class="openFastBtn" id="openFastBtn" onclick="doOpenPayment()">开通快捷支付</button>
 </section> -->
 
  <section class="rechargeBox">
     <p>提现</p>
     <div class="rechangeLi">
          <p class="account_cash" style="float:left;">
              <img  src="${pageContext.request.contextPath}/images/accountIcon.png"/>
                    账户余额
         </p>
        <p style="float:left;width:45%;text-align:center;"><img style="margin:2rem 0 0 1rem;" src="${pageContext.request.contextPath}/images/arrowRight.png"/> 
         </p>
          <div class="bankIcon" style="float:right;">
	          <p style="padding-top:0.5rem;"><img id="bank_logo" src=""/></p>
	           <span class="bank-name" id="bank_name"></span> 
	          	<span class="bank-card" id="bank_code"></span>
         </div>
        
     </div>
  </section>
  
  
  <section class="rechargeList">
        <ul>
          <li>可提现金额：<span id="account_balance"></span>元</li>
           <li><input class="form-control"
              onclick="iniCheck()" onkeyup="changeCash(this.value)"
              type="number" min=0 id="cash_money"/><font>元</font></li>
        </ul><div class="clear"></div>
  </section>
  
   <!-- <section class="paymentLi">
       <p>
          <button class="openFastBtn" id="openFastBtn" onclick="doOpenPayment()">开通快捷支付</button>
                         使用的银行卡
       </p>   
   </section> -->
  
 
	<!-- <div class="container-fluid mp0">
		<div class="licai-box mt10">
			<table class="table">
				<tbody>
					<tr id="account_bl_tr" style="display: none">
						<td class="w25">账户余额</td>
						<td class="text-left text-muted9"><span id="account_balance"></span>元</td>
					</tr>
					<tr>
						<td class="w25">提现金额</td>
						<td class="text-left text-muted9"><input class="form-control"
							onclick="iniCheck()" onkeyup="changeCash(this.value)"
							type="number" min=0 id="cash_money"></input></td>
					</tr>
					<tr id="psw_tr" style="display: none">
						<td class="w25">支付密码</td>
						<td class="text-left text-muted9"><input class="form-control"
							type="password" id="cash_password" placeholder="请输入您的支付密码"></input></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div> -->
	<div id="error_info" class="error_info"></div>
	<div style="display: none">
		<form action="" method="post" id="ump_cash_form"></form>
	</div>
	<p style="margin-top:5rem;text-align:center;">
		<button type="button" class="btn btn-danger" 
			id="cash_btn" onclick="cash()">下一步</button>
	</p>
<script src="${pageContext.request.contextPath}/js/ump_money_cash.js" type="text/javascript"></script>	
</body>
</html>