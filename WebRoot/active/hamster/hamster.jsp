<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="UTF-8"%>
<%@ include file="/config/config.jsp" %>
<%@ include file="/config/show_share.jsp" %>
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

String phone = request.getParameter("phone");
String lotteryId = request.getParameter("lotteryId");
String number = request.getParameter("number");
%>  
<!DOCTYPE html>
<html style="font-size:62.5%;">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
  <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
  <title>项目top1有奖 满标者有礼</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wechat2.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
  <link href="${pageContext.request.contextPath}/css/common2.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/active/hamster/css/hamster.css" rel="stylesheet">
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/remChange.js" type="text/javascript"></script>
  <script>
  

    /*进入登录 页面 */
    function toLogin() {
    	  
         if (isAndroidOrIos()) {
             IOSModel.login();
             appFunction('login');
         } else {
             window.location.href = "<%=basePath%>/login.jsp?active=hamster";
         }
   }
    
    //增加抽奖机会
    function addlotterynum(){
        $.ajax({
              url:'<%=localPath %>/lotteryAward/addlotterynum',
              type:'POST',
              dataType:'json',
              data:{
                  userId:'<%=userId %>',
                  loginName:'<%=user %>'
              },
              success:function(data){
            	
            	  window.location.reload();
                  
              }
            
          })
    
    }
    /*标题 */
    function showShare(){
      IOSModel.changeWebTitle("项目top1有奖 满标者有礼 ");
    }
    /*分享好友*/
    $(function(){ 
      title = "项目top1有奖 满标者有礼";
      content = "项目top1有奖 满标者有礼";
      icon = "<%=basePath %>/images/logo/hamster.png";
      url  = '<%=basePath %>/active/hamster/hamster.jsp?referrer=<%=user%>';
      _url = "<%=basePath %>/active/hamster/hamster.jsp?referrer=<%=user%>";
         // getReferenceRank();
         weixinShare(title,content,icon,url,'<%=basePath%>');
          
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
                   shareUrl=shareUrl;
                   url=shareUrl;
               }
        }
        var uu = '<%=userApp%>';
        if(!uu){
          showAys3("您还没有登录，需要登录后才可以分享，现在去登录？");
        } else { 
          if (isAndroidOrIos()) {
                 
                  IOSModel.shareGetDifferentAward({
                      "url" : shareUrl,
                      "title" : title,
                      "content" : content,
                      "icon" : icon
                  });
                  iosShare(title, content, icon, shareUrl);
                  appFunction('shareGetDifferentAward');

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
      if("<%=userApp %>" != null && "<%=userApp %>" != "" && "<%=userApp %>" != "null"){
        shareUrl=url;
        }
      IOSModel.noticeShare({
          "url" : shareUrl,
          "title" : title,
          "content" : content,
          "icon" : icon
        });
    };
    
    //隐藏分享   
    function dismissAys3(){
        $("#bg")[0].style.display = "none";
        $("#ays3")[0].style.display = "none";
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
   
 /*   //我的礼物 
    function toMygift() {
        if (isAndroidOrIos()) {
         IOSModel.investFinishToMyGift();
         appFunction('investFinishToMyGift');
       }
     } */
  
   
  </script>

</head>
<body class="hamsterBody">
  <input type="hidden" value="<%=localPath%>" id="localPath">
  <input type="hidden" value="<%=basePath%>" id="basePath">
  <input type="hidden" value="<%=user%>" id="user">
  <input type="hidden" value="<%=userId %>" id="userId">

  <section class="hamsterBg">
     <div class="hamster1"></div>
     <p class="hamsterGiftBtn"><button type="button" onclick="toMygift();"></button></p>
     <div class="hamster_box">
          <div class="hammer"></div>
          <div class="hamsterNum1" onclick="showAsy(1);">
               <div>
                    <h4>20<span>元</span></h4>
                    <p>期限(≥360天)</p>
               </div> 
          </div>
          <div class="hamsterNumBox2">
		          <div class="hamsterNum2" onclick="showAsy(2);">
		               <div>
		                    <h4>100<span>元</span></h4>
		                    <p>期限(≥90天)</p>
		               </div> 
		          </div>
		          <div class="hamsterNum3" onclick="showAsy(3);">
		               <div>
		                    <h4>20<span>元</span></h4>
		                    <p>期限(≥90天)</p>
		               </div> 
		          </div>
          </div>
          
          <div class="hamsterNumBox3">
              <div class="hamsterNum4" onclick="showAsy(4);">
                   <div>
                        <h4>20<span>元</span></h4>
                        <p>期限(≥30天)</p>
                   </div> 
              </div>
              <div class="hamsterNum5" onclick="showAsy(5);">
                   <div>
                        <h4>35<span>元</span></h4>
                        <p>期限(≥30天)</p>
                   </div> 
              </div>
          </div>
          
          <div class="hamsterNum6" onclick="showAsy(6);">
               <div>
                    <h4>400<span>元</span></h4>
                    <p>期限(≥360天)</p>
               </div> 
          </div>
          
     
     </div>
  </section>
 
  <section class="activeRule">
     <h4>活动说明： </h4>
     <p><span>1</span>活动时间：2017年12月7日-2018年2月28日；</p>
		 <p><span>2</span>消费金融债转项目不参与满标有奖；</p>
		 <p><span>3</span>红包奖励在投资成功后一个工作日内发放，红包有效期为30天；</p>
		 <p><span>4</span>大额投资红包和满标红包可共享。</p>
  </section>
	<section class="copyRight">
	 <p>本活动最终解释权归瑞钱宝所有</p>
	</section>
<div class="bg"></div> 
  <!-- 抽奖成功-->
 <div class="dialog pop1">
    <div class="close_btn">×</div>
    <p><button type="button" onclick="toProject();"></button></p>
</div> 
 <div class="dialog pop2">
    <div class="close_btn">×</div>
    <p><button type="button" onclick="toProject();"></button></p>
</div> 
 <div class="dialog pop3">
    <div class="close_btn">×</div>
    <p><button type="button" onclick=" toProject();"></button></p>
</div>
<div class="dialog pop4">
    <div class="close_btn">×</div>
    <p><button type="button" onclick="toProject();"></button></p>
</div>
<div class="dialog pop5">
    <div class="close_btn">×</div>
    <p><button type="button" onclick="toProject();"></button></p>
</div>
<div class="dialog pop6">
    <div class="close_btn">×</div>
    <p><button type="button" onclick="toProject();"></button></p>
</div>
  <!-- 抽奖失败-->
 <div class="dialog lotteryFailed">
    <div class="close_btn">×</div>
    <p>对不起,您还没有进行投资呐～</p>
    <p>需单笔投资≥1000元，可获得抽奖机会吆～</p>
    <p class="goUse" onclick="toProject();"><button>马上投资</button></p>
</div>

  <!-- 抽奖失败-->
 <div class="dialog myGift" style="left:1.15rem !important;">
    <div class="lotteryList">
		      <ul>
		      </ul>
		      <div class="noGift">
				      <h4>暂无记录</h4>
				      <p>投资即有机会获得红包奖励!</p>
				      <p class="goUse" onclick="toProject();"><button></button></p>
		      </div>
    </div>  
</div>
<script>
		var  userId = $("#userId").val();
		var  loginName = $("#user").val();
		var  localPath = $("#localPath").val();
		var  basePath = $("#basePath").val();
		initMyGiftList(); //初始化礼品列表 
		$(function(){
			
			 //判断用户是否登录
        if ((userId == "" || userId == null || userId == "null") && (loginName == "" || loginName == null || loginName == "null")){
        	     
        	     $(".hamster_box").css("margin-top","2.2rem");
        	     $(".hamsterBg").css("height","21.8rem");
               $(".hamsterGiftBtn").hide();
        } else {
        	
        	     $(".hamsterGiftBtn").show();
        }
		    //关闭遮罩层
		    $(".close_btn").click(function(){
		    	
				    	$(".hamster_box div").removeClass("replaceImg");
				    	$(".hammer").show();
				      $(".hamster_box h4").show();
				      $(".hamster_box p").show();
				      $(".bg").hide();
				      $(".dialog").hide();
		      
		    })
		    
		    //关闭遮罩层
        $(".myGift").click(function(){
          $(".bg").hide();
          $(".dialog").hide();
          
        })
		})
		
		//初始化礼物列表 
		function initMyGiftList(){
			   
					$.ajax({
						  url:localPath + '/lotteryAward/activityCouponList ',
						  type:'post',
						  data:{
							  userId: userId,
							  loginName: loginName
						  },
							success:function(data){
								if(data.success){
									  var info = data.result;
									  var str ='';
									  if(info !=null && info.length > 0){
										  
										  for(var obj in info){
											  
												      if(info[obj].type == "1"){ //type的等于1满标奖励  type的等于2大额投资奖励  
											    	         if(info[obj].period =="30"){
		                                                  
						                               str += '<li class="coupon20" onclick="toProject();"></li>'; 
						                                   
						                         } else if (info[obj].period =="90"){
						                                                        
						                               str += '<li class="coupon20_90" onclick="toProject();"></li>'; 
						                         } else if (info[obj].period =="360"){
						                                                            
						                               str += '<li class="coupon20_360" onclick="toProject();"></li>'; 
						                         }  
				                                
				                    } else {
												    	  
														    	  if(info[obj].period =="30"){
								                                      
								                         str += '<li class="coupon35" onclick="toProject();"></li>'; 
								                       
								                     } else if (info[obj].period =="90"){
								                                            
								                           str += '<li class="coupon100" onclick="toProject();"></li>'; 
								                     } else if (info[obj].period =="360"){
								                                                
								                           str += '<li class="coupon400" onclick="toProject();"></li>'; 
								                     } 
												    	  
												   }
											     
											  
									    }
										  $(".lotteryList ul").html(str);
										  $(".bg").show();
										  $(".myGift").show();
										  /* $(".hamster_box").css("margin-top","3rem"); */
										  $(".hamsterGiftBtn").show();
									  } else { 
										  $(".bg").show();
										  $(".myGift").show();
										  $(".noGift").show();
										  $(".hamsterGiftBtn").show();
										 
										  
									  }
									
								} 
							
							}
					
					})
		}
	
		
		function showAsy(num){
			 //判断用户是否登录
	    if ((userId == "" || userId == null || userId == "null") && (loginName == "" || loginName == null || loginName == "null")){
	          
	           toLogin();//去登陆 
	           return;
	   }
		  $(".hamsterNum"+num).addClass("replaceImg");
		  $(".hamsterNum"+num).find("h4").hide();
		  $(".hamsterNum"+num).find("p").hide();
		  $(".bg").show();
		  $(".pop"+num).show();
		  $(".hammer").hide();
		}
		
		//我的礼物 
		function toMygift(){
			 
		     $(".bg").show();
		     $(".myGift").show();
		}
		
		

</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
<script src="${pageContext.request.contextPath}/active/nationalDay/js/weixin_share.js" type="text/javascript"></script>
</body> 
</html>
