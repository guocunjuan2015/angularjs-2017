var max_money = 0;
var min_money = 0;
var project_type = 0;
$(function() {
	var project_id = getRequestParam("id");
	if (!isEmptyStr(project_id)) {
		getProjectInfo(project_id);
//		getAccountInfo(0);
		initData();
	}
});

function initData() {
	copType = getRequestParam("copType");
	if (copType == null) {
		passValue = "";
		copId = "";
		$("#copType").val(0);
		$("#passValue").val("");
		$("#copId").val("");
	} else {
		passValue = getRequestParam("passValue");
		copId = getRequestParam("copId");
		$("#passValue").val(passValue);
		$("#copId").val(copId);
		if(copType == 1){
			$("#copType").val(1);
			$("#coupon")[0].innerHTML = "瑞钱币 "+formatCurrency(parseInt(passValue).toFixed(2))+"元";
		}else if(copType == 2){
			$("#copType").val(2);
			$("#coupon")[0].innerHTML = "投资券 "+formatCurrency(parseInt(passValue).toFixed(2))+"元";
		}
	}
}

function getAccountInfo(tag) {
	$.ajax({
		type : "POST",
		url : "account/detail/get.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					getCheckInfo(tag);
				} else {
					errorMsg(info.errInfo);
					$("#button_invest").attr("disabled", false);
				}
			} else {
				if (isEmpty(response.result)) {
					errorMsg(response.msg);
				} else {
					window.location.href = response.result
							+ "?reflect_url="
							+ encodeURIComponent("project_content.jsp?id="
									+ getRequestParam("id"));
				}
				$("#button_invest").attr("disabled", false);
			}
		},
		dataType : "json"
	});
}

function getCheckInfo(tag) {
	$
			.ajax({
				type : "POST",
				url : "account/check.do",
				data : {},
				success : function(response) {
					if (response.success) {
						var info = $.parseJSON(response.result);
						if (info.result) {
							var checkInfo = info.resultObject;
							var flag = false;

							$("#msg_btn_0")[0].style.display = "none";
							$("#msg_btn_1")[0].style.display = "none";
							$("#msg_btn_2")[0].style.display = "none";
							$("#msg_btn_3")[0].style.display = "none";

							if (checkInfo.paypassword == 0) {
								$("#tip_content")[0].innerHTML = "请先设置支付密码";
								$("#msg_btn_0")[0].style.display = "block";
								flag = true;
							} else if (checkInfo.realname == 0) {
								$("#tip_content")[0].innerHTML = "请先设进行实名认证";
								$("#msg_btn_1")[0].style.display = "block";
								flag = true;
								// }else if(checkInfo.bandcard == 0){
								// $("#msg_btn_2")[0].style.display = "block";
								// flag = true;
							} else if (checkInfo.fund == 0) {
								$("#tip_content")[0].innerHTML = "请先充值";
								$("#msg_btn_3")[0].style.display = "block";
								flag = true;
							}

							if (flag) {
								$('#myModal').on('shown.bs.modal', function() {
									$('#myInput').focus();
								});
								$('#myModal').modal('toggle');
								$('#myModal')[0].click();
							} else {
								if (tag == 1 && check()) {
									if($("#copType").val() == "1" || $("#copType").val() == "2"){
										checkCouponMaxAndToInvest();//瑞钱币，投资券配比
									}else{
										toRealInvestPage();
									}
								}else if(tag == 2){
									chooseCop();
								}else if(tag == 3){
									//输入投资金额
								}
							}
						} else {
							errorMsg(info.errInfo);
						}
					} else {
						if (isEmpty(response.result)) {
							errorMsg(response.msg);
						} else {
							window.location.href = response.result
									+ "?reflect_url="
									+ encodeURIComponent("project_content.jsp?id="
											+ getRequestParam("id"));
						}
					}
					$("#button_invest").attr("disabled", false);
				},
				dataType : "json"
			});
}

function getCheckInfoRecharge() {
	$.ajax({
		type : "POST",
		url : "account/check.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					var checkInfo = info.resultObject;
					var flag = false;

					$("#msg_btn_0")[0].style.display = "none";
					$("#msg_btn_1")[0].style.display = "none";
					$("#msg_btn_2")[0].style.display = "none";
					$("#msg_btn_3")[0].style.display = "none";

					if (checkInfo.paypassword == 0) {
						$("#tip_content")[0].innerHTML = "请先设置支付密码";
						$("#msg_btn_0")[0].style.display = "block";
						flag = true;
					} else if (checkInfo.realname == 0) {
						$("#tip_content")[0].innerHTML = "请先设进行实名认证";
						$("#msg_btn_1")[0].style.display = "block";
						flag = true;
						// }else if(checkInfo.bandcard == 0){
						// $("#msg_btn_2")[0].style.display = "block";
						// flag = true;
					}

					if (flag) {
						$('#myModal').on('shown.bs.modal', function() {
							$('#myInput').focus();
						});
						$('#myModal').modal('toggle');
						$('#myModal')[0].click();
					} else {
						window.location.href = "money_recharge.jsp";
					}
				} else {
					errorMsg(info.errInfo);
				}
			} else {
				if (isEmpty(response.result)) {
					errorMsg(response.msg);
				} else {
					window.location.href = response.result
							+ "?reflect_url="
							+ encodeURIComponent("project_content.jsp?id="
									+ getRequestParam("id"));
				}
			}

			$("#recharge_btn").attr("disabled", false);
		},
		dataType : "json"
	});
}

