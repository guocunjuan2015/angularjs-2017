var period = 0;
var rate = 0.0;
var passValue = 0;// 选择的总面值
var copId = "";// 选择的优惠券拼接id
var mergeArray = new Array();
var ticketInfo = new Array();
var moreRateInfo = new Array();
var map = {};
var tyLength = 0;// 体验金列表长度
var len = 0;//
var couponType = 0;//记录选择的优惠券类型，1是优惠券，2是加息券
var storage = window.localStorage;
//$(function() {
	//initData();
	//getTicketData();
//});

function initData() {
	period = getRequestParam("period");
	projectIdToCop = getRequestParam("project_id");
	$("#periodBack").val(period);// 表单元素赋值
	$("#projectIdBack").val(projectIdToCop);// 表单元素赋值
}

function getTicketData() {
	$.ajax({
		type : "POST",
		url : "account/my/ticketinfo/get.do",
		data : {
			projectId : projectIdToCop
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					var data = info.resultObject;
					if (data.ticket) {
						ticketInfo = data.ticket.unuseds;
					}
					if (data.morerate) {
						moreRateInfo = data.morerate.unuseds;
					}
					mergeArray = ticketInfo.concat(moreRateInfo);// 数组合并
					initCouponInfo(mergeArray);
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
		$("#div_no_cop_record")[0].innerHTML = "没有可用优惠券!";
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
			if ("ticket" == data[i].type) {
				row += '<span style="color: #f64840; font-size: 1.6rem;">'
						+ data[i].unit + '</span>';
				row += '<strong class="cop-strong">' + data[i].amount
						+ '</strong>';
			} else {
				row += '<strong class="cop-strong">' + data[i].rate
						+ '</strong>';
				row += '<span style="color: #f64840; font-size: 1.6rem;">'
						+ data[i].unit + '</span>';
			}

		} else {
			row += '<span style="color: #a0a0a0; font-size: 1.6rem;">'
					+ data[i].unit
					+ '</span><strong class="cop-strong font-grey">';
		}

		row += '</br><span style="font-size:14px;color:#666;">';
		if ("ticket" == data[i].type) {
			row += '体验券';
		} else {
			row += '加息券';
		}

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
		if (index == 1) {
			row += "还有" + tm + "天过期";
		} else if (index == 2) {
			row += "已使用";
		} else if (index == 3) {
			row += "已过期";
		}

		row += '</span> <span class="span3">';
		row += "有效期：" + date;
		row += '</span></div></div>';
		table.append(row);
	}
}


function addToMap(i) {
	//if (period < 2) {
		var money = parseInt(getRequestParam("money_invest"));
		if (money < 100) {
			doNotSupport("投资金额超过100元才能使用优惠券");
		} else {
			if (map[i] != undefined) {
				document.getElementById("tz_box" + i).src = "images/cbox_bg1.jpg";
				delete map[i];
			} else {
				clearMap(map);// 清空map
				for (var n = 0; n < tyLength; n++) {
					document.getElementById("tz_box" + n).src = "images/cbox_bg1.jpg";
				}
				document.getElementById("tz_box" + i).src = "images/cbox_bg3.jpg";
				map[i] = i;
			}
			countValue();
		}
	/*} else {
		doNotSupport("该项目不支持投资券");
	}*/
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
	var id = "";
	for (key in map) {
		if (mergeArray[map[key]].amount) {
			value = (value + parseInt(mergeArray[map[key]].amount)); // 计算当前选择优惠券总值
			id = id + "," + mergeArray[map[key]].ticketId;
			couponType = 1;//选择了类型为体验券
		} else if (mergeArray[map[key]].rate) {
			couponType = 2;//选择了类型为加息券
			rate = (rate + parseFloat(mergeArray[map[key]].rate)); // 计算当前选择优惠券总值
			id = id + "," + mergeArray[map[key]].morerateId;
		}
	}
	if(couponType == 1){
		$("#passValue").val(value);// 表单元素赋值选择体验券的数额
	}else if(couponType == 2){
		$("#passValue").val(rate);// 表单元素赋值选择加息券的数额
	}
	var ids = id.substring(1);
	$("#copId").val(ids);// 表单元素赋值
	
	if(value > 0){//选择的是体验券
		showChoose(length, value,1);
	}else if(rate > 0){//选择的是加息券
		showChoose(length, rate,2);
	}else{//什么也没选
		showChoose(length, rate,0);
	}
	
}

function saveExit() {
	var storage = window.localStorage;
	removeStorage(storage);//清除localStorage
	if (couponType == 1) {
		storage.setItem("ticketValue", $("#passValue").val());
		storage.setItem("ticketId", $("#copId").val());
		storage.setItem("couponType",1);//选择类型为优惠券
	} else if(couponType == 2){
		storage.setItem("moreRateValue", $("#passValue").val());
		storage.setItem("moreRateId", $("#copId").val());
		storage.setItem("couponType",2);//选择类型为加息券
	}
	history.go(-1);
}
function removeStorage(storage){
	if(storage.getItem("couponType")){
		storage.removeItem("couponType");
	}
	if(storage.getItem("ticketId")){
		storage.removeItem("ticketId");
		storage.removeItem("ticketValue");
	}
	if(storage.getItem("moreRateId")){
		storage.removeItem("moreRateId");
		storage.removeItem("moreRateValue");
	}
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
		$("#sp_cop_type")[0].innerHTML = "投资券";
		break;
	case 2:// 加息券
		$("#sp_cop_value")[0].innerHTML = v + "%";
		$("#sp_cop_type")[0].innerHTML = "加息券";
		break;
	case 0:
		$("#sp_cop_value")[0].innerHTML = "";
		$("#sp_cop_type")[0].innerHTML = "";
		break;
	}
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

/*不适用优惠券*/

function unuse(){
    window.location.href = "project_invest.jsp?id="+ project_id + '&userId='+ userId + '&investAmount=' +investAmount + '&projectType=' + projectType  

}
 
/*20170113微信改版*/
var myGiftApp=angular.module("myGiftApp",[]);

myGiftApp.controller("myGiftController",function($scope,$http){

	var data = {
		projectId:project_id,
		userId:userId,
		investAmount:investAmount
	}

	transFn = function(data) {
        return $.param(data);
    },
    postCfg = {
        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
        transformRequest: transFn
    };
$http.post(" userAward/getUserCanUseCouponList.do",data,postCfg).success(function(data,index){
	var result = angular.fromJson(data.result);
	$scope.couponLists=result.resultObject.couponList;
	if($scope.couponLists == null || $scope.couponLists == ""){
      $(".noCoupon").show();
	} 

	/*选择优惠券点击事件*/
	$scope.couponClick = function(couponId, couponAmount,couponType,isUseCoupon,$event){
		storage.setItem("couponId", couponId);
		storage.setItem("couponAmount", couponAmount);
		storage.setItem("couponType", couponType);
		storage.setItem("investAmount", investAmount);
		
		var investMoney = $("#invest_number").val();
		if (isUseCoupon) {
			angular.element(document).ready(function(){
				//console.log($($event.target).find(".rightIcon").is(".rightIcon1"));
				//console.log($event.target);
				if($($event.target).find(".rightIcon").is(".rightIcon1") == true){
			        $(".rightIcon").removeClass("rightIcon1");
				} else {
				   $(".rightIcon").removeClass("rightIcon1");
				   $($event.target).find(".rightIcon").addClass("rightIcon1");
				}
			});
		}

		/*跳转到红包加息券页面*/
		window.location.href = "project_invest.jsp?id=" + getRequestParam("project_id")+ "&userId=" + userId + "&investAmount=" + investAmount + "&projectType=" + projectType;
	}

})

})
