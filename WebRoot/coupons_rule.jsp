<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/main.css" rel="stylesheet" />
<link href="css/common2.css" rel="stylesheet" />
<link href="css/common.css" rel="stylesheet" />
<link href="css/couponstyle.css" rel="stylesheet" />
<link href="css/bottom_munu.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script   type="text/javascript">
 var type = getRequestParam("couponType");
 var from = getRequestParam("from");
 /*标题 */
 function showShare(){
	 if("ticket" == type){
	     IOSModel.changeWebTitle("加息券使用规则");
		 }else if("redEvp" == type){
			 IOSModel.changeWebTitle("红包使用规则");
		 }
   }
 $(function(){
	 if("ticket" == type){
		 $("#rule_title")[0].innerHTML = "加息券使用规则";
	     $("#ticket_illus")[0].style.display = "block";
	 }else if("redEvp" == type){
		 $("#rule_title")[0].innerHTML = "红包使用规则";
         $("#redEvp_illus")[0].style.display = "block";
	 }else if("goods" == type){
		 $("#rule_title")[0].innerHTML = "实物奖品使用规则";
         $("#goods_illus")[0].style.display = "block";
	 }else if("withdraw" == type){
     $("#rule_title")[0].innerHTML = "提现券使用规则 ";
         $("#withdraw_cash")[0].style.display = "block";
   }
	 if("app" == from){
		 $(".illus").css("top","0px");
	 }else{
		 $("#rule_title")[0].style.display = "block";
	 }
 });

</script>
<%@ include file="config/header.jsp" %>
</head>
<body>
<section>
        <h1 class="home_title red_bg" id="rule_title" style="display:none">           
        </h1>
</section>
	 <div id="ticket_illus" class="illus">
        <p>1. 使用加息券所获得的收益，统一在所投项目还本时发放；</p>
        <p>2. 加息券不能和红包等其它优惠劵同时使用</p>
        <p>3. 注册时获得的红包时是投资成功计息后直接发还到可提取帐户中；</p>
        <p>4. 实名、绑卡、首次投资获得的红包，红包面额的50%是在计息后先返还到可提取帐户中，剩余50%是在投资期满后随本金及最后一期收益一并返还到可提取帐户中；</p>
        <p>5. 获得的红包和加息券截至有效期后将无法使用；</p>
        <p>6. 如有任何问题请拨打客服电话400-9198-555；</p>
        <p>7. 最终解释权法律范围内归瑞钱宝资产管理服务有限公司所有。</p>
    </div>
    <div id="coupon_illus" class="illus">
        <p>a)   瑞钱币根据使用范围，在有效期内投资使用，每投资100元可使用1个瑞钱币，投资成功后瑞钱币以现金返回到用户账户中。</p>
        <p>b)   单次投资使用瑞钱币个数不限制。</p>
        <p>c)   若使用了瑞钱币的项目在投资期间发生流标，则瑞钱币还给用户。</p>
        <p>d)   使用瑞钱币的项目不支持债权转让。</p>
    </div> 
    <div id="redEvp_illus" class="illus">
        <p>1. 获得的红包和加息券截至有效期后，将无法使用；</p>
        <p>2. 平台红包分为理财红包和现金红包。理财红包在购买相应标的满标放款（次日）后，会返还到“帐户中心－可用余额” 中；现金红包直接返还到“帐户中心－可用余额”中（某些现金红包需要累积到100元后，才能提现）;</p>
        <p>3. 平台理财红包不适用于新手标和债权转让；</p>
        <p>4. 使用加息券所获得的收益，在所投项目还本时统一发放；</p>
        <p>5. 使用红包之后，不可进行债权转让，加息券可以进行债券转让，转让后，加息券利息作废；</p>
        <p>6. 加息券不能和红包等其他优惠券同时使用；</p>
        <p>7. 如有任何问题，请拨打客服电话：400-9198-555</p>
        <p>8. 最终解释权法律范围内归瑞钱宝资产管理服务有限公司所有</p>
    </div>
    <div id="goods_illus" class="illus">
        <p>1. 用户抽到实物奖品，需填写收货地址等详细信息；</p>
        <p>2. 实物奖品，寄送时间以每次活动说明为准；</p>
        <p>3. 瑞钱宝客服团队发放实物奖品前，将会通过电话进行确认，请保持手机畅通；</p>
        <p>4. 奖品“京东卡”以短信的形式告知用户卡号及密码；</p>
        <p>5. 实物奖品（除不可折现的奖品）八折折现，折现现金将在7个工作日内到达用户瑞钱宝账户。</p>
    </div>
    
    <div id="withdraw_cash" class="illus">
      <p>1、提现券请在有效期内使用，截至有效期后，将无法使用；</p>
     <p>2、每笔提现仅可使用一张提现券，不可叠加使用；</p>
     <p>3、提现券直接抵扣提现费用，不设找零；</p>
     <p>如有任何问题，请拨打客服电话：400-919-8555 法律范围内解释权归瑞钱宝资产管理服务有限公司所有</p>
    </div>
    
</body>
</html>