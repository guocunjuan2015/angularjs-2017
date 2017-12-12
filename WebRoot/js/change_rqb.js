var is_exchanged = false;

$(function() {
	num_choose = 0;
	arr = new Array();
	init();
});

function init() {
	arr[0] = 0;
	arr[1] = 0;
	arr[2] = 0;
	arr[3] = 0;
	initJifInfo();
}

function toChangeRools() {// 积分规则
	window.location.href = "creditRule.jsp";
}
function toChangeDetail() {// 积分明细
	window.location.href = "exchange_history.jsp";
}

function chooseNum5() {
	num_choose = 5;
	if (arr[0] == 0) {
		arr[0] = 1;
		$("#input_5").removeClass("input_box").addClass("input_box_choosed");
		$("#input_10").removeClass("input_box_choosed").addClass("input_box");
		$("#input_50").removeClass("input_box_choosed").addClass("input_box");
		$("#input_100").removeClass("input_box_choosed").addClass("input_box");
	} else {
		arr[0] = 0;
		$("#input_5").removeClass("input_box_choosed").addClass("input_box");
		num_choose = 0;
	}
}
function chooseNum10() {
	num_choose = 10;
	if (arr[1] == 0) {
		arr[1] = 1;
		$("#input_5").removeClass("input_box_choosed").addClass("input_box");
		$("#input_10").removeClass("input_box").addClass("input_box_choosed");
		$("#input_50").removeClass("input_box_choosed").addClass("input_box");
		$("#input_100").removeClass("input_box_choosed").addClass("input_box");
	} else {
		arr[1] = 0;
		$("#input_10").removeClass("input_box_choosed").addClass("input_box");
		num_choose = 0;
	}
}
function chooseNum50() {
	num_choose = 50;
	if (arr[2] == 0) {
		arr[2] = 1;
		$("#input_5").removeClass("input_box_choosed").addClass("input_box");
		$("#input_50").removeClass("input_box").addClass("input_box_choosed");
		$("#input_10").removeClass("input_box_choosed").addClass("input_box");
		$("#input_100").removeClass("input_box_choosed").addClass("input_box");
	} else {
		arr[2] = 0;
		$("#input_50").removeClass("input_box_choosed").addClass("input_box");
		num_choose = 0;
	}
}
function chooseNum100() {
	num_choose = 100;
	if (arr[3] == 0) {
		arr[3] = 1;
		$("#input_5").removeClass("input_box_choosed").addClass("input_box");
		$("#input_10").removeClass("input_box_choosed").addClass("input_box");
		$("#input_50").removeClass("input_box_choosed").addClass("input_box");
		$("#input_100").removeClass("input_box").addClass("input_box_choosed");
	} else {
		arr[3] = 0;
		$("#input_100").removeClass("input_box_choosed").addClass("input_box");
		num_choose = 0;
	}
}

function initJifInfo() {
	$.ajax({
		type : "POST",
		url : "account/change/getpoints.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					var info = info.resultObject;
					$("#VIP_type")[0].innerHTML = info.vipdesc; // 赋值
					$("#num_total")[0].innerHTML = info.available;
					$("#num_can_change")[0].innerHTML = info.maxCoupon;
					$("#num_change_one")[0].innerHTML = info.rate;
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

function toChange() {
	// 点击button立即兑换
	if (num_choose != 0) {
		$.ajax({
			type : "POST",
			url : "account/change/exchange.do",
			data : {
				numRqb : num_choose
			},
			success : function(response) {
				if (response.success) {
					var info = $.parseJSON(response.result);
					if (info.result) {
						is_exchanged = true;
					} else {
						is_exchanged = false;
					}
					$("#msg_content")[0].innerHTML = info.errInfo; // 赋值
					$('#myModal').on('shown.bs.modal', function() {
						$('#myInput').focus();
					});
					$('#myModal').modal('toggle');
					$('#myModal')[0].click();
					// } else {
					// errorMsg(info.errInfo);
					// }
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
	} else {
		errorMsg("请选择需要兑换瑞钱币的数量!");
	}
}

function refresh() {
	if (is_exchanged) {
		location.reload();// 刷新当前界面
	}
}
function toChangeDetailHistory() {
	window.location.href = "change_detail.jsp";
}