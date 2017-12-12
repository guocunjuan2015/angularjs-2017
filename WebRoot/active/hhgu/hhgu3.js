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
//	if (browser.versions.android == true) {
//    	$('#downs').attr('href','http://file.rqbao.com/android/latest/ruiqianbao_ditui_red.apk');
//	}
//	if (browser.versions.ios == true) {
		$('#downs').attr('href','http://a.app.qq.com/o/simple.jsp?pkgname=com.dyxd.rqt&g_f=991653');
//	}else{
//      $("#downs").attr('href','http://file.rqbao.com/android/latest/ruiqianbao_ditui_red.apk');
//    };
  
	
    //注册验证
    var basePath=$("#basePath").val();
	var localPath = $("#localPath").val();
	$("#getc").on("touchend", function() {
		/*手机号验证不能为空*/
		if($("#m").val()==""|| $("#m").val()==null){
			$("#prompt_txt").text("手机号不能为空！");
			
			return;   
		}
		if (checkM("m")) {
			//$("#prompt_txt").text("");
			$.ajax({
				url : localPath + "/offLineActivity/CPAndSendSMS",
				type : "POST",
				async : false,
				data : {
					mobile: $("#m").val()
				},
				dataType : "json",
				success : function(data) {
		        	if (data.success) {
		        		$("#getc").attr("disabled", true);
		        		var count = 60;
		    			function CountDown() {
		    				$("#getc").val(count + "s");
		    				$("#getc").css("opacity","1");
		    				if (count == 0) {
		    					$("#getc").val("重新发送").removeAttr("disabled");
		    					clearInterval(countdown);
		    				}
		    				count--;
		    			}
		    			var countdown = setInterval(CountDown, 1000);
		    			$("#prompt_txt").text(data.msg);
		        	} else {
		        		$("#prompt_txt").text(data.msg);
		        		if(data.msg=="提示:抱歉此次活动仅新注册用户参加!"){
		        			$("#prompt_txt").text("该用户已注册");
		        		}else{
		        			$("#prompt_txt").text(data.msg);
		        		}
		        	}
				},
				error : function (data) {
					alert("服务器错误，请联系管理员！");
				}
			});

		} else {
			$("#prompt_txt").text("请输入格式正确的手机号!");
		}
	});
	/*******************************************************************************
	 * --------------------------------验证相关-------------------------------------------*
	 ******************************************************************************/

	var m_mess = "请输入正确的手机号!";
	// 输入长度校验公共函数
	function checkLength(prompt_txt, id, s_l, e_l, message) {
		var flag = false;
		if ($("#" + id).val().length >= s_l && $("#" + id).val().length <= e_l
				&& $("#" + id).val() != '') {
			flag = true;
		} else {
			myErrorMsg(prompt_txt, message);
		}
		return flag;
	}
	
	// 验证手机号
	function checkM(m_id) {
		return checkMpub(m_id, m_mess);
	}

	
	function checkMpub(id, message) {
		var flag = false;
		// 手机号正则
		if ($("#" + id).val().search(/^0?(13[0-9]|15[0-9]|18[0-9]|14[0-9]|17[0-9])[0-9]{8}$/) == -1) {
			myErrorMsg("prompt_txt", m_mess);
		} else {
			flag = true;
		}
		return flag; 
	};
	/**
	 * 提示方法
	 * 
	 * @param str
	 *            提示内容
	 */
	function myErrorMsg(msg_id, str) {
		$("#" + msg_id).text(str);
		$("#" + msg_id).show();

		var count = 5;
		var countdown = setInterval(CountDown, 1000);
		function CountDown() {
			if (count == 0) {
				$("#" + msg_id).hide();
				clearInterval(countdown);
			}
			count--;
		}
	}
	$(".checkbtn").on("touchend", function(){
    	/*手机号码验证是否为空*/
    	if($("#m").val()==""|| $("#m").val()==null){
    		$("#prompt_txt").text("手机号不能为空！");
			return;
		}
    	/*验证码是否为空*/
    	if($("#vc").val()==""|| $("#vc").val()==null){
    		$("#prompt_txt").text("验证码不能为空！");
			return;
		}
    	// 遮罩层
    	$(".loading").show();
		$('html').toggleClass('alpha');
    	/*注册*/
    	$.ajax({
    	  url:localPath + "/offLineActivity/registerHhguResp",
    	  type:"post",
    	  data:{
    		  mobile:$("#m").val(),
    		  validateCode : $("#vc").val(),/*短信验证码*/
    		  channel : "3041",
    		  referrer:$("#referrer").val()
    	  },
    	 dataType:"json",
    	 success:function(data){
    		 $(".loading").hide();
    		 $('html').removeClass('alpha');
			// 注册是否成功
        	if (data.success) {
        		$(".loading").hide();
     		   $('html').removeClass('alpha');
     		   // 注册是否成功
     		   if (data.success) {
     			  lotteryHhgu(data.userId);
     		   } else {
     			   $("#prompt_txt").text(data.msg);
     		   }
        	} else {
        		$("#prompt_txt").text(data.msg);
        	}
    	}/*,
    	error:function(){
    		$(".loading").hide();
   		 	$('html').removeClass('alpha');
    		alert("服务器错误，请联系管理员！");
    	}*/
    	})
    	
    	function lotteryHhgu (userId) {
    		$.ajax({
    	    	  url:localPath + "/lotteryAward/lotteryHhguResp",
    	    	  type:"post",
    	    	  data:{
    	    		  userId:userId
    	    	  },
    	    	  async : false,
    	    	  dataType:"json",
    	    	  success:function(data){
    	    		 console.log(data);
		        	if (data.status == "003") {
		        		$("#prompt a").text(data.voucher_lotteryName);
		        		$("#prompt a").attr("href", basePath + "/sys/user/award/myGift.jsp?userId=" + userId);
		        		$("#prompt2 a").text(data.lotteryName);
		        		$("#prompt2 a").attr("href", basePath + "/sys/user/award/myGift.jsp?userId=" + userId);
		        		$("#userId").val(userId);
		        		$("#code").val(data.conversionCode);
		        		$(".form_box").hide();
		        		$(".ggl_box").css({"opacity":"1", "padding-bottom": "2rem"});
		        		$(".downLoad").show();
		        		$(".hhgu3_txt").css({"margin-bottom":"4rem"});
		        	} else {
		        		alert(data.msg);
		        	}
    	    	 },
    	    	 error:function() {
    	    		alert("服务器错误，请联系管理员！");
    	    	 }
    	    	})
    	}
    });
	
});