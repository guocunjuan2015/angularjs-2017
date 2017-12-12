var max_money = 0;
var min_money = 0;
var account_banlance = 0;
var b_money = 0;
var invest_money = 0;
var tel = "";
var project_type = "";
var uid = "";
var utm_source = "";
var isTransfer = "";
var discount = 0;
var useType = 0;
var f = 22;
var binggoRate = 0;
var iniRqbUse = 0;
var period = 0;
var loanRate = 0;
var remainTime = 0;
var restPeriod = 0;
var isNeedContribution = "";
/*var isSpecial =$("#isSpecial").text();// 是否是约标
alert(isSpecial);*/
var mMultiple = 100;
var discountRate = 0;
var userName = "";
var needRecharge = 0;
var timer = "";
var storage = window.localStorage;
var couponType = "";
var couponAmountGlobal = "";
var couponIdGlobal = "";
$(function() {
	enableUMP = -1;
	invest_money = parseInt(getRequestParam("invest_money"));
	project_type = getRequestParam("project_type");
	isTransfer = getRequestParam("isTransfer");
	couponType = storage.getItem("couponType");
	storage.removeItem("couponType");
	couponAmountGlobal = storage.getItem("couponAmount");
	storage.removeItem("couponAmount");
	couponIdGlobal = storage.getItem("couponId");
	storage.removeItem("couponId");
	if (getRequestParam("discount")) {
		discount = parseFloat(getRequestParam("discount"));
	}


	/*判断优惠券的类型 1、红包 2、加息券*/
	if (couponType == '1') {
			//红包
			$("#coupon").text(couponAmountGlobal);
			$("#couponId").val(couponIdGlobal);
         	$("#error_info").text();
         	$("#coupon").css("color","#ff5555");
         	$("#error_info").text("使用红包之后不能进行债权转让");
	} else if (couponType == '2') {
			// 加息券
			$("#coupon").text(couponAmountGlobal +"%加息券");
			$("#couponId").val(couponIdGlobal);
         	$("#coupon").css("color","#ff5555");
         	$("#error_info").text("");

	}
	// initData();
});



