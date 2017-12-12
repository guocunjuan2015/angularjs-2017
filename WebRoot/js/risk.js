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
$(function (){
	$(".topic").hide();
	$(".topic").eq(0).show();
});
var basePath=$("#basePath").val();
var localPath = $("#localPath").val();
var userId = $("#userId").val();
var userApp = $("#userApp").val();
//上一题
$("#preva").click(function (){
	var $index = $(".riskNum span").html();
	var spanVal = $(".riskNum span").html();
	if( spanVal > 1 ){
		$("#preva").css('display','inline-block');
		$(".topic").hide();
		$(".topic").eq($index-2).show();
		spanVal--;
		$(".riskNum span").html(spanVal);
		$(".riskPro_on").css("width",spanVal*10+"%");
	};
	if(spanVal == 1){
		$("#preva").hide();
	}
	
})

var gulp = false;
var mark =0;
var isChecked = function (){
	gulp = false;
	$(".reward").each(function (index, obj) {
    	var i = index+1;
		var radioVal = $(obj).find(".checkinp input").val();
        if(typeof(radioVal) == 'undefined'){
        	gulp = true;
        }
    });
};
var markfun = function (){
	$(".reward").each(function(index,obj){ 
		var i = index+1;
    	var r = /^-?\d+$/;//正整数
    	var radioVal = $(obj).find(".checkinp input");
    	if(radioVal.val() !=''&&!r.test(radioVal.val())){ 
    		radioVal.val("");  //正则表达式不匹配置空 
      	}else if(radioVal.val() !=''){ 
      		mark+=parseInt(radioVal.val()); 
      	} 
      	$("#markInp").val(mark); 
   	}); 
}
	$("#submita").click(function (){
		if((userId == '' || userId == 'null' || userId == undefined) && (userApp == "" || userApp == 'null' || userApp == undefined) ){
			if (isAndroidOrIos()) {
				IOSModel.login();
				appFunction('login');
			} else { 
				window.location.href =basePath + "/login.jsp";
			}
		}else{
			isChecked();
			if(gulp){
				$(".helpmsg").html("问题还未回答，请回答完问题再申请提交");
			}else{
				markfun();
				mark = $("#markInp").val();
				$.ajax({
					url:localPath +"/member/riskAssessment",
					type : 'post',
					dataType : 'json',
					data:{
						userId: userId,
						loginName :userApp,
			    	   	score: mark
			    	},
			    	success:function(data){
			    		if(data.status == "003"){
			    			if(eval(mark) <= eval(18)){
								$(".evaluationp1").addClass('bsx');
								$(".evaluationp1").html('保守型');
								$(".evaluationp2 span").html('风险提示：您的投资风险偏好属于保守型，保住本金是您的目标，适合极低风险产品。');
							}else if(eval(mark) >= eval(19) && eval(mark) <= eval(28)){
								$(".evaluationp1").addClass('wjx');
								$(".evaluationp1").html('稳健型');
								$(".evaluationp2 span").html('风险提示：您的投资风险偏好属于稳健型，可以选择低、中等风险产品进行投资。');
							}else{
								$(".evaluationp1").addClass('jjx');
								$(".evaluationp1").html('积极型');
								$(".evaluationp2 span").html('风险提示：您的投资风险偏好属于积极型，可让P2P产品作为你资产配置的一部分。');
							}
							$(".topicStyle").hide();
							$(".closeImg").hide();
							$(".evaluationEnd").show();
			    		}else{
			    			$(".helpmsg").html(data.message);
			    		}
			    	},
			    	error:function(data){
			    		$(".helpmsg").html(data.message);
			    	}
				});
			}
			
		}
	});
	//选择
	$('.checkp').click(function(){
		$(".helpmsg").html("");
		var inp = $(this).find("input");
		var spanVal = $(".riskNum span").html();
		var $parent = $(this).parents(".topic");
		if(!$(this).is('.checkinp')){
			$(this).siblings().removeClass("checkinp");
			$(this).siblings().find("input").attr('checked', false);
			$(this).addClass("checkinp");
	    	$(this).find("input").attr('checked', 'checked');
		};
		setTimeout(function (){
			if( spanVal < 10 ){
				$("#preva").css('display','inline-block');
				$parent.hide();
				$parent.next().show();
				spanVal++;
				$(".riskNum span").html(spanVal);
				$(".riskPro_on").css("width",spanVal*10+"%");
			}else if (spanVal == 10){
				$("#submita").css('display','inline-block');
			}
		},300);
	});
	//关闭
	$(".closep").click(function (){
		$(".evaluation").hide();
		$(".loanDirlog").hide();
		$('.checkp').removeClass("checkinp");
		mark =0;
	});
	$(".closeMsg").click(function (){
		$(".msgTxt2").hide();
		$(".loanDirlog").hide();
	});
	$("#again").click(function (){
		window.location.reload();//刷新当前页面.
	});
	$("#goProject").click(function (){
		var url = getRequestParam("reflect_url");
		var projectType = getRequestParam("projectType");
		if (isAndroidOrIos()) {
			IOSModel.riskAssessmentToContinueInvest();
			appFunction('riskAssessmentToContinueInvest');
		} else {
			if(url == null){
				window.location.href=basePath +'/project.jsp';
			}else{
				window.location.href = decodeURIComponent(url + '&projectType=' + projectType);
			}
		}
	})