<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="view" ng-controller="financialList">
	<div class="financialBox" ng-repeat="financial in financials"><a href="project_other_content.jsp?id={{financial.projectId}}&projectType=1">
		<div class="entryName clearfix"><h3 class="fl">{{financial.projectName}}</h3><p class="fr">剩余金额：<font>{{financial.residualAmount}}</font> 元</p></div>
		<div class="entry clearfix">
			<div class="interest fl">
				<h4>
					{{financial.rate}}<i ng-show="isAward($index)"><b>+</b>{{financial.subsidyRate}}</i>
					<p ng-class="'{{financial.subsidyDesc}}' == '平台送' ? 'icon blue' : 'icon'" ng-show="isAward($index)"><font>{{financial.subsidyDesc}}</font></p>
				</h4>
				<span class="clearfix">预期年化收益(%)</span>
			</div>
			<div class="month fl">
				<h4>{{financial.projectPeriod}}</h4>
				<span>{{financial.deadlineDetail}}</span>
			</div>
			<div class="click fl">
				<input ng-class="{{financial.projectStatus}} == 2 ? 'buy' : 'ash'" type="button" value="{{financial.projectStatusDescName}}">
			</div>
		</div>
		<div class="investmentProgress">
			<div class="progress fl">
				<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="{{financial.progress}}" aria-valuemin="0" aria-valuemax="100" style="width: {{financial.progress}}%">
					<span class="sr-only"></span>
			  	</div>
			</div>
			<span>{{financial.progress}}%</span>
		</div>
	</a></div>
	<div ng-show="showLoadMsg" class="loading">{{loadMsg}}</div>
	<div class="errorTxt" ng-show="error()">{{errorTxt}}</div>
</div>