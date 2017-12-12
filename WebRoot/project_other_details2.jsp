<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common2.css" rel="stylesheet" />
<link href="css/bottom_munu.css" rel="stylesheet" type="text/css" />
<link href="css/utils.css" rel="stylesheet" type="text/css" />
<link href="css/pj_details.css" rel="stylesheet" type="text/css" />
<link href="css/bottom_munu.css" rel="stylesheet" type="text/css" />
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
<title>项目介绍</title>
<link rel="stylesheet" href="css/lightbox.css" type="text/css"
	media="screen" />

<script src="js/jquery-1.6.4.min.js" type="text/javascript"></script>
<script src="js/jquery.lightbox.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".lightbox").lightbox({
			fitToScreen : true,
			imageClickClose : true
		});
		/* $(".lightbox-2").lightbox({
			fitToScreen : true,
			scaleImages : true,
			xScale : 1.3,
			yScale : 1.3,
			displayDownloadLink : false,
			imageClickClose : true
		}); */
	});
</script>
<style type="text/css">
body {
	color: #333;
	font: 13px 'Lucida Grande', Verdana, sans-serif;
	background: #fefcfc;
}

</style>
</head>
<body>
<button style="display: none" id="myModal" type="button"
        class="btn btn-danger mt20 ml20" data-toggle="modal"
        data-target=".bs-example-modal-lg">温馨提示</button>
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
                    <h4 class="text-success text-center" id="tip_content"></h4>
                    <!-- <p>投资金额：<span class="text-danger" id="money_invest_modal">1000</span>元</p> -->
                </div>
                <div class="modal-footer">
                    <button type="button" style="display: none" onclick="gotoPage(0)"
                        id="msg_btn_0" class="btn btn-primary btn-block">设置支付密码</button>
                    <button type="button" style="display: none" onclick="gotoPage(1)"
                        id="msg_btn_1" class="btn btn-primary btn-block">实名认证</button>
                    <button type="button" style="display: none" onclick="gotoPage(2)"
                        id="msg_btn_2" class="btn btn-primary btn-block">绑定银行卡</button>
                    <button type="button" style="display: none" onclick="needRecharge()"
                        id="msg_btn_3" class="btn btn-primary btn-block">充值</button>
                    <button type="button" style="display: none" onclick="gotoPage(4)"
                        id="msg_btn_4" class="btn btn-primary btn-block"
                        data-dismiss="modal">绑定银行卡(联动优势)</button>
                    <div id="msg_btn_5" style="display: none">
                    <button type="button"  onclick="gotoPage(5)"
                        class="btn btn-danger btn-block"
                        data-dismiss="modal">立即操作</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="bg"></div>
    <section class="ays" id="ays">
        <div class="ays_h5">
            <h5
                style="text-decoration: underline; background: url(images/common/ays_question.png) no-repeat 80% center; background-size: 6.5%"
                onclick="linkTo('date_project.jsp')">输入投标密码</h5>
            <img src="images/input_clear.png" onclick="dismissAys()" />
        </div>
        <div>
            <input class="form-control input-number" type="tel"
                placeholder="请输入投标密码" id="ctPsw"></input>
        </div>
        <p class="ays_content" id="yb_content">请输入投标密码！致电客服约标,约标成功后可获得投标密码</p>
        <ul class="ays_ul">
        <li><button class="btn btn-primary" style="width: 30%" onclick="linkTo('tel://4000827002')" >去约标</button></li>
        <li><button class="btn btn-danger" id="checkCP" style="width: 30%;" onclick="checkContributionAndSave()">&nbsp;确定&nbsp;</button></li></ul>
    </section>
    <section class="outter">
    <header>
    <ul class="headers">
    <li class="active">项目详情</li>
    <li>保障信息</li>
    <li>安全保障</li>
    </ul>
    </header>
    <main>
    <section class="page">
    <h5 class="dt_title">借款企业信息</h5>
    <sectinon class="projectcontent">
    <div>
        <p class="rdb-info" id="type_info_p"></p>
        <div class="contenttable">
            <table cellpadding="0" cellspacing="0" border="0">
                <thead id="head_pj_name" style="display:none">
                    <th>名称</th>
                    <th class="secondsdd" id="project_name" ></th>
                </thead>
                <tbody>
                    <tr id="fb_period" style="display:none">
                        <td>封闭期限</td>
                        <td class="secondsdd" id="project_period"></td>
                    </tr>
                    <tr id="epct_income_per_year" style="display:none">
                        <td>预期年化收益</td>
                        <td class="secondsdd" id="project_rate"></td>
                    </tr>
                    <tr id="qt_money" style="display:none">
                        <td>起投金额</td>
                        <td class="secondsdd" id="min_invest"></td>
                    </tr>
                    <tr style="display: none">
                        <td>借贷人信息</td>
                        <td class="secondsdd" id="jdr_info">
                        </td>
                    </tr>
                    <tr id="finc_use_tr" style="display: none">
                        <td>资金用途</td>
                        <td class="secondsdd" id="fin_use"></td>
                    </tr>
                    <tr id="hk_resource" style="display:none">
                        <td>还款来源</td>
                        <td class="secondsdd">
                            <p id="pay_resource"></p>
                        </td>
                    </tr>
                    <tr id="mortgageInfo_td" style="display: none">
                        <td>抵押物信息</td>
                        <td class="secondsdd">
                            <p id="mortgageInfo"></p>
                        </td>
                    </tr>
                    <tr>
                        <td>还款方式</td>
                        <td class="secondsdd" id="repay_way">按月付息到期还本</td>
                    </tr>
                    <tr class="lasttr" id="exit_way" style="display:none">
                        <td>退出方式</td>
                        <td class="secondsdd">到期退出持有1个月以上可转让</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    </sectinon>
    </section>
    <section class="page"></section>
    <section class="page"></section>
    </main>
    </section>
</body>
</html>
