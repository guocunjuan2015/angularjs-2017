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
var loanId ='';
var loanType = '';

	loanId = getRequestParam("loanId");
	loanType = getRequestParam("loanType");
//angular
var app = angular.module('ngApp', ['ngRoute']);
//回款计划明细
app.controller('paymentPlan', function ($scope,$http,$timeout) {
	var loadToEnd = false;// 加载到最后一组
	$scope.type = "";
	$scope.page = 1;
	$scope.paymentList = [];
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
			userId : userId,
			loanId : loanId,
			loanType : loanType,
			currentPage : $scope.page,
			pageSize : "10"
		};
		transFn = function(data) {
	        return $.param(data);
	    };
	    postCfg = {
	        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
	        transformRequest: transFn
	    };
    	$http.post(basePath + '/user/getPaymentPlanDetail.do',data, postCfg).success(function(response,index) {
    		$scope.showLoadMsg = false;
    		var info = angular.fromJson(response.result);
			if (info.result == "1") {
				var projects = info.resultObject.paymentPlanDetail == undefined ? info.resultObject
						: info.resultObject.paymentPlanDetail;
				$scope.paymentList = $scope.paymentList.concat(projects);
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
				if($scope.paymentList == ''){
					$scope.errorTxt = '暂无数据';
					$scope.error =function (){
						return true;
					};
				}
				console.log($scope.paymentList);
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
