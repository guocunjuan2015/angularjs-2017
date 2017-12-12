var period = 0;
var rate = 0.0;
var passValue = 0;// 选择的总面值
var copId = "";// 选择的优惠券拼接id
var couponInfo = new Array();
var moreRateInfo = new Array();
var map = {};

$(function() {
	initData();
	getCouponData();
});

function initData() {
	period = getRequestParam("period");
	projectIdToCop = getRequestParam("project_id");
	
}

function getCouponData() {
		$.ajax({
			type : "POST",
			url : "account/my/couponinfo/get.do",
			data : {
				projectId : projectIdToCop,
				moneyInvest : getRequestParam("money_invest")
			},
			success : function(response) {
				if (response.success) {
					var info = $.parseJSON(response.result);
					if (info.result) {
						couponInfo = info.resultObject.unuseds;
						initCouponInfo(couponInfo);
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

function clearMap(map) {
	for (key in map) {
		delete map[key];
	}
}

function resetCouponData() {
	// 清空瑞钱币选择，从新选
	clearMap(map);
	$("#sp_save_use")[0].innerHTML = "取消使用";
	countValue();
	initCouponInfo(couponInfo);// 重置瑞钱币
	window.localStorage.removeItem("couponValue");
	window.localStorage.removeItem("couponId");
}
function initCouponInfo(data) {
	var index = 1;
	var table = $("#coupon_table");
	table[0].innerHTML = "";
	if (data.length == 0) {
		$("#div_no_cop_record")[0].innerHTML = "没有可用瑞钱币!";
		$("#div_no_cop_record")[0].style.display = "block";
	} else {
		for (var i = 0; i < data.length; i++) {
			var row = '';
			row += '<div class="use_coupon" onclick="addToMap(' + i + ')">';
			row += '<span class="ml10">瑞钱币</span>';
			row += '<span class="ml10">有效期:</span>';
			row += '<span>'+data[i].date+'</span>';
			if(data[i].selected && data[i].selected == "selected"){
				row += '<img class="rq_box" src="images/cbox_bg2.jpg" id="dj_box'+i+'"'+' / >';
			}else{
				row += '<img class="rq_box" src="images/cbox_bg1.jpg" id="dj_box'+i+'"'+' / >';
			}
			row += '<span class="last_sp">';
			row += '<span>¥ </span>';
			row += '<span class="rqb_val" >'+data[i].amount+'</span>';
			row += '<span>元</span>';
			row += '</span></div>';
			table.append(row);
			if(data[i].selected && data[i].selected == "selected"){
			addToMap(i);
			}
		}
	}
}

 

function addToMap(i) {
		// if (period > 1) {//将原来瑞钱币只支持一个月以上项目，现在改为所有项目可用
	var str = document.getElementById("dj_box" + i).src;
	/*if (map[i] != undefined) {//支持多选
		document.getElementById("dj_box" + i).src = "images/cbox_bg1.jpg";
		delete map[i];
		countValue();// 计算选择的优惠券总值；
	} else {
		document.getElementById("dj_box" + i).src = "images/cbox_bg2.jpg";
		map[i] = i;
		countValue();
	}*/ 
	if (map[i] != undefined) {
		document.getElementById("dj_box" + i).src = "images/cbox_bg1.jpg";
		delete map[i];
	} else {
		/*clearMap(map);// 清空map
		for (var n = 0; n < couponInfo.length; n++) {
			document.getElementById("dj_box" + n).src = "images/cbox_bg1.jpg";
		}*/
		document.getElementById("dj_box" + i).src = "images/cbox_bg2.jpg";
		map[i] = i;
	}
	countValue();
}

	

function doNotSupport(str) {// 使用优惠券的提醒
	$("#msg_content")[0].innerHTML = str; // 赋值
	$('#myModal').on('shown.bs.modal', function() {
		$('#myInput').focus();
	});
	$('#myModal').modal('toggle');
	$('#myModal')[0].click();
}
function useCouponAlert(str) {// 使用瑞钱币的提醒
	$("#use_alert")[0].style.display = "block";
	$("#msg_content")[0].innerHTML = str; // 赋值
	$('#myModal').on('shown.bs.modal', function() {
		$('#myInput').focus();
	});
	$('#myModal').modal('toggle');
	$('#myModal')[0].click();
}

function countValue() {
	 
	var length = Object.keys(map).length;// 计算map的长度
	var value = 0;
	var id = "";
	for (key in map) {
			value = (value + parseInt(couponInfo[map[key]].amount)); // 计算当前选择优惠券总值
			id = id + "," + couponInfo[map[key]].couponId;
	}
	var ids = id.substring(1);
	$("#copId").val(ids);// 表单元素赋值
	$("#passValue").val(value);// 表单元素赋值
	showChoose(value, value);
}

function saveExit() {
	var storage = window.localStorage;
	storage.setItem("couponValue", $("#passValue").val());
	storage.setItem("couponId", $("#copId").val());
	storage.setItem("couponType",3);
	history.go(-1);
}

/** 检查优惠券和投资金额的使用比例 */
function checkCouponMax() {
	var length = Object.keys(map).length;
	if (length == 0) {// 没有勾选，直接返回，不用计算
		saveExit();
	} else {
		var money = parseInt(getRequestParam("money_invest"));
		var id = getRequestParam("project_id");
		$.ajax({
			type : "POST",
			url : "account/check/couponmax.do",
			data : {
				money : money,
				id : id
			},
			success : function(response) {
				if (response.success) {
					var info = $.parseJSON(response.result);
					if (info.result) {
						if ("1" == getRequestParam("tab")) {
							if (info.resultObject.coupon < parseInt($(
									"#passValue").val())) {
								var storage = window.localStorage;
								storage.setItem("couponType",3);
								storage.setItem("couponValue",
										parseInt(info.resultObject.coupon));
								storage.setItem("couponId", $("#copId").val());
								useCouponAlert("本次投资最多可使用"+parseInt(info.resultObject.coupon)+"个瑞钱币，剩余瑞钱币请到我的优惠-瑞钱币中查看");
							} else {
								saveExit();
							}
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
}

function showChoose(length, money) {
	if (length == 0) {
		$("#sp_save_use")[0].innerHTML = "取消使用";
	} else {
		$("#sp_save_use")[0].innerHTML = "使用";
	}
	$("#sp_cop_count")[0].innerHTML = length;
	$("#sp_cop_value")[0].innerHTML = formatCurrency(money);
    $("#sp_cop_type")[0].innerHTML = "瑞钱币";
}

function forceUse() {// 多余瑞钱币作废，坚持使用
	location.href=document.referrer;
}