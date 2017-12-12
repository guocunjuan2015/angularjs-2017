$(function() {
	getCouponRecord();
});

function getCouponRecord(){
	$.ajax({
		type : "POST",
		url : "account/coupon/details.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					if(info.resultObject.length != 0){
						$("#no_data_div")[0].style.display = "none";
						addDataToContainer(info.resultObject);
					}else{
						$("#no_data_div")[0].style.display = "block";
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

function addDataToContainer(data) {
	var table = $("#coupon_item");
	table[0].innerHTML = "";
	for (var i = 0; i < data.length; i++) {
		row = '';
		row += '<table><tr><td><p class="points_top_p">';
		row += data[i].remarks;
		row += '</p><p>';
		row += data[i].date;
		row += '</p></td><td class="points_inner_td">';
		row += "+" + data[i].coupon;
		row += '</td></tr></table>';
		table.append(row);
	}
}

