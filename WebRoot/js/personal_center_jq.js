var login_name = "";
var is_sign = false;
var f = 0;
var isShow = true;
var real_name = "";
var user_mobile = "";
$(function() {
	if (getRequestParam("channel")) {
		f = getRequestParam("channel");
		var storage = window.sessionStorage;
		storage.setItem("channel", f);// 增加投资来源
	}
	if(window.localStorage.getItem("dismissDownload")){
		dismiss('download');
	}
	initClickEvent();// 初始遮罩点击事件
	addBottomMenu();// 添加底部tab菜单按钮
	enableUMP = -1;
	UMPRegistered = false;
	liandongBankcard = false;
	getAccountData();
	checkUMPRegister(0);
    checkHasMessage();
    getReferInfo();//获取合伙人收益信息
});

function initClickEvent() {
	// 点击关闭按钮的时候，遮罩层关闭
	$(".close").click(function() {
		$("#bg,.box").css("display", "none");
	});
}
function btnclick(index) {
	if ("#qd" == index) {
		if (!is_sign) {
			$("#bg").css({
				display : "block",
				height : $(document).height()
			});
			var $box = $(index);
			$box.css({
				// 设置弹出层距离左边的位置
				// left: ($("body").width() - $box.width()) / 2 - 20 + "px",
				// 设置弹出层距离上面的位置
				top : ($(window).height() - $box.height()) / 2
						+ $(window).scrollTop() + "px",
				display : "block"
			});
			daySignIn();
		}

	} else {
		$("#bg").css({
			display : "block",
			height : $(document).height()
		});
		var $box = $(index);
		$box.css({
			// 设置弹出层距离左边的位置
			// left: ($("body").width() - $box.width()) / 2 - 20 + "px",
			// 设置弹出层距离上面的位置
			top : ($(window).height() - $box.height()) / 2
					+ $(window).scrollTop() + "px",
			display : "block"
		});
	}
}

