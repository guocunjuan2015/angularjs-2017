var type = "";
var status = "3-5";
var isToggled = 0;
var curTab = 1;
var c = "";
$(function() {
	getInvestData(1);
	iniCss3();
	$("#invest_1")[0].style.display = "block";
});

function getInvestData(tab) {
	tab = isEmpty(tab) ? 1 : tab;
	curTab = tab;
	$("#invest_table_" + tab)[0].innerHTML = "";
	switch (tab) {
	case 1:
		addTabCss(tab);
	case 3:
	case 4:
		addTabCss(tab);
		$.ajax({
			type : "POST",
			url : "account/invest/get.do",
			data : {
				t : type,
				s : status,
				c : this.c
			},
			success : function(response) {
				if (response.success) {
					dismissCss3();
					var info = $.parseJSON(response.result);
					if (info.result) {
						var investInfo = info.resultObject;
						if (investInfo.length == 0) {
							$("#invest_table_" + tab)[0].innerHTML = "";
							$("#no_data_div")[0].style.display = "block";
							$("#space_div")[0].style.display = "block";
						} else {
							initInvestInfo(investInfo, tab);
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
		break;
	case 2:
		addTabCss(tab);
		getCanTransferData(2);
		break;
	case 5:
	case 6:
		addTabCss(tab);
		getTransferInvestData(tab);
		break;
	}
}
function addTabCss(tab){
	$("#tab1").removeClass().addClass("box_span");
	for(var i = 2;i<7;i++){
		$("#tab"+i).removeClass().addClass("box_span no_border_left");
	}
	if(tab == 1){
		$("#tab"+tab).removeClass().addClass("box_span_active");
	}else{
		$("#tab"+tab).removeClass().addClass("box_span_active no_border_left");
	}
	
}
function getCanTransferData(tab){
	$.ajax({
		type : "POST",
		url : "account/transfer/cantransfer/get.do",
		data : {
		},
		success : function(response) {
			if (response.success) {
				dismissCss3();
				var info = $.parseJSON(response.result);
				if (info.result) {
					var investInfo = info.resultObject;
					if (investInfo.length == 0) {
						$("#invest_table_" + tab)[0].innerHTML = "";
						$("#no_data_div")[0].style.display = "block";
						$("#space_div")[0].style.display = "block";
					} else {
						initInvestInfo(investInfo, tab);
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

function getTransferInvestData(tab) {
	var st = "";
	if (tab == 5) {
		st = "start";
	} else if (tab == 6) {
		st = "end";
	}
	$.ajax({
		type : "POST",
		url : "account/transfer/invest/get.do",
		data : {
			status : st
		},
		success : function(response) {
			if (response.success) {
				dismissCss3();
				var info = $.parseJSON(response.result);
				if (info.result) {
					var investInfo = info.resultObject;
					if (investInfo.length == 0) {
						$("#invest_table_" + tab)[0].innerHTML = "";
						$("#no_data_div")[0].style.display = "block";
						$("#space_div")[0].style.display = "block";
					} else {
						initInvestInfo(investInfo, tab);
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

function initInvestInfo(data, tab) {
	tab = isEmpty(tab) ? 1 : tab;
	var table = $("#invest_table_" + tab);
	table[0].innerHTML = "";

	for (var i = 0; i < data.length; i++) {
		var row = '';
		row += '<section class="touzi-details" ';
		row += 'onclick="clickContent(\'';
		if (tab == 5 || tab == 6) {
			row += data[i].projectId;
		} else {
			row += data[i].id;
		}
		row += '\',' + tab + ',' + i + ')"';
		if (i == data.length - 1) {
			row += 'style="border-bottom:none;"';
		}
		row += '>';
		row += '<div class="touzi-title">';
		if(data[i].isTransferProject){
			row += '<div class="purple-icon">转</div>';
		}else if ("000" == data[i].projectType || "101" == data[i].projectType
				|| "102" == data[i].projectType || "103" == data[i].projectType
				|| "103" == data[i].projectType) {
			row += '<div class="db-icon">担</div>';
		} else if ("108" == data[i].projectType) {
			row += '<div class="zc-icon">资</div>';
		} else if ("122" == data[i].projectType) {
			row += '<div class="blue-icon">优</div>';
		} else if ("131" == data[i].projectType){
			row += '<div class="bg-icon">并</div>';
		}else if ("111" == data[i].projectType){
			row += '<div class="xs-icon">新</div>';
		}
		row += '<div class="orange-icon">' + "A" + '</div>';
		row += '<span class="touzi-title-one">'
				+ data[i].projectName.substr(0, 10) + ".." + '</span>';
		if (tab == 5) {
			row += '<span class="touzi-title-two">' + data[i].investAmount
					+ '元</span>';
		} else if (tab == 6) {
			row += '<span class="touzi-title-two"></span>';
		} else {
			row += '<span class="touzi-title-two">' + data[i].totalInvestAmount
					+ '元</span>';
		}
		row += '</div>';
		row += '<div class="nlv-info">';
		row += '<div class="nlvdiv">';
		if (tab == 5 || tab == 6) {
			row += '<span class="nlv-qt-color">转出金额 : '
					+ data[i].transferAmount + '元</span>';
			row += '<span  class="nlv-qt-color">开始时间：' + data[i].startTime
					+ '</span>';
		} else {
			row += '<span class="nlv-qt-color">预期年化收益 : ';
			if("131" == data[i].projectType){
				row += data[i].lockupPeriodRate;
			}else{
				row += data[i].loanRate;
			}
			row	+= '%</span>';
			var investTime = "";
			if (data[i].investTime) {
				investTime = data[i].investTime.split(" ")[0];
			}
			row += '<span  class="nlv-qt-color">投资日期：' + investTime + '</span>';
		}
		row += '</div>';
		row += '<div class="nlvsy">';
		if (tab == 5 || tab == 6) {
			row += '<span class="nlv-qt-color">已被认购：'
					+ data[i].transferFinishAmount + '元</span>';
			row += '<span  class="nlv-qt-color">过期时间:' + data[i].overTime
					+ '元</span>';
		} else {
			row += '<span class="nlv-qt-color">期限：' + data[i].loanPeriod
					+ data[i].unit+'</span>';
			row += '<span  class="nlv-qt-color">预期收益:' + data[i].income
					+ '元</span>';
		}
		row += '</div>';
		row += '</div>';
		row += '</section>';
		table.append(row);
	}

}

function changeType(tab, e) {
	dismissToggle();
	curTab = tab;
	this.type = "";
	this.c = "";
	$("#no_data_div")[0].style.display = "none";
	$("#space_div")[0].style.display = "none";
	iniCss3();
	tab = isEmpty(tab) ? 1 : tab;
	switch (tab) {
	case 1:
		status = "3-5";
		break;
	case 2:
		break;
	case 3:
		status = "1";
		break;
	case 4:
		status = "3-7";
		break;
	case 5:
		break;
	case 6:
		break;
	}
	errorMsg("");
	for(var i = 1;i<7;i++){
		$("#invest_"+i)[0].style.display = "none";
	}

	$("div.tabactive").removeClass("tabactive");
	if (tab == 1) {
		$("#tab1").addClass("tabactive");
	} else {
		$("#tab2").addClass("tabactive");
	}

	$("#invest_" + tab)[0].style.display = "block";
	// if (isEmptyStr($("#invest_table_" + tab)[0].innerHTML)) {
	getInvestData(tab);
	// }
}
function iniCss3() {
	$("#loading_anim")[0].style.display = "block";
}
function dismissCss3() {
	$("#loading_anim")[0].style.display = "none";
}
function ToToggle() {
	if (isToggled == 0) {
		$(".dropdown-menu").css("display", "block");
		isToggled = 1;
	} else {
		$(".dropdown-menu").css("display", "none");
		isToggled = 0;
	}
	// $(".dropdown-menu").slideToggle("slow");
}
function changePage(index) {

}

function dismissToggle() {
	if (isToggled == 1) {
		$(".dropdown-menu").css("display", "none");
		isToggled = 0;
	}
}
$(".dropdown-menu").mouseleave(function() { // 失去焦点
	isToggled = 0;
	$(".dropdown-menu").css("display", "none");
});

function chooseType(type) {
	$("#invest_table_" + curTab)[0].innerHTML = "";
	$("#no_data_div")[0].style.display = "none";
	$("#space_div")[0].style.display = "none";
	ToToggle();
	c = type;
	$("#invest_1")[0].style.display = "none";
	$("#invest_2")[0].style.display = "none";
	$("#invest_3")[0].style.display = "none";
	$("#invest_" + curTab)[0].style.display = "block";
	iniCss3();
	getInvestData(curTab);
}

function clickContent(id, tab, i, bol) {
	if (isEmptyStr(id) || id == 'undefined') {
		return;
	}
	switch (tab) {
	case 1:
	case 2:
	case 4:
		window.location.href = "personal_record_details.jsp?id=" + id + "&tab="
				+ tab + "&index=" + i;
		break;
	case 3:
		window.location.href = "project_invest_detail.jsp?id=" + id;
		break;
	case 5:
		window.location.href = "project_other_content.jsp?id=" + id+"&isTransfer=true";
		break;
	case 6:// 债权转让
		window.location.href = "personal_transfer_details.jsp?id=" + id
				+ "&index=" + i;
		break;
	}
}