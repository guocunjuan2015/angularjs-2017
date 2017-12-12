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


var userName = $("#userName").val();
var userId = $("#userId").val();
var localPath = $("#localPath").val();
var basePath = $("#basePath").val();
//angular
var app = angular.module('ngApp', ['ngRoute']);
app.controller('personal', function ($scope,$http,$timeout,$location) {
	var loadData = function(){
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
    	$http.post(basePath + '/user/getUserCenter.do',data, postCfg).success(function(response,index) {
    		var info = angular.fromJson(response.result);
			if (info.result == "1") {
				var projects = info.resultObject;
				//总资产
				$scope.totalAsset = projects.totalAsset;
				//代收本息
				$scope.interestReceivable = projects.interestReceivable;
				//累计收益
				$scope.accumulatedEarning = projects.accumulatedEarning;
				//可用余额   
				$scope.accountBalance = projects.accountBalance;
				// 积分等级   
				$scope.vipLevel = projects.vipLevel;
				// 用户姓名realName
				$scope.realName = projects.realName;
				// 手机号
				$scope.mobile = projects.mobile;
				//消息   
				$scope.hasNoRead = function(){
					if(projects.hasNoRead == "0"){
						return true;
					}
				}
				$scope.hasNoRead2 = function(){
					if(projects.hasNoRead > "0"){
						return true;
					}
				}
			}else{
				$scope.errorTxt = info.errInfo;
				$scope.error =function (){
					return true;
				};
				$timeout(function (){
					window.location.href = 'login.jsp';
				},2000);
			}
			
    	}).error(function (){
    		var info = angular.fromJson(response.result);
    		$scope.errorTxt = info.errInfo;
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

//触发充值提现事件
function rechargeOrCash(index,event) {
	// 充值提现都要在联动开户绑卡,index为0是充值，1为绑卡
	if (realNametf) {
			// 跳到联动充值(先判断是否绑卡)
		if (0 == index) {
			// 去易宝充值
			window.location.href = "ump_money_recharge.jsp";
		} else {
			window.location.href = "custody_withdraw.jsp";
		}
	} else if(bankCodetf) {
		
		// 跳到联动充值(先判断是否绑卡)
		if (0 == index) {
			// 去易宝充值
			window.location.href = "ump_money_recharge.jsp";
		} else {
			window.location.href = "custody_withdraw.jsp";
		}
	} else {
		
		$(".fixedDirlog").show();
		$(".realNameOrCard").show();
		
	}
}

//跳转我的投资
function accountInvest() {
	window.location.href = "personal_invest.jsp";
}
//跳转我的消息
function toMessageCenter() {
	window.location.href = "message_center.jsp";
}
//资金明细
function toFincDetail(event) {
	// 去交易记录
	window.location.href = "income_details.jsp";
}
//邀请好友
function toMyReferrer() {
	window.location.href = "active/inviting/inviting.jsp";
}
//跳转我的约标 
function toMyAgreeSubject() {
  window.location.href = "myAgreeSubject.jsp?userId=" + userId;
}
//跳转我的礼物
function toMyCoupon() {
	window.location.href = "sys/user/award/myGift.jsp"
}
function toRiskAssessment(){
	window.location.href = "riskAssessment.jsp?userId=" + userId;
}
//签到
function daySignIn() {
	window.location.href = "shake_sign.jsp";
}
//  去实名、绑卡
/*function gotoPage(index) {
	switch (index) {
	case 1:
		window.location.href = "ump_real_register.jsp";
		break;
	case 2:
		window.location.href = "add_bankcard.jsp";
		break;
	}
}*/
//弹出框关闭
$(".closeName").click(function (){
	$(".realName").hide();
	$(".fixedDirlog").hide();
})
$(".closeCard").click(function (){
	$(".tieOnCard").hide();
	$(".fixedDirlog").hide();
})


//跳转我的约标 
function toMyAgreeSubject() {
  window.location.href = "myAgreeSubject.jsp?userId=" + userId;
}
//跳转我的借款
function toMyLoan() {
  window.location.href = "my_loan.jsp?userId=" + userId;
}

//头像
function toAccountInfo(){
	if(userName){//判断数据已经获取
		window.location.href = "account_info.jsp?vip_rank="+$("#vip_level_sign")[0].innerHTML
		+"&user_mobile="+$("#mobile").val()
		+"&real_name="+$("#realName").val()
	}
}

//去提现
function goWithdraw(){
	
	window.location.href = "ump_money_cash.jsp";
	
}