function getAccountData() {
	$.ajax({
		type : "POST",
		url : "account/detail/get.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					var accountInfo = info.resultObject;
					initAccountInfo(accountInfo);
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

function initAccountInfo(data) {
	$("#userName")[0].innerHTML = data.u;
	login_name = data.u;
	login_name_u_hex = data.u_hex;
	var sessionStorage = window.sessionStorage;
	sessionStorage.setItem("userHex",login_name_u_hex);
	$("#user_total")[0].innerHTML = formatCurrency(parseFloat(data.b));
//	$("#user_income")[0].innerHTML = formatCurrency(parseFloat(data.ic));
	$("#bg_account_balance")[0].innerHTML = formatCurrency(parseFloat(data.b));
	$("#bg_account_dead")[0].innerHTML = formatCurrency(parseFloat(data.frozen));
	$("#bg_will_income")[0].innerHTML = formatCurrency(parseFloat(data.principal));
	$("#bg_will_award")[0].innerHTML = formatCurrency(parseFloat(data.interest));
	if(data.ic){
		$("#tt_income")[0].innerHTML = formatCurrency(parseFloat(data.ic));
	}
	if(data.ticket){
		if(parseInt(data.ticket) == 0){
			$("#my_tic_cont").removeClass();
			$("#my_tic_cont")[0].innerHTML = "&nbsp";
		}else{
			$("#my_tic_cont")[0].innerHTML = data.ticket;
		}
	}
	if(data.realName){
		real_name = data.realName;
	}
	user_mobile = data.mobile;

	//获取用户头像
	if(data.img){
		document.getElementById("user_img").src = "data:image/png;base64,"+data.img;
		document.getElementById("bg_head_img").src = "data:image/png;base64,"+data.img;
	}else{
		document.getElementById("user_img").src = "images/userhead.png";
		document.getElementById("bg_head_img").src = "images/userhead.png";
	}
//	$("#interest")[0].innerHTML = data.interest;
//	$("#tt_points")[0].innerHTML = data.point;
//	$("#yhq_count")[0].innerHTML = data.ticket;
//	$("#rqb_count")[0].innerHTML = data.coupon;
	$("#invest_record_count")[0].innerHTML = data.investCount;
	$("#rqb_count_sign")[0].innerHTML = data.point + '<sup>+10</sup>';
	$("#vip_level_sign")[0].innerHTML = "v" + data.vipLevel;
	if (parseInt(data.isSign) == 1) {// 当天已经签到
		is_sign = true;
		$("#day_sign_sp")[0].innerHTML = "已签到";
	} else {
		$("#day_sign_sp")[0].innerHTML = "签到";
	}
}

function shareCode() {// 推荐注册二维码
	window.location.href = "share_redirect.jsp?referrer=" + login_name_u_hex
			+ "&from=weixin";
}

function accountInvest() {
	window.location.href = "personal_invest.jsp";
}
function toAccountInfo() {
	if(login_name){//判断数据已经获取
		window.location.href = "account_info.jsp?vip_rank="+$("#vip_level_sign")[0].innerHTML
		+"&user_mobile="+user_mobile
		+"&real_name="+real_name;
	}
}

function checkUMPRegister(index) {
	$("#cash_button").attr("disabled",true);
	$("#recharge_button").attr("disabled",true);
	$.ajax({
		type : "POST",
		url : "ump/check/register/status.do",
		data : {},
		success : function(response) {
			if (response.success) {
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
						// 已经在联动开户
					}
					if ("1" == data.liandongBankcard) {
						liandongBankcard = true;
					} else {
						liandongBankcard = false;
					}
				} else {// 联动时间未开启
					enableUMP = 0;
				}
			} else {
				if (isEmpty(response.result)) {
					errorMsg(response.msg);
				} else {
					window.location.href = response.result + "?reflect_url="
							+ encodeURIComponent("personal_center.jsp");
				}
			}
			$("#cash_button").attr("disabled",false);
			$("#recharge_button").attr("disabled",false);
		},
		dataType : "json"
	});
}

function rechargeOrCash(index,event) {
	event.stopPropagation();//组织父dom点击事件
	// 充值提现都要在联动开户绑卡,index为0是充值，1为绑卡
	if (1 == enableUMP) {
		if (this.UMPRegistered) {
			// 跳到联动充值(先判断是否绑卡)
			if (this.liandongBankcard) {
				if (0 == index) {
					// 去易宝充值
					window.location.href = "ump_money_recharge.jsp";
				} else {
					window.location.href = "ump_money_cash.jsp";
				}
			} else {
				// 提示联动绑卡
				dismissMsgBtn();
				$("#msg_btn_7")[0].style.display = "block";
				$("#return_message")[0].innerHTML = "请先绑定银行卡，再进行资金交易";
				$('#myModal').on('shown.bs.modal', function() {
					$('#myInput').focus();
				});
				$('#myModal').modal('toggle');
				$('#myModal')[0].click();
			}

		} else {
			// 提示去联动开户
			dismissMsgBtn();
			$("#check_epay_result")[0].style.display = "block";
			var table = $("#return_message");
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
		}
	} else if (0 == enableUMP) {
		// 检查用户信息
		if (index == 0) {
			getCheckInfoRecharge();
		} else {
			getCheckInfo();
		}
	}
}

function getCheckInfo() {
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
					dismissMsgBtn();
					if (checkInfo.paypassword == 0) {
						$("#return_message")[0].innerHTML = "请先设置支付密码";
						$("#msg_btn_0")[0].style.display = "block";
						flag = true;
					} else if (checkInfo.realname == 0) {
						$("#return_message")[0].innerHTML = "请先进行实名认证";
						$("#msg_btn_1")[0].style.display = "block";
						flag = true;
					} else if (checkInfo.fund == 0) {
						$("#return_message")[0].innerHTML = "请先进行充值";
						$("#msg_btn_3")[0].style.display = "block";
						flag = true;
					} else if (checkInfo.bankcard == 0) {
						$("#return_message")[0].innerHTML = "请先绑定银行卡";
						$("#msg_btn_2")[0].style.display = "block";
						flag = true;
					}
					if (flag) {
						$('#myModal').on('shown.bs.modal', function() {
							$('#myInput').focus();
						});
						$('#myModal').modal('toggle');
						$('#myModal')[0].click();
					} else {
						window.location.href = "money_cash.jsp";
					}
				} else {
					errorMsg(info.errInfo);
				}
			} else {
				if (isEmpty(response.result)) {
					errorMsg(response.msg);
				} else {
					window.location.href = response.result + "?reflect_url="
							+ encodeURIComponent("personal_center.jsp");
				}
			}

			$("#account_cash").attr("disabled", false);
		},
		dataType : "json"
	});
}

function getCheckInfoRecharge() {
	var c = true;
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
					$("#msg_btn_4")[0].style.display = "none";
					$("#msg_btn_5")[0].style.display = "none";
					$("#msg_btn_6")[0].style.display = "none";
					$("#msg_btn_7")[0].style.display = "none";
					$("#check_epay_result")[0].style.display = "none";

					if (checkInfo.paypassword == 0) {
						$("#return_message")[0].innerHTML = "请先设置支付密码";
						$("#msg_btn_0")[0].style.display = "block";
						flag = true;
					} else if (checkInfo.realname == 0) {
						$("#return_message")[0].innerHTML = "请先进行实名认证";
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
						c = false;
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
					window.location.href = response.result + "?reflect_url="
							+ encodeURIComponent("personal_center.jsp");
				}
			}

			$("#account_recharge").attr("disabled", false);
		},
		dataType : "json"
	});
	return c;
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
	case 4:
		window.location.href = "project.jsp";
		break;
	case 5:
		window.location.href = "personal_center.jsp";
		break;
	case 6:
		// ump绑卡
		window.location.href = "ump_bind_card.jsp";
		break;
	case 7:
		// 联动开户
		window.location.href = "reg_tip.jsp";
		break;
	}
}

