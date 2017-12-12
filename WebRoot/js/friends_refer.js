$(function() {
	getReferInfo();
});

function toRecommand(){
	window.location.href = "friends_refer_detail.jsp";
}

/**获取推荐获得奖励信息*/
function getReferInfo(){
	$.ajax({
		type : "POST",
		url : "account/refer/reward/get.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					$("#points_get")[0].innerHTML = info.resultObject.point;
					$("#coupon_get")[0].innerHTML = info.resultObject.coupon;
					$("#reward_get")[0].innerHTML = info.resultObject.returnMoney;

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

function toFriendsRule(){
	window.location.href = "friends_rule.jsp";
}