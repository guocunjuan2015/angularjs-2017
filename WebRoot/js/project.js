var isToggled = 0;
var type = "";
var childType = "";
var status = "";
var order = "";
var orderType = "";
var index = 1;
var size = 10;
var curTab = 2;
var f = 0;
var utm_source = "";
var uid = "";
var channel = "";
var tabNum = 3;// 控制tab个数
var windowHeight = $(this).height();// 屏幕宽度
var loadToEnd = false;// 加载到最后一组
var isLoading = true;// 正在加载中
$(function() {
	if(getRequestParam("channel")){
		f = getRequestParam("channel");
		var storage = window.sessionStorage;
		storage.setItem("channel", f);// 增加投资来源
	}
	
	if(window.localStorage.getItem("dismissDownload")){
		dismiss('download');
	}
	initFbaba();// 获取fbaba信息
	addBottomMenu();// 添加底部tab菜单按钮
	isToggled = 0;
	if (sessionStorage.getItem("lastTab")) {
		iniTab(parseInt(sessionStorage.getItem("lastTab")));
	} else {
		iniTab(curTab);// 初始化tab,显示第二个
	}
	getNotice();// 获取通知
	iniCss3();// 加载动画
	getPeiZi();// 获取配资比例
	showActiveLogo();//活动图标
	if (sessionStorage.getItem("lastTab")) {
		getProject(sessionStorage.getItem("lastTab"));
	} else {
		getProject(curTab);// 初始化tab,显示第二个
	}
});

function initFbaba() {
	if (getRequestParam("utm_source")) {
		utm_source = getRequestParam("utm_source");
		window.sessionStorage.setItem("utm_source", utm_source);
	}  
	if (getRequestParam("uid")) {
		uid = getRequestParam("uid");
		window.sessionStorage.setItem("uid", uid);
	}  
}
function initChannel() {
	if (getRequestParam("channel")) {
		channel = getRequestParam("channel");
		window.sessionStorage.setItem("channel", channel);
	}  
}

