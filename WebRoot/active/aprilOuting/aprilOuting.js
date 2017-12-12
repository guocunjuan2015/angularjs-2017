$(function(){
	var  localPath = $("#localPath").val();
	var  basePath = $("#basePath").val();
	var  isLoginNum = $(".isLoginNum").text();
	var  initNum = $("#initNum").val();
	var  totalNum = $(".totalNum").text();
	var  userId = $("#userId").val();
	var  user = $("#user").val();
	isLoginNum = parseInt(isLoginNum);
	/*关闭遮罩层*/
	$(".dialog").click(function(){
		$(".bg").hide();
		$(".dialog").hide();
		//location.reload(); 
	})

	/*判断是否登录*/
	if ((userId == "" || userId == null || userId == "null") && (user == "" || user == null || user == "null")){
		$(".isLoginNum").attr("id","isLoginNum");
		$("#isLoginNum").text("请登录");
		$("#isLoginNum").attr("onclick","toLogin();");
		$("#isLoginNum").css("cursor","pointer");
		$(".isLogin").show();
		$(".isLogin").css("display","inline-block");
		$(".myEquip").hide();
	}  else {
		$(".isLogin").hide();
		$("#receiveClick").show();
		$("#receiveClick").css("display","inline-block");
	}
	
	/*初始化判断我的出行设备是否为空*/
	if($("#myEquip_list").has("li").length <= 0){
		
		$(".myEquip").hide();	
	}
	/*初始化数据*/
	$.ajax({
		url: localPath + '/lotteryAward/getAprilOuting',
		type:'POST',
		dataType:"json",
		data:{
			userId : userId,
			loginName : user
		},
		success:function(response){
		var str = "";	
			if(response.success){
				$(".isLoginNum").text(response.amount);
				$.each(response.list,function(obj,_data){
					str += "<li>";
					 if(_data.lottery_id == 1){
						 str += ' <div class="equipImg col-xs-6 col-sm-6 col-md-6  col-lg-6">';
							str += ' <img src="'+ basePath +'/active/aprilOuting/images/coverAward1.png"/>';
							str += '</div>';
							str += ' <div class="equipImgDiv col-xs-6 col-sm-6 col-md-6  col-lg-6">';
							str += ' <p>';
							str += '  结束一次奖品累计';
							str += ' </p>';
							str += ' <p>';
							str += '   年化投资<font>4500</font>元';
							str += ' </p>'; 
					    str += '</div>';
					 } else if (_data.lottery_id == 2){
						 
						 str += ' <div class="equipImg col-xs-6 col-sm-6 col-md-6  col-lg-6">';
							str += ' <img src="'+ basePath +'/active/aprilOuting/images/coverAward2.png"/>';
							str += '</div>';
							str += ' <div class="equipImgDiv col-xs-6 col-sm-6 col-md-6  col-lg-6">';
							str += ' <p>';
							str += '  结束一次奖品累计';
							str += ' </p>';
							str += ' <p>';
							str += '   年化投资<font>9000</font>元';
							str += ' </p>'; 
					    str += '</div>';
						 
					 } else if (_data.lottery_id == 3){
						 
						 str += ' <div class="equipImg col-xs-6 col-sm-6 col-md-6  col-lg-6">';
							str += ' <img src="'+ basePath +'/active/aprilOuting/images/coverAward3.png"/>';
							str += '</div>';
							str += ' <div class="equipImgDiv col-xs-6 col-sm-6 col-md-6  col-lg-6">';
							str += ' <p>';
							str += '  结束一次奖品累计';
							str += ' </p>';
							str += ' <p>';
							str += '   年化投资<font>2</font>万元';
							str += ' </p>'; 
					    str += '</div>';
						 
					 } else if (_data.lottery_id == 4){
						 
						 str += ' <div class="equipImg col-xs-6 col-sm-6 col-md-6  col-lg-6">';
							str += ' <img src="'+ basePath +'/active/aprilOuting/images/coverAward4.png"/>';
							str += '</div>';
							str += ' <div class="equipImgDiv col-xs-6 col-sm-6 col-md-6  col-lg-6">';
							str += ' <p>';
							str += '  结束一次奖品累计';
							str += ' </p>';
							str += ' <p>';
							str += '   年化投资<font>6</font>万元';
							str += ' </p>'; 
					    str += '</div>';
					 } else if (_data.lottery_id == 5){
						 
						 str += ' <div class="equipImg col-xs-6 col-sm-6 col-md-6  col-lg-6">';
							str += ' <img src="'+ basePath +'/active/aprilOuting/images/coverAward5.png"/>';
							str += '</div>';
							str += ' <div class="equipImgDiv col-xs-6 col-sm-6 col-md-6  col-lg-6">';
							str += ' <p>';
							str += '  结束一次奖品累计';
							str += ' </p>';
							str += ' <p>';
							str += '   年化投资<font>13</font>万元';
							str += ' </p>'; 
					    str += '</div>';
						 
					 } else if (_data.lottery_id == 6){
						 
						 str += ' <div class="equipImg col-xs-6 col-sm-6 col-md-6  col-lg-6">';
							str += ' <img src="'+ basePath +'/active/aprilOuting/images/coverAward6.png"/>';
							str += '</div>';
							str += ' <div class="equipImgDiv col-xs-6 col-sm-6 col-md-6  col-lg-6">';
							str += ' <p>';
							str += ' 您已爆表一个温度计';
							str += ' </p>';
							str += ' <p>';
							str += '   年化投资<font>40</font>万元';
							str += ' </p>'; 
					    str += '</div>';
						 
					 }
					 str += "</li>";
					
				})
				
				$("#myEquip_list").html(str);
				/*判断投资金额温度计展示*/
				initTherm(response.amount);
				/*点击领取奖品弹框*/
				   $("#receiveClick").click(function(){
					   /*判断投资金额是否大于4万*/
				       if(response.amount < 4500){
						   $(".bg").show();
						   $(".dialog3").show();
						   $(".boatBox .boat2").css("margin-left","16%");
						   $(".boatBox .boat2").css("margin-top","6%");
					   } else if(response.amount >= 4500 && response.amount < 400000){
						   $(".bg").show();
						   $(".dialog2").show();
						   $(".lotteryHeight").css("margin","6rem");
						   $(".boat1").css("margin-left","0");
						   $(".boat1").css("margin-top","-1rem");
						   if(response.amount >= 4500 && response.amount < 9000){
							   
							   $(".amountNum").text("话费50");
							   $(".font2 .nextGift").text("酷我蓝牙运动耳机");
							   totalNum = 9000 - response.amount;
							   
						   } else if (response.amount >= 9000 && response.amount < 24000){
							   
							   $(".amountNum").text("酷我蓝牙运动耳机");
							   $(".font2 .nextGift").text("探路者登山鞋");
							   totalNum = 24000 - response.amount;
							   
							} else if (response.amount >= 24000 && response.amount < 60000){
							  
							  $(".amountNum").text("探路者登山鞋");
							  $(".font2 .nextGift").text("话费800元");
							  totalNum = 60000 - response.amount;
								
							} else if (response.amount >= 60000 && response.amount < 130000){
								
								$(".amountNum").text("话费800元");
								 $(".font2 .nextGift").text("现金1800元");
								totalNum = 130000 - response.amount;	
								
							} else if (response.amount >= 130000 && response.amount < 400000){
								$(".amountNum").text("现金1800元");
							   $(".font2 .nextGift").text("Phone7 plus 128g");
								totalNum = 400000 - response.amount;
								
							} else if (response.amount >= 400000){
								$(".amountNum").text("现金1800元");
							} 
						   
						   $(".totalNum").text(totalNum);
						   
					   } else {
						   $(".bg").show();
						   $(".dialog2 .lotteryDiv").hide();
						   $(".dialog2 .boat2").hide();
						   $("#lotteryNew").show();
						   $(".dialog2 .boat1").css("margin","30px 0 0 33%");
						   $("#receiveLootery").text("开始新一轮投资");
						   $("#receiveLootery").attr("class","startUp");
						   $(".dialog2").show();
						   showLottery(response.amount,basePath);/*爆表后显示的奖品提示*/
						  
						} 
						   
					})
				
			}
			
		},
		error:function(){
			
			alert("请联系管理员");
		}
		
	})
	
	
	$(".startUp").click(function(){
		$(".bg").hide();
		$(".dialog").hide();
		location.reload(); 
		
	})
	
	
	/*进入登录页面*/
	$("#isLoginNum").click(function(){
		
		window.location.href= rootpath + "/member/login";
	})
	
	/*进入登录页面*/
	$("#goLogin").click(function(){
		
		window.location.href= rootpath + "/member/login";
	})
	/*点击领取我的奖品*/
	$("#receiveLootery").click(function(){
		$.ajax({
			url: localPath +'/lotteryAward/springOuting',
			type:'POST',
			dataType:"json",
			data:{
				userId : userId
			},
			success:function(respnose){
			var code = 	respnose.status;
			var message = respnose.message;
			var amount = respnose.amount;
				if(code == "003"){
					/*判断投资金额*/
					if(amount >= 4500 && amount < 9000){
						$(".bg").show();
						$(".font2").text("活动结束后7个工作日内发放，小主坐等奖品");
						$(".dialog1").show(200);
						$(".therm50p").show();
						$(".font1 font").text("话费50元");
						$(".isLoginNum").text(amount);
						$(".span4500").css("color","#CA0B1B");
						$("#dialogImg").attr("src",basePath + "/active/aprilOuting/images/award6.png");
						$(".myEquip_list ul").append
							(
								'<li>' +
								    '<div class="equipImg">' +
									' <img src="'+ basePath +'/active/aprilOuting/images/award6.png"/>' +
									' </div>'  +
									'<div class="equipImgDiv">' +
									' <p>' +
									'  您已爆表一个温度计' +
									' </p>' +
									' <p>' +
									'   年化投资<font>4500</font>元' +
									' </p>' +
								'</li>'
							);
					} else if (amount >= 9000 && amount < 20000){
						$(".bg").show();
						$(".font2").text("活动结束后7个工作日内发放，小主坐等奖品");
						$(".dialog1").show(200);
						$(".therm50p").show();
						$(".therm110p").show();
						$(".isLoginNum").text(amount);
						$(".font1 font").text("酷我蓝牙运动耳机");
						$(".span9000").css("color","#CA0B1B");
						$("#dialogImg").attr("src",basePath + "/active/aprilOuting/images/award5.png");
						$(".myEquip_list ul").append
						(
							'<li>' +
							    '<div class="equipImg">' +
								' <img src="'+ basePath +'/active/aprilOuting/images/award5.png"/>' +
								' </div>'  +
								'<div class="equipImgDiv">' +
								' <p>' +
								'  您已爆表一个温度计' +
								' </p>' +
								' <p>' +
								'   年化投资<font>9000</font>元' +
								' </p>' +
							'</li>'
						);
					} else if (amount >= 20000 && amount < 60000){
						$(".bg").show();
						$(".font2").text("活动结束后7个工作日内发放，小主坐等奖品");
						$(".dialog1").show(200);
						$(".therm50p").show();
						$(".therm110p").show();
						$(".therm2wp").show();
						$(".isLoginNum").text(amount);
						$(".font1 font").text("探路者登山鞋");
						$(".span2w").css("color","#CA0B1B");
						$("#dialogImg").attr("src",basePath + "/active/aprilOuting/images/award4.png");
						$(".myEquip_list ul").append
						(
							'<li>' +
							    '<div class="equipImg">' +
								' <img src="'+ basePath +'/active/aprilOuting/images/award4.png"/>' +
								' </div>'  +
								'<div class="equipImgDiv">' +
								' <p>' +
								'  您已爆表一个温度计' +
								' </p>' +
								' <p>' +
								'   年化投资<font>2</font>万元' +
								' </p>' +
							'</li>'
						);
					} else if (amount >= 60000 && amount < 130000){
						$(".bg").show();
						$(".font2").text("活动结束后7个工作日内发放，小主坐等奖品");
						$(".dialog1").show(200);
						$(".therm50p").show();
						$(".therm2wp").show();
						$(".therm6wp").show();
						$(".therm110p").show();
						$(".isLoginNum").text(amount);
						$(".span6w").css("color","#CA0B1B");
						$(".font1 font").text("话费800元");
						$("#dialogImg").attr("src",basePath + "/active/aprilOuting/images/award3.png");
						$(".myEquip_list ul").append
						(
							'<li>' +
							    '<div class="equipImg">' +
								' <img src="'+ basePath +'/active/aprilOuting/images/award3.png"/>' +
								' </div>'  +
								'<div class="equipImgDiv">' +
								' <p>' +
								'  您已爆表一个温度计' +
								' </p>' +
								' <p>' +
								'    年化投资<font>6</font>万元' +
								' </p>' +
							'</li>'
						);
					} else if (amount >= 130000 && amount < 400000){
						$(".bg").show();
						$(".font2").text("活动结束后7个工作日内发放，小主坐等奖品");
						$(".dialog1").show(200);
						$(".therm50p").show();
						$(".therm2wp").show();
						$(".therm6wp").show();
						$(".therm110p").show();
						$(".therm13wp").show();
						$(".isLoginNum").text(amount);
						$(".span13w").css("color","#CA0B1B");
						$(".font1 font").text("现金1800元");
						$("#dialogImg").attr("src",basePath + "/active/aprilOuting/images/award2.png");
						$(".myEquip_list ul").append
						(
							'<li>' +
							    '<div class="equipImg">' +
								' <img src="'+ basePath +'/active/aprilOuting/images/award2.png"/>' +
								' </div>'  +
								'<div class="equipImgDiv">' +
								' <p>' +
								'  您已爆表一个温度计' +
								' </p>' +
								' <p>' +
								'   年化投资<font>13</font>万元' +
								' </p>' +
							'</li>'
						);
					} else if(amount > 400000){
						$(".therm50p").show();
						$(".therm2wp").show();
						$(".therm6wp").show();
						$(".therm110p").show();
						$(".therm13wp").show();
						$(".therm40wp").show();
						$(".isLoginNum").text(amount);
						$(".span40w").css("color","#CA0B1B");
						$(".font1 font").text("Phone7 plus 128g");
						$("#dialogImg").attr("src",basePath + "/active/aprilOuting/images/award1.png");
						$(".myEquip_list ul").append(
							'<li>' +
								'<div class="equipImg">' +
								' <img src="'+ basePath +'/active/aprilOuting/images/award1.png"/>' +
								' </div>'  +
								'<div class="equipImgDiv">' +
								' <p>' +
								'  您已爆表一个温度计' +
								' </p>' +
								' <p>' +
								'   年化投资<font>40</font>万元' +
								' </p>' +
							'</li>'
						);
					} else {
						$(".therm50p").hide();
						$(".therm2wp").hide();
						$(".therm6wp").hide();
						$(".therm110p").hide();
						$(".therm13wp").hide();
						$(".therm40wp").hide();
						$(".isLoginNum").text(amount);
						$(".prizeM .therm div b").css("color","#333");
						location.reload();
					}
				} else {
					$(".bg").show();
					$(".dialog3").show(200);
					$("#font1").text(message);
				}
				
			},error:function(){
				
				alert("请联系管理员");
			}
			
			
		})
		
		
	})
	
	
})

