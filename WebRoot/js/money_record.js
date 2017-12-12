$(function() {
	if("cash" == getRequestParam("type")){
		$("#record_title")[0].innerHTML = "提现记录";
		getWithdrawRecord();
	}else if("recharge" == getRequestParam("type")){
		$("#record_title")[0].innerHTML = "充值记录";
		getRechargeRecord();
	}
});


function addDataToContainer(data) {
	var table = $("#points_item");
	table[0].innerHTML = "";
	for (var i = 0; i < data.length; i++) {
		row = '';
		row += '<table><tr><td><p class="points_top_p">';
		row += data[i].status;
		row += '</p><p>';
		row += data[i].date;
		row += '</p></td><td class="points_inner_td">';
		row += data[i].amount;
		row += '</td></tr></table>';
		table.append(row);
	}
}

function getRechargeRecord() {
	$.ajax({
		type : "POST",
		url : "account/recharge/record.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					if(info.resultObject.length ==0 ){
						$("#no-data")[0].style.display = "block";
					}else{
						addDataToContainer(info.resultObject);
					}
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

function getWithdrawRecord() {
	$.ajax({
		type : "POST",
		url : "account/withdraw/record.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					if(info.resultObject.length ==0 ){
						$("#no-data")[0].style.display = "block";
					}else{
						addDataToContainer(info.resultObject);
					}
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