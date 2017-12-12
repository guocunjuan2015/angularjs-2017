$(document).ready(function () {
    $("#ok").click(function () {
    	$("#ok").attr("disabled", true);
    	if(checkLength("o", 6, 16,"请输入6到16位登录密码") && checkLength("p", 6, 16,"请输入6到16位新密码")){
    		$.ajax({
    			type: "POST",
    			url: "register/modifyPayPassword.do", 
    			data: {
    				o:$("#o").val(),
    				p:$("#p").val()
    			},
    			success: function(response) {
    				var infoJson = response.result;
    				var info = $.parseJSON(infoJson);
    				var res = info.result;
    				if(res == 1){
    					window.location.href = "personal_center.jsp";
    				}else{
    					$("#showMess").text(info.errInfo);
    				}
    				$("#ok").attr("disabled", false);
    			},
    			dataType: "json"
    		});
    	}else{
    		$("#ok").attr("disabled", false);
    	}
    });
});

function checkLength(id, s_l, e_l, message){
	var flag = false;
	if($("#"+id).val().length >= s_l && $("#"+id).val().length <= e_l && $("#"+id).val()!=''){
    	flag=true;
    }else{
    	$("#showMess").text(message);
    }
	return flag;
}

function paypassword_next(){
	$("#next_btn").attr("disabled", true);
	if(checkLength("o", 6, 16,"请输入6到16位登录密码") && checkLength("p", 6, 16,"请输入6到16位新密码")){
		$.ajax({
			type: "POST",
			url: "register/modifyPayPassword.do", 
			data: {
				o:$("#o").val(),
				p:$("#p").val()
			},
			success: function(response) {
				var infoJson = response.result;
				var info = $.parseJSON(infoJson);
				var res = info.result;
				if(res == 1){
					window.location.href = "real_name.jsp";
				}else{
					$("#showMess").text(info.errInfo);
				}
				$("#next_btn").attr("disabled", false);
			},
			dataType: "json"
		});
	}else{
		$("#next_btn").attr("disabled", false);
	}
}

function cancel(){
	window.location.href = "personal_center.jsp";
}
