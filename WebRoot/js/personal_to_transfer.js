var project_id = '';
var status = "3-5";
var tab = '';
var index = '';
var mFee = 0;
$(function(){
	iniData();
	var t = parseInt(getRequestParam("tab"));
	if(t == 2){
		getCanTransferData();
	}else{
    getInvestData();
	}
});
 
function iniData(){
	project_id = getRequestParam("id");
	tab = getRequestParam("tab");
	if(tab){
		tab = parseInt(tab);
		switch (tab) {
		case 1:
			status = "3-5";
			break;
		case 2:
			 
			break;
		case 3:
			status = "3-7";
			break;
		}
	}
	index = getRequestParam("index");
	if(index){
		index = parseInt(index);
	}else{
		index = -1;
	}
}
function getCanTransferData(){
	$.ajax({
		type : "POST",
		url : "account/transfer/cantransfer/get.do",
		data : {
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					var investInfo = info.resultObject;
					if (investInfo.length == 0) {
						$("#invest_table_" + tab)[0].innerHTML = "";
						$("#no_data_div")[0].style.display = "block";
						$("#space_div")[0].style.display = "block";
					} else {
						iniPage(investInfo[index]);
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
function iniPage(data){
	 
	 if("000" == data.projectType || "101" == data.projectType
				|| "102" == data.projectType || "103" == data.projectType 
				|| "103" == data.projectType){
		     $("#pj_type").removeClass().addClass("db-icon");
			 $("#pj_type")[0].innerHTML = "担";
		}else if("108" == data.projectType){
			$("#pj_type").removeClass().addClass("zc-icon");
			$("#pj_type")[0].innerHTML = "资";
		}else if("122" == data.projectType){
			$("#pj_type").removeClass().addClass("blue-icon");
			$("#pj_type")[0].innerHTML = "优";
		}else{
			$("#pj_type").removeClass().addClass("zr-icon");
			$("#pj_type")[0].innerHTML = "转";
		}
	  

    $("#pj_title")[0].innerHTML = data.projectName;// 项目名称
	$("#pj_account")[0].innerHTML = data.totalInvestAmount+"元";// 转让金额
	$("#pj_rate")[0].innerHTML = data.loanRate+"%";// 预期年化收益
	$("#pj_period")[0].innerHTML = data.loanPeriod+"个月";// 期限
	$("#pj_endDate")[0].innerHTML = data.overTime;// 到期日期
	$("#pj_income")[0].innerHTML = data.investIncome+"元";// 已得收益
	mFee = parseFloat(data.manageFee);
	 
}

function changeTransfer(value){
	$("#pj_tips")[0].innerHTML = value*mFee;// 手续费
	$("#pj_money")[0].innerHTML = value;
}
 
function getInvestData() {
	 
	$.ajax({
		type : "POST",
		url : "account/invest/get.do",
		data : {
			t : "",
			s : status,
			c : ""
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

function toTransferIllus(){
	window.location.href = "transfer_illus.jsp";
}