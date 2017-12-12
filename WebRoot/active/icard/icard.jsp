<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="UTF-8"%>
<%
HttpSession hs = request.getSession();
String user = "";//用户名
String userId = "";//用户userId
String userHex = "";//hex编码的用户名，分享出去用到，app转进来需要解码
String utm_source = request.getParameter("utm_source");//渠道
	String localPath = "http://www.rqbao.com/"; 
	String basePath = "http://www.rqbao.com/rqb"; 
	//String localPath = "http://test.rqbao.com";
	//String basePath = "http://test.rqbao.com/rqb";
	/* String localPath = "http://localhost/rqt";
	String basePath = "http://localhost/rqb"; */
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>礼物兑换</title>
	<meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财">
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/active/icard/css/icard.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/utils.js" type="text/javascript"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/active/icard/icard.js"></script>
</head>
<body>
<input type="hidden" value="<%=basePath%>"  id="basePath">
<input type="hidden" value="<%=localPath%>"  id="localPath">
<input type="hidden" value="<%=utm_source%>"  id="channel">
	<h1 class="iktit">礼物兑换</h1>
	<div class="banner">
		<img src="<%=basePath%>/active/icard/images/ikbanner.png" alt="华融天泽"/>
	</div>
	<!--产品特点-->
	<div class="icard_trait clearfix">
		<h3>产品特点</h3>
		<div class="icard_trait_dl clearfix">
			<dl>
				<dt><img src="<%=basePath%>/active/icard/images/ikpic1.png" alt=""/></dt>
				<dd>
					<h4>大型国企</h4>
					<p>资产超过6千亿元的港交所上市企业“中国华融”之控股子公司</p>
				</dd>
			</dl>
			<dl>
				<dt><img src="<%=basePath%>/active/icard/images/ikpic2.png" alt=""/></dt>
				<dd>
					<h4>安全有保障</h4>
					<p>被中国证监会评为A类A级券商</p>
				</dd>
			</dl>
		</div>
		<div class="icard_trait_dl clearfix">
			<dl>
				<dt><img src="<%=basePath%>/active/icard/images/ikpic3.png" alt=""/></dt>
				<dd>
					<h4>优质资产</h4>
					<p>经中国证监会批准专门从事直接投资业务</p>
				</dd>
			</dl>
			<dl>
				<dt><img src="<%=basePath%>/active/icard/images/ikpic4.png" alt=""/></dt>
				<dd>
					<h4>风险非常低</h4>
					<p>到期国企华融天泽进行债券回购</p>
				</dd>
			</dl>
		</div>
	</div>
	<!--投资送好礼-->
	<div class="icard_trait clearfix">
		<h3>投资送好礼</h3>
		<div class="icard_trait_gift clearfix">
			<img src="<%=basePath%>/active/icard/images/ikpic5.png" alt=""/>
			<p>500兆流量卡</p>
			<a href="<%=basePath%>/project.jsp">投资1000送</a>
		</div>
		<div class="icard_trait_gift clearfix">
			<img src="<%=basePath%>/active/icard/images/ikpic6.png" alt=""/>
			<p>2G兆流量卡</p>
			<a href="<%=basePath%>/project.jsp">投资3000送</a>
		</div>
		<div class="icard_trait_gift clearfix">
			<img src="<%=basePath%>/active/icard/images/ikpic7.png" alt=""/>
			<p>200元加油卡</p>
			<a href="<%=basePath%>/project.jsp">投资5000送</a>
		</div>
		<div class="icard_trait_gift clearfix">
			<img src="<%=basePath%>/active/icard/images/ikpic7.png" alt=""/>
			<p>300元加油卡</p>
			<a href="<%=basePath%>/project.jsp">投资8000送</a>
		</div>
		<div class="icard_trait_gift clearfix">
			<img src="<%=basePath%>/active/icard/images/ikpic7.png" alt=""/>
			<p>400元加油卡</p>
			<a href="<%=basePath%>/project.jsp">投资10000送</a>
		</div>
		<div class="icard_trait_rule">
			<p>投资送好礼参与流程及注意事项：</p>
			<p>1、选择任意活动，点击投资；</p>
			<p>2、首先进行简单注册，根据提示完成操作和投资流程。或者您还可以下载瑞钱宝APP或者关注瑞钱宝财富街微信号（rqbcfj），登陆后选择标的，根据提示进行操作即可；</p>
			<p>3、参与投资送加油卡的用户，请在投资完毕后，根据提示完善个人收获地址；</p>
			<p>4、本活动仅限新用户参与，同一手机号只限参加任意一项投资送好礼活动。如投资1000元、时间1个月及以上标的，可获得500M流量；</p>
			<p>5、所有投资均为非新手标及转让标；</p>
			<p>6、流量将在参与活动后7个工作日内到账（工作日是指除节假日的周一到周五。）；</p>
			<p>7、加油卡将在参与活动后7个工作日内邮寄（工作日是指除节假日的周一到周五。）；</p>
			<p></p>
		</div>
	</div>
	<!--免费兑换-->
	<div class="icard_trait clearfix mb8">
		<h3>免费兑换</h3>
		<form action="">
			<p><input class="user" type="text" value="" id="m" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" placeholder="请输入手机号"/></p>
			<p class="clearfix">
				<input class="input2" id="vcode" name="vcode" type="text" placeholder="图片验证码"/>
            	<img id="imgObj" alt="换一张" title="点击图片换一张" src="<%=localPath%>/servlet/validateCodeServlet?'+new Date().getTime()" onclick="changeVC()"/>
            </p><p class="clearfix">
				<input class="input2" id="vc" name="vc" type="text" value="" placeholder="请输入验证码"/>
				<input id="getc" class="sent" type="button" value="发送验证码"/>
			</p>
			<p class="clearfix"><input class="input2" id="icardcode" name="icardcode" type="text" value="" placeholder="请输入兑换码"/><input id="exchange" class="exchange" type="button" value="兑 换"/></p>
		</form>
		<div class="icard_trait_rule">
			<p>免费实物礼品兑换流程及注意事项：</p>
			<p>1、在输入框内进行简单注册，同时输入兑换码点击确定；</p>
			<p>2、根据提示，输入个人地址信息，方便我们进行发奖；</p>
			<p>3、有效期：兑换之日--2016.10月31日截止；</p>
			<p>4、兑换范围：全国；</p>
			<p>5、PC端和APP端同ID和同地址的用户仅能兑换一次；</p>
			<p>6、客服专线：010-52684985；服务时间工作日9:00-20:00。</p>
			<p><font color="red">＊本兑换活动最终解释权归瑞钱宝所有</font></p>
		</div>
	</div>
	<!--各种框-->
	<div class="error_prompt" id="showMess"></div>
	<div class="investment">
		<a href="<%=basePath%>/project.jsp">立 即 投 资</a>
	</div>
	<!--兑换的奖品-->
	<div class="bg30" style="display:none;">
		<div class="prize">
			<h3>恭喜您获得***</h3>
			<p>请填写收货地址，方便工作人员邮寄</p>
			<a id="hrefaddress" href="javascript:;">确 定</a>
		</div>
	</div>
</body> 
</html>
