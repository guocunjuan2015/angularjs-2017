var account_money = 0;
var checked = true;
var isShow = false;
var mySwitch =  new Switchery($('#checks')[0], {
});
/*$(function(){
	main();
});*/

function main(){
	var clickCheckbox = document.querySelector('.js-switch');
	checked = clickCheckbox.checked;
	btnClickBind();
	getConstantData();
}

function btnClickBind(){
	var clickCheckbox = document.querySelector('.js-switch');
	clickCheckbox.addEventListener('click', function() {
		checked = clickCheckbox.checked;
		var sessionStorage = window.sessionStorage;
		sessionStorage.setItem("checked", checked);
	});
}

function saveRemain(){
	var remain = $("#remain_money").val();
	var sessionStorage = window.sessionStorage;
	sessionStorage.setItem("autoRemain", remain);
}
function saveMinInvest(){
	var minInvest = $("#min_money").val();
	var sessionStorage = window.sessionStorage;
	sessionStorage.setItem("minInvest", minInvest);
}
function saveMaxInvest(){
	var maxInvest = $("#max_money").val();
	var sessionStorage = window.sessionStorage;
	sessionStorage.setItem("maxInvest", maxInvest);
}
function showBg() {
	if (isShow) {
		isShow = false;
		$("#bg").css({
			display : "none",
			height : $(document).height()
		});
		$("#illus").css({
			display : "none"
		});
	} else {
		isShow = true;
		$("#bg").css({
			display : "block",
			height : $(document).height()
		});
		$("#illus").css({
			display : "block"
		});
	}
}

