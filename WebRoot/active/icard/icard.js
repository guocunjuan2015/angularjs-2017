var f = 999;
$(function(){
	if (getRequestParam("channel")) {
		f = getRequestParam("channel");
		var storage = window.sessionStorage;
		storage.setItem("channel", f);
	} else if (getRequestParam("utm_source")) {
		f = getRequestParam("utm_source");
	}
});
// 获取手机验证码
$(function(){
	
	var basePath=$("#basePath").val();
	var localPath = $("#localPath").val();
	$("#getc").click(function() {
		/*手机号验证不能为空*/
		if($("#m").val()==""|| $("#m").val()==null){
			$("#showMess").show(200);
			$("#showMess").text("手机号不能为空！");
			
			return;   
		}
		/*图形验证码验证是否为空*/
		if($("#vcode").val()==""|| $("#vcode").val()==null){
			$("#showMess").show(200);
			$("#showMess").text("图片验证码不能为空！");
			return;
		}else{
			$("#showMess").hide(200);
		}
		if (checkM("m")) {
			$("#showMess").text("");
			$.ajax({
				url : localPath + "/offLineActivity/checkPASendSMSResp",
				type : "POST",
				async : false,
				data : {
					mobile: $("#m").val(), 
	        	 	vcode : $("#vcode").val()
				},
				dataType : "json",
				success : function(data) {
		        	if (data.success) {
		        		$("#getc").attr("disabled", true);
		        		var count = 60;
		    			function CountDown() {
		    				$("#getc").val(count + "秒后重新发送");
		    				$("#getc").css("opacity","1");
		    				if (count == 0) {
		    					$("#getc").val("重新获取验证码").removeAttr("disabled");
		    					clearInterval(countdown);
		    				}
		    				count--;
		    			}
		    			var countdown = setInterval(CountDown, 1000);
		    			$("#showMess").show(200);
		    			$("#showMess").text(data.msg);
		        	} else {
		        		$("#showMess").show(200);
		    			$("#showMess").text(data.msg);
		        		if(data.msg=="提示:抱歉此次活动仅新注册用户参加!"){
		        			$("#showMess").show(200);
		        			$("#showMess").text("该用户已注册");
		        		}else{
		        			$("#showMess").show(200);
		        			$("#showMess").text(data.msg);
		        		}
		        	}
				},
				error : function (data) {
					alert("服务器错误，请联系管理员！");
				}
			});

		} else {
			$("#showMess").text("请输入格式正确的手机号!");
		}
	});
	
	/*******************************************************************************
	 * --------------------------------验证相关-------------------------------------------*
	 ******************************************************************************/

	var m_mess = "请输入格式正确的手机号!";
	// 输入长度校验公共函数
	function checkLength(showMess, id, s_l, e_l, message) {
		var flag = false;
		if ($("#" + id).val().length >= s_l && $("#" + id).val().length <= e_l
				&& $("#" + id).val() != '') {
			flag = true;
		} else {
			myErrorMsg(showMess, message);
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
			myErrorMsg("showMess", m_mess);
		} else {
			flag = true;
		}
		return flag; 
	}
	
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
	
	
	
	
})
/**
	 * 注册
	 */
   $(function(){
		var basePath=$("#basePath").val();
		var localPath = $("#localPath").val();
	    $("#exchange").click(function(){
	    	/*手机号码验证是否为空*/
	    	if($("#m").val()==""|| $("#m").val()==null){
	    		$("#divshows").show();
				$("#showMess").text("手机号不能为空！");
				return;
			}
	    	
	    	/*图形验证码验证是否为空*/
			if($("#vcode").val()==""|| $("#vcode").val()==null){
				$("#divshows").show();
				$("#showMess").text("图片验证码不能为空！");
				return;
			}
	    	/*注册*/
	    	$.ajax({
	    	  url:localPath + "/lotteryAward/icardRegister",
	    	  type:"post",
	    	  data:{
	    		  mobile:$("#m").val(),
	    		  validateCode : $("#vc").val(),/*短信验证码*/
	      	 	  vcode : $("#vcode").val(),/*图形验证码*/
	      	 	  f : $("#channel").val(),
	      	 	icardcode:$("#icardcode").val()
	    	  },
	    	 dataType:"json",
	    	 success:function(data){
	    		/*注册成功*/
	    			// 注册是否成功
		        	if (data.status=="003") {
		        		$(".prize h3").text("恭喜您获得"+data.name);
		        		$(".bg30").show();
		        	} else {
		        		$("#divshows").show();
		        		$("#showMess").text(data.message);
		        	}
	    	},
	    	error:function(){
	    		alert("服务器错误，请联系管理员！");
	    	}
	    	})
	    	
	    	
	    })
   });	
var basePath=""; 
//换一张图片验证码
function changeVC() {
	basePath=$("#localPath").val();
	$("#imgObj").attr("src", basePath +"/servlet/validateCodeServlet?"+new Date().getTime());
}


//图片验证码是否正确
function checkVCIsExist() {
	var flag = false;
	basePath=$("#localPath").val();
	$.ajax({
		type : "get",
		async : false,
		dataType : "json",
		url :  basePath +"/servlet/validateCodeServlet?"+new Date().getTime(),
		data : {
			validateCode : $("#vcode").val()
		},
		success : function(response) {
			if (response) {
				flag = true;
			} else {
				flag = false;
			}
		}
	});
	return flag;
}
$(function(){
	$("#hrefaddress").click(function(){
		
		var m=$("#m").val();
		var base =$("#basePath").val();
		if($("#m").val() ==""){
			alert("请登录");
		}else if($("#m").val()!==""){
			window.location.href=base+'/addressInfo.jsp?login_name='+m;
		}
			
	});
});