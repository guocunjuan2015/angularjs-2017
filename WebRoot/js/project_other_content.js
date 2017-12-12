var max_money = 0;
var min_money = 0;
var rest_money = 0;
var project_type = 0;
var account_banlance = 0;
var period = 0;
var loanRate = 0;
var remainTime = 0;
var restPeriod = 0;
var isTransfer = "";
var isNeedContribution = "";// 是否是约标
var mMultiple = 100;
var discountRate = 0;
var userName = "";
var needRecharge = 0;
var timer = "";
var storage = window.localStorage;
var riskUrl = $("#riskUrl").text();
//判断是否实名绑卡
var realNametf = false;//实名
var bankCodetf = false;//绑卡
//去实名认证
function goRealname (){
     $.ajax({
        url:"cg/user/register.do", // 去认证
        type: "post",
        dataType: "json",
        data: {
          bizType : '01',
        returnUrl : 'http://'+document.domain + window.location.pathname
        },
        success: function (data) {
          var infos = $.parseJSON(data.result);
          //console.log(data);
          // result为1时，表示成功
          if (infos.result == "1") {
            var myWindow = window.open('', '_self');
            myWindow.document.write(infos.resultObject);
          } else {
            alert(infos.errInfo);
          }
        },
        error: function (data){
          console.log(data);
        }
    }); 
}



