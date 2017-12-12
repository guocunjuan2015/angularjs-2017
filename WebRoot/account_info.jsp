<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="UTF-8"%>
<%@ include file="/config/config.jsp" %>
<%
    String real_name = request.getParameter("real_name");
    if (real_name == null) {
        real_name = "";
    }
    System.out.print("*********" + real_name);
    HttpSession hs = request.getSession();
    String user = "";//用户名
    String userId = "";//用户userId
    String userHex = "";//hex编码的用户名，分享出去用到，app转进来需要解码
	
    String from = request.getParameter("from");
    if (from == null || !("app".equals(from))) {
        from = "";
    }
    System.out.println("aft:" + from);
    String referHex = request.getParameter("referrer");//获得的推荐人是Hex编码
    String refer = "";
    if (referHex == null) {
        refer = "";
    } else {
        //refer需要Hex解码
        if (referHex != null) {
            byte[] bs = Hex.decodeHex(referHex.toCharArray());
            refer = new String(bs);
        }
    }
    String userApp = request.getParameter("user");
	String phone = request.getParameter("user_mobile");
    if (from != null && "app".equals(from) && userApp != null) {
        user = userApp;
        hs.setAttribute("loginUser", user);
        //app上无分享功能
    } else if (hs != null) {
        user = (String) hs.getAttribute("loginUser");
        if (user == null) {
            user = "";
        }
        if (user != null && user != "") {
            userHex = Hex.encodeHexString(user.getBytes());//将用户Hex编码，用于分享
        } else {
            userHex = "";
        }
    }
    String userAppId = request.getParameter("userId");
    if (from != null && "app".equals(from) && userId != null
            && userId != "") {
        userId = userAppId;
        hs.setAttribute("userId", userId);
        //app上无分享功能
    } else if (hs != null) {
        userId = (String) hs.getAttribute("userId");
        if (userId == null) {
            userId = "";
        }
    }
    System.out.println("aft:" + from);
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>账户中心 | 头像</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<script src="js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/angular.min.js"></script>
<script type="text/javascript" src="js/angular-route.min.js" ></script>
<script type="text/javascript" src="js/bootstrap.min3.0.3.js"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/account_info_new.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/reset.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<%@ include file="config/header.jsp" %>
</head>
<body>
   	<input type="hidden" id="loginName" value="<%=user%>" />
   	<input type="hidden" id="localPath" value="<%=localPath%>" />
   	<%--提示信息 --%>
	<button style="display: none" id="myModal" type="button" class="btn btn-danger mt20 ml20"
 	data-toggle="modal" data-target=".bs-example-modal-lg">提示信息</button>
	<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
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
					<h4 class="text-success text-center" id="return_message"></h4>
				</div>
				<div class="modal-footer">
					<button type="button" style="display: none" id="msg_btn_0"
						class="btn btn-primary btn-block" data-dismiss="modal">确定</button>
					<button type="button" style="display: none" onclick="toUmpBind()"
						id="msg_btn_1" class="btn btn-primary btn-block"
						data-dismiss="modal">绑定银行卡(联动优势)</button>
					<div id="check_epay_result" style="display: none">
						<button type="button" onclick="toUmpRegister()"
							class="btn btn-danger btn-block" data-dismiss="modal">立即操作</button>
					</div>
					<div id="modefy_psw" style="display: none">
						<button type="button" class="btn btn-primary btn-block"
							data-dismiss="modal">确定</button>
					</div>
					<div id="reset_psw" style="display: none">
						<table class="bs_dialog_table">
							<tr>
								<td align="center" valign="middle" width="50%">
									<button type="button" data-dismiss="modal"
										id="bt_cancel_to_epay" class="btn btn-danger ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;取消&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</button>
								</td>
								<td align="center" valign="middle" width="50%"><button
										type="button" data-dismiss="modal" onclick="doReset()"
										id="bt_to_epay" class="btn btn-danger ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;确定&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</button></td>
							</tr>
						</table>
					</div>
				</div>

			</div>
		</div>
	</div>
	<%--头像 --%>
	<div class="accountInfo">
		<ul>
			<li class="mb1">
				帐户名
				<span class="fr mr14" id="user_mobile"></span>
			</li>
			<li onclick="vipLevel()">
				会员等级
				<span class="fr clickImg"></span>
				<span class="fr" id="vip_rank"></span>
			</li>
			<li id="real_li" onclick="toUmpRealName()">
				实名认证
				<span class="fr clickImg"></span>
				<span class="fr" id="ump_open_right"></span>
			</li>
			<li id="ump_bind" onclick="umpBind()">
				银行卡
				<span class="fr clickImg"></span>
				<span class="fr" id="ump_bind_right"></span>
			</li>
			<li onclick="modifyPassword()">
				登录密码
				<span class="fr clickImg"></span>
				<span class="fr">修改</span>
			</li>
		</ul>
	</div>
	<div id="error_info" class="error_info"></div>
</body>
</html> 