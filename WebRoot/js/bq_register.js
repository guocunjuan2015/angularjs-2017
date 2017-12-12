/***
 * --------------------------------注册相关-------------------------------------------*
 ***/
//注册
function register(url){
	$.ajax({
		type: "POST",
		url: "register/bq/regist.do", 
		data: {
			u:$("#u").val(),
			p:$("#p").val(),
			m:$("#m").val(),
			c:$("#c").val(),
			channel: getRequestParam("channel"),
			referrer:$("#referrer").val()
		},
		success: function(response) {
			var infoJson = response.result;
			var info = $.parseJSON(infoJson);
			var res = info.result;
			if(res == 1){
				window.location.href = url;
			}else{
				$("#showMess").text(info.errInfo);
			}
			
			$("#step").attr("disabled", false);
    		$("#finish").attr("disabled", false);
		},
		dataType: "json"
	});
}

function gotoPage(){
	window.location.href = "login.jsp";
}

//获取手机验证码
$(document).ready(function () {
    $("#getc").click(function () {
    	if(checkM("m") && checkVC("vc") && checkVCIsExist()){
    		$("#getc").attr("disabled", true);
    		
    		var count = 60;
    		var countdown = setInterval(CountDown, 1000);
    		
    		function CountDown() {
    			$("#getc").attr("disabled", true);
    			$("#getc").text("重新获取(" + count + "秒)");
    			if(count == 0) {
    				$("#getc").text("重新获取验证码").removeAttr("disabled");
    				clearInterval(countdown);
    			}
    			count--;
    		}
    		
			$.ajax({
				type: "POST",
				url: "register/getMCode.do", 
				data: {
					m:$("#m").val()
				},
				success: function(response) {
				},
				dataType: "json"
			});
	        
    	}
    });
});

//完成
$(document).ready(function () {
    $("#finish").click(function () {
    	$("#step").attr("disabled", true);
    	$("#finish").attr("disabled", true);
    	//验证用户，手机号，密码，图形验证码，手机验证码
    	if(checkU("u") && checkM("m") && checkP("p") && checkVCIsExist() && checkC("c")){
    		if(getRequestParam("channel") == "beiqing"){
    			checkUser("bq/download.jsp");
    		}else{
    			checkUser("http://wx.bqsqcm.com/wxokjia/reg.php");
    		}
    	}else{
    		$("#step").attr("disabled", false);
    		$("#finish").attr("disabled", false);
    	}
    });
});

//上一步
$(document).ready(function () {
    $("#be_step").click(function () {
    	//前往上一步
    	$("#step_op").show();
    	$("#register_op").hide();
    });
});
/***
 * --------------------------------验证相关-------------------------------------------*
 ***/

var u_mess = "用户名长度应该为2-20位之间!";
var p_mess = "密码应该为6-16位之间!";
var m_mess = "请输入格式正确的手机号!";
var vc_mess = "验证码长度4位!";
//输入长度校验公共函数
function checkLength(showMess,id, s_l, e_l, message){
	var flag = false;
	if($("#"+id).val().length >= s_l && $("#"+id).val().length <= e_l && $("#"+id).val()!=''){
    	flag=true;
    }else{
    	myErrorMsg(showMess,message);
    }
	return flag;
}
//验证用户是否存在
function checkUser(url){
	$.ajax({
		type: "POST",
		url: "register/checkUser.do", 
		data: {
			u:$("#u").val(),
			m:$("#m").val()
		},
		success: function(response) {
			var infoJson = response.result;
			var info = $.parseJSON(infoJson);
			var res = info.result;
			if(res == 1){
				register(url);
			}else{
				myErrorMsg("showMess",info.errInfo);
				
				$("#step").attr("disabled", false);
				$("#finish").attr("disabled", false);
			}
		},
		dataType: "json"
	});
}
//验证用户表单
function checkU(u_id){
	return checkLength("showMess",u_id, 2, 20, u_mess);
}
$(document).ready(function () {
	$('input[id="u"]').blur(function(){
        checkLength("showMess","u", 2, 20, u_mess);
    });
});

//验证密码表单
function checkP(p_id){
	return checkLength("showMess",p_id, 6, 16, p_mess);
}
$(document).ready(function () {
	$('input[id="p"]').blur(function(){
        checkLength("showMess","p", 6, 16, p_mess);
    });
});

//图片验证码是否正确
function checkVCIsExist(){
	var flag = false;
	$.ajax({
		type: "POST",
		async: false, 
		url: "register/verify/validateCode.do", 
		data: {
			vc:$("#vc").val()
		},
		success: function(response) {
			//result 0 验证码空 1正确 2不正确
			var result = response.result;
			if(result == 1){
				flag = true;
			}else{
				flag = false;
				myErrorMsg("showMess","请正确输入图片验证码!");
			}
		},
		dataType: "json"
	});
	return flag;
}
//换一张图片验证码
function changeVC(){
	$("#imgObj").attr("src","register/verify/verifyCode.do");
}
$(document).ready(function () {
	$('input[id="vc"]').blur(function(){
        checkLength("showMess","vc", 4, 4, vc_mess);
    });
});
function checkVC(vc_id){
	return checkLength("showMess",vc_id, 4, 4, vc_mess);
}

//手机验证码
function checkC(c_id){
	var flag = false;
	if($("#"+c_id).val().length >= 0  && $("#"+c_id).val()!=''){
    	flag=true;
    }else{
    	myErrorMsg("showMess","手机验证码不能空!");
    }
	return flag;
}

//验证手机号
function checkM(m_id){
	return checkMpub(m_id, m_mess);
}
$(document).ready(function () {
	$('input[id="m"]').blur(function(){
		checkMpub("m", m_mess);
    });
});

function checkMpub(id, message){
	var flag = false;
	//手机号正则
	if($("#"+id).val().search(/^1[3-9][0-9]\d{4,8}$/)==-1){
		myErrorMsg("showMess",m_mess);
    }else{                  
        flag=true;
    }
    return flag;
}

/**
 * 提示方法
 * @param str 提示内容
 */
function myErrorMsg(msg_id,str){
	$("#"+msg_id).text(str);
	$("#"+msg_id).show();
	
	var count = 5;
    var countdown = setInterval(CountDown, 1000);
    function CountDown() {
        if(count == 0) {
        	$("#"+msg_id).hide();
            clearInterval(countdown);
        }
        count--;
    }
}

function proxy(){
	window.location.href="proxy.jsp";
}