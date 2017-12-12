$(function() {
	iniCss3();
	getNotice();
});

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
					 dismissCss3();
					 if(data.length == 0){
						 $(".no-data")[0].style.display = "block";
					 }else{
						 addDataToContainer(data);
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

function addDataToContainer(data){
	var table = $("#notice_container");
	table[0].innerHTML = "";
	for(var i = 0;i<data.length;i++){
		var row = '';
		row += '<section class="notice_info" onclick="clickContent(\'notice_details.jsp?detailId='
			+ data[i].k + '\')">'
		row += '<dl><dt>';
		if(data[i].t){
			row += data[i].t;
		}
		row += '</dt><dd>';
			row += "&nbsp";
		row += '<span>';
		if(data[i].time){
			row += data[i].time;
		}
		row += '</span></dd></dl></section>';
		table.append(row);
	}
}
function clickContent(addr){
	window.location.href = addr;
}
function iniCss3() {
	$("#loading_anim")[0].style.display = "block";
}
function dismissCss3(){
	$("#loading_anim")[0].style.display = "none";
}

function showShare(){
	IOSModel.hideShareBtn();
}