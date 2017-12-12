jQuery(document).ready(function($) {
	var galleryItems = $('.cd-gallery').children('li');
	var  userId = $("#userId").val();
	var  loginName = $("#user").val();
	var  localPath = $("#localPath").val();
	var  basePath = $("#basePath").val();
	couponList();//加息券列表
		//判断用户是否登录
		 if ((userId == "" || userId == null || userId == "null") && (loginName == "" || loginName == null || loginName == "null")){
		       
		        $(".decActiveBtn").attr("onclick","toLogin();");
		        
		}
		 
		
		 //初始化抽奖次数展示
		$.ajax({
			url:localPath + '/lotteryAward/attendCount',
		   	type:'POST',
	       data:{
	    	   userId : userId,
	    	   loginName :loginName
	       },
	       success:function(data){
	       	if(data.success){
	       	
	       		$("#num").html(data.count);
	       		
	       	} else {
	       		$("#num").html('0');
	       	}
	       	
	       	
	       	
	       }
		})
		
		//抽奖
		$(".decActiveBtn").click(function(){
			
			 //判断用户是否登录
			 if ((userId == "" || userId == null || userId == "null") && (loginName == "" || loginName == null || loginName == "null")){
			       
			        $(".decActiveBtn").attr("onclick","toLogin();");
			       
			       
			} else {
				
				lottery();
				
			}
			
			
			
		})
		
		
		
		//抽奖
		 function lottery(){
				init = setInterval("imgAnimate()",100);
				setTimeout(function (){
			   	clearInterval(init,0);
				init = null;
			   	stopAnimate();
				$.ajax({
					
					   url:localPath + '/lotteryAward/attend',
					   type:'POST',
					   data:{
							
							userId : userId,
					        loginName :loginName
							
						},
						success:function(data){
							var info = data.result;
							if(data.success){
								
								$("#num").html(data.count);
								$(".lotterySuccess h5").html("￥"+info[1]);
								$(".lotterySuccess .p_invest").html('投资金额: ≥' + info[2]);
								$(".lotterySuccess .p_term").html('投资期限: ≥' + info[3]);
								$(".bg").show();
								$(".lotterySuccess").show();
								
								
							} else {
								
								$(".bg").show();
								$(".lotteryFailed").show();
								
							}
							
						}
					
					
					
				})
			},2000);
		
			
		}
		
		
		
		//关闭遮罩层
		$(".close_btn").click(function(){
			
			$(".bg").hide();
			$(".dialog").hide();
			
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

	/*红包移动*/
	function imgAnimate(){
		$(".img1").animate({top:".9rem",left:"3rem"},200).animate({top:"3.6rem",left:"3rem"},200);
		$(".img2").animate({top:"3.5rem",left:"2.6rem"},200).animate({top:"2.28rem",left:"1.2rem"},200);
		$(".img3").animate({top:"3.2rem",left:"4.9rem"},200).animate({top:"1.2rem",left:"4.4rem"},200);
		$(".img4").animate({top:"2.28rem",left:"1.2rem"},200).animate({top:"3.5rem",left:"2.6rem"},200);
		$(".img5").animate({top:"3.6rem",left:"3rem"},200).animate({top:".9rem",left:"3rem"},200);
		$(".img6").animate({top:"1.2rem",left:"4.4rem"},200).animate({top:"4rem",left:"3rem"},200);
		$(".img7").animate({top:"4rem",left:"3rem"},200).animate({top:"3.2rem",left:"4.9rem"},200);
		$(".img11").animate({top:"2.4rem",left:"2.8rem"},200).animate({top:"2.9rem",left:"1.5rem"},200);
		$(".img12").animate({top:"2.4rem",left:"4.6rem"},200).animate({top:"1.4rem",left:"3.8rem"},200);
		$(".img13").animate({top:"2.4rem",left:"4.6rem"},200).animate({top:"2.4rem",left:"2.8rem"},200);
		$(".img14").animate({top:"3.4rem",left:"3.9rem"},200).animate({top:"2.4rem",left:"4.6rem"},200);
		$(".img15").animate({top:"1.4rem",left:"2rem"},200).animate({top:"3.4rem",left:"3.9rem"},200);
		$(".img16").animate({top:"1.4rem",left:"3.8rem"},200).animate({top:"1.4rem",left:"2rem"},200);
	}
	
	function stopAnimate(){
		$("#con ul li").stop(true);
	}
	
	//加息券
	function receiveCoupon(event){
		var  userId = $("#userId").val();
		var  loginName = $("#user").val();
		var  localPath = $("#localPath").val();
		$coupon = $(event.target).find('input.receiveval1').val().replace(/%/g, "");
		$repeatKey = $(event.target).find('input.receiveval2').val();
		 //判断用户是否登录
		 if ((userId == "" || userId == null || userId == "null") && (loginName == "" || loginName == null || loginName == "null")){
		       
			 	$(event.target).attr("onclick","toLogin();");
		        return;
		       
		} else {
				$.ajax({
					url:localPath + '/lotteryAward//slyderAdventures',
					type:'post',
					data:{
						userId: userId,
				        loginName: loginName,
				        rate:  $coupon,
				        repeatKey: $repeatKey
					},
					success:function(data){
						if(data.success) {
							$(event.target).addClass("gray");
						} else {
							alert(data.msg);
						}
					},
					error:function(data){
						alert("温馨提示-领取失败，请稍后重试");
					}
				
					
				})
		}	
	}
	

	//加息券列表
	function couponList(){
			var  userId = $("#userId").val();
			var  loginName = $("#user").val();
			var  localPath = $("#localPath").val();
			$.ajax({
					
				url:localPath + '/lotteryAward/receiveMorerateList',
				type:'post',
				data:{
					userId : userId,
			        loginName :loginName
				},
				
				success:function(data){
					  var str = '';
					  if(data.success){
				        	var arr = data.resultList;
				        	var jslength=1;
				        	
				        	for (var k in arr){
				        		if(arr[k].count=='3'){  //count等于3表示已经领取
				        			//初始化为加息券动态追加addClass
						    		 
				        			str += '<li class="coupon'+(jslength++)+' gray"><input type="hidden" class="receiveval1" value="'+k+'"/><input type="hidden" class="receiveval2" value="'+arr[k].randomCode+'"/></li>'; 
				        		
				        		} else {
				        			
				        			
				        			str += '<li class="coupon'+(jslength++)+'" onclick="receiveCoupon(event)"><input type="hidden" class="receiveval1" value="'+k+'"/><input type="hidden" class="receiveval2" value="'+arr[k].randomCode+'"/></li>'; 
				        			
				        		}
				        	}
				        	
				          	 $(".cd-item-wrapper").html(str);
				          	 $(".coupon1").addClass("move-left");
							 $(".coupon2").addClass("selected");
							 $(".coupon3").addClass("move-right");
				        } else {
				        	   str+='<li class="move-left coupon1" onclick="receiveCoupon(event)"><input class="receiveval1" type="hidden" value="2.6"/></li>'+
				    			'<li class="coupon2 selected" onclick="receiveCoupon(event);"><input class="receiveval1" type="hidden" value="3.2"/></li>'+
				    			'<li class="coupon3 move-right" onclick="receiveCoupon(event);"><input class="receiveval1" type="hidden" value="3.4"/></li>'+
				    			'<li class="coupon4" onclick="receiveCoupon(event);"><input class="receiveval1" type="hidden" value="3.6"/></li>'+
				    			'<li class="coupon5" onclick="receiveCoupon(event);"><input class="receiveval1" type="hidden" value="3.8"/></li>'+
				    			'<li class="coupon6" onclick="receiveCoupon(event);"><input class="receiveval1" type="hidden" value="4.5"/></li>';
				        	$(".cd-item-wrapper").html(str);
				        }
					  
					 
			        },
			        error:function(data){
			        	var str='';
			        	str+='<li class="coupon1" onclick="receiveCoupon(event);"><input class="receiveval1" type="hidden" value="2.6"/></li>'+
						'<li class="coupon2" onclick="receiveCoupon(event);"><input class="receiveval1" type="hidden" value="3.2"/></li>'+
						'<li class="coupon3" onclick="receiveCoupon(event);"><input class="receiveval1" type="hidden" value="3.4"/></li>'+
						'<li class="coupon4" onclick="receiveCoupon(event);"><input class="receiveval1" type="hidden" value="3.6"/></li>'+
						'<li class="coupon5" onclick="receiveCoupon(event);"><input class="receiveval1" type="hidden" value="3.8"/></li>'+
						'<li class="coupon6" onclick="receiveCoupon(event);"><input class="receiveval1" type="hidden" value="4.5"/></li>';
			        	$(".cd-item-wrapper").html(str);
			        }
			        
			       
			        

			})
		
	}
	//2秒之后隐藏下箭头
	function hiddenDiv(){
		
		$(".arrow").hide();
	}
	
	setTimeout("hiddenDiv()",8000);//2秒之后隐藏下箭头