$(function(){
	initialChannel();
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
}
function check() {
	var number = $("#ticketNum")[0].value;
	var actNumber = $("#voucherActive")[0].value;
	if ($("#phoneNum").val().search(/^1[3-9][0-9]\d{4,8}$/) == -1) {
		errorMsg("请正确填写手机号码");
		return false;
	}
	if (!checkStr(number, regexes.float)) {
		errorMsg("请正确填写红包券号码");
		return false;
	}
	if (!checkStr(actNumber, regexes.float)) {
		errorMsg("请正确填写激活码");
		return false;
	}
	return true;
}

function activeCoupon() {
	$("#activeBtn").attr("disabled", true);
	if (check()) {
		var url = "";
		url = "account/ticket/active.do";
		$.ajax({
			type : "POST",
			url : url,
			data : {
				p : $("#phoneNum")[0].value,
				n : $("#ticketNum")[0].value,
				c : $("#voucherActive")[0].value
			},
			success : function(response) {
				if (response.success) {
					var info = $.parseJSON(response.result);
					$("#jh_content")[0].innerHTML = info.errInfo;
					if(info.result){
						$("#title_info")[0].innerHTML = "激活成功";
						$("#checkCP")[0].innerHTML = "去登录";
						$("#checkCP").click(function(){
							window.location.href = "login.jsp?channel=98";
						});
					}else{
						$("#title_info")[0].innerHTML = "激活失败";
						$("#checkCP")[0].innerHTML = "确定";
						$("#checkCP").click(function(){
							dismissAys();
						});
					} 
					showAys();
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
	$("#activeBtn").attr("disabled", false);
}
function dismissAys() {
	$("#bg")[0].style.display = "none";
	$("#ays")[0].style.display = "none";
}
function showAys() {
	$("#bg").css("height", document.body.scrollHeight);
	$("#bg")[0].style.display = "block";
	$("#ays")[0].style.display = "block";
}