$(function() {
	/*enableUMP = -1;
	$("#invest_number").val("");// 返回到此页面时，清空输入框内的金额
	var project_id = getRequestParam("id");
	isTransfer = getRequestParam("isTransfer");
	var backFrom = getRequestParam("backFrom");// 查看进入此页面的来源
	if (backFrom && "recharge" == backFrom) {
		alert('充值成功');
	}
	userAgent();
	if (!isEmptyStr(project_id)) {
//		if (isTransfer == "true") {
//			getTransferInfo(project_id);
//		} else {
//			isTransfer == 'false';
//			getProjectInfo(project_id);
//		}
		// initData();
		getAccountDataWhileLogin();
		checkUMPRegisterWhileLogin();
		clearCouponStorage();
	}*/
	
	//关闭风控问答按钮
	$(".closelog").click(function (){
		$(".fixedDirlog").hide();
		$(".evaluation").hide();
	})
	
	/*关闭 实名认证按钮  */
	$(".closeNameOrCard").click(function (){
		  $(".realNameOrCard").hide();
		  $(".fixedDirlog").hide();
	})
	
	//检查投资状态按钮
	$("#investBtnNew").on("touchstart",function(event){
		$.ajax({
			type : "POST",
			url : "account/detail/get.do",
			data : {},
			success : function(response) {
				if (response.success) {
					var info = $.parseJSON(response.result);
					//console.log(info);
					if (info.result) {
						// 已经登录,进行检查
						if (info.resultObject.u) {
							userName = info.resultObject.u;
							/*storage.setItem("id",project_id);
							storage.setItem("projectType",projectType);
							storage.setItem("userId",userId);*/
							
							//判断是否实名绑卡
							$.ajax({
						        url: "cg/user/getRegisterInfo.do", // 是否实名、绑卡
						        type: "post",
						        dataType: "json",
						        data: { },
						        async : false,
						        success: function (response) {
						          var result = $.parseJSON(response.result);
						          var info =result.resultObject; 
						        //  var data = info.resultObject;
						      if(info.realName == ''){
						        realNametf = false;
						      }else{
						        realNametf = true;
						      };
						      if(info.bankCardNo == ''){
						        bankCodetf = false;
						      }else{
						        bankCodetf = true;
						      }
						        },
						      error: function (data){
						        realNametf = false;
						        bankCodetf = false;
						      }
						    });
							
							if(realNametf == false){//未注册
							    $(".fixedDirlog").show();
							    $(".realNameOrCard").show();   
							    $("body").css("overflow","hidden");
							    return;
							  } else if(realNametf == true && bankCodetf == false ){//已经注册用户但未绑卡
							     $('html,body').animate({scrollTop: '0px'}, 800);  
							     $(".fixedDirlog").show();
							     $(".realNameOrCard").show(); 
							     $("body").css("overflow","hidden"); 
							     return;
							   } else{
							     $(".realNameOrCard").hide(); 
							   }
							
							
							//判断是否测过风险测评
							/*var risk;
							var localPath = $("#localPath").val();
							$.ajax({
								url:localPath + "member/checkRiskAssessment",
								type : 'post',
								dataType : 'json',
								async : false,
								data:{
									userId: $("#userId").val()
						    	},
						    	success:function(data){
						    		risk = data;
						    	},
						    	error:function(data){
						    		risk = false;
						    	}
							});
							if( risk == false){
								$(".fixedDirlog").show();
								$(".evaluation").show();
								return;
							}*/
							window.location.href = "project_invest.jsp?id="+ project_id +"&userId=" + userId + "&projectType=" + projectType;
						}
						/*// 显示收益
						if (isNeedContribution) {// 检查是否是约标项目
							if (iniCheckContribution()) {// 检查是否填写过约标密码
								$("#baozh_div")[0].style.display = "none";
								$("#yue_div")[0].style.display = "block";
								$("#epxt_div")[0].style.display = "block";
								$("#space_div").css("height",
										$("#footpanel").height());
								if ($("#project_type")[0].innerHTML == "131"
										|| project_type == 131) {
									// 并购计划 此处不用计算预期收益
									$(".epxt")[0].innerHTML = "&nbsp;";
									$("#epxt_yuan")[0].innerHTML = "&nbsp;";
								}
							} else {
								showAys();
							}
						} else {
							$("#baozh_div")[0].style.display = "none";
							$("#yue_div")[0].style.display = "block";
							$("#epxt_div")[0].style.display = "block";
							$("#space_div").css("height",
									$("#footpanel").height());
							if ($("#project_type")[0].innerHTML == "131"
									|| project_type == 131) {
								// 并购计划 此处不用计算预期收益
								$(".epxt")[0].innerHTML = "&nbsp;";
								$("#epxt_yuan")[0].innerHTML = "&nbsp;";
							}
						}*/
						// checkStatusDetails();// 检查后的操作
					}
				} else {
					if (isEmpty(response.result)) {
					} else {
						window.location.href = response.result
								+ "?reflect_url="
								+ encodeURIComponent("project_other_content.jsp?id="
										+ getRequestParam("id")
										+ "&projectType=" + getRequestParam("projectType"));
					}
					$("#button_invest").attr("disabled", false);
				}
			},
			dataType : "json"
		});
		
		
		event.preventDefault();
		
	})
	
	
	
	
	

});


function userAgent() {
	var ua = navigator.userAgent.toLowerCase();
	if (/iphone|ipad|ipod/.test(ua)) {
		// alert("iphone");
		$("#main").addClass("for_ios_fixed");
	}/*
		 * else if (/android/.test(ua)) { alert("android");
		 * $("#main").removeClass(); }
		 */
}

