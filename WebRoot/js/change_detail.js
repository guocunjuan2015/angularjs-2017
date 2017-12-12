$(function() {
	showPointsExchangeHistory();
});

function init() {
	
}


function showPointsExchangeHistory() {
	$.ajax({
		type : "POST",
		url : "account/points/showhistory.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					if(info.resultObject.个人积分明细.length == 0){
						$("#jf_no_record")[0].style.display = "block";
					}else{
					addDataToUI(info.resultObject.个人积分明细);
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


function addDataToUI(data) {

	var table = $("#points_exchange_rqb");
	table[0].innerHTML = "";
	for (var i = 0; i < data.length; i++) {
		var row = '';
			row += '<div class="item_div">';
		row += '<span id="sp_qd_txt">' + data[i].description + '</span>';
		row += '<span id="sp_qd_value">' +"+"+ data[i].points + '</span>';
		row += '<span id="sp_qd_data">' + 
		'<table >'
		+'<tr><td>'+"到账日:"+data[i].createDate+'</td></tr>'
		+'<tr><td>'+"有效期:"+data[i].expire+'</td></tr>'
		+'</table>'
		+ '</span>';
		row += '</div>';
		table.append(row);
	}
}