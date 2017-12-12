var p1 = false;
var p2 = false;
var p3 = false;
var p4 = false;
var channel = "";
var utm_source="";
$(function() {
	$("#space_div").css("height", $("#footpanel").height());
	iniLunBo();
	//showActiveLogo();
	//getWapData();
	//getProjectInfo();
	initChannel();//保存渠道

});  

function iniLunBo() {
	// 初始化轮播
	$("#myCarousel").carousel(0);
	$("#myCarousel").carousel('cycle');
}

function initChannel() {
	if (getRequestParam("channel")) {
		channel = getRequestParam("channel");
	}
	if (getRequestParam("utm_source")) {
		utm_source = getRequestParam("utm_source");
	}
	if(utm_source!=null && utm_source!=""){
		channel = utm_source;
	}
	
	window.sessionStorage.setItem("channel", channel);
}
function toNext(){
	$("#myCarousel").carousel('next');
}
function toPrev(){
	$("#myCarousel").carousel('prev');
}


/*function getProjectInfo() {
	$
			.ajax({
				type : "POST",
				url : "project/newget.do",
				data : {
					type : 2,
					childType : "",
					status : "",
					order : "",
					orderType : "",
					index : "",
					size : 3,
					from : "",
				},
				success : function(response) {
					if (response.success) {
						var info = $.parseJSON(response.result);
						if (info.result) {
							var projects = info.resultObject.list == undefined ? info.resultObject
									: info.resultObject.list;
							var container = $("#row_container");
							container[0].innerHTML = "";
							if (projects.length == 0) {
								$("#div_no_projects").css("display", "block");
							} else {
								for (var i = 0; i < projects.length; i++) {
									if(projects[i].isNeedContribution){
										continue;
									}
									container.append(initRow(projects[i]));
								}
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
	var row = '';
	var current_time = new Date();
	var start_time = new Date(data.projectStartDate);

		row += '<section class="yjh-details" onclick="clickContent(\'';
		row += data.projectID;
		if(data.isTransferProject){
			row += '\','+data.isTransferProject+')">';
		}else{
			row += '\','+false+')">';
		}
		row += '<div class="yjh-title">';
 
	 
	var st = parseInt(data.status);
	if (st == 2) {
		if (data.isTransferProject) {
			row += '<div class="zr-icon">' + "转" + '</div>';
		} else if (data.isNeedContribution) {
			row += '<div class="zr-icon">' + "约" + '</div>';
		} else if ("122" == data.projectType) {
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
		}  else if (data.isNeedContribution) {
			row += '<div class="zr-icon bg-grey">' + "约" + '</div>';
		}else if ("122" == data.projectType) {
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
	if (st == 2) {
		row += '<strong class="qxmoney">';
	} else {
		row += '<strong class="qxmoney font-grey">';
	}
	if("131" == data.projectType){
		row += data.lockupPeriodRate;
	}else{row += roundToTenth(data.loanRate_split);}
	if(st == 2){
		row += '</strong><span class="qxspan">'
			+ "%";
	}else{
		row += '</strong><span class="qxspan_grey">'
			+ "%";
	}
	if (parseFloat(data.award) > 0) {
		row += '&nbsp;+&nbsp;' + '</span>';
		if (st == 2) {
			row += '<strong class="qxmoney">';
			row += roundToTenth(data.award) + '</strong><span class="qxspan">'
			+ "%";
			row += '</span><i class="nlv-active">';
		} else {
			row += '<strong class="qxmoney font-grey">';
			row += roundToTenth(data.award) + '</strong><span class="qxspan_grey">'
			+ "%";
			row += '</span><i class="nvl-active-grey">';
		}
		row += data.bid_award_source + '</i>';
	} else {
		row += '</span>';
	}
	row += '</span>' + '<span class="nlv-qt-color">' + "预期年化收益" + '</span>'
			+ '</div>' + '<div class="nlvdiv" style="margin-left:7%;">'
			+ '<span>';
	if (st == 2) {// 投资期限
		row += '<strong class="loan_period">';
	} else {
		row += '<strong class="loan_period font-grey">';
	}
	row += data.loanPeriod + '</strong><span class="qxspan_grey">';
	row += data.unit;//期限单位	
	row += '</span></span>' + '<span class="nlv-qt-color">' + "期限"
			+ '</span>' + '</div>';
	switch (st) {
	case 2:
		row += '<div class="nlv-btn-Add">' + "抢" + '</div>';
		break;
	case 9:
		row += '<div class="nlv-btn-Add font-grey border-grey font-size-4">'
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
			row += '</div>' + '</div>' + '<div class="qtmoney">'
			+  "&nbsp";
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
			if(storage.getItem("PZRate3")){
				row += "配资" +parseFloat(storage.getItem("PZRate3")*100) +"%";
			} 
		}else if (period == 6) {
			if(storage.getItem("PZRate6")){
				row += "配资" +parseFloat(storage.getItem("PZRate6")*100) +"%";
			} 
		}else if (period == 12) {
			if(storage.getItem("PZRate12")){
				row += "配资" +parseFloat(storage.getItem("PZRate12")*100) +"%";
			} 
		} else if (period == 24) {
			if(storage.getItem("PZRate24")){
				row += "配资" +parseFloat(storage.getItem("PZRate24")*100) +"%";
			} 
		}
		row += '</em>';
	}
	if (data.isTransferProject) {
		if (data.discountAmount) {
			row += '<span class="yjh-title-two font-smaller">' + data.discountAmount
					+ '元折让金' + '</span>';
		}
	} else if (st == 2) {
		row += '<span class="yjh-title-two">' + "还剩 "
				+ formatIntCurrency(parseInt(data.projectBalance)) + "元"
				+ '</span>';
	} 
	row += '</div>' + '</section>';
	return row;
}

function clickContent(id,isTransfer) {
	window.location.href = "project_other_content.jsp?id="+id+"&isTransfer="+isTransfer;
}

function getWapData() {
	$.ajax({
		type : "POST",
		url : "project/wap/data/get.do",
		data : {
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					 $("#banlance_totle")[0].innerHTML = info.resultObject.turnover+"元";
					 $("#user_totle")[0].innerHTML = info.resultObject.interest+"元";
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

function clickIntro(id){
	$(".intro").css("display","none");
	if('block' == document.getElementById(id)
			.getAttribute("display")){
		$("#"+id)[0].style.display = "none";
	}else{
		$("#"+id)[0].style.display = "block";
	}
	
}
$(".invest-reason").mouseleave(function(){ 
    var index=$(".invest-reason li ").index(this); 
    $(".intro").css("display","none"); 
});

function hideRegBanner(){
	$("#space_div")[0].style.display = "none";
	$("#footpanel")[0].style.display = "none";
}
function floatClick(){
	window.location.href = "new_year.jsp";
}

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
							 $("#float")[0].style.display = "block";
							 document.getElementById('float').setAttribute("src", data.imgSrc);
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
*/


