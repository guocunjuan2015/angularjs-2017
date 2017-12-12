<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
    content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common2.css" rel="stylesheet" />
<link href="css/login.css" rel="stylesheet" />
<link href="css/coupons_market.css" rel="stylesheet" />
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/coupon_exchange.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
<title>兑换优惠券</title>
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
                    <h4 class="modal-title" id="myModalLabel">提示信息</h4>
                </div>
                <div class="modal-body">
                    <h4 class="text-success text-center" id="tip_content"></h4>
                </div>
                <div class="modal-footer">
                    <button type="button" style="display: none"
                          data-dismiss="modal" id="msg_btn_0"
                        class="btn btn-primary btn-block">返回</button>
                </div>
            </div>
        </div>
    </div>
    <section class="ays" id="ays">
    <div class="ays_h5"><h5 >确认兑换</h5>
    <img src="images/input_clear.png" onclick="dismissAys()"/></div>
    <div>您的积分共计<span id="points_total"></span>，确认使用积分<span id="points_need"></span>兑换本商品吗？</div>
    <button type="button" class="btn btn-in" id="sure_btn" onclick="couponExchange()">确认</button>
    </section>
    <section class="rulehead">
        <h1 >兑换优惠券</h1>
    </section>
    <img id="banner_img"   width="100%" />
    <section style="margin-top: 4%">
        <div class="login" style="display: none">
            <span>兑换数量</span><input type="text" placeholder="请输入兑换数量" />
        </div>
        <div class="login" style="display: none">
            <span>所需积分</span><input type="text" placeholder="（可用积分21201）" />
        </div>
        <div style="margin:20px 20px">
            <button type="button" class="btn btn-primary btn-block mt10 mb20"
                id="exchange_btn" onclick="areYouSure()">兑换</button>
        </div>
        <div id="error_info" class="error_info"></div>
        <!--积分不足按钮样式为btn-grey，可直接替换样式btn-red,如下
    <input type="submit" class="button btn-grey btn-next" value="兑换"/>
    -->
    </section>
    <section class="spend_need">
    <div id="price">价格：¥500.00</div>
    <div id="points">积分：20000</div>
    </section>
    <section class="coupons-info" style="display:none">
        <dl>
            <dt>使用地区</dt>
            <dd id="use_area"></dd>
        </dl>
        <dl>
            <dt>商品介绍</dt>
            <dd id="goods_intro"></dd>
        </dl>
        <dl>
            <dt>使用方式</dt>
            <dd id="use_way">
            </dd>
        </dl>
    </section>
</body>
</html>