
var period = 0;
var rate = 0.0;
var passValue = 0;// 选择的总面值
var copId = "";// 选择的优惠券拼接id
var redEvpInfo = new Array();
var map = {};
var tyLength = 0;// 体验金列表长度
var len = 0;//
var couponType = 0;//记录选择的优惠券类型，1是优惠券，2是加息券,3是红包
$(function() {
	initData();
	getTicketData();
});

function initData() {
	period = getRequestParam("period");
	projectIdToCop = getRequestParam("project_id");
	$("#periodBack").val(period);// 表单元素赋值
	$("#projectIdBack").val(projectIdToCop);// 表单元素赋值
}

function getTicketData() {
	$.ajax({
		type : "POST",
		url : "account/my/redenvelope/get.do",
		//url:"account/my/ticketinfo/get.do",
		data : {
			projectId : projectIdToCop
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					var data = info.resultObject;
						redEvpInfo = data.unuseds;
					initCouponInfo(redEvpInfo);
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

 
function initCouponInfo(data) {
	var table = $("#coupon_table");
	table[0].innerHTML = "";
	if (data.length == 0) {
		$("#div_no_cop_record")[0].innerHTML = "没有可用红包!";
		$("#div_no_cop_record")[0].style.display = "block";
	} else {
		if (data) {
			tyLength = data.length;
			addDataToTable(data, table);
		}
	}
}
function addDataToTable(data, table) {

	var index = 1;// 始终未过期的
	for (var i = 0; i < data.length; i++) {
		var row = '';
		if (index == 1) {
			row += '<div class="coupons" onclick="addToMap(' + i + ')">';
			row += '<div class="r">'
					+ '<img class="tz_box" src="images/cbox_bg1.jpg" id="tz_box' + i + '" />';
			row += '<div class="coupons-top">';
			row += '<div class="coupons-left" style="width:30%;">';
		} else {
			row += '<div class="coupons border-grey">';
			row += '<div class="coupons-top border-bottom-grey">';
			row += '<div class="coupons-left border-top-grey">';
		}
		if (index == 1) {
				row += '<span style="color: #f64840; font-size: 1.6rem;">'
						+ data[i].unit + '</span>';
				row += '<strong class="cop-strong">' + data[i].amount
						+ '</strong>';
		} else {
			row += '<span style="color: #a0a0a0; font-size: 1.6rem;">'
					+ data[i].unit
					+ '</span><strong class="cop-strong font-grey">';
		}

		row += '</br><span style="font-size:14px;color:#666;">';
		 
			row += '红包';
		row += '</span>';
		row += '</div>';
		if (index == 0) {
			row += '<div class="coupons-right" style="float:left;">';
		} else {
			row += '<div class="coupons-right border-top-grey" style="float:left;">';
		}
		row += '<span class="span2">';
		row += data[i].remarks;
		row += '</span> <span class="span4">';
		row += data[i].rule;
		row += '</span></div></div>';
		if (index == 1) {
			row += '<div class="coupons-bottom"><span>';
		} else {
			row += '<div class="coupons-bottom bg-grey"><span>';
		}
		var date = data[i].date;
		var nowDate = new Date();
		var endDate = new Date(date.replace(/-/g, "/"))
		var tm = endDate.getTime() - nowDate.getTime();
		if (tm <= 0) {
			tm = 0;
		} else {
			tm = parseInt(tm / 1000 / 60 / 60 / 24);
		}
		if (date) {
			date = date.split(" ")[0];
		}
		/*if (index == 1) {
			row += "还有" + tm + "天过期";
		} else if (index == 2) {
			row += "已使用";
		} else if (index == 3) {
			row += "已过期";
		}*/
		if(data[i].reserve1){
			row += data[i].reserve1;
		}

		row += '</span> <span class="span3">';
		row += "有效期：" + date;
		row += '</span></div></div>';
		table.append(row);
	}
}


function addToMap(i) {
	
		var money = parseInt(getRequestParam("money_invest"));
			if (map[i] != undefined) {
				document.getElementById("tz_box" + i).src = "images/cbox_bg1.jpg";
				delete map[i];
			} else {
				/*clearMap(map);// 清空map
				for (var n = 0; n < tyLength; n++) {
					document.getElementById("tz_box" + n).src = "images/cbox_bg1.jpg";
				}*/
				if(check(i)){
				document.getElementById("tz_box" + i).src = "images/cbox_bg3.jpg";
				map[i] = i;
				}
			}
			countValue();
	/*} else {
		doNotSupport("该项目不支持投资券");
	}*/
}
function check(index){
	var moneyInvest = parseInt(getRequestParam("money_invest"));
	var monyeNeed = parseInt($("#valueNeed").val());
	if(monyeNeed){
	}else{
		monyeNeed = 0;
	}
	if((monyeNeed + redEvpInfo[index].needUseMoney)>moneyInvest){
		doNotSupport("已超出红包累计使用金额");
		return false;
	}
	return true;
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
	var rate = 0;
	var moneyNeed = 0;
	var id = "";
	for (key in map) {
		if (redEvpInfo[map[key]].amount) {
			value = (value + parseInt(redEvpInfo[map[key]].amount)); // 计算当前选择优惠券总值
			moneyNeed = (moneyNeed + parseInt(redEvpInfo[map[key]].needUseMoney));
			id = id + "," + redEvpInfo[map[key]].couponId;
		} 
	}
	$("#passValue").val(value);// 表单元素赋值选择体验券的数额
	$("#valueNeed").val(moneyNeed);// 使用所选红包最小的投资金额
	var ids = id.substring(1);
	$("#copId").val(ids);// 表单元素赋值
	if(value > 0){//选择的是体验券
		showChoose(length, value,1);
	}else{//什么也没选
		showChoose(length, rate,0);
	}
	
}

function saveExit() {
	var storage = window.localStorage;
	removeStorage(storage);// 清除localStorage
	if($("#passValue").val()){
		storage.setItem("redEvpValue", $("#passValue").val());
		storage.setItem("redEvpId", $("#copId").val());
		storage.setItem("couponType", 4);// 选择类型为加息券
	}
	history.go(-1);
}
function removeStorage(storage){
	if(storage.getItem("couponType")){
		storage.removeItem("couponType");
	}
	if(storage.getItem("redEvpId")){
		storage.removeItem("redEvpId");
		storage.removeItem("redEvpValue");
	}
}

/** 检查红包和投资金额的使用比例 */
function checkCouponMax() {
	var length = Object.keys(map).length;
	if (length == 0) {// 没有勾选，直接返回，不用计算
		saveExit();
	} else {
		var money = parseInt(getRequestParam("money_invest"));
		useCouponAlert("所选瑞钱币总金额超过可使用额度,超过金额作废");
		
	}
}

function showChoose(length, v,type) {
	if (length == 0) {
		$("#sp_save_use")[0].innerHTML = "取消使用";
		couponType = 0;//什么优惠券也没选
	} else {
		$("#sp_save_use")[0].innerHTML = "使用";
	}
	$("#sp_cop_count")[0].innerHTML = length;//优惠券的张数
    switch (type) {
	case 1:// 体验券
		$("#sp_cop_value")[0].innerHTML = formatCurrency(v) + "元";
		$("#sp_cop_type")[0].innerHTML = "红包";
		break;
	case 0:
		$("#sp_cop_value")[0].innerHTML = "";
		$("#sp_cop_type")[0].innerHTML = "";
		break;
	}
}
