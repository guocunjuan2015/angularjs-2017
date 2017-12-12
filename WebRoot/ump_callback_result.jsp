<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% 
HttpSession s = request.getSession();
String user = "";
 if(s.getAttribute("loginUser") != null){
    user = (String)s.getAttribute("loginUser");
};
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>瑞钱宝</title>
<meta name="viewport" content="width=device-width,initial-scale=1" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/common.css">
<link rel="stylesheet" type="text/css" href="css/yeepay.css">
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/frame/ios_js.js" type="text/javascript"></script>
<script src="js/ump_callback_result.js" type="text/javascript"></script>
<script type="text/javascript">
 
</script>
</head>
<body id="vip_apply_body" 
	style="background: #fff;">
	<header>
		<div class="home_title red_bg" id="callback_title">
			<a class="icon-back" href="#"></a>
		</div>
	</header>
	<div class="container" id="ep_cash_div1">
        <div class="align-center" id="ep_reg_suc_div">
            <img src="images/op_success.png" />
        </div>
        <div class="align-center" id="ep_reg_suc_txt_div">
            <span id="ep_reg_suc_text"> </span>
        </div>
        <div class="align-center" id="ep_reg_suc_bt">
            <table class="full-width">
                <tr>
                    <td class="half-width">
                        <button type="button" class="btn btn-danger" id="ep_suc_bt_to_m"
                            onclick="toMain()"> &nbsp;&nbsp; 马上赚钱
                            &nbsp;&nbsp; </button>
                    </td>
                    <td class="half-width">
                        <button type="button" class="btn btn-primary" id="ep_suc_bt_to_p"
                            onclick="toPCenter()"> &nbsp;&nbsp; 个人中心
                            &nbsp;&nbsp; </button>
                    </td>
                </tr>
            </table>
        </div>
    </div>
	<div id="error_info" class="error_info"></div>
	<input type="hidden" value='<%=user %>' id="userName" />
</body>
<script type="text/javascript" src="js/frame/rqbaoappshare.js"></script>
</html>