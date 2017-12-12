<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="view" ng-controller="settledList">
	<div class="financialBox" ng-repeat="settled in settledList"><a href="project_invest_detail.jsp?id={{settled.projectId}}&projectType={{settled.projectType}}&loanType=3">
		<div class="entryName clearfix">
				<h3 class="fl">{{settled.projectName}}</h3>
				<p class="couponTip redEnvelopeTip"  ng-show="isReward($index)"></p>
				<p class="fr">{{settled.investTime}}</p>
		</div>
		<div class="entry clearfix">
			<div class="interest fl">
				<h4>{{settled.investMoney}}</h4>
				<span class="clearfix">投资金额(元)</span>
			</div>
			<div class="month fl">
				<h4>{{settled.projectPeriod}}</h4>
				<span>{{settled.deadlineDetail}}</span>
			</div>
			<div class="month fr">
				<h4>{{settled.dueinMoney}}</h4>
				<span>已收收益(元)</span>
			</div>
		</div>
	</a>
	    <div class="entry clearfix" style="padding-top:0;">
        <p class="couponTip redEnvelopeTip"  ng-show="isReward($index)"> <span>{{redEnvelopeList}}</span></p>
       <p class="couponTip" ng-show="'{{return.moreRate}}' != ''"><span>{{settled.moreRate}}</p>
    </div>
	
	</div>
	<div ng-show="showLoadMsg" class="loading">{{loadMsg}}</div>
	<div class="errorTxt" ng-show="error()">{{errorTxt}}</div>
</div>