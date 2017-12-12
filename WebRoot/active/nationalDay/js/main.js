jQuery(document).ready(function($) {
	var galleryItems = $('.cd-gallery').children('li');
	var  userId = $("#userId").val();
	var  loginName = $("#user").val();
	var  localPath = $("#localPath").val();
	var  basePath = $("#basePath").val();
	tenactivitynum();//初始化奖品机会
	gettenrecordlist();//初始化翻牌奖品列表
	var lotteryNum = 0; //抽奖次数
     //判断用户是否登录
	 if ((userId == "" || userId == null || userId == "null") && (loginName == "" || loginName == null || loginName == "null")){
        
        $("#inviteBtn").attr("onclick","toLogin();");
        $(".activeTitle span").text("1");
        
      }  else {
        
        $("#inviteBtn").attr("onclick","shareClick();");
        
      }
      //点击注册  
     $("#registerBtn").click(function(){
         var mobile = $("#mobile").val();//手机号码
         var pattern = /^0?(13[0-9]|15[0-9]|18[0-9]|14[0-9]|17[0-9])[0-9]{8}$/;//手机号码校验
         var deviceId = SMSdk.getDeviceId();
         var utm_source = $("#utm_source").val();
         if(mobile == "" || mobile == null){
		           $("#error_info").show();
		           $("#error_info").html("手机号码不能为空");
		            return;
         }
       //手机号码输入校验
         if(pattern.test(mobile)){
           $("#error_info").hide();
           var objData = {
              mobile : mobile,
              deviceId : deviceId,
              referrer : '',
              channel : utm_source
           };
           $.ajax({
                    url:localPath + '/activity/reg/p?date='+new Date(),
                    type:'POST',
                    dataType:'json',
                    data: JSON.stringify(objData),
                    contentType: "application/json",
                    success:function(data){
                      if(data.result=="1"){
                           location.href = basePath + "/login.jsp?active=nationalDay";
                       } else {
                           $("#error_info").show();
                           $("#registerDiv").css("height","12.8rem");
                           $("#error_info").html(data.errInfo); 
                           return;
                         
                       }
                       
                      
                    },
                    error:function(){
                      
                      $("#error_info").html("注册失败 ");   
                      
                    }
                  
                })
           
         } else {
                 $("#error_info").show();
                 $("#error_info").html("请输入格式正确的手机号! ");
           
         }
        
        
     }); 
      
	//活动规则
	$(".activeBg").click(function(){
			    $(".bg").show();
			    $(".activeRule").show();
			  
	})
		 
	//关闭遮罩层 
	$(".close_btn").click(function(){
		   $(".bg").hide();
		   $(".activeRule").hide();
		   $(".loginBox").hide();
		   $(".lotteryNumError").hide();
		 
	})
	//重新翻牌 
	$(".reset").click(function(){
			 location.reload();
		
	})
    
	//点击奖品触发事件
	$(".cd-item-wrapper li").click(function(){
		var $this = $(this);
		var isFrist = true;
    	if ((userId == "" || userId == null || userId == "null") && (loginName == "" || loginName == null || loginName == "null")){
    		 $(".bg").show();    
	         $(".loginBox").show();
	             
	     }  else {
	             
	    	 $(".bg").hide();    
	         $(".loginBox").hide();
	       //奖品池//
	     	if(lotteryNum == "1"){
	     		$.ajax({
	                 url:localPath + '/lotteryAward/tenactivity',
	                 type:'POST',
	                 dataType:'json',
	                 data:{
	                     userId: userId,
	                     loginName: loginName
	                  },
	                 success:function(data){
	                 	if(data.success){
	                 		//判断是否首次抽奖	
	                 		if(isFrist){
	                 			$this.find('.showLottery').show();
	            	         	$this.find('.lotteryShow').show();
	            	         	$this.find('.lotteryShow').css('background','none');
	                     		isFrist = false;
	                     	
	     			             	if(data.get != null && data.get != undefined && data.get.length > 0){  
	     			             		$this.find('.showLottery img').attr("src",basePath + '/active/nationalDay/image/'+data.get[7]+''); 
	     			             		$this.find('.showLottery p').text(data.get[8]);
	     				             	  
	     			             	  } else {
	     			             		  
	     			             		  alert(data.get.msg);
	     	             	          }  
	                  	    
	     			             	tenactivitynum ();//奖品机会
	     			             	gettenrecordlist();//获取翻牌列表
	                        }
	                 		
	                 		
	                 	}
	                 }
	               
	     			}) 
	     	}  else if( lotteryNum == "2") {
	     		shareClick();	
	     		
	     	} else {
	     		
	     		$(".bg").show();
	     		$(".lotteryNumError").show();  
	     		$("#errorInfo").text("今日翻牌机会已用完！");
	     		
	     	}
	             
	   }
    	
    		

   })
	galleryItems.each(function(){
		var container = $(this),
			// create slider dots
			sliderDots = createSliderDots(container);
		//check if item is on sale
		updatePrice(container, 0);

		// update slider when user clicks one of the dots
		sliderDots.on('click', function(){
			var selectedDot = $(this);
			if(!selectedDot.hasClass('selected')) {
				var selectedPosition = selectedDot.index(),
					activePosition = container.find('.cd-item-wrapper .selected').index();
				if( activePosition < selectedPosition) {
					nextSlide(container, sliderDots, selectedPosition);
				} else {
					prevSlide(container, sliderDots, selectedPosition);
				}

				updatePrice(container, selectedPosition);
				$(".selected div.lotteryShow").attr({"style":"background:url(http://test.rqbao.com/rqb/active/nationalDay/image/defaultLight.png)","background-size":"10rem"});
			}
		});

		// update slider on swipeleft
		container.find('.cd-item-wrapper').on('swipeleft', function(){
			var wrapper = $(this);
			if( !wrapper.find('.selected').is(':last-child') ) {
				var selectedPosition = container.find('.cd-item-wrapper .selected').index() + 1;
				nextSlide(container, sliderDots);
				updatePrice(container, selectedPosition);
			}
		});

		// update slider on swiperight
		container.find('.cd-item-wrapper').on('swiperight', function(){
			var wrapper = $(this);
			if( !wrapper.find('.selected').is(':first-child') ) {
				var selectedPosition = container.find('.cd-item-wrapper .selected').index() - 1;
				prevSlide(container, sliderDots);
				updatePrice(container, selectedPosition);
			}
		});

		// preview image hover effect - desktop only
		container.on('mouseover', '.move-right, .move-left', function(event){
			hoverItem($(this), true);
		});
		container.on('mouseleave', '.move-right, .move-left', function(event){
			hoverItem($(this), false);
		});

		// update slider when user clicks on the preview images
		container.on('click', '.move-right, .move-left', function(event){
			event.preventDefault();
			if ( $(this).hasClass('move-right') ) {
				var selectedPosition = container.find('.cd-item-wrapper .selected').index() + 1;
				nextSlide(container, sliderDots);
			} else {
				var selectedPosition = container.find('.cd-item-wrapper .selected').index() - 1;
				prevSlide(container, sliderDots);
			}
			updatePrice(container, selectedPosition);
		});
	});
 	
  //初始化获取用户抽奖机会
 	function  tenactivitynum(){
 		
 	     $.ajax({
 	          url:localPath +'/lotteryAward/tenactivitynum',
 	          type:'POST',
 	          dataType:'json',
 	          data:{
 	              userId:userId,
 	              loginName:loginName
 	           },
 	          success:function(data){
 	        	  console.log(data);
 	       	   if(data.success){
 	       		   if(data.msg.lotteryNumber1 <= 0){
 	       			   
 	       			$(".activeTitle span").html("0");
 	       		     lotteryNum = 2;//分享获取更多机会！
 	       			
 	       		   }  else {
 	       			   
 	       			   $(".activeTitle span").text(data.msg.lotteryNumber1);
 	       			   lotteryNum = 1;//有机会
 	       		   }
 	       	   } else {
 	       		   
 	       		 if ((userId == "" || userId == null || userId == "null") && (loginName == "" || loginName == null || loginName == "null")){
	 	       		
 	       			$(".activeTitle span").html("1"); //未登录默认显示1次抽奖机会
 	       		 } else { 
 	       			$(".activeTitle span").html("0"); //没有抽奖机会
	 	       		 lotteryNum = 3;
 	       		 }
 	       	   }
 	          }
 	        
 	   })
 		
 	}
 	
 	
 	//初始化奖品 
 	function  gettenrecordlist(){
 		if ((userId == "" || userId == null || userId == "null") && (loginName == "" || loginName == null || loginName == "null")){
 			
 				$(".lotteryRecord").hide();
 			
 			
 		} else {
 			$.ajax({
	 	   	     url:localPath + '/lotteryAward/gettenrecordlist',
	 	   	     type:'POST',
	 	   	     data:{
	 	   	    	  userId:userId,
	 	   	    	  loginName:loginName
	 	   	     },
	 	   	     dataType:'json',
	 	   	     success:function(data){
	 	   	    	console.log(data);
	 	   	    	 console.log(data.getlist);
	 	   	    	 var str = '';
	 	   	    	 if(data.getlist != null && data.getlist.length > 0){
	 	   	    		 
	 	   	    		   $.each(data.getlist,function(obj,_data){
	 	                            str += "<li>"
	 	                            str += ' <div class="lotteryRecordL">' ; 
	 	                            str +='  <img src="'+_data.img_url2+'">';
	 	                            str +='  <p>'+_data.award_name+'</p>';
	 	                            str += '</div>';
	 	                            str += ' <div class="lotteryRecordR">' ;
	 	                            str += '  <p>'+_data.date +'</p>' ; 
	 	                                if(_data.isdiscount == "1"){
	 	                               	 str += ' <button class="receiveBtn" onclick="toProject();">领取未兑换</button>' ;
	 	                                } else if(_data.isdiscount == "2") {
	 	                               	 
	 	                               	 str += ' <button class="receiveBtn receiveGray">已兑换</button>' ;
	 	                                }
	 	                                
	 	                            str += '</li>';  
	 	                }) 
	 	                $("#prizeList").html(str);
	 	   	    		 
	 	   	    	 } else {
	 	   	    		 
	 	   	    		 $(".lotteryRecord").hide();
	 	   	    	 } 
	 	   	    	 
	 	   	     },error:function(){
	 	   	    	 
	 	   	    	  alert("请联系管理员!");
	 	   	     }
	 	      }) 
 		}
 	     
 		
 	}

	function createSliderDots(container){
		var dotsWrapper = $('<ol class="cd-dots"></ol>').insertAfter(container.children('a'));
		container.find('.cd-item-wrapper li').each(function(index){
			var dotWrapper = (index == 0) ? $('<li class="selected"></li>') : $('<li></li>'),
				dot = $('<a href="#0"></a>').appendTo(dotWrapper);
			dotWrapper.appendTo(dotsWrapper);
			dot.text(index+1);
		});
		return dotsWrapper.children('li');
	}

	function hoverItem(item, bool) {
		( item.hasClass('move-right') )
			? item.toggleClass('hover', bool).siblings('.selected, .move-left').toggleClass('focus-on-right', bool)
			: item.toggleClass('hover', bool).siblings('.selected, .move-right').toggleClass('focus-on-left', bool);
	}

	function nextSlide(container, dots, n){
		var visibleSlide = container.find('.cd-item-wrapper .selected'),
			navigationDot = container.find('.cd-dots .selected');
		if(typeof n === 'undefined') n = visibleSlide.index() + 1;
		visibleSlide.removeClass('selected');
		container.find('.cd-item-wrapper li').eq(n).addClass('selected').removeClass('move-right hover').prevAll().removeClass('move-right move-left focus-on-right').addClass('hide-left').end().prev().removeClass('hide-left').addClass('move-left').end().next().addClass('move-right');
		navigationDot.removeClass('selected')
		dots.eq(n).addClass('selected');
	}

	function prevSlide(container, dots, n){
		var visibleSlide = container.find('.cd-item-wrapper .selected'),
			navigationDot = container.find('.cd-dots .selected');
		if(typeof n === 'undefined') n = visibleSlide.index() - 1;
		visibleSlide.removeClass('selected focus-on-left');
		container.find('.cd-item-wrapper li').eq(n).addClass('selected').removeClass('move-left hide-left hover').nextAll().removeClass('hide-left move-right move-left focus-on-left').end().next().addClass('move-right').end().prev().removeClass('hide-left').addClass('move-left');
		navigationDot.removeClass('selected');
		dots.eq(n).addClass('selected');
	}

	function updatePrice(container, n) {
		var priceTag = container.find('.cd-price'),
			selectedItem = container.find('.cd-item-wrapper li').eq(n);
		if( selectedItem.data('sale') ) { 
			// if item is on sale - cross old price and add new one
			priceTag.addClass('on-sale');
			var newPriceTag = ( priceTag.next('.cd-new-price').length > 0 ) ? priceTag.next('.cd-new-price') : $('<em class="cd-new-price"></em>').insertAfter(priceTag);
			newPriceTag.text(selectedItem.data('price'));
			setTimeout(function(){ newPriceTag.addClass('is-visible'); }, 100);
		} else {
			// if item is not on sale - remove cross on old price and sale price
			priceTag.removeClass('on-sale').next('.cd-new-price').removeClass('is-visible').on('webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', function(){
				priceTag.next('.cd-new-price').remove();
			});
		}
	}
});