function getProjectInfo(id) {
	if (isEmptyStr(id)) {
		return;
	}
	$.ajax({
		type : "POST",
		url : "project/find.do",
		data : {
			id : id
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					var content = info.resultObject;
					initProjectInfo(content);
				} else {
					errorMsg(info.errInfo);
				}
			} else {
				errorMsg(response.msg);
			}
		},
		dataType : "json"
	});
}

function initProjectInfo(data) {
	max_money = data.projectMaxNum;
	min_money = data.projectMinNum;

	$("#project_id")[0].innerHTML = data.projectID;
	$("#project_name")[0].innerHTML = data.projectName;
	$("#project_loanRate")[0].innerHTML = data.loanRate;
	$("#project_loanPeriod")[0].innerHTML = data.loanPeriod;
	$("#project_minNum")[0].innerHTML = data.projectMinNum;
	$("#project_type")[0].innerHTML = data.projectType;
	project_type = parseInt(data.projectType);
	//小于3个月或债权转让项目，不可债权转让
	if(!(data.projectType == "106" || data.loanPeriod < 3 || data.projectType == "122")){
		$("#transfer_intro_div")[0].style.display = "block";
		$("#transfer_txt")[0].innerHTML = "PICC承保,投资有保障 支持债权转让";
	}else{
		$("#transfer_txt")[0].innerHTML = "PICC承保,投资有保障";
	}
	// 教育优选计划，不显示优惠券
	if(data.projectType == "122"){
		$("#choose_coupon")[0].style.display = "none";
	}
	
	var project_rate = $("#project_rate");
	project_rate[0].innerHTML = "";
	
	/**添加项目过期的判断*/
	var nowDate = new Date();//获取当前时间
	var endDate = parseInt(data.projectEndDate)*24*60*60*1000;
	var date = "";
	if(data.projectStartDate){
		//获取项目起始日期
		date = data.projectStartDate.split(".")[0];
	}
	date = date.replace(/-/g,"/");
	var startDate = new Date(date);

	if (data.projectPercent == 100 || (nowDate.getTime()-startDate.getTime())>endDate) {
		project_rate.append('<div class="grey-scoll" style="width:'
				+ data.projectPercent + '%"></div>');
		project_rate.append('<div class="grey-point" style="left:'
				+ data.projectPercent + '%">' + parseInt(data.projectPercent)
				+ '%</div>');
	} else {
		$("#cash_table")[0].style.display = "table";
		$("#button_invest")[0].style.display = "block";
		project_rate.append('<div class="green-scoll" style="width:'
				+ data.projectPercent + '%"></div>');
		project_rate.append('<div class="green-point" style="left:'
				+ data.projectPercent + '%">' + parseInt(data.projectPercent)
				+ '%</div>');
	}

	$("#project_loanAmount")[0].innerHTML = data.loanAmount;
	$("#project_balance")[0].innerHTML = formatCurrency(data.projectBalance);
	$("#project_createDate")[0].innerHTML = data.createDate;
	$("#project_repaymentWay")[0].innerHTML = data.repaymentWay;
	$("#project_maxNum")[0].innerHTML = formatCurrency(data.projectMaxNum);
	// $("#project_income")[0].innerHTML = formatCurrency(data.income);

	countPerIncome();// 每投资一万元收入..
}

function getDetail() {
	if(project_type){
	window.location.href = "project_content_detail.jsp?id="
			+ getRequestParam("id")+"&projectType="+project_type;
	}
}

function login() {
	window.location.href = "login.jsp";
}

function auth() {
	window.location.href = "real_name.jsp";
}

function recharge() {
	$("#recharge_btn").attr("disabled", true);
	getCheckInfoRecharge();
}

function invest() {
	$("#button_invest").attr("disabled", true);
	getAccountInfo(1);
}


function check() {
	var money = $("#invest_number")[0].value;

	// var balance = parseFloat($("#account_balance")[0].innerHTML);
	var max = parseInt(max_money);
	var min = parseInt(min_money);

	if (!checkStr(money, regexes.float)) {
		errorMsg("请正确填写投资金额");
		return false;
	}

	if (min == 50 && money % 50 != 0) {
		errorMsg("投资金额必须为50的整数倍");
		return false;
	} else if (money % 100 != 0) {
		errorMsg("投资金额必须为100的整数倍");
		return false;
	}

	if (money < min || money > max) {
		errorMsg("填写金额应当在[" + formatCurrency(min) + "]元和["
				+ formatCurrency(max) + "]元之间");
		return false;
	}

	// if(money > balance){
	// errorMsg("余额不足，请充值");
	// return false;
	// }

	return true;
}

