$(function() {
	getCouponData(1);
	$("#coupon_table_1")[0].style.display = "block";
});

function getCouponData(tab) {
	tab = isEmpty(tab) ? 1 : tab;
	if (tab == 1) {
		$.ajax({
			type : "POST",
			url : "account/reward/getRuiqbInfo.do",
			data : {
				type : tab
			},
			success : function(response) {
				if (response.success) {
					var info = $.parseJSON(response.result);
					if (info.result) {
						var RQBinfo = info.resultObject;
						initRuiQBInfo(RQBinfo);
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
	} else {
		$.ajax({
			type : "POST",
			url : "account/reward/get.do",
			data : {
				type : tab
			},
			success : function(response) {
				if (response.success) {
					var info = $.parseJSON(response.result);
					if (info.result) {
						var couponInfo = info.resultObject.投资券;
						if (couponInfo.length == 0) {
							$("#div_ticket_record")[0].style.display = "block";
						} else {
							initCouponInfo(couponInfo, tab);
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

function initRuiQBInfo(data) {
	$("#keyong_rqb")[0].innerHTML = data.可用;
	$("#yiyong_rqb")[0].innerHTML = data.已用;
	$("#guoqi_rqb")[0].innerHTML = data.过期;
}

function initCouponInfo(data, tab) {
	tab = isEmpty(tab) ? 1 : tab;
	var table = $("#coupon_table_" + tab);
	table[0].innerHTML = "";
	if (tab == 2) {
		for (var i = 0; i < data.length; i++) {
			var row = '';
			if (data[i].status == 3 || data[i].status == 6
					|| data[i].status == 7 || data[i].status == 8) {
				row += '<div class="djq gq">';
				row += '<img src="images/3.jpg" width="100%" onclick="goToProjectPage()">';
			} else if (data[i].status == 4 || data[i].status == 5) {
				row += '<div class="djq gq">';
				row += '<img src="images/2.jpg" width="100%" onclick="goToProjectPage()">';
			} else {
				row += '<div class="djq tz">';
				row += '<img src="images/4.jpg" width="100%" onclick="goToProjectPage()">';
			}
			row += '<div class="q">￥<font>' + data[i].money + '</font></div>';
			row += '<div class="p">投资券<br>' + parseString(data[i].endTime.split(" ")[i])
					+ '</div>';
			row += '<div class="ly">—— ' + data[i].remark + ' ——</div>';
			row += '<div class="r">NO.' + data[i].number + '';
			row += '</div>';
			table.append(row);
		}
	}
}

function changeType(tab, e) {
	tab = isEmpty(tab) ? 1 : tab;
	$("#coupon_table_1")[0].style.display = "none";
	$("#coupon_table_2")[0].style.display = "none";
	$("#div_ticket_record")[0].style.display="none";
	$("#coupon_table_3")[0].style.display="none";
	// 修改样式
	if (tab == 1) {
		$("#head_tab2").removeClass("tab_1").addClass("tab_2");
		$("#head_tab1").removeClass("tab_2").addClass("tab_1");
		$("#head_tab3").removeClass("tab_1").addClass("tab_2");
	} else if(tab == 2) {
		$("#head_tab1").removeClass("tab_1").addClass("tab_2");
		$("#head_tab2").removeClass("tab_2").addClass("tab_1");
		$("#head_tab3").removeClass("tab_1").addClass("tab_2");
	}else if(tab == 3){
		$("#head_tab1").removeClass("tab_1").addClass("tab_2");
		$("#head_tab2").removeClass("tab_1").addClass("tab_2");
		$("#head_tab3").removeClass("tab_2").addClass("tab_1");
	}
	$("#coupon_table_" + tab)[0].style.display = "block";
	if (isEmptyStr($("#coupon_table_" + tab)[0].innerHTML && tab == 2)) {
		getCouponData(tab);
	}else if (tab == 3) {
		getRatePercent();
//		addDataToCountTable("");
//		addDataToRateTable("");
	}
}

function getCountFriends(){
	
}
function getRatePercent(){
	$.ajax({
		  type: "POST",
		  url: "account/getrate/percent.do",
		  data: {},
		  success: function(response) {
		   if(response.success){
		    var info = $.parseJSON(response.result);
		    if(info.result){
		    	//添加数据到返利表格
		    	addDataToCountTable(info.resultObject);
		    	addDataToRateTable(info.resultObject);
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

function addDataToCountTable(data){
	var table = $("#count_div");
	var i = data.length -1;
	table[0].innerHTML = "";
		var row = '';
		row += '<table id="count_tb">';
		row += '<tr><th>'+"推荐注册人数"+'</th>'
		+ '<th>'+"实名人数"+'</th>' 
		+ '<th>'+"投资人数"+'</th>'
		+ '<th>'+"投资总额"+'</th>'
		+'</tr>';
		if(undefined != data[i].register){
			row += '<tr><td>'+data[i].register+'</td>'
		}else{
			row += '<tr><td>'+" "+'</td>';
		}
		if(undefined !=data[i].auth){
			row +='<td>'+data[i].auth+'</th>';
		}else{
			row += '<tr><td>'+" "+'</td>';
		}
		if(undefined != data[i].invest){
			row += '<td>'+data[i].invest+'</th>';
		}else{
			row += '<tr><td>'+" "+'</td>';
		}
		if(undefined != data[i].investCount){
			row +='<td>'+data[i].investCount+'</th>';
		}else{
			row += '<tr><td>'+" "+'</td>';
		}
			+'</tr>';
		row += '</table>';
		table.append(row);
}

function addDataToRateTable(data){
	var table = $("#income_rate_div");
	table[0].innerHTML = "";
		var row = '';
		row += '<table id="income_rate_tb">';
		row += '<tr><th>'+"用户名"+'</th>'
		+ '<th>'+" 投资金额"+'</th>'
		+ '<th>'+"注册日期"+'</th>'
		+ '<th>'+"奖励返现"+'</th>'
		+'</tr>';
		if(data.length == 1){
			row += '<tr><td>'+"-"+'</td>'
			+ '<td>'+"-"+'</td>'
			+ '<td>'+"-"+'</td>'
			+ '<td>'+"-"+'</td>'
			+'</tr>';
		}else{
		for(var i=0;i<data.length-1;i++){
			if(data[i].loginName !=undefined ){
				row += '<tr><td>'+data[i].loginName+'</td>';
			}else{
				row += '<tr><td>'+" "+'</td>';
			}
			if(data[i].totalInvestAmount !=undefined){
				row += '<td>'+data[i].totalInvestAmount+'</td>';
			}else{
				row += '<td>'+" "+'</td>';
			}
			if(data[i].registerDate !=undefined){
				row += '<td>'+data[i].registerDate+'</td>';
			}else{
				row += '<td>'+" "+'</td>';
			}
			if(data[i].returnMoney !=undefined){
				row += '<td>'+data[i].returnMoney+'</td>';
			}else{
				row += '<td>'+" "+'</td>';
			}
			+'</tr>';
		}
		}
		row += '</table>';
		table.append(row);
	
}

function goToProjectPage() {
	window.location.href = "project.jsp";
}

function RQBDetail() {// 瑞钱币明细
	window.location.href = "rqb_detail.jsp";
}
function changeRQB() {// 兑换瑞钱币
	window.location.href = "change_rqb.jsp";
}
