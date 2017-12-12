/* 页面定义html字体大小 */
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
var app = angular.module('ngApp', ['ngRoute']);
app.controller('message',function ($scope,$http,$timeout){
	//请求消息数据
    var data = {
    	userId : userId
	};
	transFn = function(data) {
        return $.param(data);
    };
    postCfg = {
        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
        transformRequest: transFn
    };
	$http.post('account/message/center/get.do',data, postCfg).success(function(response,index) {
		if (response.success) {
			var info = angular.fromJson(response.result);
			var messageList = info.resultObject.productsList == undefined ? info.resultObject
					: info.resultObject.productsList;
			$scope.messageList = messageList;
		}else{
    		$scope.errorTxt = response.msg;
			$scope.error =function (){
				return true;
			};
			window.location.href=response.result;
			
		}
	}).error(function (){
		$scope.errorTxt = response.msg;
		$scope.error =function (){
			return true;
		};
		$timeout(function (){
			window.location.href=response.result;
		},2000)
	});
	
});

function changeMessageStatus(obj){
	$.ajax({
	type : "POST",
	url : "account/message/center/changeallmessage.do",
	data : {},
	success : function(response) {
		if (response.success) {
			var info = $.parseJSON(response.result);
			if (info.result) {
				$(obj).addClass('read');
				
				$(obj).find('p').css({
					'height': 'auto',
					'overflow': 'auto',
					'text-overflow':'clip',
					'white-space':'inherit'
				});
			} else {
				errorMsg(info.errInfo);
			}
		} else {
			if (isEmpty(response.result)) {
				errorMsg(response.msg);
			} else {
				window.location.href = response.result;
			}
		}
	},
	dataType : "json"
});
}