var shopid = "";
var method = "";
var point = "";
var total_points = 0;
var price = 0;
$(function() {
	
	
	initPage();
	getMarketDetail();
});

function initPage(){
	shopid = getRequestParam("id");
	method = getRequestParam("method");
	point = getRequestParam("point");
	price = getRequestParam("price");
	total_points = getRequestParam("total_points");
	$("#points_total")[0].innerHTML = total_points;
	$("#points_need")[0].innerHTML = point;
	$("#price")[0].innerHTML = "价格：¥"+price;
	$("#points")[0].innerHTML = "积分："+point;
}
function dismissAys(){
	$("#ays")[0].style.display = "none";
}
function sureToExchange(){
	
}
function couponExchange(){
	$("#sure_btn").attr("disabled", true);
	$("#ays")[0].style.display = "none";
	$.ajax({
		type : "POST",
		url : "account/market/coupon/exchange.do",
		data : {
			shopid:shopid,
			method:method,
			point:point,
			channel:"weixin"
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
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
	$("#sure_btn").attr("disabled", false);
}

function areYouSure(){
	 $("#ays")[0].style.display = "block";
}

function getMarketDetail(){
	$.ajax({
		type : "POST",
		url : "account/market/details/get.do",
		data : {
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if(info.result){
					var detail = info.resultObject;
					if(detail[shopid]){
						addInfoToPage(detail[shopid]);
					}
				}else{
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

function addInfoToPage(info){
	document.getElementById("banner_img").src = info.img;
	/*$("#goods_intro")[0].innerHTML = info.introduce;
	$("#use_area")[0].innerHTML = info.area;
	$("#use_way")[0].innerHTML = info.useDescription;*/
}
	