function daySignIn() {
	window.location.href = "shake_sign.jsp";
}

function toFincDetail(event) {
	// 去交易记录
	event.stopPropagation();//组织父dom点击事件
	window.location.href = "income_details.jsp";
}

function toMyReferrer() {
	window.location.href = "friends_refer.jsp?referrer=" + login_name_u_hex
			+ "&from=weixin";
}

function checkHasMessage() {
	$.ajax({
		type : "POST",
		url : "account/message/hasread/check.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.resultObject.hasNoRead == 1) {
					// 有未读信息
					$("#lingd")[0].style.display = "none";
					$("#lingdred")[0].style.display = "block";
				} else {
					$("#lingdred")[0].style.display = "none";
					$("#lingd")[0].style.display = "block";
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

function toMessageCenter() {
	window.location.href = "message_center.jsp";
//	window.location.href = "aswipe.jsp";
}

function toMyPoints() {
	window.location.href = "coupon_record.jsp";
}
function toMyCoupon() {
	window.location.href = "my_coupon.jsp";
}
function toMyTicket() {
	window.location.href = "my_ticket.jsp";
}

function refresh() {
	location.reload();
}
function toInvest() {
	window.location.href = "project.jsp";
}

function dismissMsgBtn(){
	$("#msg_btn_0")[0].style.display = "none";
	$("#msg_btn_1")[0].style.display = "none";
	$("#msg_btn_2")[0].style.display = "none";
	$("#msg_btn_3")[0].style.display = "none";
	$("#msg_btn_4")[0].style.display = "none";
	$("#msg_btn_5")[0].style.display = "none";
	$("#msg_btn_6")[0].style.display = "none";
	$("#msg_btn_7")[0].style.display = "none";
	$("#msg_btn_8")[0].style.display = "none";
	$("#check_epay_result")[0].style.display = "none";
}

function toDaJiaHui(){
	window.location.href = "coupon_market.jsp";
}

function showBg(){
		$("#bg").css({
			display : "none",
			height : $(document).height()
		});
		$("#qd")[0].style.display = "none";
		$("#ewm")[0].style.display = "none";
}
function toDownloadApp(){
	window.location.href="http://a.app.qq.com/o/simple.jsp?pkgname=com.dyxd.rqt&g_f=991653";
}
function cancelDownload(event){
	event.stopPropagation();//阻止父dom点击事件
	$("#download")[0].style.display = "none";
	window.localStorage.setItem("dismissDownload",true);
}

function toMyCoupon(){
	// window.location.href = "my_coupon_center.jsp";
	window.location.href = "sys/user/award/myGift.jsp"
}

/**获取推荐获得奖励信息*/
function getReferInfo(){
	$.ajax({
		type : "POST",
		url : "account/refer/reward/get.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					$("#refer_income")[0].innerHTML = info.resultObject.returnMoney;
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

function atuoInvest(){
	if(!(this.UMPRegistered)){
		dismissMsgBtn();
		$("#check_epay_result")[0].style.display = "block";
		var table = $("#return_message");
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
	}else
	if(1 == parseInt(openNoPassword)){
		window.location.href = "auto_invest.jsp";
	}else{
		dismissMsgBtn();
		$("#msg_btn_8")[0].style.display = "block";
		$("#return_message")[0].innerHTML = "只有开通免密协议,才能使用自动投标功能";
		$('#myModal').on('shown.bs.modal', function() {
			$('#myInput').focus();
		});
		$('#myModal').modal('toggle');
		$('#myModal')[0].click();
	}
}
function openNoPasswordInvest(){//免密
	$.ajax({
		type: "POST",
		url: "ump/payment/open.do",
		data: {
			payment:"ZTBB0G00",
			returl:"http://www.rqbao.com/rqb/ump_callback_result.jsp",
		},
		success: function(response) {
			if(response.success){
				var info = $.parseJSON(response.result);
				document.getElementById("no_password_form")
				.setAttribute("action",info.resultObject.url);
				$("#no_password_form").submit();
			}else{
				if(isEmpty(response.result)){
					errorMsg(response.msg);
				}else{
					window.location.href = response.result;
				}
			}
		},
		dataType: "json"
	});
}