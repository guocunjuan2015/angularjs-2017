var projectId = "";
var isTransfer = "";
var needRecharge = "";
$(function() {  
	enableUMP = -1;
	getAccountInfo();
	initData();
	checkUMPRegister();
	checkIfUMPRegister();
	getCardInfo();
	//checkUMPRegister();
	
});
function initData(){
	projectId = getRequestParam("projectId");
	isTransfer = getRequestParam("isTransfer");
	needRecharge = getRequestParam("needRecharge");
	if(needRecharge){
		$("#recharge_money").val(parseFloat(needRecharge));
	}
}
function getAccountInfo() {
	//账户信息加载前，按钮不可点击
	$("#recharge_btn").attr("disabled", true);
	$
			.ajax({
				type : "POST",
				url : "account/detail/get.do",
				data : {},
				success : function(response) {
					if (response.success) {
						var info = $.parseJSON(response.result);
						if (info.result) {
							var accountInfo = info.resultObject;
								$("#account_balance")[0].innerHTML = formatCurrency(accountInfo.b);
								$("#recharge_btn").attr("disabled", false);
						} else {
							errorMsg(info.errInfo);
						}
					} else {
						if (isEmpty(response.result)) {
							errorMsg(response.msg);
						} else {
							window.location.href = response.result
									+ "?reflect_url="
									+ encodeURIComponent("ump_money_recharge.jsp");
						}
					}
				},
				dataType : "json"
			});
}


