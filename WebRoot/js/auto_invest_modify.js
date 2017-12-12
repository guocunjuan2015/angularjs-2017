var account_money = 0;
var checked = true;
var isShow = false;
var autoBidId = "";
var mySwitch =  new Switchery($('#checks')[0], {
});
var sessionStorage = window.sessionStorage;
 
function main(){
	autoBidId = getRequestParam("id");
	btnClickBind();
	var clickCheckbox = document.querySelector('.js-switch');
	checked = clickCheckbox.checked;
	getLastData();
}

function btnClickBind(){
	var clickCheckbox = document.querySelector('.js-switch');
	clickCheckbox.addEventListener('click', function() {
		checked = clickCheckbox.checked;
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
/*获取默认数据*/
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

/*获取用户设置数据*/
function getLastData(){
		$.ajax({
			type : "POST",
			url : "account/autoinvest/set/query.do",
			data : {
				autoBidId : autoBidId
			},
			success : function(response) {
				if (response.success) {
					var info = $.parseJSON(response.result);
					if (info.result) {
						 var data = info.resultObject;
						 addDataToSession(data);
						 //加载默认
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
function addDataToSession(data){
//Checks the switch
if(sessionStorage.getItem("checked")){
	if(sessionStorage.getItem("checked") == "true"){
		setSwitchery(mySwitch, true);//开启
	}else if(sessionStorage.getItem("checked") == "false"){
		setSwitchery(mySwitch, false);//关闭
	}
}else{
	setSwitchery(mySwitch, data.enable);//开启
}
if(sessionStorage.getItem("autoRemain")){
	$("#remain_money").val(sessionStorage.getItem("autoRemain"));
}else{
	$("#remain_money").val(data.reserve);
}
if(sessionStorage.getItem("minInvest")){
	$("#min_money").val(sessionStorage.getItem("minInvest"));
}
if(sessionStorage.getItem("maxInvest")){
	$("#max_money").val(sessionStorage.getItem("maxInvest"));
}
if(sessionStorage.getItem("autoWayValue")){
	
}else{
	sessionStorage.setItem("autoWayValue", data.investType);
	sessionStorage.setItem("autoWayLabel", data.investType_label);
	if (data.investType == 1) {
		$("#min_money").val(data.investMin);
		$("#max_money").val(data.investMax);
		sessionStorage.setItem("minInvest",data.investMin);
		sessionStorage.setItem("maxInvest",data.investMax);
	}
}
if(sessionStorage.getItem("autoTypeValue")){
}else{
	sessionStorage.setItem("autoTypeValue", data.projectType);
	sessionStorage.setItem("autoTypeLabel", data.projectType_label);
}
if(sessionStorage.getItem("autoRepayWayValue")){
}else{
	sessionStorage.setItem("autoRepayWayValue", data.repaymentWay);
	sessionStorage.setItem("autoRepayWayLabel", data.repaymentWay_label);
}


if(data.isNoLimitPeriod){
}else{
	if(sessionStorage.getItem("autoPeriodValue")){
	}else{
		sessionStorage.setItem("autoPeriodValue",data.period);
		sessionStorage.setItem("autoPeriodLabel",data.period_label);
	}
}
if(data.isNoLimitRate){
}else{
	if(sessionStorage.getItem("autoRateFrom") || sessionStorage.getItem("autoRateTo")
			|| sessionStorage.getItem("autoRateLimit")){
	}else{
		sessionStorage.setItem("autoRateFrom",data.rateMin);
		sessionStorage.setItem("autoRateTo",data.rateMax);
	}
	
}
getConstantData();
};

function setSwitchery(switchElement, checkedBool) {//设置checkbox状态
    if((checkedBool && !switchElement.isChecked()) || (!checkedBool && switchElement.isChecked())) {
    	switchElement.setPosition(true);
    	checked = checkedBool;
        /*switchElement.handleOnchange(true);*/
    }
}
function addDataToPage(data){
	/*投标方式*/
	if (sessionStorage.getItem("autoWayLabel")) {
        $("#auto_invest_way")[0].innerHTML = sessionStorage.getItem("autoWayLabel");
        $("#auto_invest_way_value").val(sessionStorage.getItem("autoWayValue"));
        if(parseInt(sessionStorage.getItem("autoWayValue")) == 1){
        	$("#max_li")[0].style.display = "";
        	$("#min_li")[0].style.display = "";
        	if(sessionStorage.getItem("maxInvest")){
        		$("#max_money").val(sessionStorage.getItem("maxInvest"));
        	}
            if(sessionStorage.getItem("minInvest")){
            	$("#min_money").val(sessionStorage.getItem("minInvest"));
        	}
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
	window.location.href = "auto_invest_way.jsp?retUrl=auto_invest_modify.jsp?id="+getRequestParam("id");
}
function toSetType(){
	window.location.href = "auto_invest_type.jsp?retUrl=auto_invest_modify.jsp?id="+getRequestParam("id");
}
function toSetRepayWay(){
	window.location.href = "auto_invest_repayment_way.jsp?retUrl=auto_invest_modify.jsp?id="+getRequestParam("id");
}
function toSetAutoPeriod(){
	window.location.href = "auto_invest_period.jsp?retUrl=auto_invest_modify.jsp?id="+getRequestParam("id");
}
function toSetAutoRate(){
	window.location.href = "auto_invest_rate.jsp?retUrl=auto_invest_modify.jsp?id="+getRequestParam("id");
}

function saveSet() {
	$("#save_set").attr("disabled",true);
	if (check()) {
		$.ajax({
			type : "POST",
			url : "account/autoinvest/set/save.do",
			data : {
				autoBidId : autoBidId,
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
function deleteRule(){
	$.ajax({
		type : "POST",
		url : "account/autoinvest/rule/delete.do",
		data : {
			autoBidId:autoBidId
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
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