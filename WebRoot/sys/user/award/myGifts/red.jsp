<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="view gifts" ng-controller="redList">
	<div class="giftBox" ng-repeat="red in reds"  ng-show="'{{red.amount}}' > 0">
		<a class="clearfix" href="">
		   <div  ng-class="'{{red.status}}' == 'useds' ? 'grayColor' : '' ">
					<div class="fl giftIcon">
						<dl>
							<dt>{{red.amount}}<span>元</span></dt>
							<dd>{{red.giftName}}</dd>
						</dl>
					</div>
					<div class="fr giftList">
						<ul>
							<li><b></b>{{red.source}}</li>
							<li><b></b>{{red.rule}}</li>
							<li><b></b><font>{{red.validity}}</font></li>
						</ul>
					</div>
		</div>	
		</a>
	</div>
	<div ng-show="showLoadMsg" class="loading">{{loadMsg}}</div>
	<div class="errorTxt" ng-show="error()">{{errorTxt}}</div>
</div>
