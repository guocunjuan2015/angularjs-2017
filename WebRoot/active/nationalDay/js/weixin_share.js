//分享成功添加抽奖机会
function shareSuccess(){
	var  userId = $("#userId").val();
	var  loginName = $("#user").val();
	var  localPath = $("#localPath").val();

	$.ajax({
        url:localPath + '/lotteryAward/addlotterynum',
        type:'POST',
        dataType:'json',
        data:{
            userId:userId,
            loginName:loginName
        },
        success:function(data){
          
        }
      
    })
	
	
}
/**公众号分享，传入标题，内容，图片，链接，以及baseUrl（测试还是正式）*/
function weixinShare(title,content,img,link,localPath){
	  var mytitle = title; 
	  var mydesc =  content;
      var myimgUrl = img; // 200*200大小
      //alert(location.href.split('from=')[0]);encodeURIComponent(
      var mylink = window.location.href;//当前网页的全部内容（包括参数）link.split('#')[0]
      $.getJSON(localPath + '/weixin/getSignature.do',  { url:mylink},  function(response){
              if(response.success){
                  var info = $.parseJSON(response.result);
                  //console.log(info);
				      wx.config({
				          debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
				          appId: info.appId, // 必填，公众号的唯一标识
				          timestamp: info.timestamp, // 必填，生成签名的时间戳
				          nonceStr: info.nonceStr, // 必填，生成签名的随机串
				          signature: info.signature,// 必填，签名，见附录1
				          jsApiList: ['onMenuShareTimeline','onMenuShareAppMessage','onMenuShareQQ','onMenuShareWeibo'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
				      });
				      wx.ready(function(){
				          wx.error(function(res){
				              // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
				        	  //alert('wx.error: '+ JSON.stringify(res));
				          });
				          
				           wx.checkJsApi({
				               jsApiList: [
				                   'onMenuShareTimeline',
				               ]
				           }); 
				
				          // 分享到朋友圈   
				          wx.onMenuShareTimeline({
				              title: mytitle, // 分享标题
				              link: info.url, // 分享链接
				              imgUrl: myimgUrl, // 分享图标
				              success: function () { 
				                  // 用户确认分享后执行的回调函数
				                 //alert('成功' + "0000");
				            	  shareSuccess();//分享成功添加一次抽奖机会
				              },
				              cancel: function () { 
				                  // 用户取消分享后执行的回调函数
				                  alert('取消');
				              }
				          });
				          //分享给朋友
				          wx.onMenuShareAppMessage({
				              title: mytitle, // 分享标题
				              desc: mydesc, // 分享描述
				              link: info.url, // 分享链接
				              imgUrl: myimgUrl, // 分享图标
				              type: '', // 分享类型,music、video或link，不填默认为link
				              dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
				              success: function () { 
				                  // 用户确认分享后执行的回调函数
				            	  //alert('成功' + "1111");
				            	  shareSuccess();//分享成功添加一次抽奖机会
				              },
				              cancel: function () { 
				                  // 用户取消分享后执行的回调函数
				            	//alert('cancel000');
				              }
				          });
				          
				          // 分享到QQ
				          wx.onMenuShareQQ({
				              title: mytitle, // 分享标题
				              desc: mydesc, // 分享描述
				              link: info.url,  // 分享链接
				              imgUrl: myimgUrl, // 分享图标
				              success: function () { 
				                 // 用户确认分享后执行的回调函数
				            	  shareSuccess();//分享成功添加一次抽奖机会
				              },
				              cancel: function () { 
				                 // 用户取消分享后执行的回调函数
				              }
				          }); 
				          // 分享到腾讯微博
				          wx.onMenuShareWeibo({
				              title: mytitle, // 分享标题
				              desc: mydesc, // 分享描述
				              link: info.url, // 分享链接
				              imgUrl: myimgUrl, // 分享图标
				              success: function () { 
				                 // 用户确认分享后执行的回调函数
				            	  shareSuccess();//分享成功添加一次抽奖机会
				              },
				              cancel: function () { 
				                  // 用户取消分享后执行的回调函数
				              }
				          });
				          
				      });
              }
          }
      );
}