$(function(){
	getAccountData();
});

function toFincDetails(){
	window.location.href = "personal_record.jsp";
}

function getAccountData() {
	$.ajax({
		type : "POST",
		url : "account/detail/get.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					var accountInfo = info.resultObject;
					initAccountInfo(accountInfo);
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

function initAccountInfo(data){
	$("#total_finc")[0].innerHTML = data.total;
	$("#rest_useable")[0].innerHTML = data.b + "元";
	$("#will_income")[0].innerHTML = data.principal + "元";
	$("#will_lix")[0].innerHTML = data.interest + "元";
	$("#money_frozen")[0].innerHTML = data.frozen + "元";
	$("#lj_income")[0].innerHTML = data.ic;
	
}