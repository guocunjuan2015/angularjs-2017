<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*,java.net.URLDecoder"
    pageEncoding="UTF-8"%>
<%@ include file="/config/config.jsp" %>
<%
HttpSession hs = request.getSession();
    String user = "";//用户名
    String userId = "";//用户userId
    String userHex = "";//hex编码的用户名，分享出去用到，app转进来需要解码
  String from = request.getParameter("from");
    if (from == null || !("app".equals(from))) {
        from = "";
    }
    System.out.println("aft:" + from);
    String referHex = request.getParameter("referrer");//获得的推荐人是Hex编码
    String refer = "";
    if (referHex == null) {
        refer = "";
    } else { 
        System.out.println("referHex:" + referHex);
        //refer需要Hex解码
//         if (referHex != null) {
//         byte[] bs = Hex.decodeHex(referHex.toCharArray());
//         refer = new String(bs);
    }
    String userApp = request.getParameter("user");
    if (from != null && "app".equals(from) && userApp != null
      && userApp != "") {
        user = userApp;
        hs.setAttribute("loginUser", user);
        //app上无分享功能
    } else if (hs != null) {
        user = (String) hs.getAttribute("loginUser");
        if (user == null) {
            user = "";
        }
        if (user != null && user != "") {
              userHex = Hex.encodeHexString(user.getBytes());//将用户Hex编码，用于分享
        } else {
            userHex = "";
        }
    }
      String userAppId = request.getParameter("userId");
    if (from != null && "app".equals(from) && userId != null
      && userId != "") {
        userId = userAppId;
        hs.setAttribute("userId", userId);
        //app上无分享功能
    } else if (hs != null) {
        userId = (String) hs.getAttribute("userId");
        if (userId == null) {
            userId = "";
        }
    }

    String utm_source = request.getParameter("utm_source");//渠道
%> 

<script>
  var _url = "";
</script>
<!DOCTYPE html>
<html lang="en" style="font-size:10px;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
  <meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
  <meta name="description" content="瑞钱宝互联网金融平台投资越多惊喜越多,年收化率7%-13.5%，" />
  <title>你嗨购我买单</title>
  <link href="${pageContext.request.contextPath}/css/common2.css" rel="stylesheet"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/active/custodyOperation/css/swiper.min.css"> 
  <link href="${pageContext.request.contextPath}/active/highPurchase/css/highPurchase.css" rel="stylesheet">
  <script src="${pageContext.request.contextPath}/js/jquery-1.11.2.min.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
<script> 
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
        language : (navigator.browserLanguage || navigator.language)
            .toLowerCase()
      }
      if (browser.versions.android == true) {
        $('#downs').attr('href','http://file.rqbao.com/android/latest/ruiqianbao_ditui_red.apk');
      }
      if (browser.versions.ios == true) {
         $('#downs').attr('href','http://a.app.qq.com/o/simple.jsp?pkgname=com.dyxd.rqt&g_f=991653');
      }
      else{
        $("#downs").attr('href','http://file.rqbao.com/android/latest/ruiqianbao_ditui_red.apk');
      };
      
  })
    /*标题 */
    function showShare(){
        IOSModel.changeWebTitle("你嗨购我买单");
      }
    $(function(){
        title = "你嗨购我买单";
        content = "你的千元红包和京东E卡等待领取，参与活动…";
      icon = "<%=basePath %>/images/logo/highPurchase.png";
      url  = "<%=basePath %>/active/highPurchase/highPurchase.jsp?from=app&utm_source=<%=utm_source %>";
      _url = "<%=basePath %>/active/highPurchase/highPurchase.jsp?from=app&utm_source=<%=utm_source %>";
       // getReferenceRank();
      /*分享好友*/
        weixinShare(title,content,icon,_url,'<%=basePath%>');
        
        if("<%=userApp %>" != null && 
            "<%=userApp%>" != "" && 
            "<%=userApp%>" != "null") {
        }
        
    });
  
    /*分享 */
      function shareClick() {
       var shareUrl=url;
         if("<%=userApp %>" != null && 
              "<%=userApp %>" != "" && 
              "<%=userApp %>" != "null"){
               if(shareUrl.indexOf("&referrer")>=0)
               {
               }
               else
               {
               shareUrl=shareUrl+"&referrer="+$("#m").val();
               url=shareUrl;
               }
        }
        var uu = '<%=userApp%>';
        if(!uu){
          showAys3("您还没有登录，需要登录后才可以分享，现在去登录？");
        }else{ 
          if (isAndroidOrIos()) {
                  IOSModel.noticeShare({
                      "url" : shareUrl,
                      "title" : title,
                      "content" : content,
                      "icon" : icon
                  });
                  iosShare(title, content, icon, shareUrl);
                  appFunction('share');
              } else {
                weixinShare(title,content,icon,_url,'<%=basePath%>');
                 showShareBox();
              }
        }
      }
        function showShare() {
          IOSModel.showShareBtn();
        }
        
        function shareWithType() {
          var shareUrl=url;
          if("<%=userApp %>" != null && 
            "<%=userApp %>" != "" && 
            "<%=userApp %>" != "null"){
              shareUrl=url+"&referrer="+$("#m").val();
              
            }
          IOSModel.noticeShare({
            "url" : shareUrl,
            "title" : title,
            "content" : content,
            "icon" : icon
          });
        }
    </script>
