var map = {};
var array = {};
var firstValue = "";
var firstLabel = "";
var firstId = "";
var sessionStorage = window.sessionStorage;
var fValue = "";//保存首项的value，label,默认用
var fLabel = "";
$(function(){
	getCouponData();
});

function itemClick(id,value,label,i){
	if (map[value] != undefined) {
		$("#"+id).removeClass("checkarrow");
		delete map[value];
	} else {
		if(i==0){
			clearMap(map);
			firstValue = value;
			firstId = id;
			$(".item_i").removeClass("checkarrow");
			$("#"+id).addClass("checkarrow");
			map[value] = label;
		}else{
			if(firstValue){
				delete map[firstValue];
				$("#"+firstId).removeClass("checkarrow");
			}
			$("#"+id).addClass("checkarrow");
			map[value] = label;
		}
	}
	/*countValue();*/
}

function clearMap(map) {
	for (key in map) {
		delete map[key];
	}
}

function getCouponData() {
	$.ajax({
		type : "POST",
		url : "account/autoinvest/constant/get.do",
		data : {
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					var data = info.resultObject.auto_bid_loan_type;
					initPage(data);
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
function initPage(data){
	var table = $("#container");
	table[0].innerHTML = "";
		fValue = data[0].value;
		fLabel = data[0].label;
	for(var i = 0;i<data.length;i++){
		var row = '';
		row += '<div class="auto_item" id="item'+i+'"';
		row += 'onclick="itemClick(\'';
		row += 'item'+data[i].value+'_sp';
		row += '\',\''+data[i].value+'\',\''+data[i].label+'\','+i+')">';
		row += '<span>'+data[i].label+'</span><i class="item_i" id="item'+data[i].value+'_sp"></i></div>';
		table.append(row);
	}
	if(sessionStorage.getItem("autoTypeValue")){
		 var k = sessionStorage.getItem("autoTypeValue");
		 var v = sessionStorage.getItem("autoTypeLabel");
		 var arr = k.split(",");
		 var arr1 = v.split(",");
		 for(var i = 0;i<arr.length;i++){
			 if(fValue == arr[i]){
				 firstValue = arr[i];
				 firstId = "item" + fValue + "_sp";
			 }
			 map[arr[i]] = arr1[i];
			 var id = "item"+arr[i]+"_sp";
			 $("#"+id).addClass("checkarrow");
		 }
	} else {
		var id = "item" + fValue + "_sp";
		$("#" + id).addClass("checkarrow");
		firstValue = fValue;
		firstId = "item" + fValue + "_sp";
		sessionStorage.setItem("autoTypeValue", fValue);
		sessionStorage.setItem("autoTypeLabel", fLabel);
	}
	
}

function countValue() {
	var k = "";
	var v = "";
	for (key in map) {
		if (key) {
			k += "," + key;
			v += "," + map[key];
		}
	}
	var ks = k.substring(1);
	var vs = v.substring(1);
	sessionStorage.setItem("autoTypeValue", ks);
	sessionStorage.setItem("autoTypeLabel", vs);
}
function saveExit() {
	if (check()) {
		countValue();
		//location.href = document.referrer;
		// history.go(-1);
		var url = getRequestParam("retUrl");
		if(url.indexOf("?")>0){
			url = url + "&retUrl=auto_invest.jsp";
		}else{
			url = url + "?retUrl=auto_invest.jsp";
		}
		window.location.replace(url);
	}
}
function check(){
	for (key in map) {
		if(key){
			 return true;
		}
	}
	errorMsg("请选择投标种类");
	return false;
}