function recharge() {
	// $("#recharge_btn").attr("disabled", true);
		if(UMPRegistered){
			//联动开户了
			if(liandongBankcard){
				//联动绑卡了 - 去联动充值
				if("DEBITCARD" == isOpenFastPayment){
					doUMPRecharge();//只有开通快捷支付才能去充值
				}else{
					//弹出提示去开通快捷支付
					//doOpenPayment();
					$("#msg_btn_0")[0].style.display = "none";
					$("#msg_btn_1")[0].style.display = "none";
					$("#msg_btn_2")[0].style.display = "none";
					$("#msg_btn_3")[0].style.display = "none";
					$("#msg_btn_4")[0].style.display = "none";
					$("#msg_btn_5")[0].style.display = "none";
					$("#msg_btn_7")[0].style.display = "none";
					$("#check_epay_result")[0].style.display = "none";
					$("#msg_btn_6")[0].style.display = "block";
					$("#tip_content")[0].innerHTML = "您没有开通快捷支付，现在去开通?";
					$('#myModal').on('shown.bs.modal', function () {
						  $('#myInput').focus();
					});
					$('#myModal').modal('toggle');
					$('#myModal')[0].click();
				}
			}else{
				//提示去联动绑卡
				$("#msg_btn_0")[0].style.display = "none";
				$("#msg_btn_1")[0].style.display = "none";
				$("#msg_btn_2")[0].style.display = "none";
				$("#msg_btn_3")[0].style.display = "none";
				$("#msg_btn_4")[0].style.display = "none";
				$("#msg_btn_5")[0].style.display = "none";
				$("#msg_btn_6")[0].style.display = "none";
				$("#msg_btn_7")[0].style.display = "block";
				$("#check_epay_result")[0].style.display = "none";
				$("#tip_content")[0].innerHTML = "请先绑定银行卡，再进行资金交易";
				$('#myModal').on('shown.bs.modal', function () {
					  $('#myInput').focus();
				});
				$('#myModal').modal('toggle');
				$('#myModal')[0].click();
			}
		}else{
			//去联动开户
			$("#msg_btn_0")[0].style.display = "none";
			$("#msg_btn_1")[0].style.display = "none";
			$("#msg_btn_2")[0].style.display = "none";
			$("#msg_btn_3")[0].style.display = "none";
			$("#msg_btn_4")[0].style.display = "none";
			$("#msg_btn_5")[0].style.display = "none";
			$("#msg_btn_6")[0].style.display = "none";
			$("#msg_btn_7")[0].style.display = "none";
			$("#check_epay_result")[0].style.display = "block";
			var table = $("#tip_content");
			table[0].innerHTML = "";
			var row = '';
			row += "根据《关于促进互联网金融健康发展的指导意见》的要求，为平台用户提供更好、更安全、更规范的服务，瑞钱宝与联动优势合作，安全再升级。现将用户账户资金交由中信银行存管，";
			row += '<font style="color:#f64840;">需要您重新进行实名认证和绑定银行卡，请尽快操作</font>';
			row += "，以免影响您的正常使用，感谢您对平台的支持，给您带来的不变敬请谅解，如有任何疑问请致电客服：400-9198-555";
			table.append(row);
			$('#myModal').on('shown.bs.modal', function () {
				  $('#myInput').focus();
			});
			$('#myModal').modal('toggle');
			$('#myModal')[0].click();
		}
}
function doUMPRecharge(){
	if(check()){
		var money = $("#recharge_money")[0].value;
		var url = "http://www.rqbao.com/rqb/ump_callback_result.jsp";
		if(projectId){
    		//url = "http://www.rqbao.com/rqb/project_other_content.jsp?id="+projectId+"&isTransfer="+isTransfer+"&backFrom=recharge";
    	}
	$.ajax({
		  type: "POST",
		  url: "ump/money/recharge.do",
		  data: {amount:money,
			  payType:isOpenFastPayment,
			  retUrl : url,},
		  success: function(response) {
		   if(response.success){
		    var info = $.parseJSON(response.result);
		    if(info.result){
		    	//保存充值来源
		    	
		    	document.getElementById("ump_recharge_form")
				.setAttribute("action",info.resultObject.url);
				$("#ump_recharge_form").submit();
		    }else{
		     errorMsg(info.errInfo);
		    }
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
}

function doOpenPayment(){
	alert();
	$("#recharge_btn").attr("disabled", true);
	$.ajax({
		type: "POST",
		url: "ump/payment/open.do",
		data: {
			payment:"ZKJP0700",
			returl:"http://www.rqbao.com/rqb/ump_callback_result.jsp",
		},
		success: function(response) {
			//alert(response);
			if(response.success){
				var info = $.parseJSON(response.result);
            	window.location.href = info.resultObject.url;
              /*   document.getElementById("payment_form")
                .setAttribute("action",info.resultObject.url); */
                //$("#payment_form").submit();
			}else{
				if(isEmpty(response.result)){
					errorMsg(response.msg);
				}else{
					window.location.href = response.result;
				}
			}
			$("#recharge_btn").attr("disabled", false);
		},
		error:function(){
			alert();
		},
		dataType: "json"
	});
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
		//ump绑卡
		window.location.href = "ump_bind_card.jsp";
		break;
	case 7:
		//联动开户
		window.location.href = "ump_real_register.jsp";
		break;
		
	}
}

function real_recharge(){
	if(check()){
		var money = $("#recharge_money")[0].value;
		$.ajax({
			type: "POST",
			url: "money/recharge.do",
			data: {
				money: money
			},
			success: function(response) {
				if(response.success){
					$("#req_data")[0].value = response.result;
					var form = $("#request_form")[0];
					form.submit();
				}else{
					if(isEmpty(response.result)){
						errorMsg(response.msg);
					}else{
						window.location.href = response.result;
					}
				}
				$("#recharge_btn").attr("disabled", false);
			},
			dataType: "json"
		});
	}else{
		$("#recharge_btn").attr("disabled", false);
	}
}

function check() {
	var money = $("#recharge_money")[0].value;

	if (!checkStr(money, regexes.float)) {
		errorMsg("请正确填写金额");
		return false;
	}
	if (money < 100) {
		errorMsg("填写金额应当大于等于100元");
		return false;
	}
	return true;
}


/**检查是否是联动用户*/
function checkUMPRegister() {
	$("#recharge_btn").attr("disabled", true);
	$.ajax({
		type : "POST",
		url : "ump/check/register/status.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				var data = info.resultObject;
				//检查联动开启时间
				if("1" == data.liandongStart){//联动已经开启
					enableUMP = 1;
					//检查注册状态
					if("1" == data.liandongRegister){
						UMPRegistered = true;
					}else {
						UMPRegistered = false;
						//已经在联动开户
					}
					if("1" == data.liandongBankcard){
						liandongBankcard = true;
						if("1" == data.isOpenFastPayment){
							isOpenFastPayment = "DEBITCARD";
						}else{
							isOpenFastPayment = "B2CDEBITBANK";
						}
					}else{
						liandongBankcard = false;
					}
					
				}else {//联动时间未开启
					enableUMP = 0;
				}
			}else {
				if (isEmpty(response.result)) {
					errorMsg(response.msg);
				} else {
					window.location.href = response.result
							+ "?reflect_url="
							+ encodeURIComponent("ump_money_recharge.jsp");
				}
			}
		},
		dataType : "json"
	});
	$("#recharge_btn").attr("disabled", false);
}

/**重新输入金额，错误信息清除*/
function changeRecharge(){
	errorMsg("");
}

function showRechargeRecord(){
	window.location.href = "money_record.jsp?type=recharge";
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
                    $("#bank_info")[0].style.display = "block";
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

                            /*$("#alopen")[0].style.display = "block";
                            $("#alopen_img")[0].style.display = "block";*/
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
            	window.location.href = info.resultObject.url;
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