/*判断投资金额的温度计展示*/
function initTherm(isLoginNum){
	
	if(isLoginNum < 4500){
		$(".therm50p").hide();
	}
	else if(isLoginNum >= 4500 && isLoginNum < 9000){
		$(".therm50p").show();
		$(".span4500").css("color","#CA0B1B");
	} else if (isLoginNum >= 9000 && isLoginNum < 20000){
		$(".therm50p").show();
		$(".therm110p").show();
		$(".span9000").css("color","#CA0B1B");
	} else if (isLoginNum >= 20000 && isLoginNum < 60000){
		$(".therm50p").show();
		$(".therm110p").show();
		$(".therm2wp").show();
		$(".span2w").css("color","#CA0B1B");
	} else if (isLoginNum >= 60000 && isLoginNum < 130000){
		$(".therm50p").show();
		$(".therm2wp").show();
		$(".therm6wp").show();
		$(".therm110p").show();
		$(".span6w").css("color","#CA0B1B");
	} else if (isLoginNum >= 130000 && isLoginNum < 400000){
		
		$(".therm50p").show();
		$(".therm2wp").show();
		$(".therm6wp").show();
		$(".therm110p").show();
		$(".therm13wp").show();
		$(".span13w").css("color","#CA0B1B");
	} else if(isLoginNum >= 400000){
		$(".therm50p").show();
		$(".therm2wp").show();
		$(".therm6wp").show();
		$(".therm110p").show();
		$(".therm13wp").show();
		$(".therm40wp").show();
		$(".span40w").css("color","#CA0B1B");
	}
	
	
}