function clearCouponStorage() {
	// 清除localStorage coupon,ticket
	var storage = window.localStorage;
	if (storage.getItem("couponType")) {
		storage.removeItem("couponType");
	}
	if (storage.getItem("ticketValue")) {
		storage.removeItem("ticketValue");
	}
	if (storage.getItem("couponValue")) {
		storage.removeItem("couponValue");
	}
	if (storage.getItem("moreRateValue")) {//
		storage.removeItem("moreRateValue");
	}
	if (window.localStorage.getItem("couponId")) {
		storage.removeItem("couponId");
	}
	if (window.localStorage.getItem("ticketId")) {
		storage.removeItem("ticketId");
	}
	if (window.localStorage.getItem("moreRateId")) {
		storage.removeItem("moreRateId");
	}
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

function getTransferInfo(id) {
	if (isEmptyStr(id)) {
		return;
	}
	$.ajax({
		type : "POST",
		url : "project/transfer/find.do",
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
// 初始化项目信息
function initProjectInfo(data) {
	max_money = data.projectMaxNum;
	min_money = data.projectMinNum;
	if (data.isNeedContribution) {
		isNeedContribution = data.isNeedContribution;
	}
	if (data.projectBalance) {// 项目剩余金额
		rest_money = data.projectBalance;
	} else {
		rest_money = min_money;
	}

	$("#project_id")[0].innerHTML = data.projectID;
	$("#project_name")[0].innerHTML = data.projectName;
	if ("131" == data.projectType) {
		$("#project_loanRate")[0].innerHTML = data.lockupPeriodRate;
		document.getElementById("project_loanRate").style.FontSize = "12px";
	} else {
		$("#project_loanRate")[0].innerHTML = roundToTenth(data.loanRate);
	}
	loanRate = data.loanRate;
	if (data.multiple) {
		mMultiple = parseInt(data.multiple);
	}
	if (data.loanPeriod) {// 项目期限
		period = data.loanPeriod;
	} else if (data.fromEndTime) {
		period = data.fromEndTime;
	}

	document.getElementById("invest_number").setAttribute("placeholder",
			"起投金额" + data.projectMinNum);

	/** 添加项目倒计时 */
	if (data.remainTime && (parseInt(data.remainTime) >= 0)) {
		remainTime = parseInt(data.remainTime);
	}
	getRTime();
	timer = setInterval(getRTime, 1000);// 添加倒计时

	if (data.isTransferProject) {// 债权转让页面变动
		$("#investCount")[0].innerHTML = /* "转让金额 " + data.loanAmount; */data.projectPercent
				+ "%";
		/*
		 * $("#qixian")[0].innerHTML = "剩余期限"; $("#qtje")[0].innerHTML = "折让金";
		 */
		$("#project_minNum")[0].innerHTML = /* data.discountAmount */data.projectMinNum;
		discountRate = parseFloat(data.discountRate);
		$("#project_loanPeriod")[0].innerHTML = data.fromEndTime;

		if (data.legalName) {
			/*
			 * $("#p_tf")[0].style.display = "block";
			 * $("#author_tf")[0].innerHTML = data.legalName;
			 */
		}

	} else {
		$("#investCount")[0].innerHTML = /* "项目进度 " + */data.projectPercent
				+ "%";
		$("#qixian")[0].innerHTML = "期限";
		// $("#qtje")[0].innerHTML = "起投金额";
		$("#project_minNum")[0].innerHTML = data.projectMinNum;
		if ("111" == data.projectType || data.repaymentWay == "按月付息到期还本(天标)") {// 新手标期限为天
			$("#project_loanPeriod")[0].innerHTML = data.loanPeriod + "天";
		} else {
			$("#project_loanPeriod")[0].innerHTML = data.loanPeriod + "个月";
		}
	}
	$("#project_type")[0].innerHTML = data.projectType;
	if ("122" == data.projectType) {
		//$("#pd_title")[0].innerHTML = "优计划详情页";
		var storage = window.localStorage;
		//$("#tf_txt")[0].innerHTML = "配资 ";
		/*if (period == 3) {
			if (storage.getItem("PZRate3")) {
				$("#author_tf")[0].innerHTML = parseFloat(storage
						.getItem("PZRate3"))
						* 100 + "%";
			}
		} else if (period == 6) {
			if (storage.getItem("PZRate6")) {
				$("#author_tf")[0].innerHTML = parseFloat(storage
						.getItem("PZRate6"))
						* 100 + "%";
			}
		} else if (period == 12) {
			if (storage.getItem("PZRate12")) {
				$("#author_tf")[0].innerHTML = parseFloat(storage
						.getItem("PZRate12"))
						* 100 + "%";
			}
		} else if (period == 24) {
			if (storage.getItem("PZRate24")) {
				$("#author_tf")[0].innerHTML = parseFloat(storage
						.getItem("PZRate24"))
						* 100 + "%";
			}
		}*/
		//$("#p_tf")[0].style.display = "block";
	} else {
		// $("#pd_title")[0].innerHTML = "散标详情页";
	}

	// 倒计时
	project_type = parseInt(data.projectType);
	// max_money = data.projectMaxNum;
	// min_money = data.projectMinNum;

	$("#progressbars").css("width", data.projectPercent + "%");

	/*
	 * document.getElementById("project_progress").setAttribute("aria-valuenow",
	 * parseInt(data.projectPercent) + "");
	 */


	// 设置space——div占位的宽度
	$("#space_div").css("height", $("#footpanel").height());

	// $("#project_loanAmount")[0].innerHTML = data.loanAmount;
	$("#project_balance")[0].innerHTML = /* "剩余金额 " */
	+data.projectBalance + "元";
	// $("#project_createDate")[0].innerHTML = data.createDate;
	$("#project_repaymentWay")[0].innerHTML = data.repaymentWay;
}


function getDetail() {
	var jsp = '';
	if ("131" == project_type) {
		jsp = "new_project_details.jsp";
		loanRate = 0;
	} else if (isTransfer != "true") {
		jsp = "project_other_details.jsp";
	} else {
		jsp = "transfer_project_details.jsp";
	}

	window.location.href = jsp + "?id=" + getRequestParam("id")
			+ "&from=weixin" + "&project_info=" + '{"projectType":'
			+ project_type + ',"loan_period":' + period + ',"loan_rate":'
			+ loanRate + "}" + "&isTransfer=" + isTransfer;
}

function login() {
	window.location.href = "login.jsp";
}

function auth() {
	window.location.href = "real_name.jsp";
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
	if (money > parseFloat(account_banlance)) {// 余额不足
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

// 改变投资金额时调用
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
	case 3:// 投资时余额不足，提示充值
		needToRecharge();
		// window.location.href = "ump_money_recharge.jsp";
		break;
	case 4:
		window.location.href = "ump_bind_card.jsp";
		break;
	case 5:
		window.location.href = "ump_real_register.jsp";
		break;
	}
}
function needToRecharge() {
	window.location.href = "ump_money_recharge.jsp?projectId="
			+ getRequestParam("id") + "&isTransfer=" + isTransfer
			+ "&needRecharge=" + needRecharge;
}

function toTransferRool() {
	window.location.href = "transfer_rool.jsp";
}

function toRecharge() {
	window.location.href = "ump_money_recharge.jsp";
}

function getAccountDataWhileLogin() {
	$("#button_invest").attr("disabled", true);
	$("#invest_number").attr("readOnly", true);
	$.ajax({
		type : "POST",
		url : "account/detail/whilelogin/get.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					var accountInfo = info.resultObject;
					// 获取用户余额
					$("#yue_span")[0].innerHTML = accountInfo.b;
					account_banlance = accountInfo.b;
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
	$("#button_invest").attr("disabled", false);
	$("#invest_number").attr("readOnly", false);
}


// 在登录的状态下获取联动的信息
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
		$
				.ajax({
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



function toInvestRecord() {
	window.location.href = "project_invest_record.jsp?id="
			+ getRequestParam("id") + "&projectType=" + project_type
			+ "&isTransfer=" + isTransfer;
}

function toSafeEnsure() {
	window.location.href = "safe_ensure.jsp";
}

function allIn() {
	var bs = mMultiple;
	var input = 0;
	var a_b = parseFloat(account_banlance);
	var m_m = parseFloat(min_money);

	input = parseInt((parseInt(a_b) / bs)) * bs;
	$("#invest_number").val(input);
	changeInvest(input);// 计算预期收益
}
function dismissAys() {
	$("#ays").animate({"height":"toggle"},200,function(){
		$("#bg")[0].style.display = "none";
	});
}
function dismissAys2() {
	$("#ays2").animate({"height":"toggle"},200,function(){
		$("#bg")[0].style.display = "none";
	});
}

function showAys2(value) {
	$("#ays_content2")[0].innerHTML = "";
	var row = '';
	row += '本次购买还差 <font style="color:#f00">';
	row += value;
	row += '</font> 元，去充值?';
	$("#ays_content2").append(row);
	$("#bg").css("height", document.body.scrollHeight);
	$("#bg")[0].style.display = "block";
	$("#ays2").animate({"height":"toggle"});
}
function showAys() {
	$("#yb_content")[0].innerHTML = "请输入投标密码！致电客服约标,约标成功后可获得投标密码";
	$("#bg").css("height", document.body.scrollHeight);
	$("#bg")[0].style.display = "block";
	//$("#ays")[0].style.display = "block";
	$("#ays").animate({"height":"toggle"});
}

function showAys3() {
	$("#bg").css("height", document.body.scrollHeight);
	$("#bg")[0].style.display = "block";
	//$("#ays")[0].style.display = "block";
	$("#ays3").animate({"height":"toggle"});
}




/*20170106新版本改版*/
var projectdetailsApp=angular.module("projectdetailsApp",[]);
var loadToEnd = false;// 加载到最后一组

projectdetailsApp.controller("projectdetailsController",function($scope,$http, $timeout){
	$scope.type = "";
	$scope.page = 1;
	$scope.loadMsg = "努力加载中...";
	$scope.showLoadMsg = true;
	$scope.loadMsgTop = "";
	$scope.invest_records = [];
	$scope.showLoadMsgTop = false;
	//触发滚动事件
	window.onscroll = function (){
		var st = document.body.scrollTop,
			sh = document.body.scrollHeight,
			ih = this.innerHeight;
		if(st + ih == sh){
			$scope.page++;
			loadData();
		}
		/*if(st < 0){
			$timeout(function(){
				$scope.showLoadMsgTop = true;
				$scope.loadMsg = "刷新中...";
				$timeout(function (){
					$scope.showLoadMsg = false;
				},2000)
			})
		}*/
	};

	//请求理财记录数据
    var loadData = function(){
    	if (loadToEnd) {
    		return;
    	};
		var data1 = {
		projectId:project_id,
		projectType:projectType,
		currentPage:$scope.page,/*当前页*/
		pageSize:'10'  /* 每页显示记录*/
	    }
		transFn = function(data) {
	        return $.param(data);
	    };
	    postCfg = {
	        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
	        transformRequest: transFn
	    };


		 /*产品详情投资记录数据*/
		$http.post("project/getRyInvestList.do",data1,postCfg).success(function(data){
			
			var result = angular.fromJson(data.result);
			//console.log(result);
			$scope.financials=result.resultObject.ryInvestList;
			//数据加载完成后，不再请求后台
			$scope.invest_records = $scope.invest_records.concat($scope.financials);
			if ($scope.financials.length == 0) {
				$timeout(function(){
					$scope.loadMsg = "没有更多了...";
					$timeout(function (){
						$scope.showLoadMsg = false;
					},2000)
				})
				loadToEnd = true;
			}
			
		});  

    };
    loadData();//加在数据
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

/*产品详情信息*/     
$http.post("project/getLoanDetail.do",data,postCfg).success(function(data){
		var result = angular.fromJson(data.result);
		//console.log(result);
		$scope.rate = result.resultObject.rate;/*预期年化收益率*/
		$scope.subsidyDesc = result.resultObject.subsidyDesc;/*加息描述*/
		$scope.subsidyRate = result.resultObject.subsidyRate;/*加息收益率*/
		$scope.projectPeriod = result.resultObject.projectPeriod; /*期限天数*/
		$scope.deadlineDetail = result.resultObject.deadlineDetail; /*期限*/
		$scope.incomePerMyriad = result.resultObject.incomePerMyriad; /*预期年化收益*/
		$scope.residualAmount = result.resultObject.residualAmount; /*剩余可投金额*/
		$scope.totleMoney = result.resultObject.totleMoney; /*项目总金额*/
		$scope.paymentMethod = result.resultObject.paymentMethod; /*还款方式*/
		$scope.projectIntro = result.resultObject.projectIntro; /*项目详情*/
		$scope.borrowRemark = result.resultObject.borrowRemark; /*资金用途*/	
		$scope.paymentSource = result.resultObject.paymentSource; /*>还款来源*/
		remainTime = result.resultObject.countDownTime; /*投资倒计时*/
		$scope.proofUrlList = result.resultObject.proofUrlList;/*证明材料*/
		//console.log($scope.proofUrlList + "证明材料");
        if($scope.proofUrlList.length > 0){
        	$scope.proofUrlList = result.resultObject.proofUrlList; /*证明材料*/
		} 
		//console.log($scope.proofUrlLists);
		$scope.safeguard1 = result.resultObject.safeguard1; /*资金用途1*/
		$scope.safeguard2 = result.resultObject.safeguard2; /*资金用途2*/
		$scope.safeguard3 = result.resultObject.safeguard3; /*资金用途3*/
		$scope.isBorrowing = result.resultObject.isBorrowing; /*判断是否是借款详情*/
		$scope.fundPurpose = result.resultObject.fundPurpose; /*借款理由*/
		$scope.isBorrowing = result.resultObject.isBorrowing; /*是否是借款信息*/
		$scope.borrowLoginName = result.resultObject.borrowLoginName; /*用户登录名*/
		$scope.borrowUserName = result.resultObject.borrowUserName; /*借款人姓名*/
		$scope.sex = result.resultObject.sex; /*借款人性别*/
		$scope.homeAddr = result.resultObject.homeAddr; /*身份所在地*/
		$scope.borrowEducation = result.resultObject.borrowEducation; /*借款人学历*/
		$scope.riskUrl = decodeURIComponent(result.resultObject.riskUrl); /*风险控制url*/
		$scope.contactTypeList = result.resultObject.contactTypeList; /*联系人类型列表*/
		$scope.BorrowTotalAmount = result.resultObject.BorrowTotalAmount; /*共计借入资金*/
		$scope.BorrowTotalNum = result.resultObject.BorrowTotalNum; /*借款次数*/
		$scope.normalPayNum = result.resultObject.normalPayNum; /*正常还清次数*/
		$scope.approDate = result.resultObject.approDate; /*认证时间*/
		$scope.WaitePrincipal = result.resultObject.WaitePrincipal; /*待还本金*/
		$scope.projectStatus = result.resultObject.projectStatus; /*项目状态*/
		// 初始化投资按钮显示
		var st = parseInt($scope.projectStatus);
		initInvestButton(st);
		timer = setInterval(getRTime, 1000);// 添加倒计时
});


	function getRTime() {
		var d = Math.floor(remainTime / 60 / 60 / 24);
		var h = Math.floor(remainTime / 60 / 60 % 24);
		var m = Math.floor(remainTime / 60 % 60);
		var s = Math.floor(remainTime % 60);
		if (d < 0 || h < 0 || m < 0 || s < 0) {
			d = 0;
			h = 0;
			m = 0;
			s = 0;
			if(timer){
				clearInterval(timer);
			}
		}
		document.getElementById("time_span").innerHTML = d + "天" + h + "时" + m
				+ "分" + s + "秒";
		remainTime --;
	}
	
	// 初始化投资按钮样式
	function initInvestButton(st) {
		if (2 == st) {
			// 可投
			$("#investBtnNew")[0].innerHTML = "马上赚钱";
		} else {
			switch (st) {
			case 4:
			case 5:
			case 12:
				$("#investBtnNew")[0].innerHTML = "回款中";
				break;
			case 7:
				$("#investBtnNew")[0].innerHTML = "已结清";
				break;
			case 9:
				$("#button_invest")[0].innerHTML = "敬请期待";
				break;
			case 3:
			case 6:
				$("#investBtnNew")[0].innerHTML = "流标";
				break;
			}
			
			$("#invest_number").attr("readOnly", true);
			$("#investBtnNew").attr("disabled", true);
			$("#investBtnNew").css("background-color", "#666");

		}
	}


});