</head>
<body class="highPurchaseBody">
<input type="hidden" id="utm_source" value="<%=utm_source %>">
<input type="hidden" value=" <%=localPath%>" id="localPath">
<input type="hidden" value="<%=basePath%>" id="basePath">
<input type="hidden" value="<%=user%>" id="user">
<input type="hidden" value="<%=userId %>" id="userId">
      <section>
          <img alt="banner" src="images/acticeBanner.png">
      </<section>
      <img alt="banner" class="title1"  src="images/title1.png">
      <div class="couponContainer">
            <ul>
                <li>
                    <p>输入投资金额</p>
                    <input type="text" placeholder="请输入100的整数倍" id="investAmount" name="investAmount"/>
                </li>
                
                <li>
                    <p>选择投资周期</p>
                    <select id="period">
                          <option value="30" selected="selected">30天</option>
                          <option value="90">90天</option>
                          <option value="360">360天</option>
                    </select>
                </li>
            
            </ul><div class="clear"></div>
            <p class="errInfo"></p> 
            <p class="addCouponZone"><button type="button" id="addCoupon">生成优惠券</button><span onclick="openCoupon();">?</span></p> 
       
      </div>
      <!-- 马上使用 -->
      <div class="couponList">
          <ul class="clear" id="addCouponList">
             
          
          </ul>     
      </div>
       <!-- 京东卡待领取-->
      <div class="receive">
	       <img alt="banner" class="title2"  src="images/title2.png">  
	       <p class="receiveBtn" ><a href="javascript:;" onclick="receiveBtn();">领卡攻略</a></p>
          <div class="receiveBorder">
					      <!--  <div class="swiper-container">
							          
										        <div class="swiper-wrapper">
										                 
										        </div>
								 </div>		        
								        <div class="swiper-button-next swiper-button-white"></div>
                        <div class="swiper-button-prev swiper-button-white"></div>  -->
                        <div class="rotation">
                        
                        </div>
 
					         
          </div>
      
      <!-- 活动规则-->
       <img alt="banner" class="title1"  src="images/title3.png">
       <div  class="activeRule"> 
        <p>1、活动时间：11月3日10:00-11月30日17:00；</p>
        <p>2、用户每天可领取2次优惠券，所获优惠券自领取之日3日内有效；</p>
        <p>3、每笔投资满足条件即可领取一张京东卡，请查看领卡攻略；</p>
        <p>4、京东卡奖励与其他加息项目不共享，京东卡可8折折现；如需帮助请拨打瑞钱宝官方客服热线400-919-8555（工作日9:00-18:00）。</p>
      </div>
  </section> 
  <%--弹出框 --%>
