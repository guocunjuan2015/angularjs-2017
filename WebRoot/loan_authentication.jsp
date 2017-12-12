<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>认证中心</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/reset.css">
<link rel="stylesheet" type="text/css" href="css/loan.css" />
<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min3.0.3.js"></script>
<script type="text/javascript" src="js/utils.js" type="text/javascript"></script>
<%@ include file="/config/config.jsp" %>
<%@ include file="config/header.jsp"%>
<%
	String userName = (String) request.getSession().getAttribute("loginUser");
%>
<style>
.slider.slider-horizontal{
display:none;
}
</style>
</head>
<body>
<%@ include file="/config/globalHead.jsp" %>
<input type="hidden" value="<%=basePath%>"  id="basePath">
<input type="hidden" value="<%=localPath%>"  id="localPath">
<input type="hidden" value="<%=userId%>"  id="userId">
<input type="hidden" value="<%=userName%>" id="userName">
<section class="authentication">
	<h1>必填信息 <span>(基础认证完成，可提交借款申请)</span></h1>
	<ul>
		<li id="idCardLi">手持身份证认证</li>
		<li id="creditLi">芝麻信用 </li>
	</ul>
	<div class="bottomBtn">
		<input type="button" id="applyBtn" class="idCardBtn" value="立即申请">
	</div>
</section>
<div class="loanDirlog"></div>
<div class="msgTxt3"></div>
<!-- 金额提示 -->
<div class="promptMoney">
	<p class="loanMoneyP">借款金额：<span></span>元</p>
	<p class="actualArrival">实际到帐：<span></span>元</p>
	<p class="due">到期应还：<span></span>元</p>
	<p class="p3"><a class="fl closeMsg4" href="javascript:;">再看一下</a><a class="fr" href="javascript:;" onclick="fixedLoan()">确定借款</a></p>
</div>
<div class="success">
	<img src="<%=basePath%>/images/loan13.png">
	<p class="sucP">借款申请已提交，请耐心等待审核！</p>
	<p class="p3"><a class="fl closeMsg2" href="javascript:;">关闭</a><a class="fr" href="javascript:;" onclick="seeMyLoan()">查看我的申请</a></p>
</div>
<div class="fail">
	<img src="<%=basePath%>/images/loan14.png">
	<p class="failP">对不起，您的借款申请提交失败！</p>
	<p class="p2"><a class="closeMsg3" href="javascript:;">关闭</a></p>
</div>
</body>
<script type="text/javascript" src="js/loan_authentication.js"></script>
<script>
var idCard = false;
var credit = false;
$.ajax({
	type : "POST",
	url : "<%=basePath%>/user/credit/userAuthenInfo.do",
	data : { },
	success : function(response) {
		if (response.success) {
			var info = $.parseJSON(response.result);
			if(info.result == 1){
				var data = info.resultObject;
				if(data == undefined || data == ""){
					idCard = false;
					var table = $("#idCardLi");
					var row = '<span class="fr clickImg"></span>';
					row += '<span class="fr" id="ump_open_right">未认证</span>';
					table.append(row);
					credit = false;
					var table2 = $("#creditLi");
					var row2 = '<span class="fr clickImg"></span>';
					row2 += '<span class="fr" id="ump_open_span">未认证</span>';
					table2.append(row2);
				}else{
					if(data.status != '01' && data.status != '02' ){
						window.location.href = 'personalInfo.jsp';
					}else{
						var id_card_no_img = data.idCardNoImg;
						var zhima_score = data.zhimaScore;
						//判断身份证是否认证
						if (id_card_no_img != undefined && id_card_no_img != "") {
							idCard = true;
							var table = $("#idCardLi");
							var row = '<span class="fr mr14" id="ump_open_right">已认证</span>';
							table.append(row);
						} else {
							idCard = false;
							var table = $("#idCardLi");
							var row = '<span class="fr clickImg"></span>';
							row += '<span class="fr" id="ump_open_right">未认证</span>';
							table.append(row);
						}
						if (zhima_score != undefined && zhima_score != "") {
							credit = true;
							var table = $("#creditLi");
							var row = '<span class="fr mr14" id="ump_open_span">已认证</span>';
							table.append(row);
						} else {
							credit = false;
							var table = $("#creditLi");
							var row = '<span class="fr clickImg"></span>';
							row += '<span class="fr" id="ump_open_span">未认证</span>';
							table.append(row);
						}
					}
				}
			}else{
				idCard = false;
				var table = $("#idCardLi");
				var row = '<span class="fr clickImg"></span>';
				row += '<span class="fr" id="ump_open_right">未认证</span>';
				table.append(row);
				credit = false;
				var table2 = $("#creditLi");
				var row2 = '<span class="fr clickImg"></span>';
				row2 += '<span class="fr" id="ump_open_span">未认证</span>';
				table2.append(row2);
				
			}
		} else {
			var info = $.parseJSON(response.result);
			$(".loanDirlog").show();
			$(".msgTxt3").show();
			$(".msgTxt3").html(info.errInfo);
		}
	},
	error : function (){
		
	}
});
</script>
</html>