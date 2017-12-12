//页面定义html字体大小
(function (doc,win) {
	var docEl = doc.documentElement,
        resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
    recalc = function (){
        var clientWidth = docEl.clientWidth;
        if (!clientWidth) {return ;}
    	docEl.style.fontSize = 10 * (clientWidth / 375) +"px";
    };
    if(!doc.addEventListener) return;
    win.addEventListener(resizeEvt,recalc,false);
    doc.addEventListener('DOMContentLoaded',recalc,false);
})(document,window);
var mLevel = -1;
$(function(){
	getLevelData();
});
function getLevelData() {
	$.ajax({
		type : "POST",
		url : "points/task/detail/get.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					var data = info.resultObject;
					$("#level_progress")[0].innerHTML = data.point+"/"+data.nextLevelPoints;
					$("#points_of_month")[0].innerHTML = data.pointsOfMonth;
					mLevel = data.vipLevel;
					initData(mLevel);
					iniAward(mLevel);
					initAddAward(mLevel);
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

function initData(level){
	$(".progress-perc").css("width", (100/14)*(2*(level)-1) + "%");
	document.getElementById("level_img").setAttribute("src", "images/vip_level/level"+level+".png");
	$("#hotline")[0].style.display = "block";
	$("#message")[0].style.display = "block";
	switch (level) {
	case 3:
	case 4:
	case 5:
		$("#senior")[0].style.display = "block";
		break;
	case 6:
		$("#senior")[0].style.display = "block";
		$("#invest")[0].style.display = "block";
		break;
	case 7:
		$("#senior")[0].style.display = "block";
		$("#invest")[0].style.display = "block";
		$("#onetoone")[0].style.display = "block";
		$("#lend")[0].style.display = "block";
		$("#repay")[0].style.display = "block";
		break;
	case 8:
		$("#senior")[0].style.display = "block";
		$("#invest")[0].style.display = "block";
		$("#onetoone")[0].style.display = "block";
		$("#lend")[0].style.display = "block";
		$("#repay")[0].style.display = "block";
		break;
	}
}

function iniAward(level){
	switch (level) {
	case 1:
		//$("#month_award")[0].innerHTML = 0;
		$("#birth_award")[0].innerHTML = 10;
		break;
	case 2:
		//$("#month_award")[0].innerHTML = 5;
		$("#birth_award")[0].innerHTML = 10;
		break;
	case 3:
		//$("#month_award")[0].innerHTML = 8;
		$("#birth_award")[0].innerHTML = 50;
		break;
	case 4:
		//$("#month_award")[0].innerHTML = 10;
		$("#birth_award")[0].innerHTML = 100;
		break;
	case 5:
		//$("#month_award")[0].innerHTML = 30;
		$("#birth_award")[0].innerHTML = 200;
		break;
	case 6:
		//$("#month_award")[0].innerHTML = 100;
		$("#birth_award")[0].innerHTML = 400;
		break;
	case 7:
		//$("#month_award")[0].innerHTML = 200;
		$("#birth_award")[0].innerHTML = 500;
		break;
	case 8:
		//$("#month_award")[0].innerHTML = 6000;
		$("#birth_award")[0].innerHTML = 1000;
		break;
	}
}
function initAddAward(level) {//增值服务
	if(level>4){
		$("#vip"+level)[0].style.display = "block";
	}else{
		$("#vip1_4")[0].style.display = "block";
	}
}
function toStrategy(){
	window.location.href = "member_strategy.jsp";
}