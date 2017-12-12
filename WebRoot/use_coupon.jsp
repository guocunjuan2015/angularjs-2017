<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>瑞钱宝</title>
<meta name="viewport"
    content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/project.css">
<link rel="stylesheet" type="text/css" href="css/reward1.css">
<link rel="stylesheet" type="text/css" href="css/reward2.css">
<link href="css/couponstyle.css" rel="stylesheet" />
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/use_coupon.js?t=114" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
</head>
<body style="background: #fff;">
	<header>
		<div class="home_title red_bg">
			<a class="icon-back" href="#"></a>瑞钱币<span class="sp_titile_right smaller-font"
				id="sp_save_use" onclick="saveExit()">取消使用</span>
		</div>
	</header>
	<button style="display:none" id="myModal" type="button" class="btn btn-danger mt20 ml20" data-toggle="modal" data-target=".bs-example-modal-lg">提示信息</button>
	<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">提示信息</h4>
				</div>
				<div class="modal-body">
					<h4 class="text-success text-center" id="msg_content"></h4>
				</div>
				<div class="modal-footer">
					<div id="use_alert" style="display: none">
                        <table style="width:100%">
                            <tr>
                                <td align="center" valign="middle" width="50%">
                                    <button type="button" data-dismiss="modal" onclick="resetCouponData()"
                                        id="bt_cancel_use" class="btn btn-danger ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;重新选择&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    </button>
                                </td>
                                <td align="center" valign="middle" width="50%"><button
                                        type="button" data-dismiss="modal" onclick="forceUse()"
                                        id="bt_to_use" class="btn btn-danger ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;确定使用&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    </button></td>
                            </tr>
                        </table>
                    </div>
				</div>
			</div>
		</div>
	</div>
		<div  id="coupon_table"></div>
	<div>
		<FORM action="project_invest.jsp" method="post" id="choose_cop_form">
			<input type="hidden" name="copType" id="copType" /> <input
				type="hidden" name="passValue" id="passValue" /> <input
				type="hidden" name="copId" id="copId" /> <input type="hidden"
				name="periodBack" id="periodBack" /> <input type="hidden"
				name="projectIdBack" id="projectIdBack" /> <input type="hidden"
				name="rateBack" id="rateBack" />
		</FORM>
	</div>
	<div id="div_no_cop_record"></div>
	<div id="show_choose_div">已选择 <span id="sp_cop_count">0</span> 元 <span id="sp_cop_type"></span>,共 <span id="sp_cop_value">0.00</span> 元</div>
	<div id="error_info" class="error_info"></div>
</body>
</html>