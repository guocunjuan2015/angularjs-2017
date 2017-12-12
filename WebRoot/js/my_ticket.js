var isShow = false;
$(function() {
	getCouponInfo(1);
});

function changeTab(index) {
	$("#no_data")[0].style.display = "none";
	switch (index) {
	case 1:
		$("#tab_unused").removeClass().addClass("tab_choosed");
		$("#tab_used").removeClass();
		$("#tab_over_due").removeClass();

		$("#coupon_content1")[0].style.display = "block";
		$("#coupon_content2")[0].style.display = "none";
		$("#coupon_content3")[0].style.display = "none";
		getCouponInfo(1);
		break;
	case 2:
		$("#tab_unused").removeClass();
		$("#tab_used").removeClass().addClass("tab_choosed");
		$("#tab_over_due").removeClass();

		$("#coupon_content1")[0].style.display = "none";
		$("#coupon_content2")[0].style.display = "block";
		$("#coupon_content3")[0].style.display = "none";
		getCouponInfo(2);
		break;
	case 3:
		$("#tab_unused").removeClass();
		$("#tab_used").removeClass();
		$("#tab_over_due").removeClass().addClass("tab_choosed");

		$("#coupon_content1")[0].style.display = "none";
		$("#coupon_content2")[0].style.display = "none";
		$("#coupon_content3")[0].style.display = "block";
		getCouponInfo(3);
		break;
	}
}

function getCouponInfo(index) {
	$
			.ajax({
				type : "POST",
				url : "account/my/ticketinfo/get.do",
				data : {},
				success : function(response) {
					if (response.success) {
						var info = $.parseJSON(response.result);
						if (info.result) {
							if (info.resultObject.unused != null) {
								$("#cop_unuse_count")[0].innerHTML = info.resultObject.unused;
							}
							addDataToContainer(index, info.resultObject);
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

function addDataToContainer(index, data) {
	var table = $("#coupon_content" + index);
	table[0].innerHTML = "";
	switch (index) {
	case 1:
		data = data.unuseds;
		break;
	case 2:
		data = data.useds;
		break;
	case 3:
		data = data.expires;
		break;
	}
	if (data.length == 0) {
		$("#no_data")[0].style.display = "block";
	} else {
		$("#no_data")[0].style.display = "none";
		for (var i = 0; i < data.length; i++) {
			var row = '';
			if (index == 1) {
				row += '<div class="coupons">';
				row += '<div class="coupons-top">';
				row += '<div class="coupons-left">';
			} else {
				row += '<div class="coupons border-grey">';
				row += '<div class="coupons-top border-bottom-grey">';
				row += '<div class="coupons-left border-top-grey">';
			}
			if (index == 1) {
				row += '<span style="color: #f64840; font-size: 1.6rem;">￥</span><strong class="cop-strong">';
			} else {
				row += '<span style="color: #a0a0a0; font-size: 1.6rem;">￥</span><strong class="cop-strong font-grey">';
			}
			row += data[i].amount;
			row += '</strong></div>';
			if (index == 0) {
				row += '<div class="coupons-right">';
			} else {
				row += '<div class="coupons-right border-top-grey">';
			}
			row += '<span class="span2">';
			row += data[i].remarks;
			row += '</span> <span class="span4">';
			row += "体验劵只可投资一个月的项目";
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
}

function showBg(){
	if (isShow) {
		isShow = false;
		$("#bg").css({
			display : "none",
			height : $(document).height()
		});
		$("#ticket_illus").css({display:"none"});
	}else{
		isShow = true;
		$("#bg").css({
			display : "block",
			height : $(document).height()
		});
		$("#ticket_illus").css({display:"block"});
	}
}

function toActiveCoupon(){
	window.location.href = "active_ticket.jsp";
}