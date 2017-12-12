var m_mess = "请输入格式正确的手机号!";

$(function(){
});

function curCheck(){
	if (isEmptyStr($("#cur_tel").val())) {
		errorMsg("请输入当前手机号");
		return false;
	}
	checkM("cur_tel");//检查手机号格式
	if (isEmptyStr($("#cur_code").val())) {
		errorMsg("请输入短信验证码");
		return false;
	}
	return true;
}

function newCheck(){
	if (isEmptyStr($("#new_tel").val())) {
		errorMsg("请输入新手机号");
		return false;
	}
	checkM("new_tel");
	if (isEmptyStr($("#new_code").val())) {
		errorMsg("请输入短信验证码");
		return false;
	}
	return true;
}

function modifyStep1(){
	if(curCheck()){
		$("#btn_modify").attr("disabled",true);
		$.ajax({
			type : "POST",
			url : "account/change/mobile.do",
			data : {
				m : $("#cur_tel").val(),
				c : $("#cur_code").val(),
				s : 1
			},
			success : function(response) {
				if (response.success) {
					var info = $.parseJSON(response.result);
					if (info.result) {
						window.location.href = "modify_mobile2.jsp";
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
		$("#btn_modify").attr("disabled",false);
	}
}
function modifyStep2(){
	if(newCheck()){
		$("#btn_modify").attr("disabled",true);
		$.ajax({
			type : "POST",
			url : "account/change/mobile.do",
			data : {
				m : $("#new_tel").val(),
				c : $("#new_code").val(),
				s : 2
			},
			success : function(response) {
				if (response.success) {
					var info = $.parseJSON(response.result);
					if (info.result) {
						$("#phone_code_div")[0].style.display = "none";
						$("#next_div")[0].style.display = "block";
						$('#myModal').on('shown.bs.modal', function() {
							$("#body_content_h4")[0].innerHTML = "手机号修改成功!"
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
			},
			dataType : "json"
		});
		$("#btn_modify").attr("disabled",false);
	}
}

function clearError(){
	errorMsg("");
}
function getRadioCode(index){
	var number = -1;
	switch (index) {
	case 1:
		m = "cur_tel";
		break;
	case 2:
		m = "new_tel";;
	}
	if (checkM(m)) {
		$("#next_div")[0].style.display = "none";
		$("#phone_code_div")[0].style.display = "block";
		$('#myModal').on('shown.bs.modal', function() {
			$("#body_content_h4")[0].innerHTML = "接收语音验证码?"
			$('#myInput').focus();
		});
		$('#myModal').modal('toggle');
		$('#myModal')[0].click();

	}
}
function sendRadioCode(index) {//获取语音验证码
	var number = -1;
	switch (index) {
	case 1:
		number = $("#cur_tel").val();
		break;
	case 2:
		number = $("#new_tel").val();
	}
	$.ajax({
		type : "POST",
		url : "register/getRadioCode.do",
		data : {
			m : number
		},
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

function getCode(index){
	var number = -1;
	var m = "";
	switch (index) {
	case 1:
		number = $("#cur_tel").val();
		m = "cur_tel";
		break;
	case 2:
		number = $("#new_tel").val();
		m = "new_tel";
	}
	if (checkM(m)) {
		$("#getc").attr("disabled", true);
		var count = 60;
		function CountDown() {
			$("#getc").attr("disabled", true);
			$("#getc").text("重新获取(" + count + "秒)");
			if (count == 0) {
				$("#getc").text("重新获取验证码").removeAttr("disabled");
				clearInterval(countdown);
			}
			count--;
		}
		var countdown = setInterval(CountDown, 1000);

		$.ajax({
			type : "POST",
			url : "register/getMCode.do",
			data : {
				m : number
			},
			success : function(response) {
			},
			dataType : "json"
		});

	}
}
function checkM(m_id) {
	return checkMpub(m_id, m_mess);
}
function checkMpub(id, message) {
	var flag = false;
	// 手机号正则
	if ($("#" + id).val().search(/^1[3-9][0-9]\d{4,8}$/) == -1) {
		errorMsg(m_mess);
	} else {
		flag = true;
	}
	return flag;
}

function gotoPage(){
	window.location.href = "ump_real_register.jsp";
}