function getConstantData() {
	$.ajax({
		type : "POST",
		url : "account/autoinvest/constant/get.do",
		data : {
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					var data = info.resultObject;
					account_money = data.accountBalance;
					$("#account_balance")[0].innerHTML = "￥"+data.accountBalance +"元";
					addDataToPage(data);
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
function addDataToPage(data){
	var sessionStorage = window.sessionStorage;
    /*页面输入数据*/
	if(sessionStorage.getItem("autoRemain")){
		$("#remain_money").val(sessionStorage.getItem("autoRemain"));
	}
	if(sessionStorage.getItem("checked")){
		if(sessionStorage.getItem("checked") == "true"){
			setSwitchery(mySwitch, true);//开启
		}
		if(sessionStorage.getItem("checked") == "false"){
			setSwitchery(mySwitch, false);//开启
		}
		
	}
	if(sessionStorage.getItem("maxInvest")){
		$("#max_money").val(sessionStorage.getItem("maxInvest"));
	}
	if(sessionStorage.getItem("minInvest")){
		$("#min_money").val(sessionStorage.getItem("minInvest"));
	}
	/*投标方式*/
	
	if (sessionStorage.getItem("autoWayLabel")) {
        $("#auto_invest_way")[0].innerHTML = sessionStorage.getItem("autoWayLabel");
        $("#auto_invest_way_value").val(sessionStorage.getItem("autoWayValue"));
        if(parseInt(sessionStorage.getItem("autoWayValue")) == 1){
        	$("#max_li")[0].style.display = "";
        	$("#min_li")[0].style.display = "";
        }
	}else if(data.auto_bid_invest_type){
		var info = data.auto_bid_invest_type;
		$("#auto_invest_way")[0].innerHTML = info[0].label;
		$("#auto_invest_way_value").val(info[0].value);
	}
	
	/*投标种类*/
	if (sessionStorage.getItem("autoTypeLabel")) {
        $("#auto_invest_type")[0].innerHTML = sessionStorage.getItem("autoTypeLabel");
        $("#auto_invest_type_value").val(sessionStorage.getItem("autoTypeValue"));
	}else if(data.auto_bid_loan_type){
		var info = data.auto_bid_loan_type;
		$("#auto_invest_type")[0].innerHTML = info[0].label;
		$("#auto_invest_type_value").val(info[0].value);
	} 
	/*还款方式*/ 
	if (sessionStorage.getItem("autoRepayWayLabel")) {
        $("#repayment_way")[0].innerHTML = sessionStorage.getItem("autoRepayWayLabel");
        $("#repayment_way_value").val(sessionStorage.getItem("autoRepayWayValue"));
	}else if(data.auto_bid_repayment_way_type){
		var info = data.auto_bid_repayment_way_type;
		$("#repayment_way")[0].innerHTML = info[0].label;
		$("#repayment_way_value").val(info[0].value);
	}
	/*借款期限*/
	if (sessionStorage.getItem("autoPeriodValue")) {
        $("#auto_invest_period")[0].innerHTML = sessionStorage.getItem("autoPeriodLabel");
        $("#auto_period_value").val(sessionStorage.getItem("autoPeriodValue"));
	}else if(data.auto_bid_loan_period){
		var info = data.auto_bid_loan_period;
		$("#auto_invest_period")[0].innerHTML = info[0].label;
		$("#auto_period_value").val(info[0].value);
	}
	/*预期收益*/
	if (sessionStorage.getItem("autoRateFrom") || sessionStorage.getItem("autoRateTo")) {
		var from = "";
		var to = "";
		if(sessionStorage.getItem("autoRateFrom")){
			from = sessionStorage.getItem("autoRateFrom");
		}
		if(sessionStorage.getItem("autoRateTo")){
			to = sessionStorage.getItem("autoRateTo");
		}
        $("#auto_rate")[0].innerHTML = from+"% ~ "+to+"%";
        $("#auto_rate_choosed").val(false);
        $("#auto_rate_from").val(from);
        $("#auto_rate_to").val(to);
	}else{
		$("#auto_rate")[0].innerHTML = "不限制";
		$("#auto_rate_choosed").val(true);
        $("#auto_rate_from").val("");
        $("#auto_rate_to").val("");
	}
}

function investWay(){
	window.location.href = "auto_invest_way.jsp?retUrl=auto_invest_edit.jsp";
}
function toSetType(){
	window.location.href = "auto_invest_type.jsp?retUrl=auto_invest_edit.jsp";
}
function toSetRepayWay(){
	window.location.href = "auto_invest_repayment_way.jsp?retUrl=auto_invest_edit.jsp";
}
function toSetAutoPeriod(){
	window.location.href = "auto_invest_period.jsp?retUrl=auto_invest_edit.jsp";
}
function toSetAutoRate(){
	window.location.href = "auto_invest_rate.jsp?retUrl=auto_invest_edit.jsp";
}

function saveSet() {
	$("#save_set").attr("disabled",true);
	if (check()) {
		$.ajax({
			type : "POST",
			url : "account/autoinvest/set/save.do",
			data : {
				autoBidId : "",
				enable : checked,
				reserve : $("#remain_money").val(),
				investType : $("#auto_invest_way_value").val(),
				investMin : $("#min_money").val(),
				investMax : $("#max_money").val(),
				projectType : $("#auto_invest_type_value").val(),
				repaymentWay : $("#repayment_way_value").val(),
				period : $("#auto_period_value").val(),
				isNoLimitRate : $("#auto_rate_choosed").val(),
				rateMin : $("#auto_rate_from").val(),
				rateMax : $("#auto_rate_to").val()
			},
			success : function(response) {
				if (response.success) {
					var info = $.parseJSON(response.result);
					if (info.result) {
						//location.href=document.referrer;
						//history.go(-1);
						window.location.replace(getRequestParam("retUrl"));
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
	$("#save_set").attr("disabled",false);
}
function check(){
	var remain_money = $("#remain_money")[0].value;
	if (!checkStr(remain_money, regexes.float)) {
		errorMsg("请正确账户保留金额");
		return false;
	}
	if(parseInt($("#auto_invest_way_value").val()) == 1){
		var min_money = $("#min_money")[0].value;
		if (!checkStr(min_money, regexes.float)) {
			errorMsg("请正确填写单笔最低投标额");
			return false;
		}
		var max_money = $("#max_money")[0].value;
		if (!checkStr(max_money, regexes.float)) {
			errorMsg("请正确填写单笔最高投资额");
			return false;
		}
	}
	if ( remain_money>account_money) {
		errorMsg("保留金额应小于账户余额");
		return false;
	}
	return true;
}
function setSwitchery(switchElement, checkedBool) {//设置checkbox状态
    if((checkedBool && !switchElement.isChecked()) || (!checkedBool && switchElement.isChecked())) {
    	switchElement.setPosition(true);
    	checked = checkedBool;
        /*switchElement.handleOnchange(true);*/
    }
}