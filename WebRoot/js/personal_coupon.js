$(function(){
	getCouponData(1);
	$("#coupon_table_1")[0].style.display = "block";
});

function getCouponData(tab){
	tab = isEmpty(tab) ? 1 : tab;
	$.ajax({
		type: "POST",
		url: "account/coupon/get.do",
		data: {type: tab},
		success: function(response) {
			if(response.success){
				var info = $.parseJSON(response.result);
				if(info.result){
					var couponInfo = info.resultObject.list;
					initCouponInfo(couponInfo, tab);
				}else{
					errorMsg(info.errInfo);
				}
			}else{
				if(isEmpty(response.result)){
					errorMsg(response.msg);
				}else{
					window.location.href = response.result;
				}
			}
		},
		dataType: "json"
	});
}

function initCouponInfo(data, tab){
	tab = isEmpty(tab) ? 1 : tab;
	var table = $("#coupon_table_" + tab);
	table[0].innerHTML = "";
	if(tab == 1){
		for(var i = 0; i < data.length; i++){
			var row = '<div class="cash-list">';
			row += '<img src="images/cash.png" alt="" class="img-responsive center-block">';
			row += '<div class="row coupon-list">';
			row += '<div class="col-xs-5 text-danger cl01"><h1><span class="rmb">￥</span>' + data[i].money + '</h1></div>';
			row += '<div class="col-xs-7 text-danger">';
			row += '<h5>' + data[i].remark + '</h5>';
			row += '<p>有效期：' + parseString(data[i].endTime) + '</p>';
			row += '</div></div></div>';
			table.append(row);
		}
	}else{
		for(var i = 0; i < data.length; i++){
			var row = '<div class="cash-list">';
			row += '<img src="images/cashed.png" alt="" class="img-responsive center-block">';
			row += '<div class="row coupon-list">';
			row += '<div class="col-xs-5 text-muted9 cl01"><h1><span class="rmb">￥</span>' + data[i].money + '</h1></div>';
			row += '<div class="col-xs-7 text-muted9">';
			row += '<h5>' + data[i].remark + '</h5>';
			row += '<p>' + parseString(data[i].endTime) + '</p>';
			row += '</div></div></div>';
			table.append(row);
		}
	}
}

function changeType(tab, e){
	tab = isEmpty(tab) ? 1 : tab;
	$("#coupon_table_1")[0].style.display = "none";
	$("#coupon_table_2")[0].style.display = "none";
	$("#coupon_table_3")[0].style.display = "none";
	
	$("div.tabactive").removeClass("tabactive");
	e.classList.add("tabactive");
	$("#coupon_table_" + tab)[0].style.display = "block";
	if(isEmptyStr($("#coupon_table_" + tab)[0].innerHTML)){
		getCouponData(tab);
	}
}