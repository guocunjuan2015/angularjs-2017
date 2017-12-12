 
var curTab = 1;
var curDate = "";
var arr = new Array();
$(function() {
	iniCss3();
	getCardData();
	//$("#invest_1")[0].style.display = "block";
});
 
function getCardData(){
	$.ajax({
		type : "POST",
		url : "account/repayment/plan/cardlist/get.do",
		data : {
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					var cardList = info.resultObject;
					if (cardList.length == 0) {
						dismissCss3();
						$("#cardList")[0].style.display = "none";
						$("#no_data_div")[0].style.display = "block";
					} else {
						initCardList(cardList);
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
function initCardList(data){
	var table = $("#box");
	table[0].innerHTML = "";
	for(var i = 0;i<data.length;i++){
		var row = '';
		if(i == 0){
			row += '<li><div class="box active" id="tab'+i+'" onclick="changeTab('+i+')">';
		}else{
			row += '<li><div class="box" id="tab'+i+'" onclick="changeTab('+i+')">';
		}
		arr[i] = data[i].due_date;
		row += '<h5>'+data[i].due_date+'</h5>';
		row += '<img src="images/card_bg.png" />';
		row += '<table>'
		row += ' <tr><td>回款总额(元)</td><td>回款笔数</td></tr><tr><td>';
		row += data[i].amount;
		row += '</td><td>';
		row += data[i].count;
		row += '</td></tr></table></div></li>';
		table.append(row);
	}
	setTabWidth();
	getListData(arr);
}
function getListData(array){
	var table = $("#listContainer");
	table[0].innerHTML = "";
	for(var i = 0;i<array.length;i++){
		$.ajax({
			type : "POST",
			url : "account/repayment/plan/listdetails/get.do",
			data : {
				paymentDate : array[i]
			},
			async : false,
			success : function(response) {
				if (response.success) {
					var info = $.parseJSON(response.result);
					if (info.result) {
						var listDetails = info.resultObject;
							table.append(initList(listDetails,i));
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

function initList(data,index) {
	dismissCss3();
		var row = '';
		if(index == 0){
			row += '<div class="licai-box mt10" id="invest_'+index+'">';
		}else{
			row += '<div class="licai-box mt10" id="invest_'+index+'" style="display: none">';
		}
		
		row += '<table class="table">';
		row += '<tbody>';
		if(data.length == 0){
			row += '<div id=  style="display: none;margin:0 2% 2% 2%;text-align: center';
			 row +='   background: #fff;height: 45px;line-height: 45px;-moz-border-radius: 5px';
		    row += '-webkit-border-radius: 5px';
		    row += 'border-radius: 5px;  ">没有记录 !</div>';
		}else{
		for(var i = 0;i<data.length;i++){
		row += '<section class="touzi-details mg2" ';
		/*row += 'onclick="clickContent(\'';
		row += data[i].loan_id;
		row += '\',' + index + ',' + index + ')"';*/
		if (i == data.length - 1) {
			row += 'style="border-bottom:none;"';
		}
		row += '>';
		row += '<div class="touzi-title">';
		if(data[i].isTransferProject){
			row += '<div class="purple-icon">转</div>';
		}else if ("000" == data[i].project_type || "101" == data[i].project_type
				|| "102" == data[i].project_type || "103" == data[i].project_type
				|| "103" == data[i].project_type) {
			row += '<div class="db-icon">担</div>';
		} else if ("108" == data[i].project_type) {
			row += '<div class="zc-icon">资</div>';
		} else if ("122" == data[i].project_type) {
			row += '<div class="blue-icon">优</div>';
		} else if ("131" == data[i].project_type){
			row += '<div class="bg-icon">并</div>';
		}else if ("111" == data[i].project_type){
			row += '<div class="xs-icon">新</div>';
		}
		row += '<div class="orange-icon">' + "A" + '</div>';
		row += '<span class="touzi-title-one">'
				+ data[i].project_name.substr(0, 10) + ".." + '</span>';
		  
			row += '<span class="touzi-title-two">' + data[i].invest_total
					+ '元</span>';
		 
		row += '</div>';
		row += '<div class="nlv-info">';
		row += '<div class="nlvdiv">';
		 
			row += '<span class="nlv-qt-color">下次回款金额 : ';
			if("131" == data[i].project_type){
				row += formatCurrency(data[i].payment_amount);
			}else{
				row += formatCurrency(data[i].payment_amount);
			}
			row	+= '元</span>';
			var investTime = "";
			if (data[i].invest_date) {
				investTime = data[i].invest_date.split(" ")[0];
			}
			row += '<span  class="nlv-qt-color">投资日期：' + investTime + '</span>';
		 
		row += '</div>';
		row += '<div class="nlvsy">';
			row += '<span class="nlv-qt-color">下次回款：' + data[i].due_date.split(" ")[0]
					+'</span>';
			row += '<span  class="nlv-qt-color">到期日:' + data[i].over_date.split(" ")[0]
					+ '</span>';
		row += '</div>';
		row += '</div>';
		row += '</section>';
		}}
		row += '</tbody>';
		row += '</table></div>';
		return row;
}

 
function iniCss3() {
	$("#loading_anim")[0].style.display = "block";
}
function dismissCss3() {
	$("#loading_anim")[0].style.display = "none";
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
		window.location.href = "project_other_content.jsp?id=" + id;
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
function changeTab(index){
	for(var i = 0;i<arr.length;i++){
		$("#invest_"+i)[0].style.display = "none";
		$("#tab"+i).removeClass("active");
	}
	$("#tab"+index).addClass("active");
	$("#invest_"+index)[0].style.display = "block";
	//$("#invest_"+index).show("200");
}