$(function() {
	getReferInfo();
});


/**获取推荐好友信息*/
function getReferInfo(){
	$.ajax({
		type : "POST",
		url : "account/refer/myrefer/get.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					addDataToRateTable(info.resultObject);
					var str = info.resultObject;
					$("#friends_total_invest")[0].innerHTML = formatCurrency(parseFloat(str[(str.length-1)].investCount));
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

function toFriendsRule(){
	window.location.href = "friends_rule.jsp";
}

function addDataToRateTable(data){
	var table = $("#refer_detail_table");
	table[0].innerHTML = "";
		var row = '';
		row += '<table class="refer_table">';
		row += '<tr id="refer_table_th_tr"><th>'+"已邀请好友"+'</th>'
		+ '<th>'+"注册日期"+'</th>'
		+ '<th>'+"投资金额"+'</th>'
		+'</tr>';
		if(data.length == 1){
			row += '<tr><td>'+"-"+'</td>'
			+ '<td>'+"-"+'</td>'
			+ '<td>'+"-"+'</td>'
			+'</tr>';
		}else{
		for(var i=0;i<data.length-1;i++){
			if(data[i].loginName !=undefined ){
				row += '<tr><td>'+data[i].loginName+'</td>';
			}else{
				row += '<tr><td>'+" "+'</td>';
			}
			if(data[i].totalInvestAmount !=undefined){
				row += '<td>'+data[i].registerDate+'</td>';
			}else{
				row += '<td>'+" "+'</td>';
			}
			if(data[i].registerDate !=undefined){
				row += '<td>'+data[i].totalInvestAmount+'</td>';
			}else{
				row += '<td>'+" "+'</td>';
			}
			+'</tr>';
		}
		}
		row += '</table>';
		table.append(row);
	
}