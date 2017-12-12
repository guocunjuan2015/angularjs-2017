var isShow = false;
$(function() {
	getCouponInfo();
	getTicketInfo();
	getRedEnvelopeRecord();
	$("#footpanel").click(function() {
		toActiveTicket();
	});
});

function toCouponDetails() {
	window.location.href = "coupon_details.jsp";
}

function toActiveCoupon(index) {
	window.location.href = "active_coupon.jsp?type="+index;
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
							if (info.resultObject.unused) {
								$("#cop_useful")[0].innerHTML = info.resultObject.unused;
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

function showBg() {
	if (isShow) {
		isShow = false;
		$("#bg").css({
			display : "none",
			height : $(document).height()
		});
		$("#coupon_illus").css({
			display : "none"
		});
	} else {
		isShow = true;
		$("#bg").css({
			display : "block",
			height : $(document).height()
		});
		$("#coupon_illus").css({
			display : "block"
		});
	}
}

function clickTab(index) {
	$("#cop_tab" + 1).removeClass();
	/*$("#cop_tab" + 2).removeClass();*/
	$("#cop_tab" + 3).removeClass();
	$("#cop_tab" + index).removeClass().addClass("red_border_btm");
	var table = $("#coupon_illus");
	table[0].innerHTML = "";
	var row = '';
	switch (parseInt(index)) {
	case 1:// 选择体验券tab
		row += '<p>1. 体验券自生效起，使用期限为一个月</p>';
		row += '<p>2. 体验券只可投资一个月的项目</p>';
		row += '<p>3. 单次投资只能使用一张体验券，体验券和瑞钱币不能同时使用</p>';
		row += '<p>4. 体验券不可作为现金使用，投资需搭配最低100元现金方使用</p>';
		table.append(row);
		$("#footpanel")[0].style.display = "block";
		$("#foot-div")[0].innerHTML = "我有优惠券号";
		$("#coupon_outter")[0].style.display = "none";
		$("#red_package")[0].style.display = "none";
		$("#ticket_outter")[0].style.display = "block";
		$("#footpanel").click(function() {
			toActiveTicket();
		});
		break;
	case 2:// 选择瑞钱币tab
		row += '<p>a)	瑞钱币根据使用范围，在有效期内投资使用，每投资100元可使用1个瑞钱币，投资成功后瑞钱币以现金返回到用户账户中</p>';
		row += '<p>b)	单次投资使用瑞钱币个数不限制</p>';
		row += '<p>c)	若使用了瑞钱币的项目在投资期间发生流标，则瑞钱币还给用户</p>';
		row += '<p>d)	使用瑞钱币的项目不支持债权转让</p>';
		table.append(row);
		$("#footpanel")[0].style.display = "none";
		$("#coupon_outter")[0].style.display = "block";
		$("#red_package")[0].style.display = "none";
		$("#ticket_outter")[0].style.display = "none";
		break;
	case 3:
		row += '<p>1.  平台红包记录红包金额、红包来源、红包类型以及红包的使用说明；</p>';
		row += '<p>2.  平台红包分为理财红包和现金红包。理财红包在购买相应标的后到达用户可提取帐户中（理财红包需满足其使用条件方可使用）；现金红包直接到达可提取帐户中（某些现金红包需要累积达100后才能获得）请留意现金红包下方说明；</p>';
		row += '<p>3.  注册获得的理财红包在投资成功（计息）次日发放到可提取帐户中；</p>';
		row += '<p>4.  实名、绑卡、首次投资获得的理财红包，红包面额的50%是在投资成功（计息）次日返还到可提取帐户中，剩余50%是在投资期满后随本金及最后一期收益一并返还到可提取帐户中；</p>';
		row += '<p>5.  可提取帐户中的资金只有进行提取操作后，方可到达用户帐户余额中（可提现）</p>';
		row += '<p>6.  平台理财红包不适用于新手标、债权转让；</p>';
		row += '<p>7.  如有任何问题请拨打客服电话400-9198-555；</p>';
		row += '<p>8.  最终解释权法律范围内归瑞钱宝资产管理服务有限公司所有。</p>';
		table.append(row);
		$("#foot-div")[0].innerHTML = "我有红包号";
		$("#footpanel")[0].style.display = "block";
		$("#coupon_outter")[0].style.display = "none";
		$("#ticket_outter")[0].style.display = "none";
		$("#red_package")[0].style.display = "block";
		$("#footpanel").click(function() {
			toActiveCoupon(2);
		});
		break;
	}
}

function toActiveTicket() {
	window.location.href = "active_ticket.jsp";
}

function getTicketInfo() {
	$
			.ajax({
				type : "POST",
				url : "account/my/ticketinfo/get.do",
				data : {},
				success : function(response) {
					if (response.success) {
						var info = $.parseJSON(response.result);
						if(info.result) {
							if (info.resultObject.unused != null) {
								$("#cop_unuse_count")[0].innerHTML = info.resultObject.unused;
							}
							var table = $("#coupon_content" + 1);
							table[0].innerHTML = "";
							var morerateArr = "";
							if(info.resultObject.morerate){
								morerateArr = info.resultObject.morerate;
							}
							var ticketArr = info.resultObject.ticket;
							if (morerateArr.unuseds && morerateArr.unuseds.length == 0
									&& morerateArr.used.length == 0
									&& morerateArr.expires.length == 0
									&& ticketArr.unuseds.length == 0
									&& ticketArr.useds.length == 0
									&& ticketArr.expires.length == 0) {
								$("#no_data")[0].style.display = "block";
							} else {
								if(info.resultObject.morerate && info.resultObject.morerate.unuseds){
									addDataToContainer(1,
											info.resultObject.morerate.unuseds,1);
								}
								if(info.resultObject.ticket && info.resultObject.ticket.unuseds){
									addDataToContainer(1,
											info.resultObject.ticket.unuseds,1);
								}
								if(info.resultObject.morerate && info.resultObject.morerate.used){
									addDataToContainer(2,
											info.resultObject.morerate.used,1);
								}
								if(info.resultObject.ticket && info.resultObject.ticket.useds){
									addDataToContainer(2,
											info.resultObject.ticket.useds,1);
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
function getRedEnvelopeRecord(){
	$
			.ajax({
				type : "POST",
				url : "account/my/redenvelope/get.do",
				data : {},
				success : function(response) {
					if (response.success) {
						var info = $.parseJSON(response.result);
						if(info.result) {
							 
							var table = $("#coupon_content" + 2);
							table[0].innerHTML = "";
 
							if (info.resultObject.unuseds.length == 0 &&info.resultObject.useds.length == 0
									&& info.resultObject.expires.length == 0) {
								$("#no_red")[0].style.display = "block";
							} else {
								if(info.resultObject.unuseds){
									addDataToContainer(1,
											info.resultObject.unuseds,2);
								}
								if(info.resultObject.useds){
									addDataToContainer(2,
											info.resultObject.useds,2);
								}
								if(info.resultObject.expires){
									addDataToContainer(2,
											info.resultObject.expires,2);
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

function addDataToContainer(index, data,type){
	var table = $("#coupon_content" + type);
	
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
			if ("ticket" == data[i].type || type == 2) {
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
			/*
			 * row += '<span style="color: #a0a0a0; font-size:
			 * 1.6rem;">'+data[i].unit+'</span><strong class="cop-strong
			 * font-grey">';
			 */
			if ("ticket" == data[i].type || type == 2) {
				row += '<span style="color: #a0a0a0; font-size: 1.6rem;">'
						+ data[i].unit + '</span>';
				row += '<strong class="cop-strong font-grey">' + data[i].amount
						+ '</strong>';
			} else {
				row += '<strong class="cop-strong font-grey">' + data[i].rate
						+ '</strong>';
				row += '<span style="color: #a0a0a0; font-size: 1.6rem;">'
						+ data[i].unit + '</span>';
			}
		}
		row += '</br><span style="font-size:14px;color:#666;">';
		if ("ticket" == data[i].type) {
			row += '体验券';
		}else if(type == 2){
			row += data[i].name;
		} else {
			row += '加息券';
		}

		row += '</span>';
		row += '</div>';
		if (index == 0) {
			row += '<div class="coupons-right">';
		} else {
			row += '<div class="coupons-right border-top-grey">';
		}
		row += '<span class="span2">';
		row += data[i].remarks;
		row += '</span> <span class="span4">';
		row += data[i].rule;
		row += '</span></div></div>';
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
			row += '<div class="coupons-bottom"><span>';
		} else {
			row += '<div class="coupons-bottom bg-grey"><span>';
		}
		if (type == 2) {
			row += data[i].reserve1;
		} else {
			if (index == 1) {
				row += "还有" + tm + "天过期";
			} else if (index == 2) {
				row += "已使用";
			} else if (index == 3) {
				row += "已过期";
			}
		}
		row += '</span> <span class="span3">';
		row += "有效期：" + date;
		row += '</span></div></div>';
		table.append(row);
	}
}