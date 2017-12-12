/*******************************************************************************
 * --------------------------------注册相关-------------------------------------------*
 ******************************************************************************/
// 注册
var regetCode = false;
var utm_source = "";
var uid = "";
var hid = "";
var f = 22;
$(function() {
	initialChannel();
	initFubaba();
});

function initialChannel(){
	if (getRequestParam("channel")) {
		f = getRequestParam("channel");
		var storage = window.sessionStorage;
		storage.setItem("channel", f);
	} 
	if (window.sessionStorage.getItem("channel")) {
		f = window.sessionStorage.getItem("channel");
	}  
	if (getRequestParam("utm_source")) {
		f = getRequestParam("utm_source");
		var storage = window.sessionStorage;
		storage.setItem("utm_source", f);
	}
	if (getRequestParam("id")) {
		hid = getRequestParam("id");
		var storage = window.sessionStorage;
		storage.setItem("hid", hid);
	}
}
function initFubaba() {
	if (window.sessionStorage.getItem("utm_source")) {
		utm_source = window.sessionStorage.getItem("utm_source");
	}
	if (window.sessionStorage.getItem("uid")) {
		uid = window.sessionStorage.getItem("uid");
	}

}

function register(url) {
	if ("fbaba" == window.sessionStorage.getItem("utm_source")) {
		f = 4;
	}
	$.ajax({
		type : "POST",
		url : basePath + "/register/regist.do",
		data : {
			u : $("#m").val(),
			p : $("#p").val(),
			m : $("#m").val(),
			c : $("#c").val(),
			f : '4047',
			hid : hid,
			referrer : $("#referrer").val()
		},
		success : function(response) {
			var infoJson = response.result;
			var info = $.parseJSON(infoJson);
			var res = info.result;
			if (res == 1) {
				var tprm = "username=" + $("#m").val() + "&phone="
						+ $("#m").val() + "&referrer=" + $("#referrer").val();
				/*__ozfac2(tprm, "#regsuccess");*/// 99-click，统计用户行为

				setTimeout(function() {
					window.location.href = url;
				}, 300);
			} else {
				$("#showMess").text(info.errInfo);
			}
			$("#step").attr("disabled", false);
			$("#finish").attr("disabled", false);
		},
		dataType : "json"
	});
}

function gotoPage() {
	window.location.href = "login.jsp";
}

function changeVCode() { 
	
	   $("#imgObj").attr("src", "/servlet/validateCodeServlet?"+new Date().getTime()); 
}
// 获取手机验证码
$(document).ready(function() {
	
	$("#getc").click(function() {
		if(regetCode){
			//图片验证码置空，验证码刷新
			$("#vc").val("");
			$("#c").val("");
			changeVCode();
			regetCode = false;
		}
		if (checkM("m") && checkVC("vc") && checkVCIsExist()) {
			$("#getc").attr("disabled", true);

			var count = 100;
			function CountDown() {
				$("#getc").attr("disabled", true);
				$("#getc").text("重新获取(" + count + "秒)");
				if (count == 0) {
					$("#getc").text("重新获取验证码").removeAttr("disabled");
					clearInterval(countdown);
					regetCode = true;
				}
				count--;
			}
			var countdown = setInterval(CountDown, 1000);

			$.ajax({
				type : "POST",
				url : basePath + "/register/getMCode.do",
				data : {
					m : $("#m").val()
				},
				success : function(response) {
				},
				dataType : "json"
			});

		}
	});
});

// 下一步
$(document).ready(function() {
	$("#step").click(function() {
		$("#step").attr("disabled", true);
		$("#finish").attr("disabled", true);
		// 验证用户，手机号，密码，图形验证码，手机验证码
		
		//
		
		
		if (checkM("m") && checkP("p") && checkVCIsExist() && checkC("c")) {
			
			checkUser( basePath + "/active/518active/518active.jsp");
		} else {
			$("#step").attr("disabled", false);
			$("#finish").attr("disabled", false);
		}
	});
});

// 完成
$(document).ready(function() {
	$("#finish").click(function() {
		$("#step").attr("disabled", true);
		$("#finish").attr("disabled", true);
		// 验证用户，手机号，密码，图形验证码，手机验证码
		if (checkM("m") && checkP("p") && checkVCIsExist() && checkC("c")) {
			checkUser("personal_center.jsp");
		} else {
			$("#step").attr("disabled", false);
			$("#finish").attr("disabled", false);
		}
	});
});

// 上一步
$(document).ready(function() {
	$("#be_step").click(function() {
		// 前往上一步
		$("#step_op").show();
		$("#register_op").hide();
	});
});

/*******************************************************************************
 * --------------------------------登录相关-------------------------------------------*
 ******************************************************************************/
