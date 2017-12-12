<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="UTF-8"%>
<%@ include file="/config/config.jsp" %>
<%
HttpSession hs = request.getSession();
String user = "";//用户名
String userId = "";//用户userId
String userHex = "";//hex编码的用户名，分享出去用到，app转进来需要解码
String from = request.getParameter("from");
if (from == null || !("app".equals(from))) {
    from = "";
}
String referrer = request.getParameter("referrer");//获得的推荐人是Hex编码
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
String userAppId = request.getParameter("userId");
if (from != null && "app".equals(from)) {
    userId = userAppId;
    hs.setAttribute("userId", userId);
    //app上无分享功能
} else if (hs != null) {
    userId = (String) hs.getAttribute("userId");
    if (userId == null) {
        userId = "";
    }
}
String phone = request.getParameter("phone");
String lotteryId = request.getParameter("lotteryId");
String utm_source = request.getParameter("utm_source");//渠道
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>风险测评</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link rel="stylesheet" type="text/css" href="css/reset.css">
<link href="css/risk.css" rel="stylesheet"/>
<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/utils.js" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
<script type="text/javascript" src="js/bootstrap.min3.0.3.js"></script>
<style>
.errorZone p{line-height:3rem !important;}
.errorZone p img{padding:2rem;}
</style>
</head>
<body>
<input type="hidden" value="<%=basePath%>"  id="basePath">
<input type="hidden" value="<%=localPath%>"  id="localPath">
<input type="hidden" value="<%=userId %>" id="userId"/>
	<input type="hidden" value="<%=userApp %>" id="userApp"/>
