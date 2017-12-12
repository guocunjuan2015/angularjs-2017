<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/config/config.jsp" %>
<%@ include file="/config/global.jsp" %>
<!doctype html>
<html lang="en">
<head>
	<script>
		//分享信息定义
		var title   = '';
		var content = '';
		var url     = '';
		var icon    = '';
	</script>
	<meta charset="UTF-8">
	<title>投资成功</title>
	<meta name="keywords" content="">
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/success.css">
	<link href="css/rqbao_index.css" rel="stylesheet"/>
	<script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/json2.js"></script>
	<%
		String f = request.getParameter("f");
		String orderId = request.getParameter("orderId");
		String opt = request.getParameter("opt");
		String userApp = request.getParameter("user");
	%>
	<script type="text/javascript">
		/*标题 */
		function showShare(){
		    IOSModel.showShareBtn();
		}
		/*分享好友*/
		$(function(){ 
		    title = "瑞钱宝新手注册";
		    content = "瑞钱宝—大型国企参股，多种优质项目，让您轻松理财！";
		    icon = "<%=basePath %>/images/app/488.png";
		    url  = '<%=basePath %>/active/noviceGuide/noviceGuide.jsp';
		});
		$(function() {
		apxDataHub.push({"event": "invest"});/*投资成功  */
			$.ajax({
				url : "<%=localPath%>/appInvest/getInvestById",
				type : "post",
				dataType : "json",
				data : {orderId : "<%=orderId%>"},
				async : false,
				success : function (data) {
					if (data.success) {
						if ("<%=f%>" == 1) {
							var isLottery = "0"
							if (data.isLottery) {
								isLottery = "1";
							}
							window.location.href="<%=basePath%>/active/360active/360wxdirlog.jsp?user=<%=userApp%>&isLottery=" + isLottery + "&orderId=<%=orderId%>";
						}
					}
					$(".projectName").html(data.projectName);
					$(".amount").html(data.investAmount);
					$(".projectPeriod").html(data.loanPeriod);
				},
				error : function (data) {
					alert("服务器错误");
				}
			});
		})
		
		/*分享 */
		function shareClick() {
		     if (isAndroidOrIos()) {
		    	 IOSModel.investFinishToShare({
	                  "url" : url,
	                  "title" : title,
	                  "content" : content,
	                  "icon" : icon
	              });
	              appFunction('investFinishToShare');
	          }
		}
		
		function toProject() {
			if (isAndroidOrIos()) {
				IOSModel.investFinishToUserCenter();
				//toIosInvest();
				appFunction('investFinishToUserCenter');
			} else {
				//toIosInvest();
				window.location.href = "personal_center.jsp";
			}
		}
	</script>
</head>
<body>
<script type="text/javascript">
(function(w,d,h){w[h]=w[h]||[];var f=d.getElementsByTagName('script')[0],j=d.createElement('script');j.async=true;j.src='//tms.chinapex.com.cn/container_files/container_b57jxh5.js';f.parentNode.insertBefore(j,f);})(window,document,'apxDataHub');
</script>
	<div class="wxBox" style="background:#fff;">
	  <div style="border-bottom:6px solid #F5F4F4;">
		   <img class="successimg" src="images/pic1.jpg" alt=""/>
		    <h3 class="successh3">成功投资</h3>
		</div>
		<div class="successdiv">
			<p>投资项目<span class="projectName"></span></p>
			<p>投资金额<span class="amount"></span></p>
			<p>投资期限<span class="projectPeriod"></span></p>
			<!-- <p><a id ="shareMessage" class="successShare" href="javascript:shareClick();">分享得积分</a></p> -->
			<p style="text-align:center;border-bottom:none;"><a class="successCheck" href="javascript:toProject();">查看我的帐户</a></p>
		</div>
	</div> 
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
</html>