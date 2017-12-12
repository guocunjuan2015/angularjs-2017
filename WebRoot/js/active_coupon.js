var type = "";
$(function(){
	type = getRequestParam("type");
	if(parseInt(type) == 1){
		$("#homeTitle")[0].innerHTML = "激活瑞钱币";
	}else{
		$("#homeTitle")[0].innerHTML = "激活红包";
	}
});
function check() {
	var number = $("#number")[0].value;
	var actNumber = $("#act_number")[0].value;
	if (!checkStr(number, regexes.float)) {
		errorMsg("请正确填写号码");
		return false;
	}
	if (!checkStr(actNumber, regexes.float)) {
		errorMsg("请正确填写激活码");
		return false;
	}
	return true;
}

function activeCoupon() {
	$("#exchange_btn").attr("disabled", true);
	if (check()) {
		$.ajax({
			type : "POST",
			url : "account/coupon/active.do",
			data : {
				n : $("#number")[0].value,
				c : $("#act_number")[0].value
			},
			success : function(response) {
				if (response.success) {
					var info = $.parseJSON(response.result);
					$("#tip_content")[0].innerHTML = info.errInfo;
					$("#msg_btn_0")[0].style.display = "block";
					$('#myModal').on('shown.bs.modal', function() {
						$('#myInput').focus();
					});
					$('#myModal').modal('toggle');
					$('#myModal')[0].click();
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
	$("#exchange_btn").attr("disabled", false);
}
