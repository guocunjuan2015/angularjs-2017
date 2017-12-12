function checkLength(id, s_l, e_l, message) {
	var flag = false;
	if ($("#" + id).val().length >= s_l && $("#" + id).val().length <= e_l
			&& $("#" + id).val() != '') {
		flag = true;
	} else {
		$("#showMess").text(message);
	}
	return flag;
}

function checkRealCode(id, message) {
	var flag = false;
	// 手机号正则
	if ($("#" + id).val().search(/^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/) == -1) {
		$("#showMess").text(message);
	} else {
		flag = true;
	}
	return flag;
}

function toUMPRegister() {
	$("#next_btn").attr("disabled", true);
	if (checkLength("real_name", 2, 20, "真实姓名长度应该为2-20位之间")
			&& checkRealCode("real_code", "身份证号格式不正确!")) {
		$
				.ajax({
					type : "POST",
					url : "register/ump/register.do",
					data : {
						r : $("#real_name").val(),
						n : $("#real_code").val()
					},
					success : function(response) {
						if (response.success) {
							var info = $.parseJSON(response.result);
							if (info.result) {
								$("#msg_btn_45")[0].style.display = "none";
								$("#tip_content")[0].innerHTML = "支付密码将会以短信的形式发送到您的手机上，请及时修改密码并妥善保存。";
								$("#msg_btn_45")[0].style.display = "block";
								$('#myModal').on('shown.bs.modal', function() {
									$('#myInput').focus();
								});
								$('#myModal').modal('toggle');
								$('#myModal')[0].click();
								
								var tprm = "username=" + $("#userName").val();
						        __ozfac2(tprm, "#realNamesuccess");// 99-click，统计用户实名认证
							} else {
								$("#showMess").text(info.errInfo);
							}
						} else {
							if (isEmpty(response.result)) {
								$("#showMess").text(info.errInfo);
							} else {
								window.location.href = response.result
										+ "?reflect_url="
										+ encodeURIComponent("project_other_content.jsp?id="
												+ getRequestParam("id"));
							}
						}
					},
					dataType : "json"
				});
	}
	$("#next_btn").attr("disabled", false);
}

function cancel() {
	window.location.href = "personal_center.jsp";
}
function gotoPage() {
	window.location.href = "add_bankcard.jsp";
}
//协议
function onBoxClicked() {
	if (document.getElementById("agreeBox").checked) {
		enableInvest = true;
		$("#next_btn").attr("disabled", false);
	} else {
		enableInvest = false;
		$("#next_btn").attr("disabled", true);
	}
}

function toProxy() {
	window.location.href = "ump_proxy.jsp";
}

function cancelRegist(){
	window.location.href = "personal_center.jsp";
}