/*爆表后显示的奖品提示*/
function showLottery(isLoginNum,basePath){
	
	 if(isLoginNum >= 4500 && isLoginNum < 9000){
			$(".bg").show();
			$(".font2").text("活动结束后7个工作日内发放，小主坐等奖品");
			$(".dialog1").show(200);
			$(".therm50p").show();
			$(".font1 font").text("话费50元");
			$(".span4500").css("color","#CA0B1B");
			$("#dialogImg1").attr("src",basePath + "/active/aprilOuting/images/coverAward1.png");
		} else if (isLoginNum >= 9000 && isLoginNum < 20000){
			$(".bg").show();
			$(".therm50p").show();
			$(".therm110p").show();
			$(".font1 font").text("酷我蓝牙运动耳机");
			$(".font2").text("活动结束后7个工作日内发放，小主坐等奖品");
			$(".span9000").css("color","#CA0B1B");
			$("#dialogImg1").attr("src",basePath + "/active/aprilOuting/images/coverAward2.png");
		} else if (isLoginNum >= 20000 && isLoginNum < 60000){
			$(".bg").show();
			$(".font2").text("活动结束后7个工作日内发放，小主坐等奖品");
			$(".therm50p").show();
			$(".therm110p").show();
			$(".therm2wp").show();
			$(".font1 font").text("探路者登山鞋");
			$(".span2w").css("color","#CA0B1B");
			$("#dialogImg1").attr("src",basePath + "/active/aprilOuting/images/coverAward3.png");
		} else if (isLoginNum >= 60000 && isLoginNum < 130000){
			$(".bg").show();
			$(".dialog1").show(200);
			$(".therm50p").show();
			$(".therm2wp").show();
			$(".therm6wp").show();
			$(".therm110p").show();
			$(".font2").text("活动结束后7个工作日内发放，小主坐等奖品");
			$(".span6w").css("color","#CA0B1B");
			$(".font1 font").text("话费800元");
			$("#dialogImg1").attr("src",basePath + "/active/aprilOuting/images/coverAward4.png");
		} else if (isLoginNum >= 130000 && isLoginNum < 400000){
			$(".bg").show();
			$(".font2").text("活动结束后7个工作日内发放，小主坐等奖品");
			$(".dialog1").show(200);
			$(".therm50p").show();
			$(".therm2wp").show();
			$(".therm6wp").show();
			$(".therm110p").show();
			$(".therm13wp").show();
			$(".isLoginNum").text(amount);
			$(".span13w").css("color","#CA0B1B");
			$(".font1 font").text("现金1800元");
			$("#dialogImg1").attr("src",basePath + "/active/aprilOuting/images/coverAward5.png");
		} else {
			$(".therm50p").show();
			$(".therm2wp").show();
			$(".therm6wp").show();
			$(".therm110p").show();
			$(".therm13wp").show();
			$(".therm40wp").show();
			$(".font2").text("活动结束后7个工作日内发放，小主坐等奖品");
			$(".span40w").css("color","#CA0B1B");
			$(".font1 font").text("Phone7 plus 128g");
			$("#dialogImg1").attr("src",basePath + "/active/aprilOuting/images/coverAward6.png");
		}
}