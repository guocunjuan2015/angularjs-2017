<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String userName = (String) request.getSession().getAttribute("loginUser");
	String userId = (String) request.getSession().getAttribute("userId");
%>
<div class="view" ng-controller="returnList">
	<div class="financialBox" ng-repeat="return in returnList">
		<a href="project_invest_detail.jsp?id={{return.projectId}}&projectType={{return.projectType}}&loanType=2">
			<div class="entryName clearfix">
				<h3 class="fl">{{return.projectName}}</h3>
				<p class="couponTip redEnvelopeTip"  ng-show="isReward($index)"></p>
				<p class="fr">{{return.investTime}}</p>
			</div>
			<div class="entry clearfix">
				<div class="interest fl">
					<h4>{{return.investMoney}}</h4>
					<span class="clearfix">投资金额(元)</span>
				</div>
				<div class="month fl">
					<h4>{{return.projectPeriod}}</h4>
					<span>{{return.deadlineDetail}}</span>
				</div>
				<div class="month fr">
					<h4>{{return.dueinMoney}}</h4>
					<span>待收收益(元)</span>
				</div>
			</div>
		</a>
		<div class="entry clearfix" style="padding-top:0;">
        <p class="couponTip redEnvelopeTip"  ng-show="isReward($index)"> <span>{{redEnvelopeList}}</span></p>
       <p class="couponTip" ng-show="'{{return.moreRate}}' != ''"><span>{{return.moreRate}}</p>
    </div>
		<div class="operation clearfix">
			<ul>
				<!-- <li ng-show="'{{return.moreRate}}' != ''"><span>{{return.moreRate}}</span></li> -->
				<li><a href="paymentPlan.jsp?userId=<%=userId%>&loanId={{return.loanId}}&loanType={{return.projectType}}">回款计划</a></li>
				<li ng-if="return.projectType == '1'"><a href="agreement.jsp?userId=<%=userId%>&loanId={{return.loanId}}">查看合同</a></li>
				<li ng-if="return.projectType == '2'"><a href="agreementClaims.jsp?userId=<%=userId%>&investId={{return.loanId}}">查看合同</a></li>
			</ul>
		</div>
	</div>
	<div ng-show="showLoadMsg" class="loading">{{loadMsg}}</div>
	<div class="errorTxt" ng-show="error()">{{errorTxt}}</div>
</div>