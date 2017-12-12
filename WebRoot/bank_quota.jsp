<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
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
   
%>
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
<%@ include file="/config/config.jsp" %>
<%@ include file="config/header.jsp" %>
</head>
<body>
<input type="hidden" value="<%=basePath%>"  id="basePath">
<input type="hidden" value="<%=userId%>"  id="userId">
	<!-- 新布局 -->
	<section class="addBankSec">
		<section class="bank bankAccount">
			<div class="bankList">
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/gs_bk.png" alt="ICBC"></dt>
					<dd class="fl">
						<h3>中国工商银行</h3>
						<p>单笔限额99,999元，单日限额20万</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/ny_bk.png" alt="ABC"></dt>
					<dd class="fl">
						<h3>中国农业银行</h3>
						<p>单笔限额20万，单日限额50万</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/js_bk.png" alt="CCB"></dt>
					<dd class="fl">
						<h3>中国建设银行</h3>
						<p>单笔限额5万，单日限额50万</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/zg_bk.png" alt="BOC"></dt>
					<dd class="fl">
						<h3>中国银行</h3>
						<p>单笔限额5万，单日限额30万</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/yc_bk.png" alt="SPDB"></dt>
					<dd class="fl">
						<h3>中国邮政储蓄银行</h3>
						<p>单笔限额10万，单日限额100万</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/zs_bk.png" alt="CMB"></dt>
					<dd class="fl">
						<h3>招商银行</h3>
						<p>单笔限额5000元，单日限额10万</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/xy_bk.png" alt="CIB"></dt>
					<dd class="fl">
						<h3>兴业银行</h3>
						<p>单笔限额5万，单日限额5万</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/gd_bk.png" alt="CEB"></dt>
					<dd class="fl">
						<h3>光大银行</h3>
						<p>单笔限额20万，单日限额20万</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/gf_bk.png" alt="GDB"></dt>
					<dd class="fl">
						<h3>广发银行</h3>
						<p>单笔无限额，单日无限额</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/pa_bk.png" alt="SPAB"></dt>
					<dd class="fl">
						<h3>平安银行</h3>
						<p>单笔限额50万，单日限额500万</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/ms_bk.png" alt="CMBC"></dt>
					<dd class="fl">
						<h3>民生银行</h3>
						<p>单笔限额2,000万，单日限额10,000万</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/pf_bk.png" alt="SPDB"></dt>
					<dd class="fl">
						<h3>上海浦东发展银行</h3>
						<p>单笔限额5万，单日限额5万</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/zx_bk.png" alt="CITIC"></dt>
					<dd class="fl">
						<h3>中信银行</h3>
						<p>单笔限额5,000元，单日限额5,000元</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/jt_bk.png" alt="COMM"></dt>
					<dd class="fl">
						<h3>交通银行</h3>
						<p>单笔限额20万，单日限额20万</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/hx_bk.png" alt="CITIC"></dt>
					<dd class="fl">
						<h3>华夏银行</h3>
						<p>单笔限额50万，单日限额150万</p>
					</dd>
				</dl>
				<dl class="clearfix">
					<dt class="fl"><img src="<%=basePath%>/images/logo/bj_bk.png" alt="COMM"></dt>
					<dd class="fl">
						<h3>北京银行</h3>
						<p>单笔限额5,000元，单日限额5,000元</p>
					</dd>
				</dl>
			</div>
		</section>
	</section>

</body>
</html>