$(document).ready(function() {
	$("#login").click(function() {
		$("#login").attr("disabled", true);
		if (!checkP("p")) {
			$("#login").attr("disabled", false);
			return;
		}
		$.ajax({
			type : "POST",
			url : basePath +"/register/login.do",
			data : {
				u : $("#u").val(),
				p : $("#p").val()
			},
			success : function(response) {
				var infoJson = response.result;
				var info = $.parseJSON(infoJson);
				var res = info.result;
				if (res == 1) { 
					var userId = info.resultObject.userId;
					var url = getRequestParam("reflect_url");
					if ($("#active").val() != null && $("#active").val() == "715") {
						window.location.href = "/rqb/active/715active/715active.jsp?userId=" + userId;
					}else if($("#active").val() != null && $("#active").val() == "watermelon"){
					
						window.location.href = "/rqb/active/watermelon/watermelon.jsp?userId=" + userId;
					} else if($("#active").val() != null && $("#active").val() == "mid_Autumn"){
						window.location.href = "/rqb/active/mid_Autumn/mid_Autumn.jsp?userId=" + userId;
					} else if ($("#active").val() != null && $("#active").val() == "doubleEleven") {
						window.location.href = "/rqb/active/doubleTenthActive/doubleTenthActive.jsp?userId=" + userId;
					}  else if ($("#active").val() != null && $("#active").val() == "thanksGiving") {
						window.location.href = "/rqb/active/thanksGiving/thanksGiving.jsp?userId=" + userId;
					} else if ($("#active").val() != null && $("#active").val() == "doubleDay") {
						window.location.href = "/rqb/active/doubleDay/doubleDay.jsp?userId=" + userId;
					} else if ($("#active").val() != null && $("#active").val() == "mar") {
						window.location.href = "/rqb/active/mar/mar.jsp?userId=" + userId;
					} else if ($("#active").val() != null && $("#active").val() == "aprilOuting") {
						window.location.href = "/rqb/active/aprilOuting/aprilOuting.jsp?userId=" + userId;
					}  else {
						if (isEmptyStr(url)) {
							window.location.href = "personal_center.jsp";
						} else {
							window.location.href = decodeURIComponent(url);
						}
					} 
				} else {
					$("#showMess").text(info.errInfo);
				}

				$("#login").attr("disabled", false);
			},
			dataType : "json"
		});
	});
});

// 登录页面跳转到注册
$(document).ready(function() {
	$("#register_login").click(function() {
		if(getRequestParam("referrer")){
			window.location.href = "register_referrer.jsp?reflect_url=scratch_card.jsp&referrer="
				  + getRequestParam("referrer");
		}else{
			window.location.href = "ump_register.jsp";
		}
	});
});

// 找回密码
$(document).ready(function() {
	$("#lostPwd").click(function() {
		window.location.href = "forget_password.jsp";
	});
});

/*******************************************************************************
 * --------------------------------验证相关-------------------------------------------*
 ******************************************************************************/

var u_mess = "用户名长度应该为2-20位之间!";
var p_mess = "密码应该为6-16位之间!";
var m_mess = "请输入格式正确的手机号!";
var vc_mess = "请输入图片验证码";
// 输入长度校验公共函数
function checkLength(showMess, id, s_l, e_l, message) {
	var flag = false;
	if ($("#" + id).val().length >= s_l && $("#" + id).val().length <= e_l
			&& $("#" + id).val() != '') {
		flag = true;
	} else {
		myErrorMsg(showMess, message);
	}
	return flag;
}
// 验证用户是否存在
function checkUser(url) {
	// $.ajax({
	// type : "POST",
	// url : "register/checkUser.do",
	// data : {
	// u : $("#m").val(),
	// m : $("#m").val()
	// },
	// success : function(response) {
	// var infoJson = response.result;
	// var info = $.parseJSON(infoJson);
	// var res = info.result;
	// if (res == 1) {
	register(url);
	// } else {
	// myErrorMsg("showMess", info.errInfo);
	//
	// $("#step").attr("disabled", false);
	// $("#finish").attr("disabled", false);
	// }
	// },
	// dataType : "json"
	// });
}
// 验证用户表单
function checkU(u_id) {
	return checkLength("showMess", u_id, 2, 20, u_mess);
}
$(document).ready(function() {
	$('input[id="u"]').blur(function() {
		checkLength("showMess", "u", 2, 20, u_mess);
	});
});

// 验证密码表单
function checkP(p_id) {
	return checkLength("showMess", p_id, 6, 16, p_mess);
}
$(document).ready(function() {
	$('input[id="p"]').blur(function() {
		checkLength("showMess", "p", 6, 16, p_mess);
	});
});

