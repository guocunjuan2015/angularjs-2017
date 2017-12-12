$(function() {
	getInvestRecord();
});

function getInvestRecord(){
	$.ajax({
		type : "POST",
		url : "project/transfer/buy/record.do",
		data : {
			projectId:getRequestParam("id"),
			pageSize:50,
			pageNo:1
		},
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
	 row += '<tr id="record_th_tr"><th>投资用户</th><th>投资金额</th><th>购买方式</th></tr>';
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