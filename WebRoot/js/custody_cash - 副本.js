var b_money = 100;
var iniChecked = false;
var basePath = $("#basePath").val();
$(function() {
	getCardInfo();//初始化提现账户金额信息
	initTixianQuan();//初始化提现信息
	$("#addWithdrawInfo li").click(function(){
		var cash_money = Number($("#cash_money").val());//输入提现金额
		var fee = (Number($("#feeRate").val())*Number(cash_money));//手续费
		var withdrawInput = Number($(this).find("input").val());//选中的提现框的值
		var withdrawCash = $(".withdrawCash a").text();//选中提现券之后展示的提现券值
		withdrawCash = $(".withdrawCash a").text(Number($(this).find("input").val()) + "元提现券");
	   if(cash_money < 2){
		   	$("#withdrawErr").text('请输入正确的提现金额。');
		   	return;
		} else {
			var checkinp = $(this).find("input");
			$("#addWithdrawInfo li input").attr('checked',false);
			checkinp.attr('checked',true);
			$("#withdrawErr").text('');
		}
		if($("#addWithdrawInfo li").hasClass("w_checked")){
			$("#addWithdrawInfo li").siblings().removeClass("w_checked");
		}
		$(this).addClass("w_checked").siblings().removeClass("w_checked");
		$(this).addClass("w_checked").siblings().removeClass("w_checked");
		$(this).css("color","#ff5555").siblings().css("color","#333");
	    if ((fee - withdrawInput) < 0) {
		    fee = Number("0.00");
	    } else {
		    fee = (fee - withdrawInput).toFixed(2);
	    }
		$("#fee").text(fee);
     	$(".fixedDirlog").hide();
    	$(".withdrawCashBox").hide();
	});
});

// 如果选中 不使用提现券，则重新计算提现手续费
function disuseClick(){
	$(".withdrawCash a").text("提现券");
	$(".w_checked").css("color","#333");
	calculateWithdrawCash();
	$(".fixedDirlog").hide();
	$(".withdrawCashBox").hide();
}  


//检查提现信息
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
					$("#msg_btn_0")[0].style.display = "none";
					$("#msg_btn_1")[0].style.display = "none";
					$("#msg_btn_2")[0].style.display = "none";
					$("#msg_btn_3")[0].style.display = "none";
					$("#msg_btn_4")[0].style.display = "none";
					$("#msg_btn_5")[0].style.display = "none";
					$("#check_epay_result")[0].style.display = "none";

					if (checkInfo.paypassword == 0) {
						$("#tip_content")[0].innerHTML = "请先设置支付密码";
						$("#msg_btn_0")[0].style.display = "block";
						flag = true;
					} else if (checkInfo.realname == 0) {
						$("#tip_content")[0].innerHTML = "请先设进行实名认证";
						$("#msg_btn_1")[0].style.display = "block";
						flag = true;
					} else if (checkInfo.fund == 0) {
						$("#tip_content")[0].innerHTML = "请先充值";
						$("#msg_btn_3")[0].style.display = "block";
						flag = true;
					} else if (checkInfo.bankcard == 0) {
						$("#tip_content")[0].innerHTML = "请先绑定银行卡";
						$("#msg_btn_2")[0].style.display = "block";
						flag = true;
					}
					if (flag) {
						$('#myModal').on('shown.bs.modal', function() {
							$('#myInput').focus();
						});
						$('#myModal').modal('toggle');
						$('#myModal')[0].click();

						$("#cash_btn").attr("disabled", false);
					} else {
						real_cash();
					}
				} else {
					errorMsg(info.errInfo);
					$("#cash_btn").attr("disabled", false);
				}
			} else {
				if (isEmpty(response.result)) {
					errorMsg(response.msg);
				} else {
					window.location.href = response.result + "?reflect_url="
							+ encodeURIComponent("ump_money_cash.jsp");
				}
				$("#cash_btn").attr("disabled", false);
			}
		},
		dataType : "json"
	});
}






function cash() {
	if(realNametf && bankCodetf){
		doUMPCash();
	} 
} 

function doUMPCash() {
	if (umpCheck()) {
		var money = $("#cash_money")[0].value;
		$.ajax({
			type : "POST",
			url : basePath + "/cg/trade/withdraw.do",
			data : {
				amount : money,
				memberCouponId:$("#addWithdrawInfo li.w_checked input").attr('id'),
				returnUrl : 'http://'+document.domain + window.location.pathname
			},
			success : function(response) {
				//console.log(response);
				if (response.success) {
					var info = $.parseJSON(response.result);
					if (info.result == "1") {
						//保存提现来源
				    	var myWindow = window.open('', '_self');
		       			myWindow.document.write(info.resultObject);
					} else {
						alert(info.errInfo);
					}
				} 
			},
			dataType : "json"
		});
	}
}

