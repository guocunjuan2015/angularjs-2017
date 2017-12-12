var tel = "";
var regetCode = true;
$(function(){
	 
});

function showGetRadioCode() {
		$("#phone_code_div")[0].style.display = "block";
		$('#myModal').on('shown.bs.modal', function() {
			$("#body_content_h4")[0].innerHTML = "接收语音验证码?"
			$('#myInput').focus();
		});
		$('#myModal').modal('toggle');
		$('#myModal')[0].click();
}

//获取手机验证码
$(document).ready(function() {
	$("#getc").click(function() {
				$("#getc").attr("disabled", true);
				var count = 60;
				function CountDown() {
					$("#getc").attr("disabled", true);
					$("#getc").text("重新获取(" + count + "秒)");
					if (count == 0) {
						$("#getc").text("重新获取验证码").removeAttr("disabled");
						clearInterval(countdown);
						$("#getc").attr("disabled", false);
					}
					count--;
				}
				var countdown = setInterval(CountDown, 1000);

				$.ajax({
					type : "POST",
					url : "register/getMCode.do",
					data : {
						m : $("#my_tel").val()
					},
					success : function(response) {
					},
					dataType : "json"
				});

	});
});

function identify(){
	if(check()){
		$("#next").attr("disabled", true);
		$.ajax({
			type : "POST",
			url : "account/change/bandcard/identify.do",
			data : {
				code : $("#c").val()
			},
			success : function(response) {
				if (response.success) {
					var info = $.parseJSON(response.result);
					if (info.result) {
						 window.localStorage.setItem("card", "change")
						 window.location.href = "ump_bind_card.jsp";
					}else{
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
		$("#next").attr("disabled", false);
	}
}

function check(){
	var code = $("#c").val();
	if(isEmptyStr(code)){
		errorMsg("请正确填写验证码");
		return false;
	}
	return true;
}