$(function(){
	getCouponData(1);
	$("#coupon_table_1")[0].style.display = "block";
});

function getCouponData(tab){
	tab = isEmpty(tab) ? 1 : tab;
	$.ajax({
		type: "POST",
		url: "account/reward/get.do",
		data: {type: tab},
		success: function(response) {
			if(response.success){
				var info = $.parseJSON(response.result);
				if(info.result){
					if(tab == 1){
						var couponInfo = info.resultObject.代金券;
					}else{
						var couponInfo = info.resultObject.投资券;
					}
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
			var row = '';
			// 图片1未使用 图片2已使用 图片3已过期
			if(data[i].status == 3 
					|| data[i].status == 6 
					|| data[i].status == 7 
					|| data[i].status == 8){
				row += '<div class="djq gq">';
				row += '<img src="images/3.jpg" width="100%" onclick="goToProjectPage()">';
			}else if(data[i].status == 4 
					|| data[i].status == 5 ){
				row += '<div class="djq gq">';
				row += '<img src="images/2.jpg" width="100%" onclick="goToProjectPage()">';
			}else{
				row += '<div class="djq">';
				row += '<img src="images/1.jpg" width="100%" onclick="goToProjectPage()">';
			}
			row += '<div class="q">￥<font>' + data[i].money + '</font></div>';
			row += '<div class="p">代金券<br>' + parseString(data[i].endTime) + '</div>';
			row += '<div class="ly">—— ' + data[i].remark + ' ——</div>';
			row += '<div class="r">NO.' + data[i].number + '';
			row += '</div>';
			row += '</div>';
			table.append(row);
		}
	}else{
		for(var i = 0; i < data.length; i++){
			var row = '';
			if(data[i].status == 3 
					|| data[i].status == 6 
					|| data[i].status == 7 
					|| data[i].status == 8){
				row += '<div class="djq gq">';
				row += '<img src="images/3.jpg" width="100%" onclick="goToProjectPage()">';
			}else if(data[i].status == 4 
					|| data[i].status == 5 ){
				row += '<div class="djq gq">';
				row += '<img src="images/2.jpg" width="100%" onclick="goToProjectPage()">';
			}else{
				row += '<div class="djq tz">';
				row += '<img src="images/4.jpg" width="100%" onclick="goToProjectPage()">';
			}
			row += '<div class="q">￥<font>' + data[i].money + '</font></div>';
			row += '<div class="p">投资券<br>' + parseString(data[i].endTime) + '</div>';
			row += '<div class="ly">—— ' + data[i].remark + ' ——</div>';
			row += '<div class="r">NO.' + data[i].number + '';
			row += '</div>';
			table.append(row);
		}
	}
}

function changeType(tab, e){
	tab = isEmpty(tab) ? 1 : tab;
	$("#coupon_table_1")[0].style.display = "none";
	$("#coupon_table_2")[0].style.display = "none";
	// 修改样式
	if(tab == 1){
		$("div.fl").removeClass("tab_2").addClass("tab_1");
		$("div.fr").removeClass("tab_1").addClass("tab_2");
	}else{
		$("div.fr").removeClass("tab_2").addClass("tab_1");
		$("div.fl").removeClass("tab_1").addClass("tab_2");
	}
	$("#coupon_table_" + tab)[0].style.display = "block";
	if(isEmptyStr($("#coupon_table_" + tab)[0].innerHTML)){
		getCouponData(tab);
	}
}

function goToProjectPage(){
	window.location.href = "project.jsp";
}
