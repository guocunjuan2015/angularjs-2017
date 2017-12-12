$(function(){
	getResult();
});


function getResult(){
	$.ajax({
		type: "POST",
		url: "weixin/result/get.do",
		data: {},
		success: function(response) {
			if(response.success){
				initResult(response.result);
			}else{
				errorMsg(response.msg);
			}
		},
		dataType: "json"
	});
}

function initResult(data){
	var top = $("#top_n")[0].value;
	if(isEmpty(top) || top < 1){
		top = 10;
		$("#top_n")[0].value = 10;
	}
	var table = $("#result_table");
	var j = 0;
	for(var i = 0; i < data.length && j < top; i++){
		if(isEmptyStr(data[i].name)){
			continue;
		}
		var content = "<tr>";
		content += "<td hidden='hidden'><span>" + data[i].openid + "</span></td>";
		content += "<td><span>" + data[i].name + "</span></td>";
		content += "<td><span>" + dateFormat(data[i].date) + "</span></td>";
		content += "<td><span>" + data[i].count + "</span></td>";
		content += "</tr>";
		table.append(content);
		j++;
	}
}

function dateFormat(date){
	var d = new Date(date.time);
	var month = formatNumber(d.getMonth() + 1);
	var day = formatNumber(d.getDate());
	var hour = formatNumber(d.getHours());
	var minute = formatNumber(d.getMinutes());
	var second = formatNumber(d.getSeconds());
	
	return month + "月" + day + "日" + "<br/>" + hour + ":" + minute + ":" + second;
}

function formatNumber(num){
	if(num < 10){
		return "0" + num;
	}else{
		return num;
	}
}

function refresh(){
	$("#result_table")[0].innerHTML = "";
	getResult();
}