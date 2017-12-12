$(function(){
	getRecordData();
});

function getRecordData(){
	$.ajax({
		type: "POST",
		url: "account/record/get.do",
		data: {},
		success: function(response) {
			if(response.success){
				var info = $.parseJSON(response.result);
				if(info.result){
					var recordInfo = info.resultObject;
					initRecordInfo(recordInfo);
				}else{
					errorMsg(info.errInfo);
				}
			}else{
				if(isEmpty(response.result)){
					errorMsg(response.msg);
				}else{
					window.location.href = response.result;
				}
			}
		},
		dataType: "json"
	});
}

function initRecordInfo(data){
	//$("#record_count")[0].innerHTML = data.length;
	var table = $("#record_table");
	for(var i = 0; i < data.length; i++){
		var row = '<tr><td class="">';
		row += '<h4 class="">' + data[i].type + '</h4>';
		row += '<span class="text-muted">' + data[i].date + '</span>';
		row += '</td><td class="text-right">';
		row += '<h4 class="text-primary" style="color:#333">' + formatCurrency(data[i].amount) + '元</h4>';
		//row += '<span class="text-muted">余额：' + formatCurrency(data[i].balance) + '元</span>';
		row += '</td></tr>';
		
		table.append(row);
	}
}