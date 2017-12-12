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
<script src="js/transfer_project_details.js" type="text/javascript"></script>
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
         <div  style="text-align: center;font-size: 1.6rem;color:#f64840;margin-top:12px">
                  转让介绍  </div>
        <section class="project">
            <div class="projectlx" style="display:none">
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
                            <tr id="zrr_tr" style="display:none">
                                <td>转让人</td>
                                <td class="secondsdd" id="zrr"></td>
                            </tr>
                             <tr id="zr_ills_tr" style="display:none">
                                <td>转让说明</td>
                                <td class="secondsdd" id="zr_ills"></td>
                            </tr>
                            <tr id="qs" style="display:none">
                                <td>期数</td>
                                <td class="secondsdd" id="qs_val"></td>
                            </tr>
                            <tr id="ysbx" style="display:none">
                                <td>应收本息</td>
                                <td class="secondsdd" id="ysbx_val"></td>
                            </tr>
                            <tr id="yybj" style="display:none">
                                <td>应收本金</td>
                                <td class="secondsdd" id="yybj_val"></td>
                            </tr>
                            <tr  class="lasttr" id="yybx" style="display:none">
                                <td>应收利息</td>
                                <td class="secondsdd" id="yybx_val"></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div id="invest_show">
                
            </div>
        <div id="predgeList_content">
         <div>
                <span class="firstspan">&nbsp;</span><h2>还款情况</h2><span>&nbsp;</span>
                <div class="transfer-table" style="background: #fef3ec">
                    <table cellpadding="0" cellspacing="0" border="0" id="table">
                       <!--  <tr>
                            <th>期次</th>
                            <th>收款日</th>
                            <th>还款情况</th>
                             
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>2015-07-17</td>
                            <td>已还</td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>2015-07-17</td>
                            <td>已还</td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>2015-07-17</td>
                            <td>已还</td>
                        </tr> -->
                    </table>
                </div>
            </div>
    </div>
    </sectinon></section>
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
            预期收益： <span id="epxt_income" style="float: none;"> </span>元
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
