var userId = $("#userId").val();
var localPath = $("#localPath").val();
var basePath = $("#basePath").val();
//angular
var app = angular.module('ngApp',['ngRoute']);

/*首页/认证/个人中心页面切换*/
app.config('$routeProvider',function($routeProvider){
	
	$routeProvider
	.when('/',{templateUrl:'/'})  /*首页*/
	
	.when('/authenticate',{templateUrl:''}) /*认证*/
	
	.when('/personalCenter',{templateUrl:''}) /*个人中心*/
	
	.otherwise({redirectTo:'/'});/*默认情况下首页展示*/
	
})
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
