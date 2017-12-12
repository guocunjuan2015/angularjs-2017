<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="view" ng-controller="bidList">
	<div class="financialBox" ng-repeat="bid in bidList"><a href="project_invest_detail.jsp?id={{bid.projectId}}&projectType={{bid.projectType}}&loanType=1">
		<div class="entryName clearfix">
		    <h3 class="fl">{{bid.projectName}}</h3>
		     <p class="couponTip redEnvelopeTip"  ng-show="isReward($index)"></p>
		     <p class="fr">{{bid.investTime}}</p>
		</div>
		<div class="entry clearfix">
			<div class="interest fl">
				<h4>{{bid.investMoney}}</h4>
				<span class="clearfix">投资金额(元)</span>
			</div>
			<div class="month fl">
				<h4>{{bid.projectPeriod}}</h4>
				<span>{{bid.deadlineDetail}}</span>
			</div>
			<div class="month fr">
				<h4>{{bid.dueinMoney}}</h4>
				<span>预期收益(元)</span>
			</div>
		</div>
		<div class="entry clearfix" style="padding-top:0;">
		    <p class="couponTip redEnvelopeTip"  ng-show="isReward($index)"> <span>{{redEnvelopeList}}</span></p>
		    <p class="couponTip" ng-show="'{{bid.moreRate}}' != ''">
              <span>{{bid.moreRate}}</span>
        </p>
		</div>
		<!-- <div class="operation clearfix" ng-show="'{{bid.moreRate}}' != ''">
			<ul>
				<li><span>{{bid.moreRate}}</span></li>
			</ul>
		</div> -->
	
	</a>
	
	</div>
	<div ng-show="showLoadMsg" class="loading">{{loadMsg}}</div>
	<div class="errorTxt" ng-show="error()">{{errorTxt}}</div>
</div>