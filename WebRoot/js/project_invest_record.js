var isTransfer = "";
$(function() {
	isTransfer = getRequestParam("isTransfer");
	getInvestRecord();
});

function getInvestRecord(){
	var url = "";
	if("true" == isTransfer){
		url = "project/transfer/invest/record.do";
	}else{
		url = "project/invest/record.do";
	}
	$.ajax({
		type : "POST",
		url : url,
		data : {id:getRequestParam("id")},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					addDataToTable(info.resultObject);
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

function addDataToTable(data){
	 var table = $("#invest_record_div");
	 table[0].innerHTML = "";
	 var row = '';
	 row += '<table class="invset_record_tb">';
	 if ("true" == isTransfer) {
		row += '<tr id="record_th_tr"><th>投资用户</th><th>投资金额</th><th>购买时间</th></tr>';
	} else {
		row += '<tr id="record_th_tr"><th>投资用户</th><th>投资金额</th><th>购买方式</th></tr>';
	}
	 
	 for(var i = 0;i<data.length;i++){
		 row += '<tr><td class="pj_record_td1">';
		 row += data[i].name;
		 row += '</td><td pj_record_td2>';
		 row += formatIntCurrency(data[i].amount);
		 row += '</td><td pj_record_td3><p>';
		 row += data[i].channel;
		 row += '</p><p>';
		 if(data[i].date){
			 var t = data[i].date.split(" ")[0];
			 row += t;
		 }
		 
		 row += '</p></td></tr>';
	 } 
	 row += '</table>';
	 table.append(row);
}