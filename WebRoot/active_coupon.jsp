<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>瑞钱宝</title>
<meta name="viewport"
    content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/wechat2.css">
<link rel="stylesheet" type="text/css" href="css/common.css">
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/active_coupon.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
</head>
<body>

<button style="display:none" id="myModal" type="button" class="btn btn-danger mt20 ml20" data-toggle="modal" data-target=".bs-example-modal-lg">提示信息</button>
    <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">提示信息</h4>
                </div>
                <div class="modal-body">
                    <h4 class="text-success text-center" id="tip_content"></h4>
                </div>
                <div class="modal-footer">
                    <button type="button" style="display:none"  id="msg_btn_0" class="btn btn-danger btn-block">返回</button>
                </div>
            </div>
        </div>
    </div>
	<header>
		<div class="home_title_red">
			<a class="icon-back" id="homeTitle" style="color: #fff"></a>
		</div>
	</header>
	
	<div class="change_body_div">
		<div>
			<span class="change_rqb_sp1">号码</span><span class="change_rqb_sp0"><input
				type="text" min=0 placeholder="输入号码" id="number" onkeyup="changeCount()"/></span>
		</div>
		<div>
			<span class="change_rqb_sp1">激活码</span><span class="change_rqb_sp2"><input
                type="text" min=0 placeholder="输入激活码" id="act_number" onkeyup="changeCount()"/></span>
		</div>
	</div>
	       <p id="change_btn"> <button type="button" class="btn btn-lg btn-danger btn-block mt20 mb20"
                id="exchange_btn" onclick="activeCoupon()">确认</button>
                </p>

	<div id="error_info" class="error_info"></div>
</body>
</html>