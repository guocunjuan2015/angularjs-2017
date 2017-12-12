$(document).ready(function () {
    $("#ok").click(function () {
    	$("#ok").attr("disabled", true);
    	if(checkLength("o", 6, 16,"请输入6到16位旧密码!") && checkLength("p",6,16,"请输入6到16位新密码!")){
    		$.ajax({
    			type: "POST",
    			url: "register/modifyPassword.do", 
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
