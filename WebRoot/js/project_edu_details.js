$(function() {
	project_id = getRequestParam("id");
	project_type = getRequestParam("project_type");
	from = getRequestParam("from");
	getProjectDetails();
});

function initData() {
	if ("weixin" == from) {
		$("#add_invest_sec")[0].style.display = "block";
	}
	if("122" == project_type){
		$("#project_type")[0].innerHTML = "优计划项目介绍";
	}else {
		$("#project_type")[0].innerHTML = "散标项目介绍";
	}
}

function getProjectDetails(){
	$.ajax({
		type : "POST",
		url : "project/more/details/get.do",
		data : {id:getRequestParam("id")},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
                   initProjectInfo(info.resultObject);
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

function initProjectInfo(data){
	$("#project_name")[0].innerHTML = data.projectName;
}