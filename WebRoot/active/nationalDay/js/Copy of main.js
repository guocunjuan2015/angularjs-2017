
	$(function (){
		$('.activityrule h3').on('click',function (){
			$(".bg").show();
			$(".dirlog").show();
		});
		$('.closen').on('click',function (){
			$(".bg").hide();
			$(".dirlog").hide();
		});
		$('.closemsg').on('click',function (){
			$(".bg").hide();
			$(".msg").hide();
		});
		var userId = $("#userId").val();
		var prize = $('.prize');
	    var isFirst = true;
	    var num = false;
	    /*抽奖次数*/
		function tenactivitynum (){
			$.ajax({
		         url:"/lotteryAward/tenactivitynum",
		         dataType:"json",
		         data:{
		        	 userId: userId
		         },
		         success:function(data){
		        	 if(!data){
		        		 if(data.success){
				        		if(data.msg.lotteryNumber1 <= 0){
				        			$(".tenactivitynum").html('分享获得更多机会');
				        			num = 2;
				        		}else{
				        			$(".tenactivitynum span").html(data.msg.lotteryNumber1);
				        			num = 1;
				        		}
			    	        	
				        	}else{
			        			$(".tenactivitynum").html('今日机会已用完！');
				        		num = 3;
			    	        	
				        	}
		        	 }
		         },
		         error:function(data){
		        	 num = 3;
		        	 alert(data);
		         }
			});
		};
		tenactivitynum ();
	    prize.on('click',function(){
	    	var index = $(".prizeList .prize").index(this);
	    	console.log(index);
	    	/*判断是否登录*/
	        if(userId){
	        	/*判断是否有机会翻牌*/
	        	if(num =='1'){
	        		/*奖池奖品*/
    				$.ajax({
    			         url:"/lotteryAward/tenactivity",
    			         dataType:"json",
    			         async: false,
    			         data:{
    			        	 userId: userId
    			         },
    			         success:function(data){
    			        	 if(data.success){
    			        		//输出数组
    			        		var fivelist = [];
    			        		var get = data.get;
    			        		 //输出个数
    			        		 var num = 5;
    			        		 while(fivelist.length < num){
    			        		     var temp = (Math.random()*(data.alllist.length)) > 0;
    			        		     fivelist.push((data.alllist).splice(temp,1));
    			        		 };
    			        		/*  get.unshift(index, 0); 
    			        		 Array.prototype.splice.apply(fivelist, get);  */
    			        		 fivelist.splice(index, 0, get);
    			        		 console.log(fivelist);
    			        		 var str = '';
    				        	 for(var i = 0; i < fivelist.length; i++) {
    				        		 var list = fivelist[i][0];
    				        		 if(i==index){
    				        			 str +='<div class="prize">';
        					        	 str +='<div class="open"><img src="/static_3/active/nationalDay/images/'+fivelist[i][7]+'">';
        					        	 str += '<p>'+fivelist[i][8]+'</p></div>';
        					        	 str +='</div>';  
    				        		 }else{
    				        			 str +='<div class="prize">';
        					        	 str +='<div class="open"><img src="/static_3/active/nationalDay/images/'+list[7]+'">';
        					        	 str += '<p>'+list[8]+'</p></div>';
        					        	 str +='</div>'; 
    				        		 }
    				        	 };
    				        	 console.log(str);
    				        	 $("#prizeList").html(str);
    				        	 var $this = $(".prizeList .prize").eq(index);
   			        			/*翻牌效果*/
   					        	if(isFirst){
   						            isFirst = false;
   						            setTimeout(function(){
   						            	$this.addClass('block');
   						            	$this.find('.open').css({'transform':'rotateY(360deg)'});
   						            },100);
   						            setTimeout(function(){
   						            	$this.css({"transformStyle":"preserve-3d","-webkitTransform":"rotateY(360deg)", "-webkitTransition":"all 0.6s"});
   						            },100);
   						            setTimeout(function(){
   						            	$(".prizeList .prize").not($this).addClass('block');
   						            	$(".prizeList .prize").not($this).find('.open').css({'transform':'rotateY(360deg)'});
   						            	$(".prizeList .prize").not($this).css({"transformStyle":"preserve-3d","-webkitTransform":"rotateY(360deg)", "-webkitTransition":"all 0.6s"})
   						        	},2000);
   						            $(".reload").show();
   						    	}
   					        	
   					        	tenactivitynum ();
   					        	prizeList ();
    					         return true;
    			        	 }else{
    			        		 console.log(data.msg);
    			        		 return false;
    			        	 }
    			        	 
    			         },
    			         error:function(data){
    			        	 console.log(data.msg);
    			        	 return false;
    			         }
    				});
	        	}else if(num =='2'){
	        		$(".bg").show();
	        		$(".msg p").html("分享获取更多机会！");
	    			$(".msg").show();
	        	}else{
	        		$(".bg").show();
	        		$(".msg p").html("今日翻牌机会已用完！");
	    			$(".msg").show();
	        	}
	        	
	        }else{
	        	window.location.href='/member/login';
	        }
	    });
	    /*点击重新洗牌*/
	    $(".reload").on('click',function (){
	    	window.location.reload();
	    });
	    /*点击弹出二维码*/
	    $(".investment").on('click',function(){
	    	$('.qrcode').show();
	    })
	    
	    /*二维码*/
	    var loginname = $("#loginName").val();
	    function utf16to8(str) { //解决中文乱码
			  var out, i, len, c; 
			  out = ""; 
			  len = str.length; 
			  for(i = 0; i < len; i++) { 
			  c = str.charCodeAt(i); 
			  if ((c >= 0x0001) && (c <= 0x007F)) { 
			    out += str.charAt(i); 
			  } else if (c > 0x07FF) { 
			    out += String.fromCharCode(0xE0 | ((c >> 12) & 0x0F)); 
			    out += String.fromCharCode(0x80 | ((c >> 6) & 0x3F)); 
			    out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F)); 
			  } else { 
			    out += String.fromCharCode(0xC0 | ((c >> 6) & 0x1F)); 
			    out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F)); 
			  } 
			  } 
			  return out; 
			};
			var the_text = "/rqb/active/nationalDay/nationalDay.jsp?referrer="+loginname;
			the_text = utf16to8(the_text);
			//alert(the_text);
			jQuery('.qrcodeDiv').qrcode({
				width:180,
				height:180,
				render:"canvas", //设置渲染方式 table canvas
				typeNumber : -1,  //计算模式 
				correctLevel  : 0,//纠错等级 
				foreground   : "#000000",//前景颜色 
				text:the_text
			});
			
			/*翻牌获得奖品*/
			function prizeList (){
				$.ajax({
			         url:"/lotteryAward/gettenrecordlist",
			         dataType:"json",
			         data:{
			        	 userId: userId
			         },
			         success:function(data){
			        	 if(data.success){
			        		 if(data.getlist.length){
				        		 $(".listOfWinners").show();
					        	 var str = '';
					        	 for(var i = 0; i < data.getlist.length; i++) {
					        		 str +='<div class="prizeDiv clearfix">';
						        	 str +='<div><img src="/static_3/active/nationalDay/images/'+data.getlist[i].img_url2+'"></div>';
						        	 str +='<div class="box2"><p>'+data.getlist[i].award_name+'</p></div>';
						        	 str +='<div class="box3"><p>' + data.getlist[i].date +'</p>';
						        	 if(data.getlist[i].status == '1'){
						        		 str +='<p class="exchange"><a href="/loan/loanQueryList2"></a><p>';
						        	 }else if (data.getlist[i].status == '2'){
						        		 str +='<p class="exchange end"><a href="javascript:;"></a><p>';
						        	 };
						        	 str +='</div></div>'; 
					        	 };
						         $(".listOfWinners2").html(str);
				        	 }
			        	 }
			        	 
			        	 
			         },
			         error:function(data){
			        	 console.log(data);
			         }
				});
			};
			prizeList ();
	})