/*function initData() {
	$("#ivst_sp2")[0].innerHTML = formatCurrency(invest_money.toFixed(2));
	if (window.sessionStorage.getItem("channel")) {
		f = window.sessionStorage.getItem("channel");// 获取投资来源
	}
	if (discount) {
		$("#discount_value")[0].innerHTML = discount;
		$("#ivst_discount")[0].style.display = "block";
	}
	if ("111" == getRequestParam("project_type")) {
		$("#choose_ticket")[0].style.display = "none";
		$("#choose_coupon")[0].style.display = "none";
		$("#choose_red_evp")[0].style.display = "none";
		var total = parseInt(getRequestParam("invest_money"));// 投资金额
		var epxt_income = total * (parseFloat(getRequestParam("loanRate")))
				* (getRequestParam("period") / 365) / 100;
		$("#invest_income")[0].innerHTML = parseFloat(epxt_income).toFixed(2);// 预期收益
		$("#invest_money")[0].innerHTML = parseInt(
				getRequestParam("invest_money")).toFixed(2);// 用户支付
	} else {
		var rqbUse = 0;// 使用瑞钱币个数
		var total = parseInt(getRequestParam("invest_money"));// 投资金额
		var lastPay = parseInt(getRequestParam("invest_money"));// 用户需要支付金额(失效)
		if ("122" == getRequestParam("project_type")) {
			var storage = window.localStorage;
			var period = parseInt(getRequestParam("period"));
			switch (period) {
			case 3:
				if (storage.getItem("PZRate3")) {
					total = parseInt(getRequestParam("invest_money"))
							* (1 + parseInt(storage.getItem("PZRate3")));
				}
				break;
			case 6:
				if (storage.getItem("PZRate6")) {
					total = parseInt(getRequestParam("invest_money"))
							* (1 + parseInt(storage.getItem("PZRate6")));
				}
				break;
			case 12:
				if (storage.getItem("PZRate12")) {
					total = parseInt(getRequestParam("invest_money"))
							* (1 + parseInt(storage.getItem("PZRate12")));
				}
				break;
			case 24:
				if (storage.getItem("PZRate24")) {
					total = parseInt(getRequestParam("invest_money"))
							* (1 + parseInt(storage.getItem("PZRate24")));
				}
				break;
			}
		} else {
			var storage = window.localStorage;
			var moreRate = 0;// 使用加息券获得的额外的加息
			if (isTransfer == 'true'
					|| "131" == getRequestParam("project_type")) {

			} else {
				$("#choose_ticket")[0].style.display = "";// 债权转让不能使用体验券
			}
			if (storage.getItem("couponType")) {
				var type = parseInt(storage.getItem("couponType"));
				if (type == 1) {
					if (storage.getItem("ticketValue")) {
						$("#coupon")[0].innerHTML = "使用"
								+ storage.getItem("ticketValue") + "元优惠券&nbsp";
						total = parseInt(getRequestParam("invest_money"))
								+ parseInt(storage.getItem("ticketValue"));
					}
				} else if (type == 2) {
					if (storage.getItem("moreRateValue")) {
						$("#coupon")[0].innerHTML = "使用"
								+ storage.getItem("moreRateValue")
								+ "% 加息券&nbsp";
						moreRate = parseFloat(storage.getItem("moreRateValue"));
					}
				} else if (type == 3) {// 使用瑞钱币
					if (storage.getItem("couponValue")) {
						rqbUse = parseInt(storage.getItem("couponValue"));
						$("#ruiqb")[0].innerHTML = "使用"
								+ storage.getItem("couponValue") + "个瑞钱币&nbsp";
						lastPay = parseInt(getRequestParam("invest_money"))
								- parseFloat(storage.getItem("couponValue"));
					}
				} else if (type == 4) {// 使用红包
					if (storage.getItem("redEvpValue")) {
						rqbUse = parseInt(storage.getItem("redEvpValue"));
						$("#redevnp")[0].innerHTML = "使用"
								+ storage.getItem("redEvpValue") + "元红包&nbsp";
						lastPay = parseInt(getRequestParam("invest_money"))
								- parseFloat(storage.getItem("redEvpValue"));
					}
				}
			} else {
				rqbUse = getCouponData();// 自动最优选择
				if (rqbUse) {
					$("#ruiqb")[0].innerHTML = "使用" + rqbUse + "个瑞钱币&nbsp";
				} else {
					rqbUse = 0;
				}
			}
		}
		var epxt_income = 0;
		if ("131" == getRequestParam("project_type")) {// 并购计划
			countBinggoRate(total, moreRate, rqbUse);// 计算并购计划的预期收益
		} else {
			if (isTransfer == 'true') {// 债权转让的收益
				epxt_income = total
						* (parseFloat(getRequestParam("loanRate")) + moreRate)
						* (getRequestParam("period") / 12 / 30.0) / 100;
			} else if("111" == getRequestParam("project_type")){
				$("#choose_red_evp")[0].style.display = "none";
				epxt_income = total
				* (parseFloat(getRequestParam("loanRate")) + moreRate)
				* (getRequestParam("period") / 365) / 100;
			}else{
				epxt_income = total
						* (parseFloat(getRequestParam("loanRate")) + moreRate)
						* (getRequestParam("period") / 12) / 100;
			}
			$("#invest_income")[0].innerHTML = parseFloat(epxt_income + rqbUse)
					.toFixed(2);// 预期收益
		}
		$("#invest_money")[0].innerHTML = parseInt(
				getRequestParam("invest_money")).toFixed(2);// 用户支付
	}*/
//}

