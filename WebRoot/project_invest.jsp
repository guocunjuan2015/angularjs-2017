<%
    String investMoney = request.getParameter("invest_money");
    HttpSession s = request.getSession(); 
    String username = (String)s.getAttribute("loginUser");
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
    String project_id = request.getParameter("id");
    String projectType = request.getParameter("projectType");
    String couponAmount = request.getParameter("couponAmount");
    String couponType = request.getParameter("couponType");
%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/config/global.jsp" %>
<!DOCTYPE html>
<html ng-app="projectInvestApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>瑞钱宝-国企参股 华融天泽参股的互联网金融平台</title>
     <link href="css/rqbao_index.css" rel="stylesheet"/>
     <link href="css/wechat2.css" rel="stylesheet" />
    <script src="js/invest.js" type="text/javascript"></script>
    <%@ include file="config/header.jsp" %>
</head>
<body style="background:#F5F4F4;"  ng-controller="projectInvestController">  <!-- onload="initData()" -->
<%@ include file="/config/globalHead.jsp" %>
 <input type="hidden" value="${param.id}"  id="project_id">
 <input type="hidden" value="<%=userId%>"  id="userId">
 <input type="hidden" value="${param.projectType}"  id="projectType">
 <input type="hidden" value="${param.couponType}"  id="couponType">
 <input type="hidden" value=""  id="couponId">
 <script>
        var project_id = $("#project_id").val();
        var userId = $("#userId").val();
        var projectType = $("#projectType").val();
        var couponType=$("#couponType").val();
  </script>
  <FORM id="form_save_cop_info">
            <input type="hidden" name="copType" id="copType" /> <input
                type="hidden" name="passValue" id="passValue" /> <input
                type="hidden" name="copId" id="copId" /> <input type="hidden"
                name="project_type" id="project_type" />
  </FORM>
  	<div class="account_balance">
	       <p>您的账户余额<font id="yue_span">{{accountBalance}}</font>元</p>
	       <button type="button" id="to_recharge" style="margin-right:15px;" onclick="toRecharge()" class="btn btn-danger">充值</button>
	</div>
	<div class="container-fluid mp0" style="background:#fff;">
	    <div  class="licai-box-new">
            <span id="projectName">{{projectName}}</span>
            <span style="display:none;"   id="project_loanRate">{{rate}}</span>
      </div>
			
			 <div  class="licai-box-new" style="color:#9B9B9B;">
         <span ng-show="'${param.projectType}'==1">可投金额：</span>
         <span ng-show="'${param.projectType}'==2">可认购本金：</span>
         <span  id="canbe_invested">{{residualAmount}}</span>
      </div>
      
      
			<div id="ivst_div1" class="licai-box-new" style="border-bottom:none;">
					<span id="ivst_sp1" ng-show="'${param.projectType}'==1">投资金额</span>
					<span  ng-show="'${param.projectType}'==2">认购本金</span>
				<input class="form-control input-number"
			     type="tel" ng-value="invest_number" id="invest_number" min="0"  
			      onkeyup="changeInvest(this.value)"
			      placeholder="请输入100的整数倍金额"> <!-- onclick="checkStatus()" -->
			</div>      
	</div>

	<div id="ivst_discount" style="display:none" class="licai-box-new">
            <span id="discount_sp1">折让金</span> <span class="ivst_sp3" id="ivst_sp3_1">元</span> <span
                class="ivst_sp2" id="discount_value"></span>
        </div>
        <!-- <div id="binggo_rate" class="licai-box-new"  >
            <span id="ivst_sp1">收益率</span>   <span
                class="ivst_sp2" id="binggo_rate_val"></span>
        </div> -->

		<div id="ivst_div2" class="licai-box-new" style="display: none">
			<span id="ivst_sp4">到期复投</span> <span id="times_invest_sp"><input
				id="times_invest" type="checkbox" checked /></span>

		</div>
		<div id="ivst_div3" style="display: none">
			<span id="ag_ivst_txt3">本金收益</span> <span id="ag_ivst_txt2"></span> <span
				id="ag_ivst_txt1">自动复投会增加</span>
		</div>
		<div id="ivst_div4" >
			<table class="table" id="coupon_table" style="color: #333;">
				<tbody>
					<tr  ng-show="'${param.projectType}'==1" id="choose_ticket" onClick="chooseCoupon(1)" style="border-bottom:2px solid #F5F4F4">
						<td style="padding-left:15px;border-top:none;">请选择优惠券</td>
						<td class="text-right text-muted" style="padding-right:15px;border-top:none;"><span id="coupon">未选择</span><span
							class="d-img pull-right" id="removeTriangle"></span></td>
					</tr>
					<tr ng-show="'${param.projectType}'==1" id="choose_coupon" onClick="chooseCoupon(2)" style="display:none">
						<td>瑞钱币</td>
						<td class="text-right text-muted"><span id="ruiqb">未选择</span><span
							class="d-img pull-right" ></span></td>
					</tr>
					<tr style="display:none;" ng-show="'${param.projectType}'==1" id="choose_red_evp" onClick="chooseCoupon(3)" style="border-bottom:2px solid #F5F4F4">
                        <td style="padding-left:15px;border-top:none;">红包</td>
                        <td class="text-right text-muted" style="border-top:none;padding-right:15px;"><span id="redevnp">未选择</span><span
                            class="d-img pull-right"></span></td>
                    </tr>
          <tr  style="border-bottom:2px solid #F5F4F4" ng-show="discountType == 1 || discountType == 2">
              <td class="discountRate" ng-if="discountType == 1"  style="padding-left:15px;border-top:none;">折让比例</td>
              <td class="increaseRate" ng-if="discountType == 2" style="padding-left:15px;border-top:none;">加价比例</td>
              <td id="ivst_div6" class="text-right text-muted" style="border-top:none;padding-right:15px;"> 
                   <span id="discountScale">{{discountScale}}</span>
              </td>
          </tr>

          <tr  style="border-bottom:2px solid #F5F4F4">
              <td style="padding-left:15px;border-top:none;">预期收益：</td>
              <td id="ivst_div7" class="text-right text-muted" style="border-top:none;padding-right:15px;"> 
                   <span id="invest_income"></span><font id="units"></font>
              </td>
          </tr>
				</tbody>
			</table>
		</div>

	<!-- <div class="div_right_bottom" id="ivst_div6" style="display:none;">
		预期收益：<span id="invest_income"></span>元
	</div> -->
	<div class="div_right_bottom" id="ivst_div7" style="display:none;">
		支付金额：<span id="invest_money"></span>元
	</div>
	<div id="error_info" class="error_info"></div>
	<div id="ivst_div8" class="checkbox" style="display:none;">
		<input onclick="onBoxClicked()" type="checkbox" value=""
			checked="checked" id="agreeBox">我同意 <span onclick="toProxy()">《瑞钱宝服务协议》</span>
	</div>
	<p class="bottom_button_div" style="text-align:center">
		<button type="button" id="invest_btn" ng-click="invest();"
			class="btn btn-danger btn-block mb20">投资</button>
	</p>
	<div style="display: none">
		<FORM action="" method="post" id="umpInvestForm"></FORM>
	</div>
	<div id="user_name" style="display:none"><%=username %></div>



	
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
          <h4 class="text-success text-center" id="body_content_h4"></h4>
          <!-- <p>投资金额：<span class="text-danger" id="money_invest_modal">1000</span>元</p> -->
        </div>
        <div class="modal-footer" id="use_cot" style="display: none">
          <table style="width: 100%">
            <tr>
              <td style="width: 50%;text-align: center">
                <button type="button" data-dismiss="modal" id="bt_invite"
                  class="btn btn-danger">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;取
                  消&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
              </td>
              <td><button type="button" data-dismiss="modal"
                  onclick="sureUse()" id="bt_to_invest"
                  class="btn btn-danger">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;继续&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button></td>
            </tr>
          </table>
        </div>
      </div>
    </div>
  </div>
</body>
</html>