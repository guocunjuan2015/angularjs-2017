<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/common2.css" rel="stylesheet"/>
    <link href="css/inverstdetails.css" rel="stylesheet"/>
    <link href="css/switchery.min.css" rel="stylesheet"/>
    <link href="css/common.css" rel="stylesheet" />
 
    <title>自动投标规则设置</title>
    <style type="text/css">
        .btn-look-invert{margin:5% auto;width:88%;border:0;color:#fff !important;font-size:1.8rem;text-align:center;}
        .invert-info span input[type="text"]{border:0;width:80px;font-size:1.6rem;color:#999;}
        .invert-info li span:nth-child(2){color:#999;}
    </style>
</head>
<body onload="main()">
<section>
        <h1 class="home_title red_bg">
        <span class="go-back"
                onclick="replaceTo('auto_invest.jsp')"></span>
            规则设置<span class="sp_titile_left" onclick="showBg()">说明</span>
        </h1>
    </section>
<section class="invert-info" style="margin-top:0;">
    <ul>
        <li>
            <span>规则设置</span>
            <span><input type="checkbox" class="js-switch" checked  id="checks"/></span>
        </li>
        <li>
            <span>账户可用余额</span>
            <span id="account_balance"></span>
        </li>
        <li>
            <span>账户保留金额</span>
            <span>￥<input type="text" placeholder="请输入金额" id="remain_money" onkeyup="saveRemain()" /></span>
        </li>
        <li onclick="investWay()">
            <span>投标方式</span>
            <i class="rightarrow"> </i>
            <span id="auto_invest_way"></span>
           
        </li>
        <li id="min_li" style="display:none">
            <span>单笔最低投标额</span>
            <span>￥<input type="text" placeholder="请输入金额" id="min_money" onkeyup="saveMinInvest()" /></span>
        </li>
        <li id="max_li" style="display:none">
            <span>单笔最高投资额</span>
            <span>￥<input type="text" placeholder="请输入金额" id="max_money" onkeyup="saveMaxInvest()" /></span>
        </li>
        <li onclick="toSetType()">
            <span>投标种类</span>
            <i class="rightarrow"> </i>
            <span id="auto_invest_type"></span>
        </li>
        <li onclick="toSetRepayWay()">
            <span>还款方式</span>
            <span><i class="rightarrow"></i></span>
            <span id="repayment_way"></span>
        </li>
        <li onclick="toSetAutoPeriod()">
            <span>借款期限</span>
            <i class="rightarrow"> </i>
            <span id="auto_invest_period"></span>
        </li>
        <li onclick="toSetAutoRate()">
            <span>预期年化收益</span>
            <i class="rightarrow"> </i>
            <span id="auto_rate"></span>
        </li>
    </ul>
    <div id="error_info" class="error_info"></div>
    <button class="btn btn-danger btn-lg btn-block btn-look-invert" id="save_set" 
    onclick="saveSet()">保存设置</button>
    <button class="btn btn-lg btn-block btn-look-invert btn-bg-grey" onclick="deleteRule()">删除</button>
    <div id="bg" onclick="showBg()"></div>
    <div id="illus" class="illus">
        <p>1、单笔最低投标额：限制每次投标的实际投标额不得低于某个数值，一旦系统判断本次投标额低于该数值时，将自动放弃本次投标机会并保持排名继续前进。该数值默认值为0。</p>
        <p>2、账户保留金额：每次投标后账户必须保留的最低可用余额。如果系统判断本次投标结束后账户可用余额将低于该数值，则本次投标金额将修正为最大投标金额减去账户保留金额，且不能低于该借款标限制的最低投标额。该数值默认值为0。</p>
        <p>3、当前规则满足所有条件时，系统将为您自动投标的金额只能为大于0的整数。</p>
        <p>4、系统最终判定的实际投标金额如果超过借款标的最大投标额度则以该额度为准进行投标，如果小于标的最小投标额度则放弃此次投标机会，排名继续前进。</p>
    </div>
    <!-- 投标方式 -->
    <input type="hidden" id="auto_invest_way_value" value="">
    <!-- 投标种类 -->
    <input type="hidden" id="auto_invest_type_value" value="">
     <!-- 还款方式 -->
    <input type="hidden" id="repayment_way_value" value="">
    <!-- 借款期限 -->
    <input type="hidden" id="auto_period_value" value="">
    <!-- 预期年化收益 -->
    <input type="hidden" id="auto_rate_choosed" value="">
    <input type="hidden" id="auto_rate_from" value="">
    <input type="hidden" id="auto_rate_to" value="">
</section>
<script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="js/switchery.min.js"></script>
<script type="text/javascript" src="js/auto_invest_modify.js"></script>
<script type="text/javascript" src="js/utils.js"></script>
<script type="text/javascript">

    // Default
    // if-else statement used only for fixing <IE9 issues
    /* if (Array.prototype.forEach) {

        var elems = Array.prototype.slice.call(document.querySelectorAll('#checks'));

        elems.forEach(function(html) {
            var switchery = new Switchery(html);
        });
    } else {
        var elems = document.querySelectorAll('#checks');

        for (var i = 0; i < elems.length; i++) {
            var switchery = new Switchery(elems[i]);
        }
    } */
   /*  function setSwitchery(switchElement, checkedBool) {
        if((checkedBool && !switchElement.isChecked()) || (!checkedBool && switchElement.isChecked())) {
            switchElement.setPosition(true);
            switchElement.handleOnchange(true);
        }
    } */

</script>
</body>
</html>