<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/config/config.jsp" %>
<%@ include file="/config/global.jsp" %>

<%
    String baseUrl = "http://member.yeepay.com/member/bhawireless/";
   /*  String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/"; */
%>
<%-- <% 
HttpSession s = request.getSession();
String from = request.getParameter("from");
String user = "";
String appUser = request.getParameter("user");
if("app".equals(from) && appUser != null && !("").equals(appUser)){
    user = request.getParameter("user");
}else if(s.getAttribute("loginUser") != null){
    user = (String)s.getAttribute("loginUser");
};
 
%> --%>
<!DOCTYPE html>
<html>
<head>
<title>瑞钱宝</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/common.css">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/ump_real_register.js" type="text/javascript"></script>
<%@ include file="/config/globalHead.jsp" %>
</head>
<body>
<!-- 	<header>
	<div class="home_title_red">
		<a style="display:inline-block;width:2rem;float: left;color:#fff;" href="#" onclick="history.back(-1)"> < </a>实名认证
	</div>
	</header> -->

	<button style="display: none" id="myModal" type="button"
        class="btn btn-danger mt20 ml20" data-toggle="modal"
        data-target=".bs-example-modal-lg">提示信息</button>
    <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog"
        aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="myModalLabel">认证成功</h4>
                </div>
                <div class="modal-body">
                    <h4 class="text-success text-center" id="tip_content"></h4>
                    <!-- <p>5分钟内现金会转到您绑定的银行卡上</p> -->
                </div>
                <div class="modal-footer">
                    <div id="msg_btn_45" style="display: none">
                       <button type="button" onclick="gotoPage()"
                        id="msg_btn_0" class="btn btn-danger btn-block">下一步</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
<input type="hidden" value='<%=user%>' id="userName"/>
<div class="safe_info">请先进行实名认证，实名认证后会自动开通第三方资金托管账户（由联动支付提供），保障您的资金安全</div>
		<div class="container-fluid mp0">
			<div class="licai-box">
				<table class="table">
					<tbody>
						<tr>
							<td class="w25">姓名</td>
							<td class="text-left" style="line-height:4.6rem;"><input type="text" 
								class="authentication" id="real_name" name="real_name"
								placeholder="请输入您的姓名"></td>
						</tr>
						<tr>
							<td class="w25">身份证</td>
							<td class="text-left" style="line-height:4.6rem;"><input type="text"
								class="authentication" id="real_code"  name="real_code"
								placeholder="请输入18位身份证号"></td>
						</tr>
						<tr style="border-bottom: none;">
							<td class="w25"></td>
							<td class="text-left text-muted9">
								<div id="showMess" style="color: red;line-height: 3.6rem;"></div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div style="text-align: center;margin-top: 20px;">
        <input onclick="onBoxClicked()" type="checkbox" value=""
            checked="checked" id="agreeBox"> 我同意<span class="proxy" onclick="toProxy()">《瑞钱宝账号托管协议》</span>
    </div>
		<div class="container-fluid">
			<button type="button" class="idCardBtn"
				id="next_btn" onclick="toUMPRegister()">认证</button>
		</div>
		<div>
			<FORM action="<%=baseUrl%>toRegister" method="post" id="epayForm">
				<input type="hidden" name="req" id="req" /> <input type="hidden"
					name="sign" id="sign" />
			</FORM>
		</div>
<%@ include file="config/header.jsp" %>
</body>
</html>