function getNotice() {
	$.ajax({
		type : "POST",
		url : "project/notice/get.do",
		data : {
			n : "",
			c : ""
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					var data = info.resultObject;
					detailId = data[0].k;
					$("#notice_title").append(data[0].t);
					var cont = $("#notice_title")[0].innerHTML;
					if (cont.length > 19) {
						var str = cont;
						str = str.substr(0, 19);
						str = str + "...";
						$("#notice_title")[0].innerHTML = str;
					} else {
						var str = "&nbsp";
						var restLength = cont.length - 19;
						for (var i = 0; i < restLength; i++) {
							str += "&nbsp";
						}
						$("#notice_title")[0].innerHTML = cont + str;
					}
					$("#notice_title_div").animate({
					    height:'toggle'
					  });
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

function iniTab(i) {
	addTabCss(i);// 为tab添加样式
}

function addTabCss(i) {
	if (tabNum == 2) {
		$("#transfer_div")[0].style.display = "none";
		switch (i) {
		case 1:
			$("#ugrow_div").removeClass().addClass(
					"col-xs-6 col-md-6 tab1 tabactive");
			$("#sanbiao_div").removeClass().addClass("col-xs-6 col-md-6 tab1");
			break;
		case 2:
			$("#ugrow_div").removeClass().addClass("col-xs-6 col-md-6 tab1");
			$("#sanbiao_div").removeClass().addClass(
					"col-xs-6 col-md-6 tab1 tabactive");
			break;
		}
	} else if (tabNum == 3) {
		switch (i) {
		case 1:
			$("#ugrow_div").removeClass().addClass(
					"col-xs-4 col-md-4 tab1 tab-bod tabactive");
			$("#sanbiao_div").removeClass().addClass(
					"col-xs-4 col-md-4 tab1 tab-bod");
			$("#transfer_div").removeClass().addClass("col-xs-4 col-md-4 tab1");
			break;
		case 2:
			$("#ugrow_div").removeClass().addClass(
					"col-xs-4 col-md-4 tab1 tab-bod");
			$("#sanbiao_div").removeClass().addClass(
					"col-xs-4 col-md-4 tab1 tab-bod tabactive");
			$("#transfer_div").removeClass().addClass("col-xs-4 col-md-4 tab1");
			break;
		case 3:
			$("#ugrow_div").removeClass().addClass(
					"col-xs-4 col-md-4 tab1 tab-bod");
			$("#sanbiao_div").removeClass().addClass(
					"col-xs-4 col-md-4 tab1 tab-bod");
			$("#transfer_div").removeClass().addClass(
					"col-xs-4 col-md-4 tab1 tab-bod tabactive");
			break;
		}
	}
	$("#row_tab_div")[0].style.display = "block";
}

function changePage(i) {
	sessionStorage.setItem("lastTab", i);// 保留上次tab记录,返回时使用
	curTab = i;
	this.index = 1;
	dismissBottom();
	isLoading = true;
	loadToEnd = false;
	addTabCss(i);
	$("#row_container")[0].innerHTML = "";
	iniCss3();
	getProject(i);
}

function getProject(tab) {
	if (tab == 3) {
		this.type = 1;
		getProjectList(0);// 获取理财债权转让列表
	} else {
		if (tab == 1) {
			this.type = 3;
		} else if (tab == 2) {
			this.type = 2;
		}// 获取理财其他项目列表
		getProjectList(1);
	}
}

function getProjectList(index) {
	var url = "";
	if (index == 1) {
		url = "project/newget.do";
	} else {
		url = "project/transferget.do"
	}
	$
			.ajax({
				type : "POST",
				url : url,
				data : {
					type : this.type,
					childType : this.childType,
					status : this.status,
					order : this.order,
					orderType : this.orderType,
					index : this.index,
					size : this.size,
					from : ""
				},
				success : function(response) {
					console.log(response.size);
					if (response.success) {
						var info = $.parseJSON(response.result);
						if (info.result) {
							var projects = info.resultObject.list == undefined ? info.resultObject
									: info.resultObject.list;
							var container = $("#row_container");
							container[0].innerHTML = "";
							dismissBottom();
							if (projects.length == 0) {
								if (this.index == 1) {
									$("#no_data")[0].style.display = "block";
								} else {
									$("#no_more")[0].style.display = "block";
								}

								$("#loading_anim")[0].style.display = "none";
							} else {
								for (var i = 0; i < projects.length; i++) {
									if(projects[i].isNeedContribution){
										continue;
									}
									container.append(initRow(projects[i]));
								}
								if (projects.length < parseInt(size)) {
									loadToEnd = true;
								} else {
									$("#click_load")[0].style.display = "block";
								}
								isLoading = false;// 加载完成
							}
						} else {
							errorMsg(info.errInfo);
						}
					} else {
						errorMsg(response.msg);
					}
				},
				dataType : "json"
			});
}
function addMore() {
	$("#click_load")[0].style.display = "none";
	$("#load_data")[0].style.display = "block";
	isLoading = true;
	this.index = this.index + 1;
	var url = "";
	switch (curTab) {
	case 1:
	case 2:
		url = "project/newget.do";
		break;
	case 3:
		url = "project/transferget.do";
		break;
	}
	$
			.ajax({
				type : "POST",
				url : url,
				data : {
					type : this.type,
					childType : this.childType,
					status : this.status,
					order : this.order,
					orderType : this.orderType,
					index : this.index,
					size : this.size,
				},
				success : function(response) {
					if (response.success) {
						var info = $.parseJSON(response.result);
						if (info.result) {
							var projects = info.resultObject.list == undefined ? info.resultObject
									: info.resultObject.list;
							var container = $("#row_container");
							dismissBottom();
							if (projects.length == 0) {
								if (this.index == 1) {
									$("#no_data")[0].style.display = "block";
								} else {
									$("#no_more")[0].style.display = "block";
								}
								$("#loading_anim")[0].style.display = "none";
							} else {
								for (var i = 0; i < projects.length; i++) {
									container.append(initRow(projects[i]));
								}
								if (projects.length < parseInt(size)) {
									loadToEnd = true;
								} else {
									$("#click_load")[0].style.display = "block";
								}
								isLoading = false;// 加载完成
							}
						} else {
							errorMsg(info.errInfo);
						}
					} else {
						errorMsg(response.msg);
					}
				},
				dataType : "json"
			});
}

function initRow(data) {
	$("#loading_anim")[0].style.display = "none";
	var row = '';
	var current_time = new Date();
	var start_time = new Date(data.projectStartDate);
	row += '<section class="yjh-details" onclick="clickContent(\'';
	row += data.projectID;
	if (data.isTransferProject) {
		row += '\',' + data.isTransferProject + ')">';
	} else {
		row += '\',' + false + ')">';
	}
	row += '<div class="yjh-title">';

	var st = parseInt(data.status);
	if (st == 2 || st == 9) {
		if (data.isTransferProject) {
			row += '<div class="zr-icon">' + "转" + '</div>';
		} else if (data.isNeedContribution) {
			row += '<div class="zr-icon">' + "约" + '</div>';
		}else if ("122" == data.projectType) {
			row += '<div class="blue-icon">' + "优" + '</div>';
		} else if ("108" == data.projectType) {
			row += '<div class="zc-icon">' + "资" + '</div>';
		} else if ("000" == data.projectType || "101" == data.projectType
				|| "103" == data.projectType || "107" == data.projectType
				|| "102" == data.projectType) {
			row += '<div class="db-icon">' + "担" + '</div>';
		} else if ("131" == data.projectType) {
			row += '<div class="bg-icon">' + "并" + '</div>';
		} else if ("111" == data.projectType) {
			row += '<div class="xs-icon">' + "新" + '</div>';
		}
		row += '<div class="orange-icon">' + "A"
				+ '</div><span class="yjh-title-one">';
	} else {
		if (data.isTransferProject) {
			row += '<div class="zr-icon bg-grey">' + "转" + '</div>';
		} else if (data.isNeedContribution) {
			row += '<div class="zr-icon bg-grey">' + "约" + '</div>';
		} else if ("122" == data.projectType) {
			row += '<div class="blue-icon bg-grey">' + "优" + '</div>';
		} else if ("108" == data.projectType) {
			row += '<div class="zc-icon bg-grey">' + "资" + '</div>';
		} else if ("000" == data.projectType || "101" == data.projectType
				|| "103" == data.projectType || "107" == data.projectType
				|| "102" == data.projectType) {
			row += '<div class="db-icon bg-grey">' + "担" + '</div>';
		} else if ("131" == data.projectType) {
			row += '<div class="bg-icon bg-grey">' + "并" + '</div>';
		} else if ("111" == data.projectType) {
			row += '<div class="xs-icon bg-grey">' + "新" + '</div>';
		}
		row += '<div class="orange-icon bg-grey">' + "A"
				+ '</div><span class="yjh-title-one">';
	}
	if (data.projectName.length > 16) {
		var str = data.projectName;
		str = str.substr(0, 16);
		row += str + "..";
	} else {
		row += data.projectName;
	}
	if (st == 2 && "100" == data.projectType) {
		row += '</span><span class="yjh-title-two">' + "还剩 "
				+ formatIntCurrency(parseInt(data.projectBalance)) + "元"
				+ '</span>' + '</div>';
	}
	row += '</span><span class="yjh-title-two">' + "&nbsp" + '</span>'
			+ '</div>';
	row += '<div class="nlv-info"><div class="nlvdiv nlvsy"><span style="position:relative;">';
	if (st == 2 || st == 9) {
		row += '<strong class="qxmoney">';
	} else {
		row += '<strong class="qxmoney font-grey">';
	}
	if ("131" == data.projectType) {
		row += data.lockupPeriodRate;
	} else {
		row += roundToTenth(data.loanRate_split);
	}
	if (st == 2 || st == 9) {
		row += '</strong><span class="qxspan">' + "%";
	} else {
		row += '</strong><span class="qxspan_grey">' + "%";
	}
	if (parseFloat(data.award) > 0) {
		row += '&nbsp;+&nbsp;' + '</span>';
		if (st == 2 || st == 9) {
			row += '<strong class="qxmoney">';
			row += roundToTenth(data.award) + '</strong><span class="qxspan">'
					+ "%";
			row += '</span><i class="nlv-active">';
		} else {
			row += '<strong class="qxmoney font-grey">';
			row += roundToTenth(data.award)
					+ '</strong><span class="qxspan_grey">' + "%";
			row += '</span><i class="nvl-active-grey">';
		}
		row += data.bid_award_source + '</i>';
	} else {
		row += '</span>';
	}
	row += '</span>' + '<span class="nlv-qt-color">' + "预期年化收益" + '</span>'
			+ '</div>' + '<div class="nlvdiv" style="margin-left:7%;">'
			+ '<span>';
	if (st == 2 || st == 9) {// 投资期限
		row += '<strong class="loan_period">';
	} else {
		row += '<strong class="loan_period font-grey">';
	}
	row += data.loanPeriod + '</strong><span class="qxspan_grey">';
	row += data.unit;// 期限单位
	row += '</span></span>' + '<span class="nlv-qt-color">' + "期限" + '</span>'
			+ '</div>';
	switch (st) {
	case 2:
		row += '<div class="nlv-btn-Add">' + "抢" + '</div>';
		break;
	case 9:
		row += '<div class="nlv-btn-Add   font-size-4">'
				+ "敬请期待" + '</div>';
		break;
	case 7:
		row += '<div class="nlv-btn-Add font-grey border-grey font-size-3">'
				+ "已结清";
		break;
	case 4:
	case 5:
	case 12:
		row += '<div class="nlv-btn-Add font-grey border-grey font-size-3">'
				+ "回款中";
		break;
	case 3:
	case 6:
		'<div class="nlv-btn-Add font-grey border-grey">' + "流标";
		break;
	}
	if ("100" == data.projectType) {
		row += '</div>' + '</div>' + '<div class="qtmoney font-smaller">'
				+ "可部分认购，持有一个月以上可再次转让";
	} else {
		if (data.isTransferProject) {
			row += '</div>' + '</div>' + '<div class="qtmoney">' + "&nbsp";
		} else {
			row += '</div>' + '</div>' + '<div class="qtmoney">'
					+ data.projectMinNum + "起投";
		}
	}
	if ("122" == data.projectType) {
		row = row + '<em class="font-grey">';
		var period = parseInt(data.loanPeriod);
		var storage = window.localStorage;
		if (period == 3) {
			if (storage.getItem("PZRate3")) {
				row += "配资" + parseFloat(storage.getItem("PZRate3") * 100)
						+ "%";
			}
		} else if (period == 6) {
			if (storage.getItem("PZRate6")) {
				row += "配资" + parseFloat(storage.getItem("PZRate6") * 100)
						+ "%";
			}
		} else if (period == 12) {
			if (storage.getItem("PZRate12")) {
				row += "配资" + parseFloat(storage.getItem("PZRate12") * 100)
						+ "%";
			}
		} else if (period == 24) {
			if (storage.getItem("PZRate24")) {
				row += "配资" + parseFloat(storage.getItem("PZRate24") * 100)
						+ "%";
			}
		}
		row += '</em>';
	}
	if (data.isTransferProject) {
		if (data.discountAmount) {
			row += '<span class="yjh-title-two font-smaller">'
					+ data.discountAmount + '元折让金' + '</span>';
		}
	} else if (st == 2) {
		row += '<span class="yjh-title-two">' + "还剩 "
				+ formatIntCurrency(parseInt(data.projectBalance)) + "元"
				+ '</span>';
	}

	row += '</div>' + '</section>';
	return row;
}

function clickContent(id, isTransfer) {
	window.location.href = "project_other_content.jsp?id=" + id
			+ "&isTransfer=" + isTransfer;
}

function ToToggle() {
	if (isToggled == 0) {
		$(".dropdown-menu").css("display", "block");
		isToggled = 1;
	} else {
		$(".dropdown-menu").css("display", "none");
		isToggled = 0;
	}
}

function iniCss3() {
	$("#loading_anim")[0].style.display = "block";
}

function refresh() {
	location.reload();
}
function toAccountCenter() {
	window.location.href = "personal_center.jsp";
}

function toNoticeDetails() {
	if (detailId) {
		window.location.href = "notice_details.jsp?detailId=" + detailId;
	}
}

function toDownloadApp() {
	window.location.href = "http://a.app.qq.com/o/simple.jsp?pkgname=com.dyxd.rqt&g_f=991653";
}
function cancelDownload(event) {
	event.stopPropagation();// 阻止父dom点击事件
	$("#download")[0].style.display = "none";
	window.localStorage.setItem("dismissDownload",true);
}

function getPeiZi() {
	$.ajax({
		type : "POST",
		url : "normal/peizi/rate/get.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					if (info.resultObject) {
						addRateToStorage(info.resultObject);// 配资比例添加到storage
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
function addRateToStorage(data) {
	var storage = window.localStorage;
	if (data[3]) {
		storage.setItem("PZRate3", data[3]);
	}
	if (data[6]) {
		storage.setItem("PZRate6", data[6]);
	}
	if (data[12]) {
		storage.setItem("PZRate12", data[12]);
	}
	if (data[24]) {
		storage.setItem("PZRate24", data[24]);
	}
}

function addScrollEvent() {
	$(window).scroll(function() {
		var scrollTop = $(this).scrollTop();
		var documentHeight = $(document).height();
		var distance = documentHeight - (scrollTop + windowHeight);
		console.log(distance);
		if (distance <= 10) {
			if (!loadToEnd) {
				if (!isLoading) {
					addMore();
				}
			} else {
				$("#no_more")[0].style.display = "block";
			}
		}
	});
}
function dismissBottom() {
	$(".add-more")[0].style.display = "none";
	$("#no_more")[0].style.display = "none";
	$("#click_load")[0].style.display = "none";
}
/*function floatClick(){
	window.location.href = "new_year.jsp";
}*/

function showActiveLogo(){
	$.ajax({
		type : "POST",
		url : "normal/active/logo/show.do",
		data : {type:"image"},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					if (info.resultObject) {
						 var data = info.resultObject;
						 if(data.visible){
							 document.getElementById('float').setAttribute("src", data.imgSrc);
							 $("#float")[0].style.display = "block";
							 $("#float").click(function(){
								 window.location.href = data.url;
							 });
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