function countBinggoRate(total, moreRate, rqbUse) {
	var rate = 0;
	$
			.ajax({
				type : "POST",
				url : "project/binggo/rate/get.do",
				data : {
					projectId : getRequestParam("project_id"),
					amount : parseInt(getRequestParam("invest_money"))
				},
				success : function(response) {
					if (response.success) {
						var info = $.parseJSON(response.result);
						if (info.result) {
							// if(info.resultObject.rate){
							rate = parseFloat(info.resultObject.rate);
							$("#discount_sp1")[0].innerHTML = "收益率";
							$("#ivst_sp3_1")[0].innerHTML = "%";
							$("#discount_value")[0].innerHTML = rate;
							$("#ivst_discount")[0].style.display = "block";
							$("#invest_income")[0].innerHTML = info.resultObject.income;
							// countBinggoIncome(rate,total,moreRate,rqbUse);
							// }
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
function countBinggoIncome(rate, total, moreRate, rqbUse) {
	if (isTransfer == 'true') {// 债权转让的收益
		epxt_income = total * (rate / 100.0 + moreRate)
				* (getRequestParam("period") / 12 / 30.0) / 100;
	} else {
		epxt_income = total * (rate / 100.0 + moreRate)
				* (getRequestParam("period") / 12) / 100;
	}
	$("#invest_income")[0].innerHTML = parseFloat(epxt_income + rqbUse)
			.toFixed(2);// 预期收益
}


function toRecharge() {
	window.location.href = "ump_money_recharge.jsp";
}

function needToRecharge() {
	window.location.href = "ump_money_recharge.jsp?projectId="+ getRequestParam("id") + "&isTransfer=" + isTransfer
			+ "&needRecharge=" + needRecharge;
}


function chooseCoupon(index) {
	checkUse(1);
	/*switch (index) {
	case 1:
		// 判断是否选择瑞钱币，若选择，提示，置空
		checkUse(1);
		break;
	case 2:
		// 判断是否选择体验券，若选择，提示，置空
		checkUse(2);
		break;
	case 3:
		checkUse(3);
		break;
	}*/
}
function checkUse(index) {
	//var storage = window.localStorage;
	investAmount=$("#invest_number").val();
	if(investAmount == null || investAmount == ""){
		$("#error_info").text("投资金额不能为空");
		return false;
	}

	window.location.href = "use_ticket.jsp?project_id="
		+ getRequestParam("id") + "&userId="
		+ getRequestParam("userId") + "&investAmount="
		+ investAmount + "&projectType="
		+ projectType; 
	
	/*switch (index) {
	case 1:
		if (storage.getItem("couponId") || storage.getItem("redEvpId")) {
			// 弹框
			useType = 1;
			$("#use_cot")[0].style.display = "block";
			$("#body_content_h4")[0].innerHTML = "加息券和红包不能同时使用，若要使用加息券将默认放弃红包的使用，是否继续？";
			$('#myModal').on('shown.bs.modal', function() {
				$('#myInput').focus();
			});
			$('#myModal').modal('toggle');
			$('#myModal')[0].click();
		} else {
			window.location.href = "use_ticket.jsp?project_id="
					+ getRequestParam("id") + "&userId="
					+ getRequestParam("userId") + "&investAmount="
					+ investAmount + "&projectType="
					+ projectType ;
		}
		break;
	case 2:
		if (storage.getItem("ticketId") || storage.getItem("moreRateId")
				|| storage.getItem("redEvpId")) {
			// 弹框
			useType = 2;
			$("#use_cot")[0].style.display = "block";
			$("#body_content_h4")[0].innerHTML = "瑞钱币与优惠券,红包不能同时使用，若要使用瑞钱币将默认放弃优惠券，红包的使用，是否继续？";
			$('#myModal').on('shown.bs.modal', function() {
				$('#myInput').focus();
			});
			$('#myModal').modal('toggle');
			$('#myModal')[0].click();
		} else {
			window.location.href = "use_ticket.jsp?project_id="
					+ getRequestParam("id") + "&userId="
					+ getRequestParam("userId") + "&investAmount="
					+ investAmount;
		}
		break;
	case 3:
		if (storage.getItem("couponId") || storage.getItem("moreRateId")
				|| storage.getItem("ticketId")) {
			useType = 3;
			$("#use_cot")[0].style.display = "block";
			$("#body_content_h4")[0].innerHTML = "加息券和红包不能同时使用，若要使用红包将默认放弃加息券的使用，是否继续？";
			$('#myModal').on('shown.bs.modal', function() {
				$('#myInput').focus();
			});
			$('#myModal').modal('toggle');
			$('#myModal')[0].click();
		} else {
			window.location.href = "use_ticket.jsp?project_id="
					+ getRequestParam("id") + "&userId="
					+ getRequestParam("userId") + "&investAmount="
					+ investAmount;
		}
	}*/
}
function sureUse() {// 仍然使用
	//var storage = window.localStorage;
	switch (useType) {
	case 1:
		if (couponIdGlobal) {
			storage.removeItechooseCouponm("couponId");
			storage.removeItem("couponValue");
		} else if (storage.getItem("redEvpId")) {
			storage.removeItem("redEvpId");
			storage.removeItem("redEvpValue");
		}
		window.location.href = "use_ticket.jsp?project_id="
				+ getRequestParam("project_id") + "&period="
				+ getRequestParam("period") + "&tab=2" + "&money_invest="
				+ getRequestParam("invest_money");
		break;
	case 2:
		if (storage.getItem("ticketId")) {
			storage.removeItem("ticketId");
			storage.removeItem("ticketValue");
		} else if (storage.getItem("moreRateId")) {
			storage.removeItem("moreRateId");
			storage.removeItem("moreRateValue");
		} else if (storage.getItem("redEvpId")) {
			storage.removeItem("redEvpId");
			storage.removeItem("redEvpValue");
		}
		window.location.href = "use_coupon.jsp?project_id="
				+ getRequestParam("project_id") + "&period="
				+ getRequestParam("period") + "&tab=1" + "&money_invest="
				+ getRequestParam("invest_money");
		break;
	case 3:
		if (storage.getItem("ticketId")) {
			storage.removeItem("ticketId");
			storage.removeItem("ticketValue");
		} else if (storage.getItem("moreRateId")) {
			storage.removeItem("moreRateId");
			storage.removeItem("moreRateValue");
		} else if (couponIdGlobal) {
			storage.removeItem("couponId");
			storage.removeItem("couponValue");
		}
		window.location.href = "use_red_evp.jsp?project_id="
				+ getRequestParam("project_id") + "&period="
				+ getRequestParam("period") + "&tab=3" + "&money_invest="
				+ getRequestParam("invest_money");
		break;
	}
}

function umpInvest() {
//	var storage = window.localStorage;
	$("#button_invest").attr("disabled", true);
	var project_id = getRequestParam("id");
	// var couponType = storage.getItem("couponType");/*类型  1、红包 2、加息券*/
	var money = $("#invest_number").val();
	var couponId = "";
	var couponAmount = "";
	var moreRateId = "";
	var morerateRate = "";
	if(couponType == "1"){
		couponId =$("#couponId").val();
		couponAmount =$("#coupon").text();
	} else if (couponType == "2") {
		moreRateId = $("#couponId").val();
		morerateRate = $("#coupon").text();
	} 
	storage.removeItem("couponId");
	storage.removeItem("couponAmount");
	storage.removeItem("couponType");
	$.ajax({
		type : "POST",
		url : "cg/trade/invest.do",
		async:false,
		data : {
			investAmount : money,
			bidId  : project_id,
			morerateIds: moreRateId,
			morerateRate: morerateRate,
			couponIds: couponId,
			couponAmount : couponAmount,
			returnUrl : 'http://'+document.domain + '/rqb/project.jsp'
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					// 跳到联动投资页面
					var myWindow = window.open('', '_self');
	      			myWindow.document.write(info.resultObject);
					/*$("#umpInvestForm").submit();*/
				} else {
					errorMsg(info.errInfo);
				}
			} 
			$("#button_invest").attr("disabled", false);
		},
		dataType : "json"
	});
}

function umpTransferInvest() {
	$("#button_invest").attr("disabled", true);
	var project_id = getRequestParam("project_id");
	var money = getRequestParam("invest_money");
	var couponId = "";
	var moreRateId = "";
	if (window.localStorage.getItem("couponId")) {
		couponId = window.localStorage.getItem("couponId");// 代金券ID
	}
	if (storage.getItem("redEvpId")) {
		couponId = window.localStorage.getItem("redEvpId");// 红包ID
	}
	if (window.localStorage.getItem("utm_source")) {
		utm_source = window.localStorage.getItem("utm_source");
	}
	if (window.localStorage.getItem("uid")) {
		uid = window.localStorage.getItem("uid");
	}

	$.ajax({
		type : "POST",
		url : "ump/transfer/invest.do",
		data : {
			loanId : project_id,
			amount : money,
			couponId : couponId,
			moreRateId : moreRateId,
			channel : f,
			retUrl : "http://www.rqbao.com/rqb/ump_callback_result.jsp",
			utm_source : utm_source,
			uid : uid
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					/*zhuge.track('投资', {
						'投资人' : $("#user_name")[0].innerHTML,
						'项目' : project_id,
						'投资额' : money
					});*/
					// 跳到联动投资页面
					document.getElementById("umpInvestForm").setAttribute(
							"action", info.resultObject.url);
					$("#umpInvestForm").submit();
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
			$("#button_invest").attr("disabled", false);
		},
		dataType : "json"
	});
}

function invest_success() {
	window.close();
	window.location.href = "project.jsp";
}

function toProxy() {
	window.location.href = "proxy.jsp";
}

// 协议
function onBoxClicked() {
	if (document.getElementById("agreeBox").checked) {
		enableInvest = true;
		$("#invest_btn").attr("disabled", false);
	} else {
		enableInvest = false;
		$("#invest_btn").attr("disabled", true);
	}
}

function getCouponData() {
	var rqbUse = 0;
	$.ajax({
		type : "POST",
		async : false,
		url : "account/my/couponinfo/get.do",
		data : {
			projectId : getRequestParam("project_id"),
			moneyInvest : invest_money
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					couponInfo = info.resultObject.unuseds;
					rqbUse = initCouponInfo(couponInfo);
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
	return rqbUse;
}
function initCouponInfo(data) {
	if (data && data.length != 0) {
		var couponUse = 0;
		var couponId = "";
		for (var i = 0; i < data.length; i++) {
			if ("selected" == data[i].selected) {
				couponUse = couponUse + data[i].amount;
				couponId = couponId + "," + data[i].couponId;
			}
		}
		var couponIds = couponId.substring(1);
		window.localStorage.setItem("couponId", couponIds);
		return couponUse;
	}
}


function showAys() {
	$("#yb_content")[	0].innerHTML = "请输入投标密码！致电客服约标,约标成功后可获得投标密码";
	$("#bg").css("height", document.body.scrollHeight);
	$("#bg")[0].style.display = "block";
	//$("#ays")[0].style.display = "block";
	$("#ays").animate({"height":"toggle"});
}


//在登录的状态下获取联动的信息
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

function iniCheckContribution() {// check contribution password
	var pjObj = "";
	if (window.localStorage.getItem(getRequestParam("id"))) {
		pjObj = window.localStorage.getItem(getRequestParam("id"));
		var info = $.parseJSON(pjObj);
		if (userName == info.user) {
			if (getRequestParam("id") == info.id) {
			} else {
				return false;
			}
		} else {
			return false;
		}
	} else {
		return false;
	}
	return true;
}
function checkContributionAndSave() {
	var psw = $("#ctPsw").val();
	if (isEmptyStr(psw)) {
		errorMsg("请正确填写约标密码！");
		return false;
	} else {
		$("#checkCP").attr("disabled", true);
		$.ajax({
					type : "POST",
					url : "project/contribution/check.do",
					data : {
						projectId : getRequestParam("id"),
						password : psw
					},
					success : function(response) {
						$("#checkCP").attr("disabled", false);
						if (response.success) {
							var info = $.parseJSON(response.result);
							if (info.result) {
								var project = new Object();
								project.id = getRequestParam("id");
								project.user = userName;
								var objStr = JSON.stringify(project);// 将对象转化成json字符串
								var s = window.localStorage;
								s.setItem(getRequestParam("id"), objStr);
								dismissAys();
							} else {
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

//改变投资金额时调用
function changeInvest(value) {
	// $("#baozh_div")[0].style.display = "none";
	// $("#yue_div")[0].style.display = "block";
	// $("#epxt_div")[0].style.display = "block";
	var rate = parseFloat($("#project_loanRate")[0].innerHTML);
	var income = 0.00;

	/*
	 * if (parseFloat(value) > parseFloat(account_banlance)) {
	 * errorMsg("余额不足，请先去充值"); } else if (isTransfer != "true" &&
	 * (parseFloat(value) > max_money)) { var max = parseInt(max_money); var min =
	 * parseInt(min_money); errorMsg("填写金额应当在[" + formatCurrency(min) + "]元和[" +
	 * formatCurrency(max) + "]元之间"); } else { errorMsg(""); }
	 */
	if ($("#project_type")[0].innerHTML == "131" || project_type == 131) {
		// 并购计划 此处不用计算预期收益
		$(".epxt")[0].innerHTML = "&nbsp;";
		$("#epxt_yuan")[0].innerHTML = "&nbsp;";
		return;
	}
	// 计算预期收入（包含配资金额的利息）
	else if (isTransfer == "true") {// 债权转让计息
		if ($("#project_type")[0].innerHTML == "122" || project_type == 122) {
			var storage = window.localStorage;
			if (period == 3) {
				if (storage.getItem("PZRate3")) {
					income = value
							* (1 + parseFloat(storage.getItem("PZRate3")))
							* rate * period / 30.0 / 1200;
				}
			} else if (period == 6) {
				if (storage.getItem("PZRate6")) {
					income = value
							* (1 + parseFloat(storage.getItem("PZRate6")))
							* rate * period / 30.0 / 1200;
				}
			} else if (period == 12) {
				if (storage.getItem("PZRate12")) {
					income = value
							* (1 + parseFloat(storage.getItem("PZRate12")))
							* rate * period / 30.0 / 1200;
				}
			} else if (period == 24) {
				if (storage.getItem("PZRate24")) {
					income = value
							* (1 + parseFloat(storage.getItem("PZRate24")))
							* rate * period / 30.0 / 1200;
				}
			}
		} else {
			income = value * rate * period / 30.0 / 1200;
		}
	} else {
		if ($("#project_type")[0].innerHTML == "122" || project_type == 122) {
			var storage = window.localStorage;
			if (period == 3) {
				if (storage.getItem("PZRate3")) {
					income = value
							* (1 + parseFloat(storage.getItem("PZRate3")))
							* rate * period / 1200;
				}
			} else if (period == 6) {
				if (storage.getItem("PZRate6")) {
					income = value
							* (1 + parseFloat(storage.getItem("PZRate6")))
							* rate * period / 1200;
				}
			} else if (period == 12) {
				if (storage.getItem("PZRate12")) {
					income = value
							* (1 + parseFloat(storage.getItem("PZRate12")))
							* rate * period / 1200;
				}
			} else if (period == 24) {
				if (storage.getItem("PZRate24")) {
					income = value
							* (1 + parseFloat(storage.getItem("PZRate24")))
							* rate * period / 1200;
				}
			}
		} else if ($("#project_type")[0].innerHTML == "111"
				|| project_type == 111) {
			income = value * rate * period / 100 / 365;
		} else {
			income = value * rate * period / 1200;
		}
	}
	//$("#epxt_income")[0].innerHTML = formatCurrency(income.toFixed(2));
}

/*20170111列表详情页面改版*/

var projectInvestApp=angular.module("projectInvestApp",[]);

projectInvestApp.controller("projectInvestController",function($scope,$http){

	var data = {
		projectId:project_id,
		projectType:projectType
	}



	transFn = function(data) {
        return $.param(data);
    },

     postCfg = {
        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
        transformRequest: transFn
    };

    /*产品投资页面数据*/
    $http.post("project/getLoanDetail.do",data,postCfg).success(function(data){
    	var result = angular.fromJson(data.result);
		$scope.accountBalance = result.resultObject.accountBalance; /*账户余额*/
		$scope.projectName = result.resultObject.projectName; /*项目名称*/
		$scope.residualAmount = result.resultObject.residualAmount; /*可投金额*/
		$scope.isSpecial = result.resultObject.isSpecial; /*是否约标*/
		$scope.maxInvestMoney = result.resultObject.maxInvestMoney; /*最大投资金额*/
		$scope.minInvestMoney = result.resultObject.minInvestMoney; /*最小投资金额*/
		$scope.discountScale = result.resultObject.discountScale; /*折让比例*/
		$scope.discountType = result.resultObject.discountType; /*折让比例*/
		$scope.projectPeriod = result.resultObject.projectPeriod; /*项目期限*/
		$scope.rate = result.resultObject.rate; /*项目收益率*/
		$scope.subsidyRate = result.resultObject.subsidyRate; /*投标金额*/
		$scope.repaymentWay  = result.resultObject.repaymentWay; /*还款方式*/
		$scope.loanType = result.resultObject.loanType; /*项目类型*/
		//console.log(storage.getItem("investAmount"));
		//console.log(storage.getItem("couponAmount"));
		//console.log(storage.getItem("couponType"));
		if (storage.getItem("investAmount")) {
				$("#invest_number").val(storage.getItem("investAmount"));
				storage.removeItem("investAmount");
				calculateInterest();
		}
		$scope.invest=function(){
			// 联动开启投资
			if (projectType == '1') {/*projectType:1、普通标 2、债转标 */
				if (check()) {
					if ($scope.isSpecial) {// 检查是否是约标项目
						if (iniCheckContribution()) {// 检查是否填写过约标密码
							var discount = parseFloat(discountRate)
									* parseInt($("#invest_number").val());
							window.location.href = "project_invest.jsp?invest_money="
									+ $("#invest_number").val() + "&project_type="
									+ project_type + "&project_id=" + getRequestParam("id")
									+ "&period=" + period + "&loanRate=" + loanRate
									+ "&isTransfer=" + isTransfer + "&discount=" + discount;
						} else {
							showAys();
						}
					} else {
						var discount = parseFloat(discountRate)
								* parseInt($("#invest_number").val());
						window.location.href = "project_invest.jsp?invest_money="
								+ $("#invest_number").val() + "&project_type="
								+ project_type + "&project_id=" + getRequestParam("id")
								+ "&period=" + period + "&loanRate=" + loanRate
								+ "&isTransfer=" + isTransfer + "&discount=" + discount;
					}
				}
				umpInvest();
			} else {/*债转标的*/
				if (check()) {
						var discount = parseFloat(discountRate)
								* parseInt($("#invest_number").val());
						window.location.href = "project_invest.jsp?invest_money="
								+ $("#invest_number").val() + "&project_type="
								+ project_type + "&project_id=" + getRequestParam("id")
								+ "&period=" + period + "&loanRate=" + loanRate
								+ "&isTransfer=" + isTransfer + "&discount=" + discount;
				}
				umpTransferInvest();
			}
			
			function check() {
				var money = $("#invest_number")[0].value;
				var max = parseInt($scope.maxInvestMoney);
				var min = parseInt($scope.minInvestMoney);
			    var rest = parseInt($scope.accountBalance);
			        rest = $scope.accountBalance.replace(",","");
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
					} else if (money < min) {
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
				if (money > parseFloat($scope.accountBalance)) {// 余额不足
				//if (money > parseFloat(account_banlance)) {// 余额不足
					if (checkStatusDetails()) {
						needRecharge = money - parseFloat(account_banlance);
						showAys2(needRecharge);
						// errorMsg("余额不足，请您先去充值!");
						return false;
					}
					return false;
				}

				return true;
			}
			
		}
		
		/*微信新投资计算方法start*/
		$("#invest_number").bind('input propertychange',function(){
			calculateInterest();
			$("#coupon").text("未选择");
			$("#coupon").css("color","#777");
			$("#couponId").val('');

		})
		/*计算投资收益*/
		function calculateInterest() {
			var investMoney = $("#invest_number").val();
			var totalInterest = 0;
			var interest = 0; // 预期收益
			if (($scope.loanType == '111' && $scope.repaymentWay == '301') || $scope.repaymentWay == '306' || $scope.repaymentWay == '307') {
				interest = (Number($scope.rate) + Number($scope.subsidyRate)) * Number(investMoney) * $scope.projectPeriod / 365 / 100;
			} else {
				interest = (Number($scope.rate) + Number($scope.subsidyRate)) * Number(investMoney) * $scope.projectPeriod / 100 / 12;
			}
			var cOrMInterest = couponOrMorerateInterest(investMoney);
			if (cOrMInterest != null && cOrMInterest != undefined && cOrMInterest != '' && cOrMInterest != '0') {
				totalInterest = formatCurrency(interest) + ' + ' + formatCurrency(cOrMInterest);
			} else {
				totalInterest = formatCurrency(interest);
			}
			// TODO:吧totalInterest 放到指定位置。
			$("#invest_income").text(totalInterest);
			$("#units").text("元");

			
		}
		
		/**
		 * 计算用户选中的红包收益或者加息券收益
		 */
		function couponOrMorerateInterest(investMoney) {
			var cOrMInterest = 0;
			// 红包
			if (couponType == '1') {
				cOrMInterest = couponAmountGlobal;
			} else if (couponType == '2') {
				// 加息券
				var morerate = couponAmountGlobal;
				if (($scope.loanType == '111' && $scope.repaymentWay == '301') || $scope.repaymentWay == '306' || $scope.repaymentWay == '307') {
					cOrMInterest = Number(morerate) * Number(investMoney) * $scope.projectPeriod / 365 / 100;
				} else {
					cOrMInterest = Number(morerate) * Number(investMoney) * $scope.projectPeriod / 100 / 12;
				}
				return cOrMInterest;
			}
			return cOrMInterest;

		}
		
		/**
		 * 将数值四舍五入(保留2位小数)后格式化成金额形式
		 *
		 * @param num 数值(Number或者String)
		 * @return 金额格式的字符串,如'1,234,567.45'
		 * @type String
		 */
		function formatCurrency(num) {
			num = num.toString().replace(/\$|\,/g, '');
			if (isNaN(num))
				num = "0";
			sign = (num == (num = Math.abs(num)));
			num = Math.floor(num * 100 + 0.50000000001);
			cents = num % 100;
			num = Math.floor(num / 100).toString();
			if (cents < 10)
				cents = "0" + cents;
			for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
				num = num.substring(0, num.length - (4 * i + 3)) + ',' +
				num.substring(num.length - (4 * i + 3));
			return (((sign) ? '' : '-') + num + '.' + cents);
		}
    })
    
   
    
})


/**/
function checkStatusDetails() {
	if (enableUMP == 1) {
		if (liandongRegister) {
			if (liandongBankcard) {
				return true;
			} else {
				// 提示去联动绑卡
				$("#msg_btn_0")[0].style.display = "none";
				$("#msg_btn_1")[0].style.display = "none";
				$("#msg_btn_2")[0].style.display = "none";
				$("#msg_btn_3")[0].style.display = "none";
				$("#msg_btn_4")[0].style.display = "block";
				$("#msg_btn_5")[0].style.display = "none";
				$("#tip_content")[0].innerHTML = "请先绑定银行卡，再进行资金交易";
				$('#myModal').on('shown.bs.modal', function() {
					$('#myInput').focus();
				});
				$('#myModal').modal('toggle');
				$('#myModal')[0].click();
				return false;
			}
		} else {
			// 提示去联动开户
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
			$('#myModal').on('shown.bs.modal', function() {
				$('#myInput').focus();
			});
			$('#myModal').modal('toggle');
			$('#myModal')[0].click();
			return false;
		}
	}
}