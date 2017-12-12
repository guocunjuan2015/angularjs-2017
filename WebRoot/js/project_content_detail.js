var project_type = 0;
$(function() {
	var project_id = getRequestParam("id");
	project_type = getRequestParam("projectType");
	if (!isEmptyStr(project_id)) {
		getDetailData(project_id);
		$("#detail_1")[0].style.display = "block";
	}
});

function getDetailData(id) {
	$.ajax({
		type : "POST",
		url : "project/detail.do",
		data : {
			id : id
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					var transferInfo = info.resultObject;
					initTransferInfo(transferInfo);
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

function initTransferInfo(data) {
	if (project_type == 122) {
		$("#xqtb3_div")[0].style.display = "none";
		$("#xqtb1_div").removeClass("col-xs-3 tab1 tab-bod tabactive")
				.addClass("col-xs-4 tab1 tab-bod tabactive");
		$("#xqtb2_div").removeClass("col-xs-3 tab1 tab-bod").addClass(
				"col-xs-4 tab1 tab-bod");
		$("#xqtb3_div").removeClass("col-xs-3 tab1 tab-bod");
		$("#xqtb4_div").removeClass("col-xs-3 tab1 tab-bod").addClass(
				"col-xs-4 tab1 tab-bod");
		$("#xqtb1_div")[0].innerHTML = "优计划简介";
		$("#xqtb2_div")[0].innerHTML = "投资案例";
		$("#xq_tab_div")[0].style.display = "block";

		var content_1 = '<h4>产品简介</h4>';
		content_1 += '<p>' + data.m.projectDec + '</p>';
		content_1 += '<h4>产品特点</h4>';
		content_1 += '<p>' + data.m.moneyPurpose + '</p>';
		content_1 += '<h4>附加服务</h4>';
		content_1 += '<p>' + data.m.repaySource + '</p>';
		$("#detail_1").append(content_1);

		var content_2 = '<h4>投资案例</h4>';
		content_2 += '<p>' + data.n.enterpriseBack + '</p>';
		$("#detail_2").append(content_2);
	} else {
		$("#xq_tab_div")[0].style.display = "block";
		var content_1 = '<h4>项目描述</h4>';
		content_1 += '<p>' + data.m.projectDec + '</p>';
		content_1 += '<h4>资金用途</h4>';
		content_1 += '<p>' + data.m.moneyPurpose + '</p>';
		content_1 += '<h4>还款来源</h4>';
		content_1 += '<p>' + data.m.repaySource + '</p>';
		$("#detail_1").append(content_1);

		var content_2 = '<h4>企业背景</h4>';
		content_2 += '<p>' + data.n.enterpriseBack + '</p>';
		content_2 += '<h4>营业范围</h4>';
		content_2 += '<p>' + data.n.businessScope + '</p>';
		if(data.n.operatingConditions){
		content_2 += '<h4>经营状况</h4>';
		content_2 += '<p>' + data.n.operatingConditions + '</p>';
		}
		$("#detail_2").append(content_2);

		var content_3 = '';
		content_3 += '<h4>保障措施一</h4>';
		content_3 += '<p>' + data.x.保障措施一 + '</p>';
		content_3 += '<h4>保障措施二</h4>';
		content_3 += '<p>' + data.x.保障措施二 + '</p>';
		content_3 += '<h4>保障措施三</h4>';
		
		if(data.x.guarantee){
		content_3 += '<h5 class="guarantee-font">担保机构</h5>';
		content_3 += '<p>' + data.x.guarantee + '</p>';
		}
		if(data.x.guaranteeDesc){
		content_3 += '<h5 class="guarantee-font">担保机构简介</h5>';
		content_3 += '<p>' + data.x.guaranteeDesc + '</p>';
		}
		if(data.x.guaranteeComment){
		content_3 += '<h5 class="guarantee-font">担保机构意见</h5>';
		content_3 += '<p>' + data.x.guaranteeComment + '</p>';
		}
		if(data.x.mortgageInfo){
		content_3 += '<h5 class="guarantee-font">抵押物质信息</h5>';
		content_3 += '<p>' + data.x.mortgageInfo + '</p>';
		}
		if(data.x.lawsuitInfo){
		content_3 += '<h5 class="guarantee-font">涉诉信息</h5>';
		content_3 += '<p>' + data.x.lawsuitInfo + '</p>';
		}
		if(data.x.riskControlInfo){
		content_3 += '<h5 class="guarantee-font">风险控制措施</h5>';
		content_3 += '<p>' + data.x.riskControlInfo + '</p>';
		}
		$("#detail_3").append(content_3);
	}
	var invest_record = $("#detail_table_4");
	for (var i = 0; i < data.rs.length && i < 5; i++) {
		var row = '<tr><td class="">';
		row += '<h4 class="">' + data.rs[i].status + '</h4>';
		row += '<span class="text-muted">' + formatCurrency(data.rs[i].amount)
				+ '</span>元<br/>';
		row += '<span class="text-muted">' + data.rs[i].name + '</span><br/>';
		row += '<span class="text-muted" style="display:none">'
				+ data.rs[i].date + '</span>';
		row += '</td></tr>';
		invest_record.append(row);
	}
}

function changeType(tab, e) {
	tab = isEmpty(tab) ? 1 : tab;
	$("#detail_1")[0].style.display = "none";
	$("#detail_2")[0].style.display = "none";
	$("#detail_3")[0].style.display = "none";
	$("#detail_4")[0].style.display = "none";

	$("div.tabactive").removeClass("tabactive");
	e.classList.add("tabactive");

	$("#detail_" + tab)[0].style.display = "block";
}