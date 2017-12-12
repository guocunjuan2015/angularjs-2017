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
  <title>投资享加息 投资后有好礼</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wechat2.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
  <link href="${pageContext.request.contextPath}/css/common2.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/active/decActive/css/decActive.css" rel="stylesheet">
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/active/decActive/js/jquery.mobile.min.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/active/decActive/js/main.js" type="text/javascript"></script>
   <script src="${pageContext.request.contextPath}/js/remChange.js" type="text/javascript"></script>
  <script>
  

    /*进入登录 页面 */
    function toLogin() {
    	  
         if (isAndroidOrIos()) {
             IOSModel.login();
             appFunction('login');
         } else {
             window.location.href = "<%=basePath%>/login.jsp?active=decActive";
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
      IOSModel.changeWebTitle("12月投资享加息 ");
    }
    /*分享好友*/
    $(function(){ 
      title = "投资享加息 投资后有好礼";
      content = "一张加息券待领取，年底了，来领一份年终奖…";
      icon = "<%=basePath %>/images/logo/decActive.png";
      url  = '<%=basePath %>/active/decActive/decActive.jsp?referrer=<%=user%>';
      _url = "<%=basePath %>/active/decActive/decActive.jsp?referrer=<%=user%>";
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
   
  
  
   
  </script>

</head>
<body class="decActiveBody">
  <input type="hidden" value="<%=localPath%>" id="localPath">
  <input type="hidden" value="<%=basePath%>" id="basePath">
  <input type="hidden" value="<%=user%>" id="user">
  <input type="hidden" value="<%=userId %>" id="userId">

  <section class="decActiveBg">
      <div class="lotteryPool">
		       <div class="redbox" id="con">
				        <ul>
				          <li class="img1"><img alt="" src="<%=basePath%>/active/decActive/image/bg.png"></li>
				          <li class="img2"><img alt="" src="<%=basePath%>/active/decActive/image/bg.png"></li>
				          <li class="img3"><img alt="" src="<%=basePath%>/active/decActive/image/bg.png"></li>
				          <li class="img4"><img alt="" src="<%=basePath%>/active/decActive/image/bg.png"></li>
				          <li class="img5"><img alt="" src="<%=basePath%>/active/decActive/image/bg.png"></li>
				          <li class="img6"><img alt="" src="<%=basePath%>/active/decActive/image/bg.png"></li>
				          <li class="img7" ><img alt="" src="<%=basePath%>/active/decActive/image/bg.png"></li>
				          <li class="img11"><img alt="" src="<%=basePath%>/active/decActive/image/5.png"></li>
				          <li class="img12"><img alt="" src="<%=basePath%>/active/decActive/image/10.png"></li>
				          <li class="img13"><img alt="" src="<%=basePath%>/active/decActive/image/20.png"></li>
				          <li class="img14"><img alt="" src="<%=basePath%>/active/decActive/image/50.png"></li>
				          <li class="img15"><img alt="" src="<%=basePath%>/active/decActive/image/100.png"></li>
				          <li class="img16"><img alt="" src="<%=basePath%>/active/decActive/image/500.png"></li>
				        </ul>
		      </div>
		      <div class="decActiveBtn">
		            <a href="javascript:;"></a>  
		      </div> 
		      <div class="opportunity">
               <p>您有<span id="num"> </span>抽奖机会</p>
          </div>
          <div class="arrow">
          
              
            
          </div>    
      </div>
      <div class="couponList">
                
                <ul class="cd-gallery">
                  <li>
                      <ul class="cd-item-wrapper">
                        
                      </ul> <!-- cd-item-wrapper -->
                
                  </li>
              </ul> 
           
           </div>
  </section>
 
  <section class="activeRule" style="margin-top:3.2rem;">
     <h4>加息券说明： </h4>
     <p>1、用户每天可领取每种加息券各一次，所获加息券自领取之日3日内有效；</p>
		 <p>2、除债转项目外，其它项目均不限制加息券的使用；</p>
		 <p>3、用户领到的加息券请到“账户中心－我的礼物－加息券”中查看。</p>
  </section>
  <section class="activeRule">
     <h4>红包使用说明： </h4>
     <p>1、每个项目投资≥1000可享一次抽奖机会，新手标、小额贷及债转项目除外。</p>
     <p>2、除债转项目外，其它项目均不限制加息券的使用；</p>
     <p>3、抽奖机会投资后发放，活动期间均有机会抽奖，奖品中的红包为投资返现红包，红包自领取之日30天内有效。</p>
  </section>
  <section class="activeRule">
     <h4>活动说明 </h4>
     <p>1、活动时间：12月4日-12月28日；</p>
     <p>2、如有疑问请拨打瑞钱宝官方客服热线400-919-8555（工作日9：00-18：00）</p>
  </section>
	<section class="copyRight">
	 <p>如有疑问请拨打瑞钱宝官方客服热线</p>
	 <p>400-919-8555（工作日9:00-18:00）</p>
	 <p>活动最终解释权归瑞钱宝所有</p>
	</section>
<div class="bg"></div> 
  <!-- 抽奖成功-->
 <div class="dialog lotterySuccess">
    <div class="close_btn">×</div>
    <h4>恭喜您获得</h4>
    <h5></h5>
    <p class="p_invest"></p>
    <p class="p_term"></p>
    <p class="goUse" onclick="toProject();"><button>马上使用</button></p>
</div> 
  <!-- 抽奖失败-->
 <div class="dialog lotteryFailed">
    <div class="close_btn">×</div>
    <p>对不起,您还没有进行投资呐～</p>
    <p>需单笔投资≥1000元，可获得抽奖机会吆～</p>
    <p class="goUse" onclick="toProject();"><button>马上投资</button></p>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
<script src="${pageContext.request.contextPath}/active/nationalDay/js/weixin_share.js" type="text/javascript"></script>
</body> 
</html>
