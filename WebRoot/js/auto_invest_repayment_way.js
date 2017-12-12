var map = {};
var firstValue = "";
var firstId = "";
$(function(){
	getCouponData();
});

function itemClick(id,value,label){
	if (map[value] != undefined) {
		/*$("#"+id).removeClass("checkarrow");
		delete map[value];*/
	} else {
		clearMap(map);
		$(".item_i").removeClass("checkarrow");
		$("#"+id).addClass("checkarrow");
		map[value] = label;
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
					var data = info.resultObject.auto_bid_repayment_way_type;
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
		firstValue = data[0].value;
		firstLabel = data[0].label;
	for(var i = 0;i<data.length;i++){
		var row = '';
		row += '<div class="auto_item" id="item'+i+'"';
		row += 'onclick="itemClick(\'';
		row += 'item'+data[i].value+'_sp';
		row += '\','+data[i].value+',\''+data[i].label+'\')">';
		row += '<span>'+data[i].label+'</span><i class="item_i" id="item'+data[i].value+'_sp"></i></div>';
		table.append(row);
	}
	if(sessionStorage.getItem("autoRepayWayValue")){
		var id = "item"+sessionStorage.getItem("autoRepayWayValue")+"_sp";
		$("#"+id).addClass("checkarrow");
	}else{
		var id = "item"+firstValue+"_sp";
		$("#"+id).addClass("checkarrow");
		sessionStorage.setItem("autoRepayWayValue", firstValue);
		sessionStorage.setItem("autoRepayWayLabel", firstLabel);
	}
}

function countValue() {
	var sessionStorage = window.sessionStorage;
	for (key in map) {
		if(map[key]){
			sessionStorage.setItem("autoRepayWayValue", key);
			sessionStorage.setItem("autoRepayWayLabel", map[key]);
		}
	}
}
function saveExit(){
		countValue();
		//location.href=document.referrer;
		//history.go(-1);
		var url = getRequestParam("retUrl");
		if(url.indexOf("?")>0){
			url = url + "&retUrl=auto_invest.jsp";
		}else{
			url = url + "?retUrl=auto_invest.jsp";
		}
		window.location.replace(url);
}
 