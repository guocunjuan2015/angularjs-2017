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

$(function(){
	
	/*判断是安卓或者是IOS*/
    var browser = {
		versions : function() {
	    	var u = navigator.userAgent, app = navigator.appVersion;
	        return { //移动终端浏览器版本信息
	        	ios : !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
	        	android : u.indexOf('Android') > -1
	        	|| u.indexOf('Linux') > -1, //android终端或uc浏览器
	        	weixin : u.indexOf('MicroMessenger') > -1, //是否微信 （2015-01-22新增）
	        };
	    }(),
	    language : (navigator.browserLanguage || navigator.language).toLowerCase()
    }
	$('#downs').attr('href','http://a.app.qq.com/o/simple.jsp?pkgname=com.dyxd.rqt&g_f=991653');
    
	var basePath=$("#basePath").val();
	var localPath = $("#localPath").val();
	var userId = $("#userId").val();
	var userApp = $("#userApp").val();
	var moneytf = false;
	var flag = false;
	var m_mess = "请输入100的整数倍!";
	$('#money').blur(function() {
		mar();
	});
	function mar (){
		var val = $('#money').val();
		flag = false;
		if (integer("#money", msg,val)) {
			flag = true;
		}
		return flag;
	}
	function integer(id, message,ssn) {
		moneytf = false;
		var re = /^[1-9][0-9]*0{2}$/;       //校验是否为100的整数倍
		if(re.test(ssn) && ssn%100===0) {
			moneytf = true;
		}else {
			myErrorMsg("msg", m_mess);
		}
		return moneytf;
	}
	function myErrorMsg(msg_id, str) {
		$("#" + msg_id).text(str);
		$("#" + msg_id).show();
		var count = 2;
		var countdown = setInterval(CountDown, 1000);
		function CountDown() {
			if (count == 0) {
				$("#" + msg_id)[0].innerHTML = "&nbsp;";
				clearInterval(countdown);
			}
			count--;
		}
	}
	$("#submit_btn").click(function (){
		$(".loading").show();
		if((userId == '' || userId == 'null' || userId == undefined) && (userApp == "" || userApp == 'null' || userApp == undefined) ){
			$(".loading").hide();
			if (isAndroidOrIos()) {
				IOSModel.login();
				appFunction('login');
			} else { 
				window.location.href =basePath + "/login.jsp?active=mar";
			}
		}else if(!flag){
			$(".loading").hide();
			myErrorMsg("msg", m_mess);
			return;
		}else{
			$(".loading").hide();
			$.ajax({
				url:localPath + "/lotteryAward/warmMarch",
				data:{
					userId: userId,
					loginName :userApp,
		    	   	investAmount: $("#money").val(),
		    	   	period: $("#month").val()
		    	},
		    	dataType : "json",
		    	success:function(data){
		    		if(data.status == "003"){
		    			if(data.couponAmount > 0){
		    				$(".msgTxt p.p1").text('恭喜您获得'+data.couponAmount +'元红包和'+data.rate + '加息券');
		    			}else{
		    				$(".msgTxt p.p1").text('恭喜您获得'+data.rate + '加息券');
		    			}
		    			$(".msgTxt").show();
		        	   $(".loanDirlog").show();
		    		}else{
		    			$(".msgTxt2 p.p1").text(data.message);
		    			$(".msgTxt2").show();
		        	   $(".loanDirlog").show();
		    		}
		    	},
		    	error:function(data){
	    			$(".msgTxt2 p.p1").text(data.message);
	    			$(".msgTxt2").show();
	        	   $(".loanDirlog").show();
		    	}
			})
		}
	});
	$(".closeMsg").click(function (){
		$(".msgTxt").hide();
		$(".msgTxt2").hide();
		$(".loanDirlog").hide();
	});
	$("#goMyGift").click(function (){
		if (isAndroidOrIos()) {
			IOSModel.investFinishToMyGift();
			appFunction('investFinishToMyGift');
		} else { 
			window.location.href =basePath + "/sys/user/award/myGift.jsp?userId=" + userId;
		}
	})
	
});