// 图片验证码是否正确
function checkVCIsExist() {
	var flag = false;
	var local=$("#local").val();
	var url = local+"/member/validateCode?"+new Date().getTime();
	 
	$.ajax({
		type : "get",
		async : false,
		url : url,
		data : {
			validateCode : $("#vc").val()
		},
		success : function(response) {
			
			if(typeof response != "object")
				response = $.parseJSON(response);
			 if(response.isFlag){
				 flag = true;
				}else{
				 flag = false;
				}	
			// result 0 验证码空 1正确 2不正确
	/*		var result = response.result;
			if (result == 1) {
				flag = true;
			} else {
				flag = false;
				myErrorMsg("showMess", "请正确输入图片验证码!");
			}*/
		},
		dataType : "json"
	});
	return flag;
}
// 换一张图片验证码
function changeVC() {
	$("#imgObj").removeAttr("src");
	$("#imgObj").attr("src", "register/verify/verifyCode.do");
}

$(document).ready(function() {
	$('input[id="vc"]').blur(function() {
		checkLength("showMess", "vc", 4, 4, vc_mess);
	});
});
function checkVC(vc_id) {
	return checkLength("showMess", vc_id, 4, 4, vc_mess);
}

// 手机验证码
function checkC(c_id) {
	var flag = false;
	if ($("#" + c_id).val().length >= 0 && $("#" + c_id).val() != '') {
		flag = true;
	} else {
		myErrorMsg("showMess", "手机验证码不能空!");
	}
	return flag;
}

// 验证手机号
function checkM(m_id) {
	return checkMpub(m_id, m_mess);
}
$(document).ready(function() {
	$('input[id="m"]').blur(function() {
		// checkMpub("m", m_mess);//验证手机号码格式
		if (checkMpub("m", m_mess)) {
			checkMUsed("m");
		}
	});
});

function checkMpub(id, message) {
	var flag = false;
	// 手机号正则
	if ($("#" + id).val().search(/^1[3-9][0-9]\d{4,8}$/) == -1) {
		myErrorMsg("showMess", m_mess);
	} else {
		flag = true;
	}
	return flag;
}

function checkMUsed(id) {
	$.ajax({
		type : "POST",
		url : basePath + "/register/checkmobile/used.do",
		data : {
			m : $("#" + id).val()
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					// 号码未被占用
				} else {
					myErrorMsg("showMess", info.errInfo);
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

/**
 * 提示方法
 * 
 * @param str
 *            提示内容
 */
function myErrorMsg(msg_id, str) {
	$("#" + msg_id).text(str);
	$("#" + msg_id).show();

	var count = 5;
	var countdown = setInterval(CountDown, 1000);
	function CountDown() {
		if (count == 0) {
			$("#" + msg_id)[0].innerHTML = "&nbsp;";
			clearInterval(countdown);
		}
		count--;
	}
}

function proxy() {
	window.location.href = "proxy.jsp";
}

function showGetRadioCode() {
	if(regetCode){
		//图片验证码置空，验证码刷新
		$("#vc").val("");
		changeVCode();
		regetCode = false;
	}
	if (checkM("m") && checkVC("vc") && checkVCIsExist()) {
		$("#phone_code_div")[0].style.display = "block";
		$('#myModal').on('shown.bs.modal', function() {
			$("#body_content_h4")[0].innerHTML = "接收语音验证码?"
			$('#myInput').focus();
		});
		$('#myModal').modal('toggle');
		$('#myModal')[0].click();

	}
}
function getRadioCode() {
	$.ajax({
		type : "POST",
		url : "register/getRadioCode.do",
		data : {
			m : $("#m").val()
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					regetCode = true;
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

function toProxy(){
	   window.location.href = "proxy.jsp";
}
//协议
function onBoxClicked() {
	if ($('#agreeBox').attr("checked") == 'checked') {
		$('#agreeBox').attr('checked',false);
		$(".squaredTwo label").removeClass("bg");
		$("#step").attr("disabled", true);
	} else {
		$('#agreeBox').attr('checked',true);
		$(".squaredTwo label").addClass("bg");
		$("#step").attr("disabled", false);
	}
}

function clearInput(id,pic_id) {//点击叉图片，清空input内容
		$("#"+id).val("");
		$("#"+pic_id)[0].style.display = "none";
}

function closeBtn(){
	
	$("#toper").hide();
}

function inputKeyUp(value,id,type,pic_id){
	switch (type) {
	case 1:
		$("#"+id).val(value.replace(/\D/g,''));
		break;
	case 2:
		break;
	}
	if(value){
		 $("#"+pic_id)[0].style.display = "block";
	}else{
		$("#"+pic_id)[0].style.display = "none";
	}
}