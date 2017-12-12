var points_ava = 0;
var exchange_res = -1;
$(function() {
	getPointsInfo();
});

function getChangeRecord() {
	$.ajax({
		type : "POST",
		url : "account/change/record.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					addDataToContainer(info.resultObject.个人积分明细);
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

function changeTab(index) {
	switch (index) {
	case 1:
		$("#points_tab2").removeClass();
		$("#points_tab1").removeClass().addClass("tab-clicked");
		$("#container1")[0].style.display = "block";
		$("#points_item")[0].style.display = "none";
		break;
	case 2:
		$("#points_tab1").removeClass();
		$("#points_tab2").removeClass().addClass("tab-clicked");
		$("#container1")[0].style.display = "none";
		$("#points_item")[0].style.display = "block";
		getChangeRecord();
		break;
	}
}

function getPointsInfo() {
	$("#exchange_btn").attr("disabled", true);
	$
			.ajax({
				type : "POST",
				url : "account/points/details/get.do",
				data : {},
				success : function(response) {
					if (response.success) {
						var info = $.parseJSON(response.result);
						if (info.result) {
							$("#my_total_points")[0].innerHTML = info.resultObject.totalpoint;
							$("#points_ava")[0].innerHTML = "可用积分("
									+ info.resultObject.availablepoint + ")";
							points_ava = info.resultObject.availablepoint;
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
	$("#exchange_btn").attr("disabled", false);
}

function toPointsRule() {
	window.location.href = "creditRule.jsp";
}

function changeCoupon() {
	exchange_res = 0;
	var count = parseInt($("#exchange_count")[0].value);
	if (check()) {
		$.ajax({
			type : "POST",
			url : "account/points/tocoupon/exchange.do",
			data : {
				a : count
			},
			success : function(response) {
				if (response.success) {
					var info = $.parseJSON(response.result);
					if (info.result) {
						exchange_res = 1;
					} 
					$("#tip_content")[0].innerHTML = info.errInfo;
					$("#msg_btn_0")[0].style.display = "block";
					$('#myModal').on('shown.bs.modal', function () {
						$('#myInput').focus();
					});
					$('#myModal').modal('toggle');
					$('#myModal')[0].click();
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
}

function check() {
	var count = $("#exchange_count")[0].value;
	var points_need = parseInt($("#points_ava")[0].innerHTML);
	if (!checkStr(count, regexes.float)) {
		errorMsg("请正确填写数量");
		return false;
	}
	if (points_need > parseInt(points_ava)) {
		errorMsg("积分不够，请重新选择兑换数量");
		return false;
	}
	return true;
}
function changeCount() {
	if ("" != $("#exchange_count")[0].value) {
		$("#points_ava")[0].innerHTML = parseInt($("#exchange_count")[0].value) * 500;
	}else{
		$("#points_ava")[0].innerHTML = "可用积分("
			+ points_ava + ")";
	}
}

function refreshOrNot(){
	if(exchange_res == 1){
		location.reload();
	}
}