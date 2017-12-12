$(function() {
	getChangeRecord();
});


function addDataToContainer(data) {
	var table = $("#points_item");
	table[0].innerHTML = "";
	for (var i = 0; i < data.length; i++) {
		row = '';
		row += '<table><tr><td><p class="points_top_p">';
		row += data[i].description;
		row += '</p><p>';
		row += data[i].createDate;
		row += '</p></td><td class="points_inner_td">';
		row += "+" + data[i].points;
		row += '</td></tr></table>';
		table.append(row);
	}
}

function getChangeRecord() {
	$.ajax({
		type : "POST",
		url : "account/change/record.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					if(info.resultObject.个人积分明细.lenght ==0 ){
						$("#no-data")[0].style.display = "block";
					}else{
						addDataToContainer(info.resultObject.个人积分明细);
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