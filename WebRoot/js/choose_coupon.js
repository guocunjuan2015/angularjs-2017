//account/my/couponinfo/get.do
//account/my/ticketinfo/get.do

var period = 0;
var rate = 0.0;
var passValue = 0;// 选择的总面值
var copId = "";// 选择的优惠券拼接id
var couponInfo = new Array();
var ticketInfo = new Array();
var moreRateInfo = new Array();
var map = {};
var tyLength = 0;// 体验金列表长度

$(function() {
	initData();
	getCouponData(getRequestParam("tab"));
	$("#coupon_table_" + getRequestParam("tab"))[0].style.display = "block";
});

function initData() {
	period = getRequestParam("period");
	projectIdToCop = getRequestParam("project_id");
	$("#periodBack").val(period);// 表单元素赋值
	$("#projectIdBack").val(projectIdToCop);// 表单元素赋值
}

function getCouponData(tab) {
	alert();
	tab = isEmpty(tab) ? 1 : tab;
	switch (parseInt(tab)) {
	case 1:
		$.ajax({
			type : "POST",
			url : "account/my/ticketinfo/get.do",
			data : {
				projectIdToCop : projectIdToCop
			},
			success : function(response) {
				if (response.success) {
					var info = $.parseJSON(response.result);
					if (info.result) {
						alert(response.result);
							ticketInfo = info.resultObject.ticket.unuseds;
							moreRateInfo = info.resultObject.morerate.unuseds;
						initCouponInfo(null, moreRateInfo,ticketInfo, tab);
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
		break;
	case 2:
		$.ajax({
			type : "POST",
			url : "account/my/couponinfo/get.do",
			data : {
				projectIdToCop : projectIdToCop
			},
			success : function(response) {
				if (response.success) {
					var info = $.parseJSON(response.result);
					if (info.result) {
						couponInfo = info.resultObject.unuseds;
						initCouponInfo(couponInfo,null,null, tab);
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
		break;
	}
	
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
	countValue(1);
	initCouponInfo(couponInfo,null, null, 1);// 重置瑞钱币
	window.localStorage.removeItem("couponValue");
	window.localStorage.removeItem("couponId");
}

function initCouponInfo(data, data1,data2, tab) {
	tab = isEmpty(tab) ? 1 : tab;
	var table = $("#coupon_table_" + tab);
	table[0].innerHTML = "";
	if (tab == 1) {
		if (data.length == 0) {
			$("#div_no_cop_record")[0].innerHTML = "没有瑞钱币记录";
			$("#div_no_cop_record")[0].style.display = "block";
		} else {
			for (var i = 0; i < data.length; i++) {
				var row = '';
				row += '<div class="djq" onclick="addToMap(' + i + ',1)">';
				row += '<img src="images/1_bg.jpg" width="100%" >';
				row += '<checkbox  onclick="">';
				row += '<div class="q">￥<font>' + data[i].money
						+ '</font></div>';
				row += '<div class="p">瑞钱币<br>';
				if (data[i].endTime) {
					row += parseString(data[i].endTime.split(" ")[0]);
				}
				row += '</div>';
				row += '<div class="ly">—— ' + data[i].remark + ' ——</div>';
				row += '<div class="r">'
						+ '<img src="images/cbox_bg1.jpg" id="dj_box' + i
						+ '" />';
				row += '</div>';
				row += '</div>';
				table.append(row);
			}
		}
	} else {
		alert(tab);
		if(data1 && data2){
			tyLength = data1.length + data2.length;
		}else{
			if(data1){
				tyLength = data1.length;
			}else{
				tyLength = data2.length;
			}
		}
		
		if (data1.length == 0 && data2.length == 0) {
			$("#div_no_cop_record")[0].innerHTML = "没有优惠券记录";
			$("#div_no_cop_record")[0].style.display = "block";
		} else {
			for (var i = 0; i < data1.length; i++) {
				var row = '';
				row += '<div class="djq tz" onclick="addToMap(' + i + ',2)">';
				row += '<img src="images/4_bg.jpg" width="100%" >';
				row += '<div class="q">￥<font>' + data1[i].money
						+ '</font></div>';
				row += '<div class="p">加息券<br>'
						+ parseString(data1[i].endTime.split(" ")[0])
						+ '</div>';
				row += '<div class="ly">—— ' + data1[i].remark + ' ——</div>';
				row += '<div class="r">'
						+ '<img src="images/cbox_bg1.jpg" id="tz_box' + i
						+ '" />';
				row += '</div>';
				row += '</div>';
				table.append(row);
			}
			for (var i = 0; i < data2.length; i++) {
				var row = '';
				row += '<div class="djq tz" onclick="addToMap(' + i + ',2)">';
				row += '<img src="images/4_bg.jpg" width="100%" >';
				row += '<div class="q">￥<font>' + data2[i].money
						+ '</font></div>';
				row += '<div class="p">投资券<br>'
						+ parseString(data2[i].endTime.split(" ")[0])
						+ '</div>';
				row += '<div class="ly">—— ' + data2[i].remark + ' ——</div>';
				row += '<div class="r">'
						+ '<img src="images/cbox_bg1.jpg" id="tz_box' + i
						+ '" />';
				row += '</div>';
				row += '</div>';
				table.append(row);
			}
		}
	}
}

function addToMap(i, type) {
	if (type == 1) {
		// if (period > 1) {//将原来瑞钱币只支持一个月以上项目，现在改为所有项目可用
		$("#copType").val(type);
		var str = document.getElementById("dj_box" + i).src;
		if (map[i] != undefined) {
			document.getElementById("dj_box" + i).src = "images/cbox_bg1.jpg";
			delete map[i];
			countValue(type);// 计算选择的优惠券总值；
		} else {
			document.getElementById("dj_box" + i).src = "images/cbox_bg2.jpg";
			map[i] = i;
			countValue(type);
		}
		 
	} else {
		if (period < 2) {
			var money = parseInt(getRequestParam("money_invest"));
			if (money < 100) {
				doNotSupport("投资金额超过100元才能使用优惠券");
			} else {
				clearMap(map);
				for (var n = 0; n < tyLength; n++) {
					document.getElementById("tz_box" + n).src = "images/cbox_bg1.jpg";
				}
				document.getElementById("tz_box" + i).src = "images/cbox_bg3.jpg";
				map[i] = i;
				//countValue(type);
			}
		} else {
			doNotSupport("该项目不支持投资券");
		}
	}
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

function countValue(type) {
	var length = Object.keys(map).length;// 计算map的长度
	var value = 0;
	var id = "";
	for (key in map) {
		if (type == 1) {
			value = (value + parseInt(couponInfo[map[key]].money)); // 计算当前选择优惠券总值
			id = id + "," + couponInfo[map[key]].id;
		} else {
			value = (value + parseInt(ticketInfo[map[key]].money)); // 计算当前选择优惠券总值
			id = id + "," + ticketInfo[map[key]].id;
		}
	}
	var ids = id.substring(1);
	$("#copId").val(ids);// 表单元素赋值
	$("#passValue").val(value);// 表单元素赋值
	showChoose(type, length, value);
}

function saveExit() {
	var storage = window.localStorage;
	if (getRequestParam("tab") == 1) {
		storage.setItem("couponValue", $("#passValue").val());
		storage.setItem("couponId", $("#copId").val());
	} else {
		storage.setItem("ticketValue", $("#passValue").val());
		storage.setItem("ticketId", $("#copId").val());
	}
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
								storage.setItem("couponValue",
										info.resultObject.coupon);
								storage.setItem("couponId", $("#copId").val());
								useCouponAlert("所选瑞钱币总金额超过可使用额度,超过金额作废");
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

function showChoose(type, length, money) {

	if (length == 0) {
		$("#sp_save_use")[0].innerHTML = "取消使用";
	} else {
		$("#sp_save_use")[0].innerHTML = "保存";
	}
	var table = $("#show_choose_div");
	$("#sp_cop_count")[0].innerHTML = length;
	$("#sp_cop_value")[0].innerHTML = formatCurrency(money);
	if (type == 1) {
		$("#sp_cop_type")[0].innerHTML = "瑞钱币";
	} else {
		$("#sp_cop_type")[0].innerHTML = "投资券";
	}
	table.append(row);
}

function changeType(tab, e) {
	clearMap(map);
	$("#div_no_cop_record")[0].style.display = "none";
	tab = isEmpty(tab) ? 1 : tab;
	$("#coupon_table_1")[0].style.display = "none";
	$("#coupon_table_2")[0].style.display = "none";
	// 修改样式
	if (tab == 1) {
		$("div.fl").removeClass("tab_2").addClass("tab_1");
		$("div.fr").removeClass("tab_1").addClass("tab_2");
	} else {
		$("div.fr").removeClass("tab_2").addClass("tab_1");
		$("div.fl").removeClass("tab_1").addClass("tab_2");
	}
	$("#coupon_table_" + tab)[0].style.display = "block";
	if (isEmptyStr($("#coupon_table_" + tab)[0].innerHTML)) {
		getCouponData(tab);
	}
}

function forceUse() {// 多余瑞钱币作废，坚持使用
	history.go(-1);
}