function real_cash() {
	if (checkWithdraw()) {
		var money = $("#cash_money")[0].value;
		var password = $("#cash_password")[0].value;
		$.ajax({
			type : "POST",
			url : "money/cash.do",
			data : {
				money : money,
				password : password
			},
			success : function(response) {
				if (response.success) {
					var info = $.parseJSON(response.result);
					if (info.result) {
						$("#tip_content")[0].innerHTML = "提现成功！";

						$("#msg_btn_0")[0].style.display = "none";
						$("#msg_btn_1")[0].style.display = "none";
						$("#msg_btn_2")[0].style.display = "none";
						$("#msg_btn_3")[0].style.display = "none";

						$("#msg_btn_4")[0].style.display = "block";
						$("#msg_btn_5")[0].style.display = "block";
						$("#check_epay_result")[0].style.display = "none";

						$('#myModal').on('shown.bs.modal', function() {
							$('#myInput').focus();
						});
						$('#myModal').modal('toggle');
						$('#myModal')[0].click();
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
				$("#cash_btn").attr("disabled", false);
			},
			dataType : "json"
		});
	} else {
		$("#cash_btn").attr("disabled", false);
	}
}

function checkWithdraw() {
	var money = $("#cash_money")[0].value;  //输入的提现金额
	var balance = parseFloat( $("#account_balance").text());
	/*var password = $("#cash_password")[0].value;*/
	if (iniChecked) {
		if (isEmptyStr(password)) {
			errorMsg("请填写支付密码");
			return false;
		}
		return true;
	}
	if (!checkStr(money, regexes.float)) {
		errorMsg("请正确填写金额");
		return false;
	}

	if (money < 100) {
		errorMsg("填写金额应当大于等于100元");
		return false;
	}

	if (money > balance) {
		errorMsg("填写金额应当小于等于账户余额");
		return false;
	}

	/*if (isEmptyStr(password)) {
		errorMsg("请填写支付密码");
		return false;
	}*/

	return true;
}
function umpCheck() {
	var money = $("#cash_money")[0].value;
	var balance = parseFloat( $("#account_balance").text()); //可提现账户金额

	if (iniChecked) {
		return true;
	}
	if (!checkStr(money, regexes.float)) {
		errorMsg("请正确填写金额");
		return false;
	}
	if (money < 100) {
		errorMsg("填写金额应当大于等于100元");
		return false;
	}
	if (money > balance) {
		errorMsg("填写金额应当小于等于账户余额");
		return false;
	}
	return true;
}


//动态监听提现输入框的边框
$("#cash_money").bind('input propertychange',function(){
	var cash_money = $("#cash_money").val();
	if(cash_money == "" || cash_money =="0" || cash_money =="0.00"  || cash_money == null || cash_money == "null"){
		$("#fee").text('0.00');
		return;
	}
	$("#withdrawErr").text('');
	calculateWithdrawCash();
	
})


//计算提现手续费
function calculateWithdrawCash(){
	var money = $("#cash_money").val();  //提现金额
	fee = (Number($("#feeRate").val())*Number(money)).toFixed(2);//手续费
		if(fee > 2){//如果手续费金额大于2
			$("#fee").text(fee);
		} else {
			$("#fee").text("2");
		}
				
}


//提现券窗口
function openCheck(){

	$(".fixedDirlog").show();
	$(".withdrawCashBox").show();
}

function initTixianQuan() {
	//获取提现费信息
	$.ajax({
		url : basePath + "/cg/mem/coupon/list.do",
		type : "POST",
		dataType : "json",
		async : false,
		data :{
			status:1
		},
		success : function(response) {
			// 最大的提现券
			var maxVal = 0;
			var info = $.parseJSON(response.result);
			var data = info.resultObject.giftList;
			var llBalance = parseFloat( $("#account_balance").text());
			if (info.result =="1") {
				var str = "";
				if (!isEmptyStr(data)) {
					str += '<div class="disuse" onclick="disuseClick();">';
					str += '不使用提现劵';
					str += '</div>';
					$.each(data,function(index,obj){
						str += '<li class="withdrawCheck">';
						str += '<span>'+ obj.validity +'</span>'+ obj.amount +'元提现劵';
						str += '<input id="'+ obj.couponId +'" name="coupon" type="checkbox" value="'+ obj.amount +'" class="couponinput" >';
						if (maxVal < Number(obj.amount)) {
							maxVal = Number(obj.amount);

						}
						str += '</li>';
					})
					$(".withdrawCash a").html(maxVal + "提现券");

				} else {
						str += '<li>';
						str += '<span></span>暂无记录';
						str += '<input id="-1" name="coupon" type="checkbox" value="-1" class="couponinput" >';
						str += '</li>';
						$(".withdrawCash a").css({"text-decoration":"none","color":"#999","cursor ":"default"});
						$(".withdrawCash a").text("无提现券可用");
						$(".withdrawCash a").removeAttr("onclick","openCheck()");
				}
				 $("#addWithdrawInfo").html(str);
			} 
		},
	});
}





/** 重新填写金额时，清除错误信息，提现金额大于账户余额时，提示用户 */
function changeCash(value) {
	errorMsg("");
	var avalibleAmount = $("#account_balance").text();
	if (value > parseFloat(avalibleAmount)) {
		errorMsg("余额不足");
	}
	
	
}


/** 检查是否是联动用户 */
function checkUMPRegister(index) {
	$("#cash_btn").attr("disabled", true);
	$.ajax({
		type : "POST",
		url : "ump/check/register/status.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				var data = info.resultObject;
				// 检查联动开启时间
				if ("1" == data.liandongStart) {// 联动已经开启
					// 检查注册状态
					if ("1" == data.liandongRegister) {
						UMPRegistered = true;
					} else {
						UMPRegistered = false;
						// 已经在联动开户
					}
					if ("1" == data.liandongBankcard) {
						liandongBankcard = true;
						if ("1" == data.isOpenFastPayment) {
							isOpenFastPayment = "DEBITCARD";
						} else {
							isOpenFastPayment = "B2CDEBITBANK";
						}
					} else {
						liandongBankcard = false;
					}

				} else {// 联动时间未开启
					$("#psw_tr")[0].style.display = "";
					$("#account_bl_tr")[0].style.display = "";
				}
			} else {
				if (isEmpty(response.result)) {
					errorMsg(response.msg);
				} else {
					window.location.href = response.result + "?reflect_url="
							+ encodeURIComponent("ump_money_cash.jsp");
				}
			}
			$("#cash_btn").attr("disabled", false);
		},
		dataType : "json"
	});
}