<div class="bg"></div>
<!-- 可以领取-->
 <div class="dialog raiders-dialog">
        <div class="close_btn">×</div>
        <h4>*投资完成后回到本页即可领取京东卡</h4>
        <table class="raiders">
          <tr class="raiders-frist">
              <td>投资额(元)</td>
              <td>投资周期</td>
              <td>京东卡</td>
          </tr>
          <tr>
              
              <td>≥30000</td>
              <td>360</td>
              <td>600</td>
          </tr>
          
           <tr>
              <td>≥30000</td>
              <td>180</td>
              <td>300</td>
          </tr>
           <tr>
              
              <td>≥30000</td>
              <td>90</td>
              <td>150</td>
          </tr>
          
          <tr>
              <td>10000(含)-30000</td>
              <td>360</td>
              <td>200</td>
          </tr>
           <tr>
              
              <td>10000(含)-30000</td>
              <td>180</td>
              <td>100</td>
          </tr>
          
          <tr>
              
              <td>5000(含)-10000</td>
              <td>360</td>
              <td>100</td>
          </tr>
        
        </table>
  
</div>
 
 
 <!-- 生成优惠券-->
 <div class="dialog  getCoupons-dialog">
        <div class="close_btn">×</div>
        
        <table class="raiders">
		        <tr class="raiders-frist">
		              <td>输入金额(元)</td>
		              <td>选择周期(天)</td>
		              <td>红包(元)</td>
		              <td>加息劵(%)</td>
		          </tr>
		          <tr>
		              <td><1000</td>
		              <td>30</td>
		              <td>0</td>
		              <td>1.8</td>
		          </th>
		          <tr>
		              
		              <td><1000</td>
		              <td>90</td>
		              <td>0</td>
		              <td>1.8</td>
		          </tr>
		          
		           <tr>
		              
		              <td><1000</td>
		              <td>360</td>
		              <td>0</td>
		              <td>2.2</td>
		          </tr>
		          <tr>
		              
		              <td><5000</td>
		              <td>30</td>
		              <td>2</td>
		              <td>1.8</td>
		          </tr>
		          <tr>
		              <td><5000</td>
		              <td>90</td>
		              <td>6</td>
		              <td>1.8</td>
		          </tr>
		          <tr>
		              <td><5000</td>
		              <td>360</td>
		              <td>25</td>
		              <td>2.2</td>
		          </tr>
		          <tr>
		              <td><10000</td>
		              <td>30</td>
		              <td>10</td>
		              <td>1.8</td>
		          </tr>
		          <tr>
		              <td><10000</td>
		              <td>90</td>
		              <td>31</td>
		              <td>1.8</td>
		          </tr>
		          <tr>
		              <td><10000</td>
		              <td>360</td>
		              <td>125</td>
		              <td>2.2</td>
		          </tr>
		          <tr>
		              <td><30000</td>
		              <td>30</td>
		              <td>21</td>
		              <td>1.8</td>
		          </tr>
		           <tr>
		              <td><30000</td>
		              <td>90</td>
		              <td>63</td>
		              <td>1.8</td>
		          </tr>
		          <tr>
		              <td><30000</td>
		              <td>360</td>
		              <td>250</td>
		              <td>2.2</td>
		          </tr>
		          <tr>
		              <td>≥30000</td>
		              <td>30</td>
		              <td>63</td>
		              <td>1.8</td>
		          </tr>
		           <tr>
		              <td>≥30000</td>
		              <td>90</td>
		              <td>188</td>
		              <td>1.8</td>
		          </tr>
		          <tr>
		              <td>≥30000</td>
		              <td>360</td>
		              <td>750</td>
		              <td>2.2</td>
		          </tr>
        
        </table>
  
</div>
  <script src="<%=basePath%>/js/swiper.min.js"></script>
