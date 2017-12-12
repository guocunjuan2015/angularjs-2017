<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*,java.net.URLDecoder"
    pageEncoding="UTF-8"%>
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

   String localPath = "http://www.rqbao.com/";
    String basePath = "http://www.rqbao.com/rqb"; 
//    String localPath = "http://test.rqbao.com/rqt/";
//    String basePath = "http://test.rqbao.com/rqb";
      //boolean flag=false;
    //String basePath = "http://www.rqbao.com";
   // String rqtPath="http://www.rqbao.com/static_3 /active/facetoface";
   //String testPath="http://123.57.77.184/rqt/static_3/active/facetoface";
    
  
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
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>瑞钱宝</title>
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/wechat2.css">
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<link href="css/accountcenterstyle.css" rel="stylesheet" />
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/account_info.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>

</head>
<body>
   <input type="hidden" id="loginName" value="<%=user%>" />
   <input type="hidden" id="localPath" value="<%=localPath%>" />
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
	<header>
		<div class="home_title_red">
			<a class="icon-back" href="#"></a>账户信息
		</div>
	</header>
	<div class="bg-white">
		<p class="readall left_padding" onclick="vipLevel()">
			会员等级<span class="d-img pull-right"></span><span class="content_right" id="vip_rank"></span>
		</p>
		<p class="readall left_padding" onclick="deliveryAddress(<%=phone%>)">
      收货地址<span class="d-img pull-right"></span><span class="content_right">修改</span>
    </p>
		<p class="readall left_padding" id="mobile_p">
            手机号<span class="content_right" id="user_mobile"></span>
        </p>
		<p id="real_p" class="readall left_padding" onclick="toUmpRealName()">
			资金托管账户 <span class="content_right"><%=real_name%></span>
		</p>
		<p class="readall left_padding" id="ump_bind" onclick="umpBind()"
            >
            银行卡<span class="d-img pull-right"></span> <span
                class="content_right" id="ump_bind_right"></span>
        </p>
		<p class="readall left_padding" id="mf_pay_psw"
            onclick="modifyPayPassword()">
            交易密码<span class="content_right"></span><span class="d-img pull-right"></span><span class="content_right">修改</span>
        </p>
        <p class="readall left_padding" id="mf_pay_psw"
            onclick="linkTo('secret_agreement.jsp')">
            免密协议<span class="content_right"></span><span class="d-img pull-right"></span><span class="content_right" id="noSecretText"></span>
        </p>
        <p class="readall left_padding" onclick="modifyPassword()">
            登录密码<span class="content_right"></span><span class="d-img pull-right"></span><span class="content_right">修改</span>
        </p>
		<p class="readall left_padding" id="ump_open" onclick="umpRegister()"
			style="display:none">
			联动开户<span class="d-img pull-right"></span> <span
				class="content_right" id="ump_open_right"></span>
		</p>
		<p class="readall left_padding" id="reset_pay_psw"
			onclick="resetPayPsw()" style="display:none">
			重置支付密码<span class="d-img pull-right"></span>
		</p>
	</div>
	<div id="error_info" class="error_info"></div>
	<div class="container-fluid mt10" id="exit_bt_div">
		<button type="button" onclick="logout()"
			class="btn btn-lg btn-block btn-white">退出登录</button>
	</div>
</body>
</html>