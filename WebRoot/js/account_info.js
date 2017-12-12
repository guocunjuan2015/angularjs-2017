//页面定义html字体大小
(function (doc,win) {
	var docEl = doc.documentElement,
        resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
    recalc = function (){
        var clientWidth = docEl.clientWidth;
        if (!clientWidth) {return ;}
    	docEl.style.fontSize = 10 * (clientWidth / 375) +"px";
    };
    if(!doc.addEventListener) return;
    win.addEventListener(resizeEvt,recalc,false);
    doc.addEventListener('DOMContentLoaded',recalc,false);
})(document,window);
var notRealName = false;
$(function(){
	checkUMPRegister();
	initData();
});

function initData(){
	if(getRequestParam("vip_rank")){
		$("#vip_rank")[0].innerHTML = 'V'+getRequestParam("vip_rank");
	}
	if(getRequestParam("user_mobile")){
		$("#user_mobile")[0].innerHTML = getRequestParam("user_mobile");
	}
}

function toUmpRealName(){
	if(notRealName){
		window.location.href = "ump_real_register.jsp";
	}
}

function modifyPassword() {
	window.location.href = "modify_password.jsp";
}

function modifyPayPassword() {
	if(enableUMP == 1){
		if(UMPRegistered){
			if(liandongBankcard){
				dismissMsgBtn();
				$("#modefy_psw")[0].style.display = "block";
				$("#return_message")[0].innerHTML = "您可以编辑短信‘GGMM#原密码#新密码’发送至联动优势10690569687修改您的支付密码，支付密码只能是6位数字.";
				$('#myModal').on('shown.bs.modal', function() {
					$('#myInput').focus();
				});
				$('#myModal').modal('toggle');
				$('#myModal')[0].click();
			}else{
				dismissMsgBtn();
				$("#msg_btn_1")[0].style.display = "block";
				$("#return_message")[0].innerHTML = "请先绑定银行卡，再进行资金交易";
				$('#myModal').on('shown.bs.modal', function() {
					$('#myInput').focus();
				});
				$('#myModal').modal('toggle');
				$('#myModal')[0].click();
			}
		}else{
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
	} 
}

function checkUMPRegister() {
	$
			.ajax({
				type : "POST",
				url : "ump/check/register/status.do",
				data : {},
				success : function(response) {
					if (response.success) {
						var info = $.parseJSON(response.result);
						var data = info.resultObject;
						// 检查联动开启时间
						if ("1" == data.liandongStart) {// 联动已经开启
							enableUMP = 1;
							// 检查注册状态
							if ("1" == data.liandongRegister) {
								UMPRegistered = true;
								$("#ump_open_right")[0].innerHTML = "已实名";
							} else {
								UMPRegistered = false;
								// 联动未开户
								var table = $("#real_li");
								var row = '<span class="fr clickImg"></span>';
								row += '<span class="fr" id="ump_open_right">未实名</span>';
								table.append(row);
							}
							if ("1" == data.liandongBankcard) {
								liandongBankcard = true;
								//绑定完卡，提示用户去修改联动支付密码
								$("#ump_bind_right")[0].innerHTML = "已绑卡";
							} else {
								liandongBankcard = false;
								$("#ump_bind_right")[0].innerHTML = "未绑卡";
							}
						} else {// 联动时间未开启
							enableUMP = 0;
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

function umpBind(){
	if(liandongBankcard){
		/*dismissMsgBtn();
		$("#msg_btn_0")[0].style.display = "block";
		$("#return_message")[0].innerHTML = "您已经绑卡!";
		$('#myModal').on('shown.bs.modal', function() {
			$('#myInput').focus();
		});
		$('#myModal').modal('toggle');
		$('#myModal')[0].click();*/
		window.location.href = "change_bind_card.jsp";
		
	}else{
		if(UMPRegistered){
			window.location.href = "ump_bind_card.jsp";
		}else{
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
	}
}

function toUmpBind(){
	window.location.href = "ump_bind_card.jsp";
}

function umpRegister(){
	if(UMPRegistered){
		dismissMsgBtn();
		$("#msg_btn_0")[0].style.display = "block";
		$("#return_message")[0].innerHTML = "您已经开通第三方资金托管!";
		$('#myModal').on('shown.bs.modal', function() {
			$('#myInput').focus();
		});
		$('#myModal').modal('toggle');
		$('#myModal')[0].click();
	}else{
		window.location.href = "ump_real_register.jsp";
	}
}

function toUmpRegister(){
	window.location.href = "ump_real_register.jsp";
}

function deliveryAddress(obj){
	var localPath=$("#localPath").val();
	 $.ajax({
	        type:"POST",
	        url:localPath+"/lotteryAward/checkUserReg", 
	        dataType:"json",
	        data:{
	         loginName:$("#loginName").val()
	         },
	        success:function(response){
	          var code = response.status;
	          if(code == "1"){
	        	  window.location.href = "addressInfo.jsp?phone="+obj; 
	       }
	          else{
	        	  alert(response.message); 
	              return;
	          }
	       }   
	});
}

function logout() {
	$.ajax({
		type : "POST",
		url : "register/logout.do",
		data : {},
		success : function(response) {
			if (response.success) {
				window.location.href = "login.jsp";
			} else {
				errorMsg(response.msg);
			}
		},
		dataType : "json"
	});
}

function resetPayPsw(){
	if(UMPRegistered){
		if(liandongBankcard){
			dismissMsgBtn();
			$("#reset_psw")[0].style.display = "block";
			$("#return_message")[0].innerHTML = "点击确认重置联动账户支付密码，新密码将发送至您的手机";
			$('#myModal').on('shown.bs.modal', function() {
				$('#myInput').focus();
			});
			$('#myModal').modal('toggle');
			$('#myModal')[0].click();
		}else{
			dismissMsgBtn();
			$("#msg_btn_1")[0].style.display = "block";
			$("#return_message")[0].innerHTML = "请先绑定银行卡，再进行资金交易";
			$('#myModal').on('shown.bs.modal', function() {
				$('#myInput').focus();
			});
			$('#myModal').modal('toggle');
			$('#myModal')[0].click();
		}
	}else{
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
}

function dismissMsgBtn(){
	$("#msg_btn_0")[0].style.display = "none";
	$("#msg_btn_1")[0].style.display = "none";
	$("#reset_psw")[0].style.display = "none";
	$("#modefy_psw")[0].style.display = "none";
	$("#check_epay_result")[0].style.display = "none";
}

function doReset(){
	$.ajax({
		type : "POST",
		url : "ump/paypassword/reset.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
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

function vipLevel(){
	window.location.href = "my_level.jsp";
}

 