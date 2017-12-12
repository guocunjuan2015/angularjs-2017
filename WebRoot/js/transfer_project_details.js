var max_money = 0;
var min_money = 0;
var project_type = 0;
var account_banlance = 0;
var period = 0;
var loanRate = 0;
var isTransfer = "";
var mMultiple = 1;
$(function() {
	project_id = getRequestParam("id");
	isTransfer = getRequestParam("isTransfer");
	from = getRequestParam("from");
	initData();
	checkUMPRegisterWhileLogin();
	getProjectDetails();
	getBreviary();
});

function initData() {
	if ("weixin" == from) {
		$("#project_type")[0].style.display = "block";
		$("#footpanel")[0].style.display = "block";
	}else {
	}
	project_id = getRequestParam("id");
	project_info = getRequestParam("project_info");
	if(project_info){
		var pj_info = $.parseJSON(project_info);
		project_type = parseInt(pj_info.projectType);
		period = parseInt(pj_info.loan_period);
		loanRate = parseFloat(pj_info.loan_rate);
	}
}

function getProjectDetails(){
	$.ajax({
		type : "POST",
		url : "project/more/transfer/details/get.do",
		data : {id:getRequestParam("id")},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
                   initProjectInfo(info.resultObject);
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

function initInvestButton(st){//初始化投资按钮样式
	if(2 == st){
		// 可投
		$("#button_invest")[0].innerHTML = "马上赚钱";
	}else{
		$("#invest_number").attr("readOnly", true);
		$("#button_invest").attr("disabled",true);
		$("#button_invest").css("background-color","#666");
		switch (st) {
		case 4:
		case 5:
		case 12:
			$("#button_invest")[0].innerHTML = "回款中";
			break;
		case 7:
			$("#button_invest")[0].innerHTML = "已结清";
			break;
		case 9:
			$("#button_invest")[0].innerHTML = "敬请期待";
			break;
		case 3:
		case 6:
			$("#button_invest")[0].innerHTML = "流标";
			break;
		}
		
	}
}

function initProjectInfo(data){
	if (data.multiple) {
		mMultiple = parseInt(data.multiple);
	}
	if(data.projectMinNum){
		min_money = parseInt(data.projectMinNum);
		document
		.getElementById("invest_number")
		.setAttribute(
				"placeholder",
				"起投金额"
						+ min_money);
	}
	if(data.projectName){
		$("#pj_intro_h1")[0].style.display = "";
		$("#project_name")[0].innerHTML = data.projectName;
	}
	if(data.legalName){//转让人
		$("#zrr_tr")[0].style.display = "";
		$("#zrr")[0].innerHTML = data.legalName;
	}
	if(data.remarks){//转让说明
		$("#zr_ills_tr")[0].style.display = "";
		$("#zr_ills")[0].innerHTML = data.remarks;
	}
	if(data.nper){//期数
		$("#qs")[0].style.display = "";
		$("#qs_val")[0].innerHTML = data.nper + "期";
	}
	if(data.principalInterest){//应收本息
		$("#ysbx")[0].style.display = "";
		$("#ysbx_val")[0].innerHTML = data.principalInterest +"元";
	}
	if(data.status){//初始化投资按钮样式
		var st = parseInt(data.status);
		initInvestButton(st);
	}
	// 设置space——div占位的宽度
	$("#space_div").css("height", $("#footpanel").height());
	if(data.loanAmount){
		$("#yybj")[0].style.display = "";
		$("#yybj_val")[0].innerHTML = data.loanAmount;
	}
	if(data.income){
		$("#yybx")[0].style.display = "";
		$("#yybx_val")[0].innerHTML = data.income +"元";
	}
	
	if(data.paymentList){
		addDataToTable(data.paymentList);
	}
}
function addDataToTable(data){
	var table = $("#table");
	table[0].innerHTML = "";
	var row = '';
	row += '<tr><th>期次</th><th>收款日</th><th>还款情况</th></tr>';
	table.append(row);
	for(var i = 0;i<data.length;i++){
		var row = '';
		row += '<tr><td>';
		row += parseInt(data[i].id)+1;
		row += '</td><td>';
		row += data[i].paymentDate;
		row += '</td><td>';
		row += data[i].staus;
		row + '</td></tr>';
		table.append(row);
	}
}

function showPic (whichpic) {  
	if (document.getElementById) {   
	document.getElementById('placeholder').src = whichpic.href;
	if (whichpic.title) {    
	document.getElementById('desc').childNodes[0].nodeValue = whichpic.title;
	} else {    
	document.getElementById('desc').childNodes[0].nodeValue = whichpic.childNodes[0].nodeValue;
	}   return false;  
	} else {   
	return true;  
	} }

function addDataToContent(data,data2){
	var table = $("#list_content");
	table[0].innerHTML = "";
	var rest = 0;
 
	if(data){
		for(var i = 0;i<data.length;i++){
			var row = '';
			if(i!=0 && (i+1)%4 == 0){
				row += '<li class="lastli">';
			}else{
				row += '<li>';
			}
			row += '<a <a  href="';
			row += data[i];
			row += '" class="lightbox">';
			row += '<img src="';
			row += "register/verify/breviary.do?link="+data[i].replace("http://www.rqbao.com","");
			row += '"/></a></li>';
			table.append(row);
		}
	}
 
}

function getBreviary(){
	$("#aaa").attr("src", "register/verify/breviary.do");
}

function toRecharge() {
	window.location.href = "ump_money_recharge.jsp";
}

function changeInvest(value) {
	var rate = loanRate;
	var date = this.period;
	var income = 0.00;

	if (parseFloat(value) > this.account_banlance) {
		errorMsg("余额不足，请先去充值");
	} else if (isTransfer != "true" && (parseFloat(value) > max_money)) {
		var max = parseInt(max_money);
		var min = parseInt(min_money);
		errorMsg("填写金额应当在[" + formatCurrency(min) + "]元和["
				+ formatCurrency(max) + "]元之间");
	} else {
		errorMsg("");
	}

	// 计算预期收入（包含配资金额的利息）
	if(isTransfer == "true"){//债权转让计息
		if ($("#project_type")[0].innerHTML == "122" || project_type == 122) {
			var storage = window.localStorage;
			if (period == 3) {
				if(storage.getItem("PZRate3")){
					income = value * (1+parseFloat(storage.getItem("PZRate3"))) * rate * period / 30.0 / 1200;
				}
			}else if (period == 6) {
				if(storage.getItem("PZRate6")){
					income = value * (1+parseFloat(storage.getItem("PZRate6"))) * rate * period / 30.0 / 1200;
				}
			} else if (period == 12) {
				if(storage.getItem("PZRate12")){
					income = value * (1+parseFloat(storage.getItem("PZRate12"))) * rate * period / 30.0 / 1200;
				}
			} else if (period == 24) {
				if(storage.getItem("PZRate24")){
					income = value * (1+parseFloat(storage.getItem("PZRate24"))) * rate * period / 30.0 / 1200;
				}
			}
		} else {
			income = value * rate * period /30.0/1200;
		}
	}else{
		if ($("#project_type")[0].innerHTML == "122" || project_type == 122) {
			var storage = window.localStorage;
			if (period == 3) {
				if(storage.getItem("PZRate3")){
					income = value * (1+parseFloat(storage.getItem("PZRate3"))) * rate * period / 1200;
				}
			}else if (period == 6) {
				if(storage.getItem("PZRate6")){
					income = value * (1+parseFloat(storage.getItem("PZRate6"))) * rate * period / 1200;
				}
			} else if (period == 12) {
				if(storage.getItem("PZRate12")){
					income = value * (1+parseFloat(storage.getItem("PZRate12"))) * rate * period / 1200;
				}
			} else if (period == 24) {
				if(storage.getItem("PZRate24")){
					income = value * (1+parseFloat(storage.getItem("PZRate24"))) * rate * period / 1200;
				}
			}
		} else {
			income = value * rate * period / 1200;
		}
	}
	$("#epxt_income")[0].innerHTML = formatCurrency(income.toFixed(2));
}

function checkStatus() {
	$
			.ajax({
				type : "POST",
				url : "account/detail/get.do",
				data : {},
				success : function(response) {
					if (response.success) {
						var info = $.parseJSON(response.result);
						if (info.result) {
							// 已经登录,进行检查
							account_banlance = info.resultObject.b;
							$("#yue_span")[0].innerHTML = account_banlance;
							checkStatusDetails();//检查后的操作
							
						}
					} else {
						if (isEmpty(response.result)) {
						} else {
							window.location.href = response.result
									+ "?reflect_url="
									+ encodeURIComponent("project_other_content.jsp?id="
											+ getRequestParam("id"))+"&isTransfer="+isTransfer;
						}
						$("#button_invest").attr("disabled", false);
					}
				},
				dataType : "json"
			});
}
function checkStatusDetails(){
	if(enableUMP == 1){
		if(liandongRegister){
			if(liandongBankcard){
				//检查ok，可以输入金额
				$("#baozh_div")[0].style.display = "none";
				$("#yue_div")[0].style.display = "block";
				$("#epxt_div")[0].style.display = "block";
			}else{
				//提示去联动绑卡
				$("#msg_btn_0")[0].style.display = "none";
				$("#msg_btn_1")[0].style.display = "none";
				$("#msg_btn_2")[0].style.display = "none";
				$("#msg_btn_3")[0].style.display = "none";
				$("#msg_btn_4")[0].style.display = "block";
				$("#msg_btn_5")[0].style.display = "none";
				$("#tip_content")[0].innerHTML = "请先绑定银行卡，再进行资金交易";
				$('#myModal').on('shown.bs.modal',
						function() {
							$('#myInput').focus();
						});
				$('#myModal').modal('toggle');
				$('#myModal')[0].click();
			}
		}else{
			//提示去联动开户
			$("#msg_btn_0")[0].style.display = "none";
			$("#msg_btn_1")[0].style.display = "none";
			$("#msg_btn_2")[0].style.display = "none";
			$("#msg_btn_3")[0].style.display = "none";
			$("#msg_btn_4")[0].style.display = "none";
			$("#msg_btn_5")[0].style.display = "block";
			var table = $("#tip_content");
			table[0].innerHTML = "";
			var row = '';
			row += "根据《关于促进互联网金融健康发展的指导意见》的要求，为平台用户提供更好、更安全、更规范的服务，瑞钱宝与联动优势合作，安全再升级。现将用户账户资金交由中信银行存管，";
			row += '<font style="color:#f64840;">需要您重新进行实名认证和绑定银行卡，请尽快操作</font>';
			row += "，以免影响您的正常使用，感谢您对平台的支持，给您带来的不变敬请谅解，如有任何疑问请致电客服：400-9198-555";
			table.append(row);
			$('#myModal').on('shown.bs.modal',
					function() {
						$('#myInput').focus();
					});
			$('#myModal').modal('toggle');
			$('#myModal')[0].click();
		}
	} 
}

function checkUMPRegisterWhileLogin() {
	$("#button_invest").attr("disabled", true);
	$("#invest_number").attr("readOnly", true);
	$.ajax({
		type : "POST",
		url : "ump/check/registerwhilelogin/status.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				var data = info.resultObject;
				// 检查联动开启时间
				if ("1" == data.liandongStart) {// 联动已经开启
					enableUMP = 1;
					// 检查注册状态
					if ("0" == data.liandongRegister) {
						liandongRegister = false;
						// 提示去联动注册
					} else {
						// 已经在联动开户
						liandongRegister = true;
					}
					if ("1" == data.liandongBankcard) {
						liandongBankcard = true;
						// 联动已经绑卡，
					} else {
						liandongBankcard = false;
					}
				} else {// 联动时间未开启
					enableUMP = 0;
				}
			} else {
				if (isEmpty(response.result)) {
					errorMsg(response.msg);
				}
			}
		},
		dataType : "json"
	});
	$("#button_invest").attr("disabled", false);
	$("#invest_number").attr("readOnly", false);
}

function check() {
	var money = $("#invest_number")[0].value;

	var max = parseInt(max_money);
	var min = parseInt(min_money);

	if (!checkStr(money, regexes.float)) {
		errorMsg("请正确填写投资金额");
		return false;
	}

	if (money % mMultiple != 0) {
		errorMsg("投资金额必须为" + mMultiple + "的整数倍");
		return false;
	}
	if (isTransfer != "true") {
		if (money < min || money > max) {
			errorMsg("填写金额应当在[" + formatCurrency(min) + "]元和["
					+ formatCurrency(max) + "]元之间");
			return false;
		}
	} else {
		if (money < min) {
			errorMsg("填写金额应当大于起投金额" + formatCurrency(min) + "元");
			return false;
		}
	}
	if (money > parseFloat(account_banlance)) {
		errorMsg("余额不足，请您先去充值!");
		return false;
	}

	return true;
}
function invest(){
	if (check() && enableUMP!=-1) {
		window.location.href = "project_invest.jsp?invest_money="
				+ $("#invest_number").val()
				+ "&enableUMP="
				+ enableUMP
				+ "&project_type="
				+ project_type
				+ "&project_id="
				+ getRequestParam("id")
				+ "&period="
				+ period
				+ "&loanRate=" + loanRate;
	}
}