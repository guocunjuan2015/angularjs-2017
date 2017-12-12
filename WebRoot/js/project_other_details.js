var max_money = 0;
var min_money = 0;
var rest_money = 0;
var project_type = 0;
var account_banlance = 0;
var period = 0;
var loanRate = 0;
var isTransfer = "";
var mMultiple = 1;
var userName = "";
var isNeedContribution = "";
var needRecharge = 0;
$(function() {
	from = getRequestParam("from");
	isTransfer = getRequestParam("isTransfer");
	initData();
	checkUMPRegisterWhileLogin();
	if(isTransfer == "true"){
		//getTransferDetails();
		getProjectDetails();
	}else{
		getProjectDetails();
	}
	getBreviary();
});

function initData() {
	if ("weixin" == from) {
		/*$("#project_type")[0].style.display = "block";*/
		$("#footpanel")[0].style.display = "block";
	}else {
		project_type = getRequestParam("projectType");
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

function tabClick(index){
	for(var i = 1;i<= 3;i++){
		$("#tab"+i).removeClass("active");
		$("#page"+i)[0].style.display = "none";
	}
	$("#tab"+index).addClass("active");
	$("#page"+index)[0].style.display = "block";
}

function getProjectDetails(){
	$.ajax({
		type : "POST",
		url : "project/more/details/get.do",
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

function initProjectInfo(data){
	if(data.isNeedContribution){
		isNeedContribution = data.isNeedContribution;
	}
	if (data.multiple) {
		mMultiple = parseInt(data.multiple);
	}
	if(data.x.mortgageInfo){
		$("#dyw_info")[0].innerHTML = data.x.mortgageInfo;
	}else{
		
	}
	if(data.buyMaxNum && data.buyMinNum){
		max_money = data.buyMaxNum;
		min_money = data.buyMinNum;
		document
		.getElementById("invest_number")
		.setAttribute(
				"placeholder",
				"起投金额"
						+ data.buyMinNum);
	}
	if(data.projectBalance){//项目剩余金额
		rest_money = data.projectBalance;
	}else{
		rest_money = min_money;
	}
	
	if(data.projectName){
		$("#head_pj_name")[0].style.display = "";
		$("#project_name")[0].innerHTML = data.projectName;
	}
	if(data.loanPeriod){
		$("#fb_period")[0].style.display = "";
	}
	if(project_type == "111"){
		$("#project_period")[0].innerHTML = data.loanPeriod+ "天";
		$("#repay_way")[0].innerHTML = "到期还本付息";
	}else{
		$("#exit_way")[0].style.display = "";
		$("#project_period")[0].innerHTML = data.loanPeriod+ "个月";
	}
	
	if(data.loanRate){
		$("#epct_income_per_year")[0].style.display = "";
		$("#project_rate")[0].innerHTML = data.loanRate+"%";
	}
	
	if(data.buyMinNum){
		$("#qt_money")[0].style.display = "";
		$("#min_invest")[0].innerHTML = data.buyMinNum+"元";
	}
	if(data.m){
		if(data.m.moneyPurpose){
			$("#finc_use_tr")[0].style.display = "";
			$("#fin_use")[0].innerHTML = data.m.moneyPurpose;//资金用途
		}
		if(data.m.repaySource){
			$("#hk_resource")[0].style.display = "";
			$("#pay_resource")[0].innerHTML = data.m.repaySource;//还款来源
		}
		
		if(data.m.mortgageInfo){
			$("#mortgageInfo_td")[0].style.display = "";
			$("#mortgageInfo")[0].innerHTML = data.m.mortgageInfo;//抵押物信息
		}
	}
	if(data.loanStatus){
		var st = parseInt(data.loanStatus);
		initInvestButton(st);
	}
	$("#space_div").css("height", $("#footpanel").height());
	if(data.projectDescription){
		$("#type_info_p")[0].innerHTML = data.projectDescription;
	}
	if(data.x.enterList || data.x.predgeList){
		$("#pjt_pic_info")[0].style.display = "block";
	}
	if(data.x.enterList){
		addDataToContent(data.x.enterList,data.x.predgeList);
	}else{
		addDataToContent(data.x.predgeList,data.x.enterList);
	}
	
		if(data.x.guarantee){
			$("#bzh3_jig")[0].innerHTML = data.x.guarantee;
		}else{
			$("#bzh3_jig")[0].innerHTML = "无";
		}
		
		if(data.x.guaranteeDesc){
			$("#bzh3_jig_jj")[0].innerHTML = data.x.guaranteeDesc;
		}else{
			$("#bzh3_jig_jj")[0].innerHTML = "无";
		}
	if(data.x.保障措施一){
		$("#bzh1")[0].style.display = "block";
		$("#first_tp")[0].innerHTML = data.x.保障措施一;
	}
	if(data.x.保障措施二){
		$("#bzh2")[0].style.display = "block";
		$("#seconddtp")[0].innerHTML = data.x.保障措施二;
	}
	if(data.x.保障措施一 && !(data.x.保障措施二)){
		$("#bzh3_p")[0].style.display = "block";
		if(data.x.保障措施三){
			$("#bzh3_p")[0].innerHTML = "保障措施二";
			$("#bzh3_cont")[0].innerHTML = data.x.保障措施三;
		}
		
	}
	if(!(data.x.保障措施一) && data.x.保障措施二){
		$("#bzh2_p")[0].innerHTML = "保障措施一";
		if(data.x.保障措施三){
			$("#bzh3_p")[0].innerHTML = "保障措施二";
			$("#bzh3_cont")[0].innerHTML = data.x.保障措施三;
		}
	}
	if(data.x.保障措施一 && data.x.保障措施二){
		if(data.x.保障措施三){
			$("#bzh3_p")[0].innerHTML = "保障措施三";
			$("#bzh3_cont")[0].innerHTML = data.x.保障措施三;
		}
	}
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

function toSafeEnsure(){
	window.location.href = "safe_ensure.jsp";
}
function toRecharge() {
	window.location.href = "ump_money_recharge.jsp";
}

function changeInvest(value) {
	var rate = loanRate;
	var date = this.period;
	var income = 0.00;

	/*if (parseFloat(value) > this.account_banlance) {
		errorMsg("余额不足，请先去充值");
	} else if (isTransfer != "true" && (parseFloat(value) > max_money)) {
		var max = parseInt(max_money);
		var min = parseInt(min_money);
		errorMsg("填写金额应当在[" + formatCurrency(min) + "]元和["
				+ formatCurrency(max) + "]元之间");
	} else {
		errorMsg("");
	}*/

	// 计算预期收入（包含配资金额的利息）
	if(isTransfer == "true"){//债权转让计息
		if ($("#project_type").val() == "122" || project_type == 122) {
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
		if ($("#project_type").val() == "122" || project_type == 122) {
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
		}else if($("#project_type").val() == "111" || project_type == 111){
			income = value * rate * period / 100 /365;
		}  else {
			income = value * rate * period / 1200;
		}
	}
	$("#epxt_income")[0].innerHTML = formatCurrency(income.toFixed(2));
}

/*检查用户是否denglu*/
function checkStatus() {
	$("#button_invest").attr("disabled", false);
	$("#invest_number").attr("readOnly", false);
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
							if(info.resultObject.u){
								userName = info.resultObject.u;
							}
							
							if (isNeedContribution) {// 检查是否是约标项目
								if (iniCheckContribution()) {// 检查是否填写过约标密码
								} else {
									showAys();
								}
							} else {
								$("#baozh_div")[0].style.display = "none";
								$("#yue_div")[0].style.display = "block";
								$("#epxt_div")[0].style.display = "block";
								$("#space_div").css("height",
										$("#footpanel").height());
								if ($("#project_type").val() == "131"
										|| project_type == 131) {
									// 并购计划 此处不用计算预期收益
									$(".epxt")[0].innerHTML = "&nbsp;";
									$("#epxt_yuan")[0].innerHTML = "&nbsp;";
								}
							}
							//checkStatusDetails();//检查后的操作
						}
					} else {
						if (isEmpty(response.result)) {
						} else {
							window.location.href = response.result
									+ "?reflect_url="
									+ encodeURIComponent("project_other_content.jsp?id="
											+ getRequestParam("id")+"&isTransfer="+isTransfer);
						}
						$("#button_invest").attr("disabled", false);
					}
				},
				dataType : "json"
			});
}

function iniCheckContribution(){//check contribution password
	var pjObj = "";
	if(window.localStorage.getItem(getRequestParam("id"))){
		pjObj = window.localStorage.getItem(getRequestParam("id"));
		var info = $.parseJSON(pjObj);
		if(userName == info.user){
			if(getRequestParam("id") == info.id){
			}else{
				return false;
			}
		}else{
			return false;
		}
	}else{
		return false;
	}
	return true;
}
function checkContributionAndSave(){
	var psw = $("#ctPsw").val();
	if(isEmptyStr(psw)){
		errorMsg("请正确填写约标密码！");
		return false;
	}else{
		$("#checkCP").attr("disabled",true);
		$
		.ajax({
			type : "POST",
			url : "project/contribution/check.do",
			data : {
				projectId : getRequestParam("id"),
				password : psw
			},
			success : function(response) {
				$("#checkCP").attr("disabled",false);
				if (response.success) {
					var info = $.parseJSON(response.result);
					if (info.result) {
						var project = new Object();
						project.id = getRequestParam("id");
						project.user = userName;
					    var objStr = JSON.stringify(project);//将对象转化成json字符串
					    var s = window.localStorage;
					    s.setItem(getRequestParam("id"), objStr);
					    dismissAys();
					}else{
						$("#ctPsw").val("");
						$("#yb_content")[0].innerHTML = "";
						var row = '';
						row += '投标密码错误！请致电客服找回密码，客服电话 ';
						row += '<font style="text-decoration: underline;"> 400-9198-555</font>';
						$("#yb_content").append(row);
					}
				} else {
					if (isEmpty(response.result)) {
					} else {
						window.location.href = response.result
								+ "?reflect_url="
								+ encodeURIComponent("project_other_content.jsp?id="
										+ getRequestParam("id")
										+ "&isTransfer=" + isTransfer);
					}
				}
			},
			dataType : "json"
		});
	}
}

function checkStatusDetails(){
	if(enableUMP == 1){
		if(liandongRegister){
			if(liandongBankcard){
				/*if (isNeedContribution) {// 检查是否是约标项目
					if(iniCheckContribution()) {//检查是否填写过约标密码
						$("#button_invest").attr("disabled", false);
						$("#invest_number").attr("readOnly", false);
						$("#baozh_div")[0].style.display = "none";
						$("#yue_div")[0].style.display = "block";
						$("#epxt_div")[0].style.display = "block";
					} else {
						showAys();
					}
				} else {
				//检查ok，可以输入金额
					$("#button_invest").attr("disabled", false);
					$("#invest_number").attr("readOnly", false);
				$("#baozh_div")[0].style.display = "none";
				$("#yue_div")[0].style.display = "block";
				$("#epxt_div")[0].style.display = "block";
				}*/
				return true;
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
				return false;
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
			return false;
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
}

function check() {
	var money = $("#invest_number")[0].value;

	var max = parseInt(max_money);
	var min = parseInt(min_money);
	var rest = parseInt(rest_money);
	if (!checkStr(money, regexes.float)) {
		errorMsg("请正确填写投资金额");
		return false;
	}

	if (money % mMultiple != 0) {
		errorMsg("投资金额必须为" + mMultiple + "的整数倍");
		return false;
	}
	if ("true" != isTransfer) {
		if (rest < min) {
			if (money != rest) {
				errorMsg("项目最后一笔，只能一次性投资" + formatCurrency(rest) + "元");
				return false;
			}
		}else if(money < min){
			errorMsg("填写金额应当大于起投金额" + formatCurrency(min) + "元");
			return false;
		} else if (money > max) {
			errorMsg("填写金额应当在[" + formatCurrency(min) + "]元和["
					+ formatCurrency(max) + "]元之间");
			return false;
		}
	} else {
		if (rest < min) {
			if (money != rest) {
				errorMsg("项目最后一笔，只能一次性投资" + formatCurrency(rest) + "元");
				return false;
			}
		} else if (money < min) {
			errorMsg("填写金额应当大于起投金额" + formatCurrency(min) + "元");
			return false;
		}
	}
	if (money > parseFloat(account_banlance)) {//余额不足
		if(checkStatusDetails()){
			needRecharge = money - parseFloat(account_banlance);
			showAys2(needRecharge);
			//errorMsg("余额不足，请您先去充值!");
			return false;
		}
		return false;
	}

	return true;
}
function needRecharge(){
	window.location.href = "ump_money_recharge.jsp?projectId="+getRequestParam("id")+"&isTransfer="+isTransfer
	+"&needRecharge="+needRecharge;
}

function invest() {
	if (check()) {
		if (isNeedContribution) {// 检查是否是约标项目
			if (iniCheckContribution()) {// 检查是否填写过约标密码
				var discount = parseFloat(discountRate)
				* parseInt($("#invest_number").val());
		window.location.href = "project_invest.jsp?invest_money="
				+ $("#invest_number").val() + "&project_type=" + project_type
				+ "&project_id=" + getRequestParam("id") + "&period=" + period
				+ "&loanRate=" + loanRate + "&isTransfer=" + isTransfer
				+ "&discount=" + discount;
			} else {
				showAys();
			}
		}else{
			var discount = parseFloat(discountRate)
			* parseInt($("#invest_number").val());
	window.location.href = "project_invest.jsp?invest_money="
			+ $("#invest_number").val() + "&project_type=" + project_type
			+ "&project_id=" + getRequestParam("id") + "&period=" + period
			+ "&loanRate=" + loanRate + "&isTransfer=" + isTransfer
			+ "&discount=" + discount;
		}
	}
}

function dismissAys() {
	$("#bg")[0].style.display = "none";
	$("#ays")[0].style.display = "none";
}
function dismissAys2(){
	$("#bg")[0].style.display = "none";
	$("#ays2")[0].style.display = "none";
}
function showAys2(value){
	$("#ays_content2")[0].innerHTML = "";
	var row = '';
	row += '本次购买还差 <font style="color:#f00">';
	row += value;
	row += '</font> 元，去充值?';
	$("#ays_content2").append(row);
	$("#bg").css("height", document.body.scrollHeight);
	$("#bg")[0].style.display = "block";
	$("#ays2")[0].style.display = "block";
}
function showAys() {
	$("#yb_content")[0].innerHTML = "请输入投标密码！致电客服约标,约标成功后可获得投标密码";
	$("#bg").css("height", document.body.scrollHeight);
	$("#bg")[0].style.display = "block";
	$("#ays")[0].style.display = "block";
}
function needToRecharge(){
	window.location.href = "ump_money_recharge.jsp?projectId="+getRequestParam("id")+"&isTransfer="+isTransfer
	+"&needRecharge="+needRecharge;
}