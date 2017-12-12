/*******************************************************************************
 * --------------------------------注册相关-------------------------------------------*
 ******************************************************************************/
// 注册
var enableGet = true;
var regetCode = false;
var mIsUsed = false;
var reflect_url = "";
var f = 22;
$(function() {
	reflect_url = getRequestParam("reflect_url");
	if (getRequestParam("channel")) {
		f = getRequestParam("channel");
		var storage = window.sessionStorage;
		storage.setItem("channel", f);
	}
	iniLunBo();
});

function register(url) {
	$.ajax({
		type : "POST",
		url : "register/regist.do",
		data : {
			u : $("#m").val(),
			p : $("#p").val(),
			m : $("#m").val(),
			c : $("#c").val(),
			f : f,
			referrer : $("#referrer").val()
		},
		success : function(response) {
			var infoJson = response.result;
			var info = $.parseJSON(infoJson);
			var res = info.result;
			if (res == 1) {
			/*	zhuge.identify($("#m").val(), {
			        userId: $("#m").val(),
			    });*/
				var tprm = "username=" + $("#m").val() + "&phone="
						+ $("#m").val() + "&referrer=" + $("#referrer").val();
				__ozfac2(tprm, "#regsuccess");// 99-click，统计用户行为
				setTimeout(function() {
					window.location.href = url;
				}, 300);
			} else {
				myErrorMsg("showMess", info.errInfo);
			}
			$("#step").attr("disabled", false);
		},
		dataType : "json"
	});
}

function gotoPage() {
	window.location.href = "login.jsp";
}
function checkMIsUsed(bool) {
	var flag = false;
	// 手机号正则
	if (bool) {
		flag = false;
		myErrorMsg("showMess", "温馨提示-您的手机号已经被注册");
	} else {
		flag = true;
	}
	return flag;
}

// 获取手机验证码
$(document).ready(function() {
	$("#getc").click(function() {
		if (enableGet) {	
			if(regetCode){
				//图片验证码置空，验证码刷新
				$("#vc").val("");
				changeVC();
				regetCode = false;
			}
			if (checkM("m") && checkMIsUsed(mIsUsed) && checkVCIsExist()) {
				$("#getc").attr("disabled", true);
				enableGet = false;
				var count = 100;
				function CountDown() {
					$("#getc").attr("disabled", true);
					$("#getc").text("重新获取(" + count + "秒)");
					if (count == 0) {
						$("#getc").text("重新获取验证码").removeAttr("disabled");
						clearInterval(countdown);
						enableGet = true;
						regetCode = true;//需要重新输入图片验证码
					}
					count--;
				}
				var countdown = setInterval(CountDown, 1000);

				$.ajax({
					type : "POST",
					url : "register/getMCode.do",
					data : {
						m : $("#m").val()
					},
					success : function(response) {
					},
					dataType : "json"
				});

			}
		}
	});
});

// 下一步
$(document).ready(function() {
	$("#step").click(function() {
		$("#step").attr("disabled", true);
		// 验证用户，手机号，密码，图形验证码，手机验证码
		if (checkM("m") && checkP("p") &&checkVCIsExist() && checkC("c")) {
			if(reflect_url){
				checkUser("lottery.jsp");
			}else{
				checkUser("project.jsp");
			}

		} else {
			$("#step").attr("disabled", false);
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
			url : "register/login.do",
			data : {
				u : $("#u").val(),
				p : $("#p").val()
			},
			success : function(response) {
				var infoJson = response.result;
				var info = $.parseJSON(infoJson);
				var res = info.result;
				if (res == 1) {
					var url = getRequestParam("reflect_url");
					if (isEmptyStr(url)) {
						window.location.href = "personal_center.jsp";
					} else {
						window.location.href = decodeURIComponent(url);
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
		window.location.href = "ump_register.jsp";
	});
});


/*******************************************************************************
 * --------------------------------验证相关-------------------------------------------*
 ******************************************************************************/

var u_mess = "用户名长度应该为2-20位之间!";
var p_mess = "密码应该为6-16位之间!";
var m_mess = "请输入格式正确的手机号!";
var vc_mess = "验证码长度4位!";
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
 
				register(url);
 
}
// 验证用户表单
function checkU(u_id) {
	return checkLength("showMess", u_id, 2, 20, u_mess);
}


// 验证密码表单
function checkP(p_id) {
	return checkLength("showMess", p_id, 6, 16, p_mess);
}
$(document).ready(function() {
	$('input[id="p"]').blur(function() {
		checkLength("showMess", "p", 6, 16, p_mess);
	});
});

// 手机验证码
function checkC(c_id) {
	var flag = false;
	if ($("#" + c_id).val().length >= 0 && $("#" + c_id).val() != '') {
		if ($("#" + c_id).val().length < 4) {
			flag = false;
			myErrorMsg("showMess", "请输入4位验证码!");
		} else {
			flag = true;
		}
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
		url : "register/checkmobile/used.do",
		data : {
			m : $("#" + id).val()
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					// 号码未被占用
					mIsUsed = false;
				} else {
					flag = false;
					mIsUsed = true;
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
		changeVC();
		regetCode = false;
	}
	if (checkM("m") && checkVCIsExist()) {
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
// 协议
function onBoxClicked() {
	if (document.getElementById("agreeBox").checked) {
		enableInvest = true;
		$("#step").attr("disabled", false);
	} else {
		enableInvest = false;
		$("#step").attr("disabled", true);
	}
}
function iniLunBo() {
	// 初始化轮播
	var curIndex = 1;
	var totalNum = 6;
	$("#myCarousel").carousel(0);
	$("#myCarousel").carousel('cycle');
	/*$('#myCarousel').on('slide.bs.carousel', function () {
		  // 执行一些动作...
		curIndex++;
		switch (curIndex % totalNum) {
		case 1:
			alert(1);
			break;
		case 2:
			alert(2);
			break;
		case 3:
			alert(3);
			break;
		case 4:
			alert(4);
			break;
		case 5:
			alert(5);
			break;
		case 6:
			alert(6);
			break;
		}
		})*/
	// 对滑动事件监听处理
	addSwipe('myCarousel', "L", toNext);
	addSwipe('myCarousel', "R", toPrev);
}
function toNext(){
	$("#myCarousel").carousel('next');
}
function toPrev(){
	$("#myCarousel").carousel('prev');
}

function toLogin(){
	window.location.href = "login.jsp";
}

function changeVC() {//更换图形验证码
	$("#imgObj").attr("src", "register/verify/verifyCode.do");
}
//图片验证码是否正确
function checkVCIsExist() {
	var flag = false;
	$.ajax({
		type : "POST",
		async : false,
		url : "register/verify/validateCode.do",
		data : {
			vc : $("#vc").val()
		},
		success : function(response) {
			// result 0 验证码空 1正确 2不正确
			var result = response.result;
			if (result == 1) {
				flag = true;
			} else {
				flag = false;
				myErrorMsg("showMess", "请正确输入图片验证码!");
			}
		},
		dataType : "json"
	});
	return flag;
}