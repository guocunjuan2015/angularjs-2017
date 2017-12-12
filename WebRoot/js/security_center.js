var epayStatus = -1;

function modifyPassword() {
	window.location.href = "modify_password.jsp";
}

function modifyPayPassword() {
	window.location.href = "modify_paypassword.jsp";
}

function checkEPayRegister() {
	$.ajax({
		type : "POST",
		url : "account/yeepay/checkregister.do",
		data : {},
		success : function(response) {
			if (response.result == 1) {
				// 是易宝用户,index控制跳转
				epayStatus = 1;
				toEPayRegister();

			} else if (response.result == 0) {
				epayStatus = 0;
				$("#msg_content")[0].innerHTML = "你还没有开通易宝账户，是否前往开户?";
				$('#myModal').on('shown.bs.modal', function() {
					$('#myInput').focus();
				});
				$('#myModal').modal('toggle');
				$('#myModal')[0].click();
			} else {
				$("#account_verify")[0].style.display = "block";
				ePayStatus = 2;
				var info = response.result;
				var arr = info.split("\t");
				if (arr.length == 2) {
					$("#next_btn").attr("disabled", false);
					$("#req").val(arr[1]);
					$("#sign").val(arr[0]);
					$("#msg_content")[0].innerHTML = "你还没有开通易宝账户，是否前往开户?";
					$('#myModal').on('shown.bs.modal', function() {
						$('#myInput').focus();
					});
					$('#myModal').modal('toggle');
					$('#myModal')[0].click();
				} else {
					errorMsg("error！");
				}
			}
		},
		dataType : "json"
	});
}

function toEPayRegister() {
	// 分0/xml跳入不同页面
	if (epayStatus == 1) {
		//已经是易宝用户，去往易宝修改交易密码
		modifyEPayPsw();
	} else if (epayStatus == 0) {
		// 跳到易宝开户实名认证页面
		window.location.href = "ep_real_name.jsp";
	} else if (epayStatus == 2) {
		// 跳到易宝开户，注册页面
		$("#epayForm").submit();
	}
}

function modifyEPayPsw(){
	$.ajax({
		type : "POST",
		url : "yeepay/modify/password.do",
		data : {
		},
		success : function(response) {
			if (response.success) {
				var info = response.result;
					var arr = info.split("\t");
					if (arr.length == 2) {
						$("#req1").val(arr[1]);
						$("#sign1").val(arr[0]);
						$("#epayModifyPswForm").submit();
					}else{
						errorMsg($.parseJSON(info).errInfo);
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