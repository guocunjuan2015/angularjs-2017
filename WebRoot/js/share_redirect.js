$(function() {
	var from = getRequestParam("from");
	if("weixin" == from || "pc" == from){
		$("#app_share")[0].style.display = "none";
		$("#wx_share")[0].style.display = "block";
	}else if(isAndroidOrIos()){
		$("#app_share")[0].style.display = "block";
		$("#wx_share")[0].style.display = "none";
	}else{
		$("#app_share")[0].style.display = "block";
		$("#wx_share")[0].style.display = "none";
	}
});

