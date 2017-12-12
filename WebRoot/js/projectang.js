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

/*理财列表*/
app.controller('financialList', function ($scope,$http,$timeout) {
	var loadToEnd = false;// 加载到最后一组
	$scope.type = "";
	$scope.page = 1;
	$scope.financials = [];
	$scope.loadMsg = "努力加载中...";
	$scope.showLoadMsg = true;
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
    	if (loadToEnd) {
    		return;
    	};
		var data = {
			userId : userId,
			projectType : "1",
			currentPage : $scope.page,
			pageSize : "10",
			from : ""
		};
		transFn = function(data) {
	        return $.param(data);
	    };
	    postCfg = {
	        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
	        transformRequest: transFn
	    };
    	$http.post('project/getLoanList.do',data, postCfg).success(function(response,index) {
			var info = angular.fromJson(response.result);
			/*console.log(info);*/
			if (info.result == "1") {
				var projects = info.resultObject.productsList == undefined ? info.resultObject
						: info.resultObject.productsList;
				//遍历数据得到当前的
				$scope.isAward = function(index) {
				    var subsidyRate = $scope.financials[index].subsidyRate;
				    if(subsidyRate =="0"){
						return false;
					}else{
						return true;
					}
				};
				$scope.financials = $scope.financials.concat(projects);
				if (projects.length == 0 ) {
					$timeout(function(){
						$scope.loadMsg = "没有更多了...";
						$timeout(function (){
							$scope.showLoadMsg = false;
						},2000)
					})
					loadToEnd = true;
				};
				if($scope.financials == ''){
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
		})
    };
    loadData();
})

/*转让专区*/
app.controller('transferList', function ($scope,$http,$timeout) {
	var loadToEnd = false;// 加载到最后一组
	$scope.type = "";
	$scope.page = 1;
	$scope.financials = [];
	$scope.loadMsg = "努力加载中...";
	$scope.showLoadMsg = true;
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
	//请求转让专区数据
    var loadData = function(){
    	if (loadToEnd) {
    		return;
    	};
    	var data = {
    		userId : userId,
			projectType : "2",
			currentPage : $scope.page,
			pageSize : "10",
			from : ""
		};
		transFn = function(data) {
	        return $.param(data);
	    };
	    postCfg = {
	        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
	        transformRequest: transFn
	    };
    	$http.post('project/getLoanList.do',data, postCfg).success(function(response,index,$routeParams) {
			var info = angular.fromJson(response.result);
			if (info.result == "1") {
				var projects = info.resultObject.productsList == undefined ? info.resultObject
						: info.resultObject.productsList;
				//遍历数据得到当前的
				$scope.isAward = function(index) {
				    var subsidyRate = $scope.financials[index].subsidyRate;
				    if(subsidyRate =="0"){
						return false;
					}else{
						return true;
					}
				};
				$scope.financials = $scope.financials.concat(projects);
				console.log($scope.financials);
				if (projects.length == 0) {
					$timeout(function(){
						$scope.loadMsg = "没有更多了...";
						$timeout(function (){
							$scope.showLoadMsg = false;
						},2000)
					})
					loadToEnd = true;
				};
				if($scope.financials == ''){
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
		})
    };
    loadData();
})
/*理财/转让 页面切换*/

app.config(function ($routeProvider) {
    $routeProvider.
    when('/', {
        templateUrl: 'tpl/financialProject.jsp',
        controller: 'financialList'
    }).
    when('/financialProject', {
        templateUrl: 'tpl/financialProject.jsp',
        controller: 'financialList'
    }).    
    when('/transferProject', {
        templateUrl: 'tpl/transferProject.jsp',
        controller: 'transferList'
    })
});

//jquery
$(function(){
	//给理财或转让加样式（默认第一个）
	$(".projectList nav li").eq(0).find("a").addClass("act");
	$(".projectList nav li").on('touchstart',function(){
		$(this).siblings().find("a").removeClass("act");
		$(this).find("a").addClass("act");
	});
	
	/*判断URL路径改变导航样式*/
	var hash=window.location.hash;
	if (hash=="#/financialProject") {
		$(".projectList nav li a").removeClass("act");
		$(".projectList nav li").eq(0).find("a").addClass("act");
	}else if (hash=="#/transferProject") {
		$(".projectList nav li a").removeClass("act");
		$(".projectList nav li").eq(1).find("a").addClass("act");
	};
	
});
