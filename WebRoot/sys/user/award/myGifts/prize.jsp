<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="view gifts" ng-controller="prizeList">
	<div class="giftBox" ng-repeat="prize in prizes">
		 <div  ng-class="'{{prize.status}}' == 'useds' ? 'grayColor' : '' ">
			   <a class="clearfix" href="">
						<div class="fl giftIcon">
							<dl>
								<dt><img alt="" ng-src="{{prize.imgUrl}}"></dt>
								<dd>{{prize.giftName}}</dd>
							</dl>
						</div>
						<div class="fr giftList">
							<ul>
								<li><b></b>{{prize.source}}</li>
								<li ng-show="'{{prize.rule}}' != ''"><b></b>{{prize.rule}}</li>
								<li><b></b>{{prize.validity}}</li>
							</ul>  
						</div>
					</a>
		   </div>
	</div>
	<div ng-show="showLoadMsg" class="loading">{{loadMsg}}</div>
	<div class="errorTxt" ng-show="error()">{{errorTxt}}</div>
</div>