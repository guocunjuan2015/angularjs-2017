<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
    content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link href="css/common2.css" rel="stylesheet" />
<link href="css/projectstyle.css" rel="stylesheet" />
<link href="css/zqzrstyle.css" rel="stylesheet" />
<link href="css/bottom_munu.css" rel="stylesheet" type="text/css" />
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/new_project_details.js" type="text/javascript"></script>
<script src="js/bootstrap.min3.0.3.js"></script>
<%@ include file="config/header.jsp"%>
<title>项目介绍</title>

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
                    <button type="button" style="display: none" onclick="gotoPage(3)"
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
        <section class="projecthead" id="project_type" style="display: none">
                <h1 id="pj_intro_h1">项目介绍</h1>
        </section>
        <section class="invest-description">
            <p id="type_info_p"> </p>
        </section>
        <section class="project">
            <div class="projectlx" style="display:none">
                <ul>
                    <li>
                        <span>预告阶段</span>
                        <span class="projectlx-secondspan" id="ygjd_time">2015-09-25</span>
                    </li>
                    <li>
                        <span>开放加入</span>
                        <span class="projectlx-secondspan" id="kfjr_time">2015-09-25</span>
                    </li>
                    <li>
                        <span>锁定期</span>
                        <span class="projectlx-secondspan" id="sdq_time">2015-09-25</span>
                    </li>
                    <li>
                        <span>到期退出</span>
                        <span class="projectlx-secondspan" id="dqtc_time">2015-09-25</span>
                    </li>
                    <li class="projectlx-lastli">
                        <span>项目结清</span>
                        <span class="projectlx-secondspan" id="xmjq_time">2015-09-25</span>
                    </li>
                </ul>
            </div>
        </section>
        <section class="projectcontent">
            <div>
                <!--<span class="firstspan">&nbsp;</span><h2>优计划项目介绍</h2><span>&nbsp;</span>-->
                <div class="contenttable" style="margin-top:5%;">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <thead>
                            <th>名称</th>
                            <th class="secondsdd" id="project_name"></th>
                        </thead>
                        <tbody>
                            <tr id="jkr_info" style="display:none">
                                <td>借款人信息</td>
                                <td class="secondsdd" id="jdr_info"></td>
                            </tr>
                            <tr id="finc_use_tr" style="display: none">
                                <td>资金用途</td>
                                <td class="secondsdd" id="fin_use"></td>
                            </tr>
                            <tr id="hk_resource" style="display:none">
                                <td>还款来源</td>
                                <td class="secondsdd" id="pay_resource">
                                </td>
                            </tr>
                            <tr id="xmbz" style="display:none">
                                <td>项目保障</td>
                                <td class="secondsdd"></td>
                            </tr>
                            <tr >
                                <td>借款人授信等级</td>
                                <td class="secondsdd">A</td>
                            </tr>
                            <tr class="lasttr">
                                <td>允许债权转让时间</td>
                                <td class="secondsdd">开始计息一个月后</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
		<div id="invest_show">
			<span class="firstspan">&nbsp;</span>
			<h2>投资演示</h2>
			<span>&nbsp;</span>
			<p
				style="clear: both; margin: 0 auto 2%; width: 94%; color: #f64840; font-size: 1.6rem;">投资收益演示表</p>
			<div class="strategy-table">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
						<th>投资<br />金额
						</th>
						<th>募集期<br />收益率
						</th>
						<th>锁定期<br />收益率
						</th>
						<th style="width: 20%;">募集期收益<br />付息时间
						</th>
						<th style="width: 23%;">锁定期收益还<br />本付息时间
						</th>
					</tr>
					<tr>
						<td>1～5万</td>
						<td>7%</td>
						<td>15%</td>
						<td>锁定日期<br />＋19个月
						</td>
						<td>锁定日期<br />＋20个月
						</td>
					</tr>
					<tr>
						<td>5～10万</td>
						<td>7%</td>
						<td>16%</td>
						<td>锁定日期<br />＋19个月
						</td>
						<td>锁定日期<br />＋20个月
						</td>
					</tr>
					<tr>
                        <td>10～20万</td>
                        <td>7%</td>
                        <td>17%</td>
                        <td>锁定日期<br />＋19个月
                        </td>
                        <td>锁定日期<br />＋20个月
                        </td>
                    </tr>
                    <tr>
                        <td>20～50万</td>
                        <td>7%</td>
                        <td>18%</td>
                        <td>锁定日期<br />＋19个月
                        </td>
                        <td>锁定日期<br />＋20个月
                        </td>
                    </tr>
                    <tr>
                        <td>50～100万</td>
                        <td>7%</td>
                        <td>19%</td>
                        <td>锁定日期<br />＋19个月
                        </td>
                        <td>锁定日期<br />＋20个月
                        </td>
                    </tr>
                    <tr>
                        <td>100万以上</td>
                        <td>7%</td>
                        <td>20%</td>
                        <td>锁定日期<br />＋19个月
                        </td>
                        <td>锁定日期<br />＋20个月
                        </td>
                    </tr>
				</table>
			</div>
			<div class="invest-demo">
				<dl>
					<dt>投资案例</dt>
					<dd>假如您在募集期投资了90天，投资金额为100万，预期收益率为7%，按天计息，在锁定期的第19个月您将收到100万元×90×7%/365=17260.27元；
						第二阶段为锁定期，从锁定期的第20个月开始，每月您将收到1/5的本金和相应的利息。见下图</dd>
				</dl>
			</div>
			<div class="strategy-table strategy-details">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
						<th>投资金额（元）</th>
						<th>100,000,000</th>
					</tr>
					<tr>
						<td>第19个月</td>
						<td>1,726,027</td>
					</tr>
					<tr>
						<td>第20个月</td>
						<td>26,666,667</td>
					</tr>
					<tr>
						<td>第21个月</td>
						<td>28,000,000</td>
					</tr>
					<tr>
						<td>合计</td>
						<td>138,392,694</td>
					</tr>
				</table>
			</div>
		</div>
		<div id="predgeList_content">
			<span class="firstspan">&nbsp;</span>
			<h2>安全保障</h2>
			<span>&nbsp;</span>
			<div class="safediv">
				<div id="bzh1" class="safediv-height" style="display: none">
					<p class="firstp">保障措施一：</p>
					<p id="first_tp"></p>
				</div>
				<div id="bzh2" class="safediv-height" style="display: none">
					<p id="bzh2_p" class="firstp">保障措施二：</p>
					<p id="seconddtp"></p>
				</div>
				<div class="safediv-height">
					<p id="bzh3_p" class="firstp" style="display: none">保障措施三：</p>
					<p>由第三方担保公司担保</p>
					<br />
					<p class="font_bold">担保机构</p>
					<p id="bzh3_jig"></p>
					<br />
					<p class="font_bold" style="display:block">担保机构简介</p>
					<p id="bzh3_jig_jj"></p>
					<br/>
					<br/>
				</div>
			</div>
		</div>
	</section>
    <div >&nbsp;</div>
    <div id="space_div"></div>
    <div id="footpanel" style="border: none;height: auto;display: none">
    <div id="error_info" class="error_info"></div>
     <section class="tzAdd">
        <div class="safe" id="baozh_div" onclick="toSafeEnsure()">
        <!-- <img class="safe" src="images/home_picc.png"/> -->
        </div>
        <div id="yue_div" style="display: none">
            可用余额： <span id="yue_span"> </span>元 <span id="to_recharge"
                onclick="toRecharge()">去充值>></span>
        </div>
        <div id="epxt_div" style="display: none">
              <span id="epxt_income" style="float: none;"> </span> 
        </div>
        <div class="Addinfo" id="add_invest" >
            <span id="input_span"> <input class="form-control input-number"
                type="tel" id="invest_number" min="0"
                onkeyup="changeInvest(this.value)" onclick="checkStatus()"
                placeholder=""  ></input></span> <button class="btnjoin"
                id="button_invest" onclick="invest()">&nbsp;</button>
        </div>
    </section>
    </div>
    </body>
</html>
