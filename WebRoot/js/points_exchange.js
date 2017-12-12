var points_ava = 0;
var exchange_res = -1;
var per_points = 0;
$(function() {
	getPointsInfo();
	per_points = getRequestParam("points");
});


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
		if(per_points){
			$("#points_ava")[0].innerHTML = parseInt($("#exchange_count")[0].value) * parseInt(per_points);
		}
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