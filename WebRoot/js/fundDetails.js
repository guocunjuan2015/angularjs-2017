//页面定义html字体大小
(function (doc,win) {
	var docEl = doc.documentElement,
        resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
    recalc = function (){
        var clientWidth = docEl.clientWidth;
        if (!clientWidth) {return ;}
    	docEl.style.fontSize = 10 * (clientWidth / 375) +"px";
    };
    if(!doc.addEventListener) return;
    win.addEventListener(resizeEvt,recalc,false);
    doc.addEventListener('DOMContentLoaded',recalc,false);
})(document,window);

//jquery
var userId = $("#userId").val();
var localPath = $("#localPath").val();
var basePath = $("#basePath").val();

//angular
var app = angular.module('ngApp', ['ngRoute']);
//回款计划明细
app.controller('fundDetails', function ($scope,$http,$timeout) {
	var loadToEnd = false;// 加载到最后一组
	$scope.type = "";
	$scope.page = 1;
	$scope.capitalList = [];
	//触发滚动事件
	window.onscroll = function (){
		var st = document.body.scrollTop,
			sh = document.body.scrollHeight,
			ih = this.innerHeight;
		if(st + ih == sh){
			$scope.page++;
			loadData();
		}
	};
	
	//请求数据
    var loadData = function(){
    	$scope.loadMsg = "努力加载中...";
    	$scope.showLoadMsg = true;
    	if (loadToEnd) {
    		return;
    	};
		var data = {
			currentPage : $scope.page,
			pageSize : "10",
			type : 1
		};
		transFn = function(data) {
	        return $.param(data);
	    };
	    postCfg = {
	        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
	        transformRequest: transFn
	    };
    	$http.post(basePath + '/account/getMyAccountList.do',data, postCfg).success(function(response,index) {
    		$scope.showLoadMsg = false;
    		var info = angular.fromJson(response.result);
    		console.log(info);
			if (info.result == "1") {
				var projects = info.resultObject.fundItemList == undefined ? info.resultObject
						: info.resultObject.fundItemList;
				//遍历数据得到当前的
				$scope.isColor1 = function(index){
					var Regx = /^[0-9]*$/;
					var subsidyRate = $scope.capitalList[index].invest_amount;
					if(Regx.test(subsidyRate)){
						return false;
					}else{
						return true;
					}
				};
				$scope.isColor2 = function(index){
					var subsidyRate = $scope.capitalList[index].invest_amount;
					if(subsidyRate.substr(0, 1) == '-'){
						return true;
					}else{
						return false;
					}
				};
				$scope.isColor3 = function(index){
					var subsidyRate = $scope.capitalList[index].invest_amount;
					if(subsidyRate.substr(0, 1) == '+'){
						return true;
					}else{
						return false;
					}
				};
				$scope.capitalList = $scope.capitalList.concat(projects);
				
				if (projects.length == 0) {
					$timeout(function(){
						$scope.loadMsg = "没有更多了...";
						$scope.showLoadMsg = true;
						$timeout(function (){
							$scope.showLoadMsg = false;
						},2000)
					})
					loadToEnd = true;
				};
				if($scope.capitalList == ''){
					$scope.errorTxt = '暂无数据';
					$scope.error =function (){
						return true;
					};
				}
				
			}else{
				$scope.errorTxt = info.errInfo;
				$scope.error =function (){
					return true;
				};
			}
			
    	}).error(function (){
			$scope.errorTxt = response.msg;
			$scope.error =function (){
				return true;
			};
			$timeout(function (){
				window.location.href = 'login.jsp';
			},2000);
		})
    };
    loadData();
});
