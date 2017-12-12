<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="view gifts" ng-controller="voucherList">
	<div class="giftBox" ng-repeat="withdrawCash in withdrawCashs"><a class="clearfix" href="">
		<!-- 追加是否国企背景图片 -->
		 <!--  <div class="unusedsImg" ng-if="status == 'unuseds'">
		  <div class="expiresImg" ng-if="status == 'expires'">
		  <div class="usedsImg" ng-if="status == 'useds'"> -->
					<div class="fl giftIcon">
						<dl>
							<dt>{{withdrawCash.amount}}<span>元</span></dt>
							<dd>{{withdrawCash.giftName}}</dd>
						</dl>
					</div>
					<div class="fr giftList">
						<ul>
							<li style="margin-top:1.2rem;"><b></b>{{withdrawCash.validity}}</li>
						</ul>   
					</div>
	</a>
	</div>
	<!-- <div ng-show="showLoadMsg" class="loading">{{loadMsg}}</div> -->
	<div class="errorTxt" ng-show="error()">{{errorTxt}}</div>
</div>