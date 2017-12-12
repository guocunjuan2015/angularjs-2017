$(function() {
	getMessageInfo();
});

function getMessageInfo(){
	$.ajax({
		type : "POST",
		url : "account/message/center/get.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
                    addDataToContainer(info.resultObject);
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
	var table = $("#message_container");
	table[0].innerHTML = "";
	for(var i=0;i<data.length;i++){
		var row = '';
		row += '<div class="msg_outter" onclick="message_detail.jsp?id="'+data[i].id+'>';
		row += '<div class="msg_time">';
		row += data[i].date;
		row += '</div>';
		row += '<div class="msg_content">';
		row += data[i].content;
		row += '</div></div>';
		table.append(row);
	}
}