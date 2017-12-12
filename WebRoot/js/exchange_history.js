$(function() {
	showHistory();
});

function showHistory() {
	$
			.ajax({
				type : "POST",
				url : "account/exchange/showhistory.do",
				data : {},
				success : function(response) {
					if (response.success) {
						var info = $.parseJSON(response.result);
						if (info.result) {
							if (info.resultObject.length == 0) {
								$("#div_exchange_no_record")[0].style.display = "block";
							} else {
								addDataToUI(info.resultObject);
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

	var table = $("#jif_exchange_history");
	table[0].innerHTML = "";
	for (var i = 0; i < data.length; i++) {
		var row = '';
		row += '<div class="item_div">';
		row += '<span id="sp_exchange_date">' + data[i].date + '</span>';
		row += '<span id="sp_excahnge_remark">' + data[i].remarks + '</span>';
		row += '<span id="sp_exchange_points_used">' + "-" + data[i].point
				+ '</span>';
		row += '</div>';
		table.append(row);
	}
}

function goToProjectPage() {
	window.location.href = "project.jsp";
}