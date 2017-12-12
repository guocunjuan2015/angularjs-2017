var project_id = '';
var status = "3-5";
var tab = '';
var index = '';
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
			status = "1";
			break;
		case 4:
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
	//优惠券，瑞钱币使用
	 if(data.morerateRate){
		 $("#useMoreRate")[0].innerHTML = "+"+ data.morerateRate+"%";
	 }
	 if(data.ticketAmount){
		 $("#useTicket")[0].innerHTML = data.ticketAmount;
	 }
	 if(data.redPacketAmount){
		 $("#useRedEvp")[0].innerHTML = data.redPacketAmount;
	 }
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
		}else if ("111" == data[i].projectType){
			row += '<div class="xs-icon">新</div>';
		}else{
			$("#pj_type").removeClass().addClass("zr-icon");
			$("#pj_type")[0].innerHTML = "转";
		}
	 if(data.isTransfer){
		 $("#group_btn")[0].style.display = "none";
	     $("#single_btn")[0].style.display = "none";
	 }else{
		 $("#group_btn")[0].style.display = "none";
	     $("#single_btn")[0].style.display = "block";
	 }
	 $("#pj_title")[0].innerHTML = data.projectName;
	 $("#total_invest")[0].innerHTML = data.totalInvestAmount +"元";
	 if("131" == data.projectType){
		 $("#epxt_rate")[0].innerHTML = data.lockupPeriodRate + "%";
	 }else{
		 $("#epxt_rate")[0].innerHTML = data.loanRate + "%";
	 }
	 $("#invest_income")[0].innerHTML = data.income + "元";
	 $("#fromEndTime")[0].innerHTML = data.fromEndTime;
	 $("#buyDate")[0].innerHTML = data.investTime;
	 $("#loanPeriod")[0].innerHTML = data.loanPeriod + data.unit;
	 cur = 100*parseFloat(data.investIncome);
	 max = 100*parseFloat(data.income);
	 $("#circle_val")[0].innerHTML = data.investIncome;
	 $("#income_text")[0].style.display = "";
	 iniProgressbar(max,cur);
}
function iniProgressbar(max,cur){
	var loanPercent=$("#inverstrate").val();
    if (loanPercent>0 && loanPercent<1) loanPercent=1;
    var radialObj4 = $('#inverstrate').radialIndicator({
        barWidth:16,
        barColor:'#7ecdfe',
        barBgColor:'#c3e7fd',
        fontColor:'#fff',//字体颜色，设置成白色,即隐藏
        fontFamily:'Hiragino Sans GB',
        fontSize:'1',
        format:'',
        minValue:0,
        maxValue:max,
        roundCorner : true,
        radius:86
        //percentage: false
    }).data('radialIndicator');

    radialObj4.animate(cur);
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

function toProject(){
	window.location.href = "project.jsp";
}

function transfer(){
	window.location.href = "personal_to_transfer.jsp?id="+project_id
			+"&tab="+tab+"&index="+index;
}