function showCashRecord(){
	window.location.href = "money_record.jsp?type=cash";
}

function changeCard(){
	window.location.href = "identify.jsp";
}

function getCardInfo(){
	$.ajax({
        type : "POST",
        url : "account/mybandcard/info/get.do",
        data : {
        },
        success : function(response) {
            if (response.success) {
                var info = $.parseJSON(response.result);
                if (info.result) {
                	var data = info.resultObject;
                	$("#bank_name")[0].innerHTML = data.bankName;
                    $("#bank_code")[0].innerHTML ="尾号" + data.cardId;
                    var doc = document.getElementById("bank_logo");
                    switch (data.gateId) {
					case "ICBC":
						doc.setAttribute("src", "images/logo/gs_bk.png");
						break;
					case "BOC":
                        doc.setAttribute("src", "images/logo/zg_bk.png");
                        break;
					case "ABC":
                        doc.setAttribute("src", "images/logo/ny_bk.png");
                        break;
					case "CCB":
                        doc.setAttribute("src", "images/logo/js_bk.png");
                        break;
					case "COMM":
                        doc.setAttribute("src", "images/logo/jt_bk.png");
                        break;
					case "PSBC":
                        doc.setAttribute("src", "images/logo/yc_bk.png");
                        break;
					case "CMBC":
                        doc.setAttribute("src", "images/logo/mc_bk.png");
                        break;
					case "CITIC":
                        doc.setAttribute("src", "images/logo/zx_bk.png");
                        break;
					case "CEB":
                        doc.setAttribute("src", "images/logo/gd_bk.png");
                        break;
					case "HXB":
                        doc.setAttribute("src", "images/logo/hx_bk.png");
                        break;
					case "GDB":
                        doc.setAttribute("src", "images/logo/gf_bk.png");
                        break;
					case "CIB":
                        doc.setAttribute("src", "images/logo/xy_bk.png");
                        break;
					case "SPDB":
                        doc.setAttribute("src", "images/logo/pf_bk.png");
                        break;
					case "SPAB":
                        doc.setAttribute("src", "images/logo/pa_bk.png");
                        break;
					case "CMB":
                        doc.setAttribute("src", "images/logo/zs_bk.png");
                        break;
					}
                    //$("#bank_info")[0].style.display = "block";
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

/**检查是否开启快捷支付*/
function checkIfUMPRegister() {
    $.ajax({
        type : "POST",
        url : "ump/check/register/status.do",
        data : {},
        success : function(response) {
            if (response.success) {
                var info = $.parseJSON(response.result);
                var data = info.resultObject;
                        if("1" == data.isOpenFastPayment){
                            //$("#alopen")[0].style.display = "block";
                            //$("#alopen_img")[0].style.display = "block";
                        }else{
                            $("#openFastBtn")[0].style.display = "block";
                        }
            }else {
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

function doOpenPayment(){
    $("#openFastBtn").attr("disabled", true);
    $.ajax({
        type: "POST",
        url: "ump/payment/open.do",
        data: {
            payment:"ZKJP0700",
            returl:"http://www.rqbao.com/rqb/ump_callback_result.jsp",
        },
        success: function(response) {
            if(response.success){
            	var info = $.parseJSON(response.result);
                document.getElementById("payment_form")
                .setAttribute("action",info.resultObject.url);
                $("#payment_form").submit();
            }else{
                if(isEmpty(response.result)){
                    errorMsg(response.msg);
                }else{
                    window.location.href = response.result;
                }
            }
            $("#openFastBtn").attr("disabled", false);
        },
        dataType: "json"
    });
}


//提现券窗口
function feeShadows(){
	
	$(".fixedDirlog").show();
	$(".feeIntro").show();		
}

//关闭手续费窗口
function cancleShadows(){
	
	$(".fixedDirlog").hide();
	$(".feeIntro").hide();		
}


//关闭提现窗口
function closeWindow(){
	
	$(".fixedDirlog").hide();
	$(".withdrawCashBox").hide();
	$(".feeIntro").hide();	
}



