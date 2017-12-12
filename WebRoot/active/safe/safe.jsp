<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="UTF-8"%>
<%@ include file="/config/config.jsp" %>
<%
HttpSession hs = request.getSession();
String user = "";//用户名
String userId = "";//用户userId
String userHex = "";//hex编码的用户名，分享出去用到，app转进来需要解码
String utm_source = request.getParameter("utm_source");//渠道
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>安全保障</title>
	<meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财">
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/active/safe/css/safe.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/utils.js" type="text/javascript"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/active/icard/icard.js"></script>
</head>
<body>
<input type="hidden" value="<%=basePath%>"  id="basePath">
<input type="hidden" value="<%=localPath%>"  id="localPath">
<input type="hidden" value="<%=utm_source%>"  id="channel">
	<div class="banner">
		<img src="<%=basePath%>/active/safe/image/safe_01.png" alt="安全保障 八重机制"/>
	</div>
	<div class="safe_one">
		<div class="bgwhite">
			<h3>国企参股</h3>
			<p>瑞钱宝是国企华融天泽参股的综合金融服务平台，致力于为个人、企业提供金融交易信息服务。</p>
		</div>
		<%-- <div class="bgwhite">
			<h3>借款项目足值抵押物</h3>
			<img src="<%=basePath%>/active/safe/image/safe_04.png"/>
			<p>所有借款项目均需提供第三方权威审计机构进行审计后，按照市场公允价的60%以内进行放款（即抵押放贷率不超过60%），且由合作担保公司提供反担保措施。</p>
		</div> --%>
		<h3>投资项目安全保障</h3>
		<img src="<%=basePath%>/active/safe/image/safe_05.png"/>
		<p>瑞钱宝对企业融资项目进行高标准的审核和筛选，对项目担保情况、抵质押物情况、项目资金用途、融资企业经营状况、还款能力等情况进行专业严格的审查。对融资企业的各项信息进行全方位的尽职调查、征信，并如实展现给平台投资人。</p>
		<div class="bgwhite">
			<h3>第三方认证合作机构</h3>
			<img src="<%=basePath%>/active/safe/image/safe_06.png"/>
			<p>第三方安全认证合作机构——“北京天威诚信电子商务服务有限公司”为用户提供安全可信的电子签名服务， 用户通过使用由第三方认证机构颁发的数字证书在应用和法律层面保证了整体系统的安全性。</p>
		</div>
	</div>
	<div class="safe_two">
		<h3>用户信息安全保障</h3>
		<p><span></span><b>数据安全</b></p>
		<p>瑞钱宝非常重视投资用户的隐私和数据安全，瑞钱宝采用国际标准的SSL安全加密技术保障数据信息安全；</p>
		<p><span></span><b>数据灾备</b></p>
		<p>瑞钱宝平台具有先进完备的开发技术、符合互联网金融交易规则的先进流程及框架设计，类似银行的数据灾容备份和系统保障技术；</p>
		<p><span></span><b>交易安全</b></p>
		<p>瑞钱宝平台引入CA认证，通过使用数字证书实现身份识别和电子信息加密，保障平台上各角色用户在平台交易的安全性、真实性、可靠性、完整性；</p>
		<p><span></span><b>网络安全</b></p>
		<p>部署了完备的网络安全设备：可杜绝ARP攻击和MAC地址欺骗;有效防护DDoS，SQL注入，跨站脚本等黑客攻击;安全人员定期对服务器进行挂马扫描，漏洞扫描等检测，保证网络安全。</p>
	</div>
</body> 
</html>
