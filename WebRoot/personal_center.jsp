<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/config/config.jsp" %>
<!DOCTYPE html>
<html ng-app="ngApp">
<head>
<meta charset="utf-8" />
<title>个人中心</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/reset.css">
<link href="css/accountcenterstyle.css" rel="stylesheet" />
<script src="js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/bootstrap.min3.0.3.js"></script>
<script type="text/javascript" src="js/angular.min.js"></script>
<script type="text/javascript" src="js/angular-route.min.js" ></script>
<script src="js/utils.js" type="text/javascript"></script>
<script>
  $(function(){
	  //判断提现是否大于0
	   $.ajax({
		     url:'<%=basePath%>/account/getUserBalance.do',
		     type:'post',
		     dataType:'json',
		     success:function(data){
		    	 var info =  $.parseJSON(data.result);
		    	 var _info = info.resultObject;
		    	 var umpAccountBalance =_info.umpAccountBalance;
		    	 var numAccountBalance =parseFloat(umpAccountBalance.split(",").join(""));
		    	  if(Number(numAccountBalance) > 0){
		    		   $(".fixedDirlog").show();
		    		    $(".balanceBox").show();
		    		  
		    	  } else {
		    		  
		    		    isDirlogShow ();
		    		  
		    	  }
		    	 
		     },error:function(){
		    	  alert("请联系管理员!");
		    	 
		     }
		   
	   })
	  
  })

</script>
<%@ include file="config/header.jsp" %>
<%
  String userName = (String) request.getSession().getAttribute("loginUser");
%>
</head>
<body ng-controller="personal" style="overflow:scroll-x">
<%@ include file="/config/globalHead.jsp" %>
<%@ include file="/config/dirlog.jsp" %>
  <input type="hidden" value="<%=userId%>" id="userId">
  <input type="hidden" value="<%=userName%>" id="userName">
  <input type="hidden" value="<%=localPath%>" id="localPath">
  <input type="hidden" value="<%=basePath%>" id="basePath">
  <input type="hidden" value="{{mobile}}" id="mobile">
  <input type="hidden" value="{{realName}}" id="realName">
  <%--头像 --%>
  <section class="accounthead">
  <div class="accounthead-newinfo" id="lingd" onclick="toMessageCenter()" ng-show="hasNoRead()">&nbsp;</div>
    <div class="accounthead-newinfo-red " id="lingdred" onclick="toMessageCenter()" ng-show="hasNoRead2()">&nbsp;</div>
    <div class="accounthead-user" >
      <div class="accounthead-userhead" onclick="toAccountInfo()">
        <img id="user_img" src="images/userhead.png" />
        <div class="accounthead-vip" id="vip_level_sign">{{vipLevel}}</div>
      </div>
      <div class="accounthead-assets">
        <h3 ng-bind="totalAsset"></h3>
        <p>总资产(元)</p>
      </div>
      <div class="accounthead-detailed">
        <div>
          <h3 ng-bind="interestReceivable"></h3>
          <p>待收本息(元)</p>
        </div>
        <div>
          <h3 ng-bind="accumulatedEarning"></h3>
          <p>累计收益(元)</p>
        </div>
      </div>
    </div>
  </section>
  <%--可用余额 --%>
  <section class="userzcsection">
    <div class="userzc">
      <span class="zc">
        <span id="user_total" ng-bind="accountBalance"></span>
        <span class="zc-block zc-zzc">可用余额(元)</span>
      </span>
      <span>
        <button type="button" id="recharge_button" onclick="rechargeOrCash(0,event)" class="btn btn-danger btn-size">充值</button>
        <button type="button" id="cash_button" onclick="rechargeOrCash(1,event)" class="btn btn-primary btn-size">提现</button>
      </span>
    </div>
  </section>
  <%-- 账户分支 --%>
  <section class="userBranch">
    <ul class="clearfix">
      <li><a href="javascript:;" onclick="accountInvest()">
        <dl>
          <dt><img alt="" src="<%=basePath%>/images/branch1.png"></dt>
          <dd>我的投资</dd>
        </dl>
      </a></li>
      <li><a href="javascript:;" onclick="toMyCoupon()">
        <dl>
          <dt><img alt="" src="<%=basePath%>/images/branch2.png"></dt>
          <dd>我的礼物</dd>
        </dl>
      </a></li>
      <li><a href="javascript:;" onclick="toFincDetail(event)">
        <dl>
          <dt><img alt="" src="<%=basePath%>/images/branch3.png"></dt>
          <dd>资金明细</dd>
        </dl>
      </a></li>
      <li><a href="javascript:;" onclick="toMyReferrer()">
        <dl>
          <dt><img alt="" src="<%=basePath%>/images/branch4.png"></dt>
          <dd>邀请好友</dd>
        </dl>
      </a></li>
     <%--  <li><a href="javascript:;" onclick="daySignIn()">
        <dl>
          <dt><img alt="" src="<%=basePath%>/images/branch5.png"></dt>
          <dd>签到</dd>
        </dl>
      </a></li> --%>
      <li><a href="javascript:;" onclick="toMyAgreeSubject()">
            <dl>
              <dt><img alt="" src="<%=basePath%>/images/yIcon.png"></dt>
              <dd>我的约标</dd>
            </dl>
        </a></li>
        <li><a href="javascript:;" onclick="toRiskAssessment()">
            <dl>
              <dt><img alt="" src="<%=basePath%>/images/branch6.png"></dt>
              <dd>风险测评</dd>
            </dl>
        </a></li>
        <%-- <li><a href="javascript:;" onclick="toMyLoan()">
            <dl>
              <dt><img alt="" src="<%=basePath%>/images/loan7.png"></dt>
              <dd>我的借款</dd>
            </dl>
        </a></li> --%>
    </ul>
      
  </section>
  <div class="errorTxt" ng-show="error()" ng-bind="errorTxt"></div>
</body>
<script src="js/personalCenterNew.js" type="text/javascript"></script>
</html>
