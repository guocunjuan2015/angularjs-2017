$(function() {
	init();
});

function init() {
	$("#vip_apply_body").css("height", document.body.scrollHeight);
    if("withdraw" == getRequestParam("opt")){
    	$("#callback_title")[0].innerHTML = "联动优势（提现）";
    	$("#ep_reg_suc_text")[0].innerHTML = "提现成功";
    }else if("recharge" == getRequestParam("opt")){
    	$("#callback_title")[0].innerHTML = "联动优势（充值）";
    	$("#ep_reg_suc_text")[0].innerHTML = "充值成功";
    }else if("bandCard" == getRequestParam("opt")){
    	$("#callback_title")[0].innerHTML = "联动优势（绑卡）";
    	$("#ep_reg_suc_text")[0].innerHTML = "绑卡成功";
    	
    	var tprm = "username=" + $("#userName").val();
        __ozfac2(tprm, "#bindCardsuccess");// 99-click，统计用户绑卡成功
    }else if("invest" == getRequestParam("opt")){
    	$("#callback_title")[0].innerHTML = "联动优势（投资）";
    	$("#ep_reg_suc_text")[0].innerHTML = "投资成功";
    	
    	var tprm = "username=" + $("#userName").val();
        __ozfac2(tprm, "#investsuccess");// 99-click，统计投资成功
    }else{
    	$("#callback_title")[0].style.display = "none";
    	$("#ep_reg_suc_text")[0].innerHTML = "恭喜您操作成功";
    }
}


function toMain(){
	IOSModel.toIosInvest();
    if(isAndroidOrIos()){
        toIosInvest();
        appFunction('invest');
    }else{
        toIosInvest();
        window.location.href = "project.jsp";
    }
}

function toPCenter(){
	IOSModel.toAccountCenter();
    if(isAndroidOrIos()){
        appFunction('toAccountCenter');
    }else{
	window.location.href = "personal_center.jsp";
    }
}

