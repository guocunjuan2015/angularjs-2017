//jquery
$(function(){
	var  validPeriod = $(".giftList font").text();
	console.log(validPeriod);
	validPeriod = validPeriod.substring(0,3);
	console.log(validPeriod);
	
	//给理财或转让加样式（默认第一个）
	$(".projectList nav li").eq(0).find("a").addClass("act");
	$(".projectList nav li").on('touchstart',function(){
		$(this).siblings().find("a").removeClass("act");
		$(this).find("a").addClass("act");
	});  
	
	/*判断URL路径改变导航样式*/
	var hash=window.location.hash;
	if (hash=="#/red") {
		$(".projectList nav li a").removeClass("act");
		$(".projectList nav li").eq(0).find("a").addClass("act");
	}else if (hash=="#/voucher") {
		$(".projectList nav li a").removeClass("act");
		$(".projectList nav li").eq(1).find("a").addClass("act");
	}else if (hash=="#/prize") {
		$(".projectList nav li a").removeClass("act");
		$(".projectList nav li").eq(2).find("a").addClass("act");
	};
	
});
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
var app = angular.module('ngApp', ['ngRoute']);
/*红包接口*/
app.controller('redList', function ($scope,$http,$timeout) {
	var loadToEnd = false;// 加载到最后一组
	$scope.type = "";
	$scope.page = 1;
	$scope.reds = [];
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
	
	
    var loadData = function(){
    	$scope.loadMsg = "努力加载中...";
    	$scope.showLoadMsg = true;
    	if (loadToEnd) {
    		return;
    	};
    	var data = {
			awardType : "2",
			current : $scope.page,
			pageSize : "10",
			userId : userId
		};
		transFn = function(data) {
	        return $.param(data);
	    };
	    postCfg = {
	        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
	        transformRequest: transFn
	    };
    	$http.post('http://test.rqbao.com/rqb/userAward/getUserAwardList.do',data, postCfg).success(function(response,index) {
    		$scope.showLoadMsg = false;
    		/*console.log(data);*/
			if (response.success) {
				if(response.result == ""||response.result == null){
					$scope.errorTxt = '没有红包';
					$scope.error =function (){
						return true;
					};
				}else{
					var info = angular.fromJson(response.result);
					var projects = info.resultObject.giftList == undefined ? info.resultObject
							: info.resultObject.giftList;
					$scope.reds = $scope.reds.concat(projects);
					/*console.log($scope.reds);*/
					//底部更换提示语
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
				}
				
			}else{
				$scope.errorTxt = '您还没有任何红包';
				$scope.error =function (){
					return true;
				};
			}
			
    	}).error(function (){
    		$scope.errorTxt = response.msg;
			$scope.error =function (){
				return true;
			};
		})
    };
    loadData();
});
//加息券
app.controller('voucherList', function ($scope,$http,$timeout) {
	var loadToEnd = false;// 加载到最后一组
	$scope.type = "";
	$scope.page = 1;
	$scope.vouchers = [];
	
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
	
	//请求理财项目数据
    var loadData = function(){
    	$scope.loadMsg = "努力加载中...";
    	$scope.showLoadMsg = true;
    	if (loadToEnd) {
    		return;
    	};
    	var data = {
			awardType : "3",
			current : $scope.page,
			pageSize : "10",
			userId : userId
		};
		transFn = function(data) {
	        return $.param(data);
	    };
	    postCfg = {
	        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
	        transformRequest: transFn
	    };
    	$http.post('http://test.rqbao.com/rqb/userAward/getUserAwardList.do',data, postCfg).success(function(response,index) {
			if (response.success) {
				if(response.result == ""||response.result == null){
					$scope.errorTxt = '没有加息券';
					$scope.error =function (){
						return true;
					};
				}else{
					var info = angular.fromJson(response.result);
					var projects = info.resultObject.giftList == undefined ? info.resultObject
							: info.resultObject.giftList;
					$scope.vouchers = $scope.vouchers.concat(projects);
					$scope.status =info.resultObject.giftList.status; 
					//底部更换提示语
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
				}
				
			}else{
				$scope.errorTxt = '您还没有任何加息券';
				$scope.error =function (){
					return true;
				};
			}
			
    	}).error(function (){
    		$scope.errorTxt = response.msg;
			$scope.error =function (){
				return true;
			};
		})
    };
    loadData();
});
//奖品
app.controller('prizeList', function ($scope,$http,$timeout) {
	var loadToEnd = false;// 加载到最后一组
	$scope.type = "";
	$scope.page = 1;
	$scope.prizes = [];
	
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
	
	
    var loadData = function(){
    	$scope.loadMsg = "努力加载中...";
    	$scope.showLoadMsg = true;
    	if (loadToEnd) {
    		return;
    	};
    	var data = {
			awardType : "1",
			current : $scope.page,
			pageSize : "10",
			userId : userId
		};
		transFn = function(data) {
	        return $.param(data);
	    };
	    postCfg = {
	        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
	        transformRequest: transFn
	    };
    	$http.post('http://test.rqbao.com/rqb/userAward/getUserAwardList.do',data, postCfg).success(function(response,index) {
			if (response.success) {
				if(response.result == ""||response.result == null){
					$scope.errorTxt = '没有红包';
					$scope.error =function (){
						return true;
					};
				}else{
					var info = angular.fromJson(response.result);
					var projects = info.resultObject.giftList == undefined ? info.resultObject
							: info.resultObject.giftList;
					$scope.prizes = $scope.prizes.concat(projects);
					//底部更换提示语
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
				}
				
			}else{
				$scope.errorTxt = '您还没有任何奖品';
				$scope.error =function (){
					return true;
				};
			}
			
    	}).error(function (){
    		$scope.errorTxt = response.msg;
			$scope.error =function (){
				return true;
			};
		})
    };
    loadData();
});



