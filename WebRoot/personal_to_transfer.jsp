<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/common2.css" rel="stylesheet"/>
    <link href="css/main.css" rel="stylesheet"/>
    <link href="css/more.css" rel="stylesheet"/>
    <link href="css/touzistyle.css" rel="stylesheet">
    <link href="css/inverstdetails.css" rel="stylesheet"/>
    <script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/personal_to_transfer.js"></script>
    <script type="text/javascript" src="js/utils.js"></script>
    <%@ include file="config/header.jsp" %>
    <title>转让记录</title>
</head>
<body>
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
                    <h4 class="modal-title" id="myModalLabel">温馨提示</h4>
                </div>
                <div class="modal-body">
                    <h4 class="text-success text-center" id="return_message"></h4>
                </div>
                <div class="modal-footer">
                    <button type="button" style="display: none" data-dismiss="modal"
                        id="msg_btn_0" class="btn btn-primary btn-block">返回</button>
                </div>
            </div>
        </div>
    </div>
    <section>
        <h1 class="home_title red_bg">
            转让<span class="sp_titile_left" onclick="toTransferIllus()">转让说明</span>
        </h1>
    </section>
<section class="touzi-details" style="width:100%;padding:2%;margin-top:2%;background:transparent;">
    <div class="touzi-title">
        <div class="purple-icon" id="pj_type"></div><div class="orange-icon">A</div>
        <span class="touzi-title-one" id="pj_title"></span>
    </div>
</section>
<ul>
    <li class="sz-details sz-font">
        <span class="span1">投资金额</span>
        <span class="span2" id="pj_account"></span>
    </li>
    <li class="sz-details  sz-span1-font2">
        <span class="span1">预期年化收益</span>
        <span class="span2" id="pj_rate"></span>
    </li>
    <li class="sz-details  sz-span1-font2">
        <span class="span1">期限</span>
        <span class="span2" id="pj_period"></span>
    </li>
    <li class="sz-details  sz-span1-font2">
        <span class="span1">到期日期</span>
        <span class="span2" id="pj_endDate"></span>
    </li>
    <li class="sz-details  sz-span1-font2">
        <span class="span1">已获得收益</span>
        <span class="span2" id="pj_income"></span>
    </li>
    <li class="sz-details  sz-span1-font2" style="margin-top: 12px;">
        <span class="span1">转让金额</span>
        <input class="input1" style="width: 70%;" type="tel" 
        onkeyup="changeTransfer(this.value)" id="money" placeholder="输入转让本金金额"/>
        <span class="span2">元</span>
    </li>
    <li class="sz-details  sz-span1-font2">
        <span class="span1">折让金&nbsp;&nbsp;&nbsp;</span>
        <input class="input1" style="width: 70%;" type="tel" id="discount" placeholder="设置折让金金额，可不填"/>
        <span class="span2" id="pj_amount">元</span>
    </li>
    <li class="sz-details  sz-span1-font2">
        <span class="span1">转让说明</span>
        <input class="input1" style="width: 80%;height: 200%;" type="tel" id="illus" placeholder="设置转让说明有利于快速转出，可不填"/>
    </li>
</ul>
<p class="sz-font" style="text-align:right;padding:4% 2% 1%;">手续费：<strong style="color:#f64840;font-weight:normal;" id="pj_tips"></strong> 元</p>
<!-- <p style="text-align:right;font-size: 13px;color:#b3b3b3;padding-right:2%;">每月三次转让机会</p> -->
<p class="sz-font" style="text-align:right;padding:1% 2% 1%;">转出金额：<strong style="color:#f64840;font-weight:normal;" id="pj_money"></strong>  元</p>
	<div class="container-fluid" style="margin-top: 20px" id="mk_sure">
		<button type="button" onclick="realTransfer()"
			class="btn btn-lg btn-danger btn-block ">确定转让</button>
	</div>
	<div id="error_info" class="error_info"></div>
</body>
</html>