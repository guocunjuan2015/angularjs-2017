//页面定义html字体大小
(function (doc,win) {
	var clientWidth;
	var docEl = doc.documentElement,
        resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
    recalc = function (){
        clientWidth = docEl.clientWidth;
        if (!clientWidth) {return ;}
    	docEl.style.fontSize = 10 * (clientWidth / 375) +"px";
    };
    if(!doc.addEventListener) return;
    win.addEventListener(resizeEvt,recalc,false);
    doc.addEventListener('DOMContentLoaded',recalc,false);
})(document,window);
//.toLocaleString()加逗号
var userId = $("#userId").val();
var userName = $("#userName").val();
$(document).ready(function(e) {
	//开启联动、实名、绑卡、开通免密协议、联系人认证、已认证
	enableUMP = -1;
	UMPRegistered = false;
	liandongBankcard = false;
	repaymentPasswordFree = false;
	personalInformation = false;
	certified = false;
	//是否实名、绑卡、开通免密协议
	authentication();
	//信息认证
	information();
});
var loanMoney = parseInt($("#scrollBarTxt").text());
var period = $("#period").text();
//利息   借款金额*借款天数*标的年化利率/365
var interest = (loanMoney * period * 6 / 100) / 365;
interest = interest.toFixed(2);
//审核费   (借款金额*借款天数*借款日利率 - 利息)*74%
var review = (loanMoney * period * 0.4762 / 100 - interest) * (74 / 100);
review = review.toFixed(2);
//通道费   (借款金额*借款天数*借款日利率 - 利息)*26%
var path = (loanMoney * period * 0.4762 / 100 - interest) * (26 / 100);
path = path.toFixed(2);
//实际到帐
var actualArrival = loanMoney - review - path;
actualArrival = actualArrival.toFixed(2);
//到期应还
var due = Number(loanMoney) + Number(interest);
due = due.toFixed(2);
$(".reviewMoney").text('审核费(元)：'+review);
$(".pathMoney").text('通道费(元)：'+path);
$(".interestMoney").text('利息(元)：'+interest);
//弹出框数据 
$(".loanMoneyP span").text(loanMoney);
$(".actualArrival span").text(actualArrival);
$(".due span").text(due);
//是否实名、绑卡、开通免密协议
function authentication (){
	$.ajax({
		type : "POST",
		url : "ump/check/register/status.do",
		data : {},
		success : function(response) {
			if (response.success) {
				$(".loading").hide();
				var info = $.parseJSON(response.result);
				var data = info.resultObject;
				openNoPassword = data.noPassWordInvest;
				// 检查联动开启时间
				if ("1" == data.liandongStart) {// 联动已经开启
					enableUMP = 1;
					// 检查注册状态
					if ("1" == data.liandongRegister) {
						UMPRegistered = true;
					} else {
						UMPRegistered = false;
					}
					if ("1" == data.liandongBankcard) {
						liandongBankcard = true;
					} else {
						liandongBankcard = false;
					}
					if ("1" == data.repaymentPasswordFree) {
						repaymentPasswordFree = true;
					} else {
						repaymentPasswordFree = false;
					}
				} else {// 联动时间未开启
					enableUMP = 0;
				}
			}
		},
		dataType : "json"
	});
		
};
//是否填写信息认证
function information (){
	$.ajax({
		type : "POST",
		url : "user/credit/userAuthenInfo.do",
		data : { },
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if(info.result == 1){
					var data = info.resultObject;
					if(data == undefined || data == ""){
						personalInformation = false;
					}else{
						if(data.status == '00' && data.contacts == null){
							personalInformation = false;
						}else if(data.status == '01'){
							personalInformation = true;
						}else if(data.status == '02'){
							personalInformation = true;
							certified = true;
						}else{
							personalInformation = false;
						}
					}
				}else{
					personalInformation = false;
				}
			}else{
				personalInformation = false;
			}
		},
		error : function (){
			
		}
	});
}

//一键借款function
function keyBorrowing (){
	//判断是否登录
	if(userId == "null" || userId  == ""){
		window.location.href = "login.jsp?reflect_url=loan.jsp";
		return;
	};
	if (1 == enableUMP) {
		// 是否实名
		if (this.UMPRegistered) {
			// 是否绑卡
			if (this.liandongBankcard) {
				// 是否开通免密协议
				/*if (this.repaymentPasswordFree) {*/
					// 信息是否认证
					if(this.personalInformation){
						if(this.certified){
							$(".loanDirlog").show();
							$(".promptMoney").show();
						}else{
							window.location.href = 'loan_authentication.jsp';
						}
					}else{
						window.location.href = 'personalInfo.jsp';
					}
				/*} else {
					// 提示开通免密协议
					$(".loanDirlog").show();
					$(".msgTxt2").show();
				}*/
			} else {
				// 提示联动绑卡
				$(".loanDirlog").show();
				$(".msgTxt").show();
				$(".msgTxt p.p1").html("还有一步之遥，请绑定银行卡");
				$(".msgTxt p.p2 a").html("绑定银行卡");
				$(".msgTxt p.p2 a").attr("href","add_bankcard.jsp");
			}

		} else {
			$(".loanDirlog").show();
			$(".msgTxt").show();
			$(".msgTxt p.p1").html("请先进行实名认证");
			$(".msgTxt p.p2 a").html("立即认证");
			$(".msgTxt p.p2 a").attr("href","ump_real_register.jsp");
		}
	}
};
function fixedLoan (){
	$.ajax({
		type : "POST",
		url : "project/credit/apply.do",
		dataType : "json",
		data : JSON.stringify({
			amount : $("#scrollBarTxt").text(),
			goodId : '10006',
			loanPeriod : $("#period").text(),
			projectType : '200',
			repaymentWay : '306'
		}),
		success : function( response ) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if(info.result =="1"){
					// 成功信息
					$(".promptMoney").hide();
					$(".success").show();
				}else{
					// 失败信息
					$(".fail p.failP").html(info.errInfo);
					$(".loanDirlog").show();
					$(".fail").show();
				}
			}
		},
		error:function (response){
			// 失败信息
			$(".loanDirlog").show();
			$(".fail").show();
		}
	})
}
//弹出框关闭
$(".closeMsg").click(function (){
	$(".loanDirlog").hide();
	$(".msgTxt2").hide();
});
$(".closeMsg2").click(function (){
	$(".loanDirlog").hide();
	$(".success").hide();
});
$(".closeMsg4").click(function (){
	$(".loanDirlog").hide();
	$(".promptMoney").hide();
});
$(".closeMsg3").click(function (){
	$(".loanDirlog").hide();
	$(".fail").hide();
});
function gorepaymentPasswordFree () {
	window.location.href = 'secret_agreement.jsp?from=app1&user='+userName+'&userId='+userId;
}
function seeMyLoan(){
	if(userId == "null" || userId  == ""){
		window.location.href = "login.jsp";
	}else{
		window.location.href = "my_loan.jsp";
	}
}