<script type="text/javascript">

  var utm_source=$("#utm_source").val();
  var userId = $("#userId").val();
  var loginName = $("#user").val();   
	//是否有机会领取
	isLotteryChance();
		//待领卡 
	isGetCoupon();
	  /*图片轮播效果 */
	function startPlay(){
	      var swiper = new Swiper('.swiper-container', {
	             pagination: '.swiper-pagination',
	             paginationClickable: '.swiper-pagination',
	             nextButton: '.swiper-button-next',
	             prevButton: '.swiper-button-prev',
	             spaceBetween: 30
	         }); 
	 
	 }
	//获取京东卡
	function isGetCoupon(){
	
		    	$.ajax({
	                 url:'<%=localPath%>/lotteryAward/receivedAwardName',
	                 type:'POST',
	                 data:{
	                   userId : userId,
	                   loginName : loginName
	                 },
	                 dataType:'json',
	                 success:function(data){
	                	 if(data.resultList != null && data.resultList.length > 0){
	                		   $(".receiveBorder").removeClass("unReceive");
	                		   var str = '<div class="swiper-container">';
	                       str +='<div class="swiper-wrapper">';
	                		   $.each(data.resultList,function(obj,_data){
	                			    str += '<div class="swiper-slide"> <div>';
	                			    if(_data.isdiscount == 2 ){
			                			    	 if(_data.img_url == "" || _data.img_url == undefined ){
			                			    		
			                			    		  str += '<img  class="resetGray" src="<%=basePath%>/active/highPurchase/images/jd.png">';
			                			    		
			                			    	 } else {
			                			    		
			                			    		  str += '<img  class="resetGray" src="'+ _data.img_url +'">';
			                			    	 
			                			    	 }
	                			    } else {
	                			    	     
	                			    	     str += '<img   src="'+ _data.img_url +'">'; 
	                			    }
	                			   
	                			    str += '</div></div>';

	                		   });
	                		   str += '</div>';
	                		   str += '<div class="swiper-button-prev"></div><div class="swiper-button-next"></div></div>';
	                		   str += '<p class="goGift">请在<a href="javascript:;" onclick="goMyGift();">我的礼物</a>中查看</p>';
	                		   if(data.count == 0 ){
	                			   
	                			   str += ' <p class="addCouponZone clickReceive"><button type="button" id="clickReceive">已领取</button></p> ';   
	                       
	                		   } else {
	                    	   
	                			   str += ' <p class="addCouponZone"><button type="button" onclick="receiveGift();">一键领取('+data.count+')</button></p> ';     
	                       }
	                		  
	                       $(".rotation").html(str);
	                       startPlay();
	                		   
	                	 } else {
	                		 
	                	   $(".receiveBorder").addClass("unReceive");
	                	 }
	                     
	                   
	                 },
	        })
		    	
		    
		
		}
	  //是否有抽奖机会 
		function isLotteryChance(){
			 
			 $.ajax({
                 url:'<%=localPath%>/lotteryAward/elevenActivityNum',
                 type:'get',
                 data:{
                   userId : userId,
                   loginName : loginName
                 },
                 dataType:'json',
                 success:function(data){
                	 //console.log(data);
                	  if(data.success){
                		    
			                	  if(data.num.lotteryNumber2 > 0){
			                		  
			                		  $(".errInfo").html("您还有 <span>"+ data.num.lotteryNumber2 +"</span>次抽奖机会 ");
			                      $(".errInfo").css("color","#666");
			                	  
			                	  } else  {
			                		  $(".errInfo").text("今日机会已用完,请明日再来");
			                		  $(".errInfo").css("color","#F3441B");
			                	  } 
                	  }  else {
                		        $(".errInfo").text("今日机会已用完,请明日再来");
                		        $(".errInfo").css("color","#F3441B");
                	  }
                   
                 },
                 error:function(data){
                     //alert(data.msg);
                }

        })
			
		}
		

		/*一键领取京东卡*/
		   function receiveGift (){
		     $.ajax({
		       url:'<%=localPath%>/lotteryAward/receivedMoOrCo',
		       type:'POST',
		        data:{
                   userId : userId,
                   loginName : loginName
             },
		          success:function(data){
		        	  isGetCoupon ();
		          },
		          error:function(data){
		            alert(data.msg);
		          }
		     })
		   };
    
    $(function(){ 
    	
	    	//生成优惠券
	    	$("#addCoupon").click(function(){
		    		 var investAmount = Number($("#investAmount").val());
		    		  
		    		  $('.couponContainer select').find('option:selected').attr('selected', 'selected');
		    		  var periodRange = $(".couponContainer select").val();
		    		  if ((userId == "" || userId == null || userId == "null") && (loginName == "" || loginName == null || loginName == "null")){
		    			
		    			  toLogin(); 
		    			  return;   
		
		          }
		    		  if(investAmount == "null" || investAmount == null || investAmount == ""){
		    		      $(".errInfo").text("请输入正确的投资金额");
		    		      $(".errInfo").css("margin-bottom","1rem");
		    		      $(".addCouponZone").css("margin-top","0");
		    		      $(".errInfo").css("color","#F3441B");
		    		      return;
		    		    } else if (investAmount%100!= 0){
		    		    	
		    		      $(".errInfo").text("请输入100的整数倍 ");
		    		      $(".errInfo").css("color","#F3441B");
		    		     
		    		      return;
		    		    
		    		    } else {
		    		       
		    		    	$.ajax({
		                        url:'<%=localPath%>/lotteryAward/elevenActivity',
		                        type:'POST',
		                        data:{
		                          userId : userId,
		                          loginName : loginName,
		                          investAmount :investAmount,
		                          periodRange : periodRange
		                          
		                        },
		                        dataType:'json',
		                        success:function(data){
		                        	  var str = '';
		                        	  
		                        	  if(data.success){
		                        		  
		                                  if(data.list != null && data.list.length > 0){
		                                      
		                                      $.each(data.list,function(obj,_data){
		                                    	    str += "<li>"
		                                          str += ' <div>';
		                                          if(_data.status == "1" ){
		                                        	  
		                                        	  str += '<p class="couponNum"><span>￥</span>'+ _data.award_name +'</p>'; 
		                                        	  str += ' <p class="couponInfo">红包</p>';
		                                        	  
		                                          } else {
		                                        	  
		                                        	  str += '<p class="couponNum">'+ _data.award_name  +'<span>%</span></p>'; 
                                                str += ' <p class="couponInfo">加息券 </p>';
		                                          
		                                          }
		                                          
		                                          str += '</div>';
		                                          str += ' <p><button type="button"   onclick="toProject();" class="useBtn">马上使用</button></p>';
		                                          str += '</li>';
		                                       })
		                                       
		                                     
		                                   }    
		                                  $("#addCouponList").html(str);  
		                                  isLotteryChance();
		                        	   }  else {
		                        		   
		                        		   alert(data.msg);
		                        	   }
		                        
		                      } 
		                        
		                     })
					                  
					    		  $(".errInfo").text("");
					    	}   
	    	})
    })
	  /*进入登录 页面 */
	  function toLogin() {
	      if (isAndroidOrIos()) {
	          IOSModel.login();
	          appFunction('login');
	      } else {
	          window.location.href = "<%=basePath%>/login.jsp?active=jdBring";
	      }
	  }
   /*进入我的理财页面 */
    function toProject() {
      if (isAndroidOrIos()) {
        IOSModel.toIosInvest();
        toIosInvest();
        appFunction('invest');
      } else {
        window.location.href = "<%=basePath%>/project.jsp";
      }
    }
   
   //去我的礼物
   function goMyGift(){
	   
	   if (isAndroidOrIos()) {
           IOSModel.investFinishToMyGift();
           appFunction('investFinishToMyGift');
         } else { 
           window.location.href ="<%=basePath %>/sys/user/award/myGift.jsp?userId=" + userId + "#/voucher";
     }
   
   
   }
   
    /*点击活动规则   */
    function receiveBtn(){
      $(".bg").show();
      $(".raiders-dialog").show();
    }
    
    
    /*点击活动规则   */
    function openCoupon(){
      $(".bg").show();
      $(".getCoupons-dialog").show();
    }
    
  //关闭遮罩层
    $(".close_btn").click(function(){
       $(".dialog").hide();
       $(".bg").hide();
    })
   

</script> 

  
</body>
</html>
