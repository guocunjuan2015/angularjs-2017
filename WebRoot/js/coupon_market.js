var list = new Array();
var count = 0;
var total_points = 0;
$(function() {
	getMarketList();
	getRecord();
});
function toExchangeRecord() {
	 window.location.href = "exchange_record.jsp";
}

function addDataToContainer(data) {
	var table = $("#market_container");
	table[0].innerHTML = "";
	for (var i = 1; i < data.length-1; i++) {
		var row = '';
		/*if (i == 1) {
			row += '<li class="coupon-hot" onclick="';
			row += "toRqbExchange(";
			row += data[i].point;
		} else {*/
			row += '<li onclick="';
			row += "toCouponExchange(";
			row += i;// 商品index
		//}
		row += ")";
		row += '"><img src="';
		row += data[i].img;
		row += '"/><p class="coupon-title">';
		row += data[i].name;
		row += '</p><p class="coupon-num"><span>';
		row += "积分";
		row += '</span><strong>';
		row += data[i].point;
		row += '</strong></p><i></i></li>';
		table.append(row);
	}
}

function toCouponExchange(index) {
	var id = list[index].shopid;
	var type = list[index].type;
	var point = list[index].point;
	var img = list[index].img;
	var price = list[index].price;
	window.location.href = "coupon_exchange.jsp?id=" + id + "&method=" + type
			+ "&point=" + point + "&img=" + img+"&price="+price+"&total_points="+total_points;
}

function getMarketList() {
	$("#loading_anim")[0].style.display = "block";
	$.ajax({
		type : "POST",
		url : "account/market/list/get.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					$("#loading_anim")[0].style.display = "none";
					if (info.resultObject.length == 0) {
						$("#div_no_projects")[0].style.display = "block"
					} else {
						list = info.resultObject;
						$("#user_points")[0].innerHTML = list[0].availablepoint;
						total_points = list[0].availablepoint;
						addDataToContainer(list);
					}
				} else {
					errorMsg(info.errInfo);
				}
			} else {
				if (isEmpty(response.result)) {
					errorMsg(response.msg);
				} else {
					window.location.href = response.result+ "?reflect_url="
					+ encodeURIComponent("coupon_market.jsp");
				}
			}
		},
		dataType : "json"
	});
}
function getAccountData() {
	$.ajax({
		type : "POST",
		url : "account/detail/get.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					var accountInfo = info.resultObject;
					$("#user_points")[0].innerHTML = accountInfo.availablepoint;
					total_points = parseInt(accountInfo.availablepoint);
				} else {
					errorMsg(info.errInfo);
				}
			} else {
				if (isEmpty(response.result)) {
					errorMsg(response.msg);
				} else {
					window.location.href = response.result+ "?reflect_url="
					+ encodeURIComponent("coupon_market.jsp");
				}
			}
		},
		dataType : "json"
	});
}

function toCouponRecord() {
	window.location.href = "coupon_record.jsp";
}

function toRqbExchange(points){
	window.location.href = "points_exchange.jsp?points="+points;
}
function getRecord(){
	$.ajax({
		type : "POST",
		url : "account/market/update/record.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					if(info.resultObject.history){
						updateRecord(info.resultObject.history);
					}
				} 
			} else {
				if (isEmpty(response.result)) {
					errorMsg(response.msg);
				} else {
					window.location.href = response.result+ "?reflect_url="
					+ encodeURIComponent("coupon_market.jsp");
				}
			}
		},
		dataType : "json"
	});
}

function updateRecord(data){
	if(count!=0 && i>=data.length){
		count = 0;
		getRecord();
	}else if(data.length!=0){
		setInterval(update(data), 30000);
	}
	count++;
}
function update(data){
	$("#user_update")[0].innerHTML = data[count];
}
