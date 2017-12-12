<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="view gifts" ng-controller="voucherList">
	<div class="giftBox"  ng-repeat="voucher in vouchers">
	<a class="clearfix" href="">
	   <div  ng-class="'{{voucher.status}}' == 'useds' ? 'grayColor' : '' ">
				<div class="fl giftIcon">
					<dl>
						<dt>{{voucher.amount}}<span>{{voucher.unit}}</span></dt>
						<dd>{{voucher.giftName}}</dd>
					</dl>
				</div>
				<div class="fr giftList">
					<ul>
						<li><b></b>{{voucher.source}}</li>
						<li><b></b>{{voucher.rule}}</li>
						<li><b></b>{{voucher.validity}}</li>
					</ul>   
				</div>
	   </div>		
	</a>
</div>
	<div ng-show="showLoadMsg" class="loading">{{loadMsg}}</div>
	<div class="errorTxt" ng-show="error()">{{errorTxt}}</div>
</div>