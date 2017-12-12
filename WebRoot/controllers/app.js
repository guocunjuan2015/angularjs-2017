
var app = angular.module('indexApp', []);

app.controller("announceController",function($scope,$http){

  
//首页网站公告
	
$http.post("project/getHomeInfo.do").success(function(data){
	var result = angular.fromJson(data.result);
//console.log(result);
	/*	console.log(result.resultObject.afficheInfoList);
	console.log(result.resultObject.totalTradingAmount);*/
	$scope.announces = result.resultObject.afficheInfoList;/*网站公告*/
	$scope.totalTradingAmount = result.resultObject.totalTradingAmount;/*累计成交金额*/
	$scope.operationDate = result.resultObject.operationDate;/*安全运营天数*/
	$scope.operationReportUrl = result.resultObject.operationReportUrl;/*运营报告*/
	$scope.userNumber = result.resultObject.userNumber;/*注册人数*/

});
	
}).controller("bannerListControll",function($scope,$http){

$http.post("project/getHomeInfo.do").success(function(data){

var result = angular.fromJson(data.result);
$scope.bannerLists = result.resultObject.bannerList;/*banner信息列表*/
//console.log(result.resultObject.bannerList);

})

})