//提现券
app.controller('withdrawList', function ($scope,$http,$timeout) {
	var loadToEnd = false;// 加载到最后一组
	$scope.type = "";
	$scope.page = 1;
	$scope.withdrawCashs = [];
	
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
	
	
    var loadData = function(){
    	$scope.loadMsg = "努力加载中00...";
    	$scope.showLoadMsg = true;
    	if (loadToEnd) {
    		$scope.loadMsg = "";
    		return;
    	};
    	var data = {
			current : $scope.page,
			pageSize : "10",
		};
		transFn = function(data) {
	        return $.param(data);
	    };
	    postCfg = {
	        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
	        transformRequest: transFn
	    };
    	$http.post('http://test.rqbao.com/rqb/cg/mem/coupon/list.do',data, postCfg).success(function(response,index) {
    		if (response.success) {
				if(response.result == ""||response.result == null){
					$scope.errorTxt = '没有提现券';
					$scope.error =function (){
						return true;
					};
				}else{
					var info = angular.fromJson(response.result);
					$scope.status = info.resultObject.giftList.status;///提现券状态  1、unused 正常 2、expries 国企 3、已使用
					/*console.log(info.resultObject.giftList);
					console.log(info.resultObject.giftList.giftName);*/
					/*console.log(info.resultObject.giftList.status);*/
					var projects = info.resultObject.giftList== undefined ? info.resultObject.giftList
							: info.resultObject.giftList;
					$scope.withdrawCashs = $scope.withdrawCashs.concat(projects);
					//底部更换提示语
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
				}
				
			}else{
				$scope.errorTxt = '您还没有任何提现券';
				$scope.error =function (){
					return true;
				};
			}
			
    	}).error(function (){
    		$scope.errorTxt = response.msg;
			$scope.error =function (){
				return true;
			};
		})
    };
    loadData();
});



//我的礼物tab切换页面
app.config(function ($routeProvider) {
    $routeProvider.
    when('/', {
        templateUrl: 'myGifts/red.jsp',
        controller: 'redList'
    }).
    when('/red', {
        templateUrl: 'myGifts/red.jsp',
        controller: 'redList'
    }).    
    when('/voucher', {
        templateUrl: 'myGifts/voucher.jsp',
        controller: 'voucherList'
    }).    
    when('/prize', {
        templateUrl: 'myGifts/prize.jsp',
        controller: 'prizeList'
    }).    
    when('/withdraw_cash', {
        templateUrl: 'myGifts/withdraw_cash.jsp',
        controller: 'withdrawList'
    })
});

