$(function(){
	var code = getRequestParam("code");
	var user = getRequestParam("user");
	if(isEmpty(code) && isEmpty(user)){
		//do nothing
	}else if(!isEmpty(code) && isEmpty(user)){
		getOpenId(code);
	}else if(!isEmpty(user)){
		visit();
	}
});

function getOpenId(code){
	$.ajax({
		type: "POST",
		url: "weixin/openid/get.do",
		data: {code: code},
		success: function(response) {
			if(response.success){
				result = response.result;
				result = JSON.parse(result);
				if(!isEmpty(result.openid) && !isEmptyStr(result.unionid)){
					window.location.href = "share.jsp?user=" + result.openid;
				}else{
					//window.location.href = "share.jsp";
					//errorMsg(result.errcode + ": " + result.errmsg);
				}
			}else{
				//window.location.href = "share.jsp";
			}
		},
		error: function(response){
			//window.location.href = "share.jsp";
		},
		dataType: "json"
	});
}

function visit(){
	var openid = getRequestParam("user");
	if(isEmpty(openid)){
		return;
	}
	$.ajax({
		type: "POST",
		url: "weixin/openid/visit.do",
		data:{openid : openid},
		success: function(response) {
			//TODO
		},
		dataType: "json"
	});
}