<div class="evaluation topicStyle" style="display:block;">
	<div class="riskTopic">
		<div class="topic">
			<h4>1、您目前的就业状况如何？</h4>
			<div class="reward clearfix">
				<p class="checkp"><input type="radio" name="radio1" value="1" /> A、学生、无业或退休</p>
				<p class="checkp"><input type="radio" name="radio1" value="2" /> B、自由职业</p>
				<p class="checkp"><input type="radio" name="radio1" value="3" /> C、上班族</p>
				<p class="checkp"><input type="radio" name="radio1" value="4" /> D、企业家</p>
			</div>
		</div>
		<div class="topic">
			<h4>2、过去一年，您可用于投资的资金为？</h4>
			<div class="reward clearfix">
				<p class="checkp"><input type="radio" name="radio2" value="1" /> A、1万元及以下</p>
				<p class="checkp"><input type="radio" name="radio2" value="2" /> B、1-5万元（含5万元）</p>
				<p class="checkp"><input type="radio" name="radio2" value="3" /> C、5-10万元（含10万元）</p>
				<p class="checkp"><input type="radio" name="radio2" value="4" /> D、20万元以上</p>
			</div>
		</div>
		<div class="topic">
			<h4>3、您投资的目的是：</h4>
			<div class="reward clearfix">
				<p class="checkp"><input type="radio" name="radio3" value="1" /> A、资产保值，我不愿意承担任何投资风险</p>
				<p class="checkp"><input type="radio" name="radio3" value="2" /> B、资产在保值的基础上，有小幅增长，我可以承担较低的投资风险</p>
				<p class="checkp"><input type="radio" name="radio3" value="3" /> C、资产稳健增长，我可以承担一定的投资风险</p>
				<p class="checkp"><input type="radio" name="radio3" value="4" /> D、资产迅速增长，我愿意承担很大的投资风险</p>
			</div>
		</div>
		<div class="topic">
			<h4>4、您对理财产品的看法是：</h4>
			<div class="reward clearfix">
				<p class="checkp"><input type="radio" name="radio4" value="1" /> A、理财产品无风险，类似存款</p>
				<p class="checkp"><input type="radio" name="radio4" value="2" /> B、理财产品应当保本，但收益不确定</p>
				<p class="checkp"><input type="radio" name="radio4" value="3" /> C、理财产品本金可能产生少量损失</p>
				<p class="checkp"><input type="radio" name="radio4" value="4"/> D、理财产品可能大幅亏损，应当仔细选择</p>
			</div>
		</div>
		<div class="topic">
			<h4>5、假设有两种投资：投资A预期获得10%的收益，可能承担的损失非常小；投资B预期获得30%的收益，但可能承担较大亏损。您会怎么支配您的投资：</h4>
			<div class="reward clearfix">
				<p class="checkp"><input type="radio" name="radio5" value="1" /> A、全部投资于收益较小且风险较小的A</p>
				<p class="checkp"><input type="radio" name="radio5" value="2" /> B、同时投资于A和B，但大部分资金投资于收益较小且风险较小的A</p>
				<p class="checkp"><input type="radio" name="radio5" value="3" /> C、同时投资于A和B，但大部分资金投资于收益较大且风险较大的B</p>
				<p class="checkp"><input type="radio" name="radio5" value="4"/> D、全部投资于收益较大且风险较大的B</p>
			</div>
		</div>
		<div class="topic">
			<h4>6、哪个情况发生了，您会明显焦虑？</h4>
			<div class="reward clearfix">
				<p class="checkp"><input type="radio" name="radio6" value="1" /> A、本金无损失，但收益未达预期</p>
				<p class="checkp"><input type="radio" name="radio6" value="2" /> B、本金10%以下损失</p>
				<p class="checkp"><input type="radio" name="radio6" value="3" /> C、本金10%-30%损失</p>
				<p class="checkp"><input type="radio" name="radio6" value="4"/> D、本金30%以上损失</p>
			</div>
		</div>
		<div class="topic">
			<h4>7、您最长可接受哪类投资期限的P2P产品？</h4>
			<div class="reward clearfix">
				<p class="checkp"><input type="radio" name="radio7" value="1" /> A、短期，1-3个月 </p>
				<p class="checkp"><input type="radio" name="radio7" value="2" /> B、中期，4-6个月</p>
				<p class="checkp"><input type="radio" name="radio7" value="3" /> C、中长期，7-12个月</p>
				<p class="checkp"><input type="radio" name="radio7" value="4"/> D、长期，12个月以上</p>
			</div>
		</div>
		<div class="topic">
			<h4>8、哪项描述最符合您对P2P投资收益率的认识？</h4>
			<div class="reward clearfix">
				<p class="checkp"><input type="radio" name="radio8" value="1" /> A、比银行定期高一点就可以了</p>
				<p class="checkp"><input type="radio" name="radio8" value="2" /> B、越高越好，但不要超过法院支持的24%利率</p>
				<p class="checkp"><input type="radio" name="radio8" value="3"/> C、利率是市场确定的，再高都合理</p>
			</div>
		</div>
		<div class="topic">
			<h4>9、在您每年的家庭收入中，可用于金融投资的比例为？</h4>
			<div class="reward clearfix">
				<p class="checkp"><input type="radio" name="radio9" value="1" /> A、小于10%</p>
				<p class="checkp"><input type="radio" name="radio9" value="2" /> B、10%至25%</p>
				<p class="checkp"><input type="radio" name="radio9" value="3" /> C、25%至50%</p>
				<p class="checkp"><input type="radio" name="radio9" value="4"/> D、大于50%</p>
			</div>
		</div>
		<div class="topic">
			<h4>10、哪项描述更符合您对P2P风险的理解？</h4>
			<div class="reward clearfix">
				<p class="checkp"><input type="radio" name="radio10" value="1" /> A、平台承诺100%本息保障就无风险 </p>
				<p class="checkp"><input type="radio" name="radio10" value="2" /> B、有担保、保险、风险准备金制度的没有风险</p>
				<p class="checkp"><input type="radio" name="radio10" value="3" /> C、最新有融资、入股新闻出来的平台短期没有风险</p>
				<p class="checkp"><input type="radio" name="radio10" value="4"/> D、所有P2P都有风险</p>
			</div>
		</div>
	</div>
	<footer>
		<p class="riskNum"><span>1</span>／10</p>
		<div class="riskPro">
			<div class="riskPro_on"></div>
		</div>
		<div class="helpmsg"></div>
		<div class="riskFoot">
			<a class="riskFoot_a" id="preva">上一题</a>
			<a class="riskFoot_a" id="submita">提交</a>
		</div>	
	</footer>
	<input id="markInp" type="hidden" value="" >
</div>
<%--测评结果 --%>
<div class="evaluationEnd">
	<img alt="" src="<%=basePath%>/images/help2.png">
	<p class="evaluationp1 pb20 txtCenter"></p>
	<p class="evaluationp2 pb20 txtCenter"><span></span></p>
	<a class="evaluationA" id="goProject" href="javascript:;">去理财</a>
	<a class="evaluationA" id="again" href="javascript:;">重新测评</a>
</div>
<script type="text/javascript" src="js/risk.js"></script>
</body>
</html>