//下一步
$(document).ready(function () {
	 
    $("#step1").click(function () {
    	$("#step1").attr("disabled", true);
    	if(checkM("auth_m") && checkC("auth_c")){
    		$("#step_layer1").hide();
    		$("#step_layer2").show();
    		$("#step_layer3").hide();
    	}
    	$("#step1").attr("disabled", false);
    });
});
//立即修改
$(document).ready(function () {
    $("#update").click(function () {
    	$("#update").attr("disabled", true);
    	if(checkAuthP() && checkReP()){
    		$.ajax({
    			type: "POST",
    			url: "register/findPW.do", 
    			data: {
    				m:$("#auth_m").val(),
    				c:$("#auth_c").val(),
    				p:$("#auth_p").val(),
    				r:$("#auth_rep").val()
    			},
    			success: function(response) {
    				var infoJson = response.result;
    				var info = $.parseJSON(infoJson);
    				var res = info.result;
    				if(res == 1){
    					$("#step_layer2").hide();
    					$("#step_layer3").show();
    				}else{
    					$("#update_mess").text(info.errInfo);
    				}
    				$("#update").attr("disabled", false);
    			},
    			dataType: "json"
    		});
    	}else{
    		$("#update").attr("disabled", false);
    	}
    });
});

//密码验证
function checkAuthP(){
	var flag = false;
	if($("#auth_p").val().length >= 6 && $("#auth_p").val().length <= 16 && $("#auth_p").val()!=''){
    	flag=true;
    }else{
    	$("#update_mess").text("密码应该为6-16位之间!");
    }
	return flag;
}

//两次密码比较
function checkReP(){
	var flag = false;
	if($("#auth_p").val() == $("#auth_rep").val()){
		flag = true;
		$("#update_mess").text("");
	}else{
		$("#update_mess").text("两次密码输入不一致!");
	}
	return flag;
}

//获取手机验证码
$(document).ready(function () {
    $("#auth_getc").click(function () {
    	$("#auth_getc").attr("disabled", true);
    	if(checkM("auth_m")){
    		var count = 60;
    		function CountDown() {
    			$("#auth_getc").attr("disabled", true);
    			$("#auth_getc").text("重新获取(" + count + "秒)");
    			if(count == 0) {
    				$("#auth_getc").text("重新获取验证码").removeAttr("disabled");
    				clearInterval(countdown);
    			}
    			count--;
    		}
    		var countdown = setInterval(CountDown, 1000);
    		
			$.ajax({
				type: "POST",
				url: "register/getMCode.do", 
				data: {
					m:$("#auth_m").val()
				},
				success: function(response) {
				},
				dataType: "json"
			});
			
    	}
    });
});

$(document).ready(function () {
    $("#ok").click(function () {
    	window.location.href = "personal_center.jsp";
    });
    $("#gotop").click(function(){
    	window.location.href = "project.jsp";
    });
});

function clearInput(id,pic_id) {//点击叉图片，清空input内容
	$("#"+id).val("");
	document
    .getElementById(pic_id)
    .setAttribute(
            "src","images/input_clear.png");
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
	document
    .getElementById(pic_id)
    .setAttribute(
            "src","images/input_clear_red.png");
}else{
	document
    .getElementById(pic_id)
    .setAttribute(
            "src","images/input_clear.png");
}
}