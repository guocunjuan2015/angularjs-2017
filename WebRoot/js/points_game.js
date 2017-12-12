var isReal = false;
var isBind = false;
var isSign = false;

$(function() {
	getAccountData();
});

function getAccountData() {
	$.ajax({
		type : "POST",
		url : "points/task/detail/get.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					var data = info.resultObject;
					//$("#user-level")
					$("#cur_points")[0].innerHTML = data.point;
					$("#level_name")[0].innerHTML = data.vipLevelName;
					document.getElementById("level_img").setAttribute("src", "images/vip_level/v"+data.vipLevel+".png");
					if(data.isSign){
						setDisAbaled('daySignIn');
						$("#daySignIn")[0].value = "已签到";
					}else{
						setEnabaled('daySignIn');
					}
					if(data.isRealName){
						$("#open").removeClass("btn-circle-red").addClass("btn-circle-grey");
						$("#open").val("已开通");
						$("#open").attr("disabled",true);
					}else{
					}
					isReal = data.isRealName;
					isBind = data.isBindCard;
					isSign = data.isSign;
					if(isBind){
						setDisAbaled('to_reacharge');
						$("#to_reacharge")[0].value = "已绑卡";
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

function addDataToPage(data) {

}

function goToPage(index) {
	switch (index) {
	case 1:// 去联动开户
		IOSModel.openUmp();
		if(isAndroidOrIos()){
			appFunction('oepnUmp');
		}else{
			window.location.href = "ump_real_register.jsp";
		}
		break;
	case 2:// 首次绑卡
		// setDisAbaled('to_reacharge');
		IOSModel.toBindCard();
		if(isAndroidOrIos()){
			appFunction('bindCard');
		}else{
		toRechargeOrCash('ump_bind_card.jsp');
		}
		break;
	case 3:// 首次提现
		IOSModel.moneyCash();
		if(isAndroidOrIos()){
			appFunction('moneyCash');
		}else{
		toRechargeOrCash('ump_money_cash.jsp');
		}
		break;
	case 4:// 签到
		window.location.href = "shake_sign.jsp";
		break;
	case 5:// 去投资
		IOSModel.toIosInvest();
		if (isAndroidOrIos()) {
			appFunction('invest');
		} else {
			window.location.href = "project.jsp";
		}
		break;
	case 6:// 去分享
		if(isAndroidOrIos()){
			window.location.href = "share_redirect.jsp?from=app&user="+getRequestParam("user");
		}else{
			var sesseionStorage = window.sessionStorage;
			var user = sessionStorage.getItem("userHex");
			window.location.href = "share_redirect.jsp?from=weixin&user="+user;
		}
		break;
	case 7:// 去分享

		break;
	}
}
function setDisAbaled(id){
	$("#"+id).removeClass().addClass("btn-border-grey");
	$("#"+id).attr("disabled",true);
}
function setEnabaled(id){
	$("#"+id).removeClass().addClass("btn-border-red");
	$("#"+id).attr("disabled",false);
}
function openUmp(){
	window.location.href = "ump_real_register.jsp";
}
function umpBind(){
	window.location.href = "ump_bind_card.jsp";
}

function toRechargeOrCash(addr){
	if(!isReal){
		 //去开户
		 $("#msg_btn_1")[0].style.display = "none";
		 $("#msg_btn_0")[0].style.display = "block";
		 $('#myModal').on('shown.bs.modal', function() {
				$('#myInput').focus();
			});
			$('#myModal').modal('toggle');
			$('#myModal')[0].click();
	 }else{
		 if(!isBind){
			 //去绑卡
			 $("#msg_btn_0")[0].style.display = "none";
			 $("#msg_btn_1")[0].style.display = "block";
			 $('#myModal').on('shown.bs.modal', function() {
					$('#myInput').focus();
				});
				$('#myModal').modal('toggle');
				$('#myModal')[0].click();
		 }else{
			 window.location.href = addr;
		 }
	 }
}

function showShare(){
	IOSModel.showShare();
}