/** 检查优惠券和投资金额的使用比例 */
function checkCouponMaxAndToInvest() {
	var money = $("#invest_number")[0].value;
	var id = getRequestParam("id");

	$.ajax({
		type : "POST",
		url : "account/check/couponmax.do",
		data : {
			money : money,
			id : id
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					if ($("#copType").val() == "1") {
						if (info.resultObject.coupon < parseInt($("#passValue").val())) {
							errorMsg("使用瑞钱币过大,请重新选择瑞钱币或增加投资金额");
						} else {
							toRealInvestPage();
						}
					} else if ($("#copType").val() == "2") {
						if (info.resultObject.ticket < parseInt($("#passValue").val())) {
							errorMsg("使用投资券过大,请重新选择投资券或增加投资金额");
						} else {
							toRealInvestPage();
						}
					}
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

/**传值跳到投资确认页面*/
function toRealInvestPage(){
	var money = $("#invest_number")[0].value;
	window.location.href = "project_invest.jsp?id="
			+ getRequestParam("id") + "&money=" + money
			+ "&copType=" + $("#copType").val()
			+ "&passValue=" + $("#passValue").val()
			+ "&copId=" + $("#copId").val();
}

function changeInvest(value) {
	var rate = parseFloat($("#project_loanRate")[0].innerHTML);
	var date = parseFloat($("#project_loanPeriod")[0].innerHTML);
	var income = 0.00;
	
	if(parseInt(value)>max_money){
		var max = parseInt(max_money);
		var min = parseInt(min_money);
		errorMsg("填写金额应当在[" + formatCurrency(min) + "]元和["
				+ formatCurrency(max) + "]元之间");
	}else{
		errorMsg("");
	}
	
	//计算预期收入（包含配资金额的利息）
	if($("#project_type")[0].innerHTML == "122" || project_type == 122){
	changePeizi(value);
	var period = parseInt($("#project_loanPeriod")[0].innerHTML);
	if(period == 3 || period == 6){
		income = value *(1.05)* rate * date / 1200;
	}else if(period == 12){
		income = value *(1.10)* rate * date / 1200;
	}else if(period == 24){
		income = value *(1.15)* rate * date / 1200;
	}
	}else{
		income = value * rate * date / 1200;
	}
	$("#invest_future_income")[0].innerHTML = formatCurrency(income.toFixed(2));
}
//根据填写的投资金额，计算u计划配资金额
function changePeizi(value){
	var period = parseInt($("#project_loanPeriod")[0].innerHTML);
	if(value != "" && period != ""){
		$("#u_plan_peiz")[0].style.display = "";
		if(period == 3 || period == 6){
			$("#u_plan_peiz_value")[0].innerHTML  =  formatCurrency((value * 0.05)+"");
		}else if(period == 12){
			$("#u_plan_peiz_value")[0].innerHTML = formatCurrency((value * 0.10)+"");
		}else if(period == 24){
			$("#u_plan_peiz_value")[0].innerHTML = formatCurrency((value * 0.15)+"");
		}
	}else{
		$("#u_plan_peiz_value")[0].innerHTML = "";
		$("#u_plan_peiz")[0].style.display = "none";
	}
	
}


function countPerIncome() {
	var rate = parseFloat($("#project_loanRate")[0].innerHTML);
	var date = parseFloat($("#project_loanPeriod")[0].innerHTML);
	var income;
	if(project_type == 122){
		var period = parseInt($("#project_loanPeriod")[0].innerHTML);
		if(period == 3 || period == 6){
			income = 10000 *(1.05)* rate * date / 1200;
		}else if(period == 12){
			income = 10000 *(1.10)* rate * date / 1200;
		}else if(period == 24){
			income = 10000 *(1.15)* rate * date / 1200;
		}
	}else{
		income = 10000 * rate * date / 1200;
	}
	$("#sp_per_income")[0].innerHTML = formatCurrency(income.toFixed(2));
}

function gotoPage(index) {
	switch (index) {
	case 0:
		window.location.href = "modify_paypassword_f.jsp";
		break;
	case 1:
		window.location.href = "real_name.jsp";
		break;
	case 2:
		window.location.href = "money_bind.jsp";
		break;
	case 3:
		window.location.href = "money_recharge.jsp";
		break;
	}
}

function chooseCop() {// 进到选择代金券优惠券界面
	window.location.href = "choose_coupon.jsp?period="
			+ $("#project_loanPeriod")[0].innerHTML + "&projectId="
			+ $("#project_id")[0].innerHTML;
}
function toTransferRool(){
	window.location.href = "transfer_rool.jsp";
}