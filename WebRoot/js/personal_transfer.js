$(function(){
	getTransferData();
	$("#transfer_1")[0].style.display = "block";
});

function getTransferData(){
	$.ajax({
		type: "POST",
		url: "account/transfer/get.do",
		data: {},
		success: function(response) {
			if(response.success){
				var info = $.parseJSON(response.result);
				if(info.result){
					var transferInfo = info.resultObject;
					initTransferInfo(transferInfo);
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

function initTransferInfo(data){
	var canTransfer = data.cantransferList;
	var transfering = data.transferingList;
	var transfered = data.transferedList;
	
	var canTransferTable = $("#transfer_table_1");
	var transferingTable = $("#transfer_table_2");
	var transferedTable = $("#transfer_table_3");
	
	canTransferTable[0].innerHTML = "";
	transferingTable[0].innerHTML = "";
	transferedTable[0].innerHTML = "";
	
	for(var i = 0; i < canTransfer.length; i++){
		var row = '<tr><td>';
		row += '<h4>' + canTransfer[i].projectName + '</h4>';
		row += '<span class="text-muted">本金：' + formatCurrency(canTransfer[i].principal) + '元</span><br/>';	
		row += '<span class="text-muted">利息：' + formatCurrency(canTransfer[i].interest) + '元</span><br/>';	
		row += '<span class="text-muted">预期年化收益：' + canTransfer[i].loanRate + '%</span><br/>';	
		row += '<span class="text-muted">到期时间：' + canTransfer[i].dueDate + '</span>';
		row += '</td></tr>';
		canTransferTable.append(row);
	}
	
	for(var i = 0; i < transfering.length; i++){
		var row = '<tr><td>';
		row += '<h4>' + transfering[i].projectName + '</h4>';
		row += '<span class="text-muted">债权金额：' + formatCurrency(transfering[i].loanAmount) + '元</span><br/>';	
		row += '<span class="text-muted">转让金额：' + formatCurrency(transfering[i].discountAmount) + '元</span><br/>';	
		row += '<span class="text-muted">转让进度：' + transfering[i].percent + '%</span><br/>';	
		row += '<span class="text-muted">转让时间：' + transfering[i].createDate + '</span>';
		row += '</td></tr>';
		transferingTable.append(row);
	}
	
	for(var i = 0; i < transfered.length; i++){
		var row = '<tr><td>';
		row += '<h4>' + transfered[i].projectName + '</h4>';
		row += '<span class="text-muted">债权金额：' + formatCurrency(transfered[i].loanAmount) + '元</span><br/>';	
		row += '<span class="text-muted">转让时间：' + transfered[i].createDate + '</span>';
		row += '<span class="text-muted"></span>';	
		row += '</td></tr>';
		transferedTable.append(row);
	}
}

function changeType(tab, e){
	tab = isEmpty(tab) ? 1 : tab;
	$("#transfer_1")[0].style.display = "none";
	$("#transfer_2")[0].style.display = "none";
	$("#transfer_3")[0].style.display = "none";
	
	$("div.tabactive").removeClass("tabactive");
	e.classList.add("tabactive");
	
	$("#transfer_" + tab)[0].style.display = "block";
}