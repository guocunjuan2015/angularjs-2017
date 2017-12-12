$(function() {
	getChangeRecord();
});


function addDataToContainer(data) {
	var table = $("#points_item");
	table[0].innerHTML = "";
	for (var i = 0; i < data.length; i++) {
		row = '';
		row += '<table><tr><td><p class="points_top_p">';
		row += data[i].remarks;
		row += '</p><p>';
		row += data[i].date;
		row += '</p></td><td class="points_inner_td">';
		row += "-" + data[i].point;
		row += '</td></tr></table>';
		table.append(row);
	}
}

function getChangeRecord() {
	$.ajax({
		type : "POST",
		url : "account/market/exchange/record.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					if(info.resultObject.length == 0){
						$("#no-data")[0].style.display = "block";
					}else
						{
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