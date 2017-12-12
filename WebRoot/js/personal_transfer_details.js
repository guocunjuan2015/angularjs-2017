var project_id = '';
var status = "end";
var index = '';
var mFee = 0;
$(function(){
	iniData();
    getInvestData();
});


 
function iniData(){
	project_id = getRequestParam("id");
	getTransferInfo(project_id);
	index = getRequestParam("index");
	if(index){
		index = parseInt(index);
	}else{
		index = -1;
	}
}

function iniPage(data) {
	if (data.isTransferProject) {
		$("#pj_type").removeClass().addClass("purple-icon");
		$("#pj_type")[0].innerHTML = "转";
	} else if ("000" == data.projectType || "101" == data.projectType
			|| "102" == data.projectType || "103" == data.projectType
			|| "103" == data.projectType) {
		$("#pj_type").removeClass().addClass("db-icon");
		$("#pj_type")[0].innerHTML = "担";
	} else if ("108" == data.projectType) {
		$("#pj_type").removeClass().addClass("zc-icon");
		$("#pj_type")[0].innerHTML = "资";
	} else if ("122" == data.projectType) {
		$("#pj_type").removeClass().addClass("blue-icon");
		$("#pj_type")[0].innerHTML = "优";
	}else if ("111" == data[i].projectType){
		row += '<div class="xs-icon">新</div>';
	} else {
		$("#pj_type").removeClass().addClass("zr-icon");
		$("#pj_type")[0].innerHTML = "转";
	}

	$("#pj_title")[0].innerHTML = data.projectName;// 项目名称
	$("#pj_account")[0].innerHTML = data.transferAmount + "元";// 转让金额
	// $("#pj_rate")[0].innerHTML = data.loanRate+"%";// 预期年化收益
	$("#pj_endDate")[0].innerHTML = data.overTime;// 到期日期
	$("#pj_start_time")[0].innerHTML = data.startTime;// 已得收益
	$("#pj_money")[0].innerHTML = data.transferAmount;
	mFee = parseFloat(data.manageFee);

}

function changeTransfer(value){
	$("#pj_tips")[0].innerHTML = value*mFee;// 手续费
	$("#pj_money")[0].innerHTML = value;
}
 
function getInvestData() {
	$.ajax({
		type : "POST",
		url : "account/transfer/invest/get.do",
		data : {
			status : status,
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					var investInfo = info.resultObject;
					if (investInfo.length == 0) {
						$("#no_data_div")[0].style.display="block";
					} else {
						if(index>=0){
							iniPage(investInfo[index]);
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
 
function check(){
	var money = $("#money")[0].value;
	if (!checkStr(money, regexes.float)) {
		errorMsg("请正确填写转让金额");
		return false;
	}
	return true;
}

function realTransfer(){
	if(check()){
		$.ajax({
			type : "POST",
			url : "account/project/transfer.do",
			data : {
				loanId : getRequestParam("id"),
				loanAmount : $("#money").val() ,
				discountAmount : $("#discount").val(),
				description : $("#illus").val()
			},
			success : function(response) {
				if (response.success) {
					var info = $.parseJSON(response.result);
					if (info.result) {
						 
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

function getTransferInfo(id) {
	if (isEmptyStr(id)) {
		return;
	}
	$.ajax({
		type : "POST",
		url : "project/transfer/find.do",
		data : {
			id : id
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					var content = info.resultObject;
					initProjectInfo(content);
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

function initProjectInfo(data){
	$("#pj_discount")[0].innerHTML = data.discountAmount+"元";
	$("#pj_period")[0].innerHTML = data.loanPeriod+"天";// 期限
	$("#pj_rate")[0].innerHTML = data.loanRate+"%";// 预期年化收益
	$("#pj_amount")[0].innerHTML = data.investCount+"人";//认购人数
	if(data.remark){
		$("#pj_transfer_illus")[0].innerHTML = data.remark;
	}
	$("#pj_tips")[0].innerHTML = data.transferFee;
}

function toBuyRecord(){
	if(getRequestParam("id")){
		window.location.href = "transfer_buy_record.jsp?id="+getRequestParam("id");
	}
}