$(document).ready(function() {
	
var basePath = $("#basePath").val();
var localPath = $("#localPath").val();
var userId = $("#userId").val();
var loginName = $("#user").val();

	
		if (window.DeviceMotionEvent){
			var speed = 25;
			var x = t = z = lastX = lastY = lastZ = 0;
			var flag = false;
			window.addEventListener('devicemotion',
				function () {
					var acceleration = event.accelerationIncludingGravity;
					x = acceleration.x;
					y = acceleration.y;
					if (Math.abs(x - lastX) > speed || Math.abs(y - lastY) > speed) {
							  $('#animationSandbox').removeClass().addClass('shake' + ' animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
							  $(this).removeClass();
						  
						});
						setTimeout(function(){
							if ((userId == "" || userId == null || userId == "null") && (loginName == "" || loginName == null || loginName == "null")){
								    $('.bg').show();
								    $('.succ').hide();
									$('.login').show();	

							}  else {
									if(!flag){
										flag=true;
										$.ajax({
										   url:localPath + '/lotteryAward/nineactivity',
										   type:'POST',
										   data:{
										     userId : userId,
										     loginName : loginName
										   },
										   dataType:'json',
										   success:function(data){
											   flag = false;
											   //console.log(data);
											  if(data.msg[5] == '1'){ /* 1、是红包  2、加息券  */
												
													$(".bg").show();  
													  $(".succ").show();
													  $(".result-hd p.tip span").text(data.msg[1]);
													  $(".result-hd p.tip font").text("元投资红包 ");
													  $(".lotteryImg").text(data.msg[1]);
													  $(".lotteryImg").removeClass("lotteryCoupons");
													  return;
												   
											   } else if(data.msg[5] == '2') {/* 1、是红包  2、加息券  */
													  
													   $(".bg").show();  
											           $(".succ").show();
											           $(".result-hd p.tip span").text(data.msg[1]);
											           $(".result-hd p.tip font").text("%加息券");
											           $(".lotteryImg").text(data.msg[1]+'%');
											           $(".lotteryImg").addClass("lotteryCoupons");
											           return;
													   
											   } else {/*没有中奖机会了  */
												   flag = false;
										    	   $(".bg").show();  
										           $(".succ").show();
										           $(".result-hd h4").text("抱歉 ");
										           $(".txtMsg").text(data.msg);
										           $(".dialog").css("top","18rem");
										           $(".lotteryImg").removeClass("lotteryCoupons");	
										           $(".lottery-msg").hide();
										           $(".result-hd p.tip").hide();
										           $(".lotteryProject").hide();
										           return;
											   }
										   },
										})
	
								}
							} 
						}, 1000);
					};
					lastX = x;
					lastY = y;
				},false);
		};
});

	$(function(){
		
	      //点击遮罩层隐藏弹框效果 
	      $(".layer").click(function(){
	          $(".bg").hide();
	          $(".dialog").hide();
	        
	      }) 
	       //活动规则展示框 
	     $(".activeTitle").click(function(){
		    var activeRule = $(".activeRule");
		    if ( activeRule.css("display") === "none" ) {
		    	activeRule.show();
		    } else {
		    	activeRule.hide();
		    }
		});
		
	})
	
	
	