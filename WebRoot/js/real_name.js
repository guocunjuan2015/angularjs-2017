$(function () {
    $("#ok").click(function () {
    	$("#ok").attr("disabled", true);
    	if(checkLength("real_name", 2, 20,"真实姓名长度应该为2-20位之间") && checkRealCode("real_code","身份证号格式不正确!")){
    		$.ajax({
    			type: "POST",
    			url: "register/realName.do", 
    			data: {
    				r:$("#real_name").val(),
    				n:$("#real_code").val()
    			},
    			success: function(response) {
    				var infoJson = response.result;
    				var info = $.parseJSON(infoJson);
    				var res = info.result;
    				if(res == 1){
    					var url = getRequestParam("reflect_url");
    					if(isEmptyStr(url)){
    						window.location.href = "personal_center.jsp";
    					}else{
    						window.location.href = decodeURIComponent(url);
    					}
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
    
    $("#next_btn").click(recharge);
    
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

function checkRealCode(id, message){
	var flag = false;
	//手机号正则
	if($("#"+id).val().search(/^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/)==-1){
		$("#showMess").text(message);
    }else{                  
        flag=true;
    }
    return flag;
}

function recharge(){
	$("#next_btn").attr("disabled", true);
	
	if(checkLength("real_name", 2, 20,"真实姓名长度应该为2-20位之间") && checkRealCode("real_code","身份证号格式不正确!")){
		$.ajax({
			type: "POST",
			url: "register/realName.do", 
			data: {
				r:$("#real_name").val(),
				n:$("#real_code").val()
			},
			success: function(response) {
				var infoJson = response.result;
				var info = $.parseJSON(infoJson);
				var res = info.result;
				if(res == 1){
					window.location.href = "money_recharge.jsp";
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