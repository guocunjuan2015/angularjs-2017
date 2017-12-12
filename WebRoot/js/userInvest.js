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

var userId = $("#userId").val();
var localPath = $("#localPath").val();
var basePath = $("#basePath").val();
//angular
var app = angular.module('ngApp', ['ngRoute']);
//投标中
app.controller('bidList', function ($scope,$http,$timeout) {
	var loadToEnd = false;// 加载到最后一组
	$scope.type = "";
	$scope.page = 1;
	$scope.bidList = [];
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
			loanType : "1",
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
    	$http.post(basePath + '/project/getMyInvestList.do',data, postCfg).success(function(response,index) {
    		$scope.showLoadMsg = false;
    		var info = angular.fromJson(response.result);
			if (info.result == "1") {
				var projects = info.resultObject.myInvestList == undefined ? info.resultObject
						: info.resultObject.myInvestList;
				$scope.bidList = $scope.bidList.concat(projects);
				//console.log($scope.bidList);
				//遍历得到当前的数据
				$scope.isReward = function(index){
					$scope.redEnvelopeList = $scope.bidList[index].redEnvelopeList;
					var arr = [];
					if($scope.redEnvelopeList.length > 0){
							angular.forEach($scope.redEnvelopeList, function(data){
								angular.forEach($scope.redEnvelopeList, function(value, key){
									arr.push(value); 
									/*$scope.redEnvelopeList = data;
									console.log($scope.redEnvelopeList);*/
								
								});
							});
						
						//console.log(arr);
						return true;
					} else {
						
						   return false;
					}
					
					
				}
				
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
				if($scope.bidList == ''){
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
//回款中
app.controller('returnList', function ($scope,$http,$timeout) {
	var loadToEnd = false;// 加载到最后一组
	$scope.type = "";
	$scope.page = 1;
	$scope.returnList = [];
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
			loanType : "2",
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
    	$http.post(basePath + '/project/getMyInvestList.do',data, postCfg).success(function(response,index) {
    		$scope.showLoadMsg = false;
    		var info = angular.fromJson(response.result);
			if (info.result == "1") {
				var projects = info.resultObject.myInvestList == undefined ? info.resultObject
						: info.resultObject.myInvestList;
				$scope.returnList = $scope.returnList.concat(projects);
				//console.log($scope.returnList);
				//遍历得到当前的数据
				$scope.isReward = function(index){
					$scope.redEnvelopeList = $scope.returnList[index].redEnvelopeList;
					//console.log($scope.returnList[index].redEnvelopeList);
					var arr = [];
					if($scope.redEnvelopeList.length > 0){
							angular.forEach($scope.redEnvelopeList, function(data){
								angular.forEach($scope.redEnvelopeList, function(value, key){
									arr.push(value); 
									/*$scope.redEnvelopeList = data;
									console.log($scope.redEnvelopeList);*/
								
								});
							});
						
						//console.log(arr);
						return true;
					} else {
						
						   return false;
					}
					
					
				}
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
				if($scope.returnList == ''){
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
//已结清
app.controller('settledList', function ($scope,$http,$timeout) {
	var loadToEnd = false;// 加载到最后一组
	$scope.type = "";
	$scope.page = 1;
	$scope.settledList = [];
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
			loanType : "3",
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
    	$http.post(basePath + '/project/getMyInvestList.do',data, postCfg).success(function(response,index) {
    		$scope.showLoadMsg = false;
			var info = angular.fromJson(response.result);
			if (info.result == "1") {
				var projects = info.resultObject.myInvestList == undefined ? info.resultObject
						: info.resultObject.myInvestList;
				$scope.settledList = $scope.settledList.concat(projects);
				//遍历得到当前的数据
				$scope.isReward = function(index){
					$scope.redEnvelopeList = $scope.settledList[index].redEnvelopeList;
					var arr = [];
					if($scope.redEnvelopeList.length > 0){
							angular.forEach($scope.redEnvelopeList, function(data){
								angular.forEach($scope.redEnvelopeList, function(value, key){
									arr.push(value); 
									/*$scope.redEnvelopeList = data;
									console.log($scope.redEnvelopeList);*/
								
								});
							});
						
						//console.log(arr);
						return true;
					} else {
						
						   return false;
					}
					
					
				}
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
				if($scope.settledList == ''){
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
/*理财/转让 页面切换*/

app.config(function ($routeProvider) {
    $routeProvider.
    when('/', {
        templateUrl: 'userInvest/bid.jsp',
        controller: 'bidList'
    }).
    when('/bid', {
        templateUrl: 'userInvest/bid.jsp',
        controller: 'bidList'
    }).    
    when('/return', {
        templateUrl: 'userInvest/return.jsp',
        controller: 'returnList'
    }).    
    when('/settled', {
        templateUrl: 'userInvest/settled.jsp',
        controller: 'settledList'
    })
});

//jquery
$(function(){
	//给理财或转让加样式（默认第一个）
	$(".investList nav li").eq(0).find("a").addClass("act");
	$(".investList nav li").on('touchstart',function(){
		$(this).siblings().find("a").removeClass("act");
		$(this).find("a").addClass("act");
	});
	
	/*判断URL路径改变导航样式*/
	var hash=window.location.hash;
	if (hash=="#/bid") {
		$(".investList nav li a").removeClass("act");
		$(".investList nav li").eq(0).find("a").addClass("act");
	}else if (hash=="#/return") {
		$(".investList nav li a").removeClass("act");
		$(".investList nav li").eq(1).find("a").addClass("act");
	}else if (hash=="#/settled") {
		$(".investList nav li a").removeClass("act");
		$(".investList nav li").eq(2).find("a").addClass("act");
	};
	
});
