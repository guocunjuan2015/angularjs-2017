var isShow = false;
$(function() {
	getCouponInfo();
});

function toCouponDetails() {
	window.location.href = "coupon_details.jsp";
}

function toActiveCoupon() {
	window.location.href = "active_coupon.jsp";
}

function getCouponInfo() {
	$
			.ajax({
				type : "POST",
				url : "account/my/couponinfo/get.do",
				data : {},
				success : function(response) {
					if (response.success) {
						var info = $.parseJSON(response.result);
						if (info.result) {
							if (info.resultObject.total) {
								$("#cop_total")[0].innerHTML = info.resultObject.total;
							} else {
								$("#cop_total")[0].innerHTML = "0";
							}
							if (info.resultObject.used) {
								$("#cop_useful")[0].innerHTML = info.resultObject.used;
							} else {
								$("#cop_useful")[0].innerHTML = "0";
							}
							if (info.resultObject.expire) {
								$("#cop_overdue")[0].innerHTML = info.resultObject.expire;
							} else {
								$("#cop_overdue")[0].innerHTML = "0";
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

function showBg(){
	if (isShow) {
		isShow = false;
		$("#bg").css({
			display : "none",
			height : $(document).height()
		});
		$("#coupon_illus").css({display:"none"});
	}else{
		isShow = true;
		$("#bg").css({
			display : "block",
			height : $(document).height()
		});
		$("#coupon_illus").css({display:"block"});
	}
}