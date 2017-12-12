<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/config/config.jsp" %>
<%@ include file="/config/global.jsp" %>
<%-- <%
HttpSession hs = request.getSession(); 
String user = ""; 
String userId = "";//用户userId
String userHex = "";//hex编码的用户名，分享出去用到，app转进来需要解码
user = (String) hs.getAttribute("loginUser");
String userAppId = request.getParameter("userId");
String from = request.getParameter("from");

String userApp = request.getParameter("user");
if (from != null && "app".equals(from) && userApp != null
        && userApp != "") {
    user = userApp;
    hs.setAttribute("loginUser", user);
    //app上无分享功能
} else if (hs != null) {
    user = (String) hs.getAttribute("loginUser");
    if (user == null) {
        user = "";
    }
    if (user != null && user != "") {
//         userHex = Hex.encodeHexString(user.getBytes());//将用户Hex编码，用于分享
        
    } else {
        userHex = "";
    }
}
if (from == null || !("app".equals(from))) {
    from = "";
}
if (from != null && "app".equals(from)) {
    userId = userAppId;
} else if (hs != null) {
    userId = (String) hs.getAttribute("userId");
}
   
%> --%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>瑞钱宝</title>
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link href="css/common2.css" rel="stylesheet" />
<link href="css/more.css" rel="stylesheet" />
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<%@ include file="/config/globalHead.jsp" %>
</head>
<body>
<input type="hidden" value="<%=basePath%>"  id="basePath">
<input type="hidden" value="<%=userId%>"  id="userId">
	<!-- <header>
		<div class="home_title red_bg">
			<a style="display:inline-block;width:2rem;float: left;color:#fff;" href="#" onclick="history.back(-1)"> < </a>添加银行卡
		</div>
	</header> -->
	<!-- 新布局 -->
	<section class="addBankSec">
		<section class="bank-details" style="margin-left: 0;">
			<ul>
				<li><span class="menus"> 持卡人 </span><span id="real_name" style="color:#666"></span></li>
				<li onclick="goBankAccount()"><span class="menus"> 开户银行 </span>
				<input class="fl" id="bank_select" type="button" value="" placeholder="请绑定开通快捷支付的借记卡"><a class="fr fa fa-angle-right" style="padding-right:1rem;" href="javascript:;"> > </a></li>
				<li><span class="menus"> 卡号 </span><input class="bank_select" type="tel" min=0
					style="border: none" id="bind_cardNO" onkeyup="onInput()"
					placeholder="输入银行卡号" /></li>
			</ul>
			<div id="ivst_div8" class="checkbox" style="display: none">
				<label><input type="checkbox" value="" checked="checked"
					id="soft_pay_cbox">开通快捷支付 一旦开通不能关闭， 请谨慎！</label>
			</div>
			<div id="error_info" class="error_info"></div>
			<div class="container-fluid">
				<button type="button" class="idCardBtn" id="btn_bind" onclick="bind()">确认</button>
			</div>
			<div class="bankcard-tips">
				<p>客服电话：<a href="tel:400-919-8555"
						style="text-decoration: underline; color: #7fdcff">400-919-8555</a>
				</p>
			</div>
		</section>
		<section class="bank bankAccount" style="margin-left: 100%;">
			<div class="bankList">
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/gs_bk.png" alt="ICBC"></dt>
					<dd class="fl">
						<h3>中国工商银行</h3>
						<p>单笔5万，单日5万；银行客户热线：95588</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/js_bk.png" alt="CCB"></dt>
					<dd class="fl">
						<h3>中国建设银行</h3>
						<p>单笔5万，单日5万；银行客户热线：95533</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/ny_bk.png" alt="ABC"></dt>
					<dd class="fl">
						<h3>中国农业银行</h3>
						<p>单笔5万，单日5万；银行客户热线：95599</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/zg_bk.png" alt="BOC"></dt>
					<dd class="fl">
						<h3>中国银行</h3>
						<p>单笔5万，单日10万；银行客户热线：95566</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/pf_bk.png" alt="SPDB"></dt>
					<dd class="fl">
						<h3>浦发银行</h3>
						<p>单笔5万，单日5万；银行客户热线：95528</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/jt_bk.png" alt="COMM"></dt>
					<dd class="fl">
						<h3>交通银行</h3>
						<p>单笔5万，单日5万；银行客户热线：95559</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/ms_bk.png" alt="CMBC"></dt>
					<dd class="fl">
						<h3>民生银行</h3>
						<p>单笔5万，单日20万；银行客户热线：95568</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/gf_bk.png" alt="GDB"></dt>
					<dd class="fl">
						<h3>广发银行</h3>
						<p>单笔5万，单日20万；银行客户热线：95508</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/zx_bk.png" alt="CITIC"></dt>
					<dd class="fl">
						<h3>中信银行</h3>
						<p>单笔5万，单日10万；银行客户热线：95566</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/xy_bk.png" alt="CIB"></dt>
					<dd class="fl">
						<h3>兴业银行</h3>
						<p>单笔5万，单日10万；银行客户热线：95561</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/gd_bk.png" alt="CEB"></dt>
					<dd class="fl">
						<h3>光大银行</h3>
						<p>单笔5万，单日20万；银行客户热线：95595</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/zs_bk.png" alt="CMB"></dt>
					<dd class="fl">
						<h3>招商银行</h3>
						<p>单笔0.1万，单日0.5万；银行客户热线：95555</p>
					</dd>
				</dl>
				<%-- <dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/pa_bk.png" alt="SPAB"></dt>
					<dd class="fl">
						<h3>平安银行</h3>
						<p>单笔5万，单日20万；银行客户热线：400-882-4365</p>
					</dd>
				</dl> --%>
			</div>
		</section>
	</section>




	<div style="display: none">
		<FORM action="" method="post" id="ump_bind_card_form"></FORM>
	</div>
</body>
<script src="js/ump_bind_card.js" type="text/javascript"></script>
</html>