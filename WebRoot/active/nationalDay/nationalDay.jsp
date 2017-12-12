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
  <title>翻牌拿走iPhone X</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wechat2.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
  <link href="${pageContext.request.contextPath}/css/common2.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/active/nationalDay/css/nationalDay.css" rel="stylesheet">
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/active/nationalDay/js/jquery.mobile.min.js" type="text/javascript"></script>
  <script>
  
  //app分享成功后回调函数 
    var appObject = {
    		appShareSuccessCallBack:function() {
    			 window.location.reload();
            addlotterynum();
            
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
      IOSModel.changeWebTitle("翻牌拿走iPhone X ");
    }
    /*分享好友*/
    $(function(){ 
      title = "翻牌拿走iPhone X";
      content = "100%中奖，iPhone X、iPhone 8、红包…等你来翻牌";
      icon = "<%=basePath %>/images/logo/nationalDay.png";
      url  = '<%=basePath %>/active/nationalDay/nationalDay.jsp?referrer=<%=user%>';
      _url = "<%=basePath %>/active/nationalDay/nationalDay.jsp?referrer=<%=user%>";
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
    
   /*进入登录 页面 */
     function toLogin() {
          if (isAndroidOrIos()) {
              IOSModel.login();
              appFunction('login');
          } else {
              window.location.href = "<%=basePath%>/login.jsp?active=nationalDay";
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
   
  
  
   
  </script>

</head>
<body class="nationalDayBody">
  <input type="hidden" id="number" name="number" value=""/>
  <input type="hidden" value="<%=localPath%>" id="localPath">
  <input type="hidden" value="<%=basePath%>" id="basePath">
  <input type="hidden" value="<%=user%>" id="user">
  <input type="hidden" value="<%=userId %>" id="userId">
  <input type="hidden" value="<%= lotteryId %>" id="lotteryId">
  <img  alt="100%中奖" src="<%=basePath%>/active/nationalDay/image/banner.png"/>
  <p class="activeTitle">您有<span>0</span>次翻牌机会</p>
  <!-- 抽奖-->
  <section class="lotteryList">
       <div class="recordList">
             <ul class="cd-gallery">
                  <li>
                      <ul class="cd-item-wrapper">
                        <li class="move-left">
                              <div class="lotteryShow">
                                    <div class="showLottery">
                                      <img alt="" src="<%=basePath%>/active/nationalDay/image/p1.png">
                                      <p>2元现金红包</p>
                                    </div>
                              </div>      
                        </li>
                        <li class="selected">
                             <div class="lotteryShow">
                                  <div class="showLottery">
                                          <img alt="" src="<%=basePath%>/active/nationalDay/image/p10.png">
                                          <p>10元理财红包</p>
                                  </div>
                              </div>  
                        </li>
                         <li class="move-right">
                            <div class="lotteryShow">
                                <div class="showLottery">
                                        <img alt="" src="<%=basePath%>/active/nationalDay/image/p50.png">
                                        <p>50元理财红包</p>
                                </div>
                            </div>  
                        </li>
                         <li>
                            <div class="lotteryShow">
                                <div class="showLottery">
                                        <img alt="" src="<%=basePath%>/active/nationalDay/image/p100.png">
                                        <p>京东E卡100元</p>
                                </div>
                            </div>  
                        </li>
                        <li>
                            <div class="lotteryShow">
                                <div class="showLottery">
                                        <img alt="" src="<%=basePath%>/active/nationalDay/image/p200.png">
                                        <p>京东E卡200元</p>
                                </div>
                            </div>  
                        </li>
                        
                         <li>
                            <div class="lotteryShow">
                                <div class="showLottery">
                                        <img alt="" src="<%=basePath%>/active/nationalDay/image/pipad.png">
                                        <p>ipad平板</p>
                                </div>
                            </div>  
                        </li>
                        
                         <li>
                            <div class="lotteryShow">
                                <div class="showLottery">
                                        <img alt="" src="<%=basePath%>/active/nationalDay/image/p8.png">
                                        <p>iPhone 8</p>
                                </div>
                            </div>  
                        </li>
                        
                        <li>
                            <div class="lotteryShow">
                                <div class="showLottery">
                                        <img alt="" src="<%=basePath%>/active/nationalDay/image/px.png">
                                        <p>iPhone X 64G</p>
                                </div>
                            </div>  
                        </li>
                        
                          <li>
                            <div class="lotteryShow">
                                <div class="showLottery">
                                        <img alt="" src="<%=basePath%>/active/nationalDay/image/plgx.png">
                                        <p>新秀丽商务拉杆箱</p>
                                </div>
                            </div>  
                        </li>
                      </ul> <!-- cd-item-wrapper -->
                
                  </li>
              </ul> <!-- cd-gallery -->
       </div>
       <p><button class="reset">重新翻牌</button></p>
       <!-- <p class="lotteryNum">已连续翻牌<span> 2 <span>张</p> -->
  </section>
  <!-- 抽奖记录-->
  <div class="lotteryRecord">
       <p class="title2"><img  alt="100%中奖" src="<%=basePath%>/active/nationalDay/image/title2.png"/> </p>
       <div class="recordList">
            <ul id="prizeList">
                
            </ul><div class="clear"></div>
       </div>
  </div>
    <!-- 活动规则 -->
  <section class="activeBg">
     <h4>活动规则 <img  alt="100%中奖" src="<%=basePath%>/active/nationalDay/image/arrowBg.png"/></h4>
  </section>
  <!-- 分享-->
  <section class="shareBox">
     <button id="inviteBtn">分享再翻一次</button>
     <p>分享即可翻牌,翻牌越多,奖品越多,100%有奖</p>
  </section>
<div class="bg"></div>  
  <!-- 活动规则-->
 <div class="dialog activeRule">
   <div class="close_btn">×</div>
  <p>1.活动时间：10月1日-10月31日</p>
  <p>2.用户每天可翻牌一次，每分享一次增加一次翻牌机会，每日翻牌上限为5次；</p>
  <p>3.活动期间单笔投资额满足条件即可获取奖品，多笔投资可获多个奖品，如您的投资额超过标的金额请联系客服；</p>
  <p>4.翻牌成功后，用户根据所获奖品详情进行投资，投资完成后为用户自动匹配最大的奖品。已获奖品在“账户中心－奖品”中查看；</p>
  <p>5.实物奖品和京东E卡于活动结束后7个工作日内发放(平台会按投资先后顺序在官方指定平台预订采购iPhone 8和iPhone X，购买成功后7个工作日内发放)，获得实物奖品的用户请完善收货地址。15个工作日内无法联系的用户视为自动放弃奖励。若用户不需要奖品，提供8折折现；</p>
  <p>6.活动期间每笔投资发放一张提现券。如有疑问请咨询平台客服热线：400-919-8555</p>
  <p>活动最终解释权归瑞钱宝所有</p>
</div>

  <!-- 登录前-->
 <div class="dialog loginBox">
  <div class="close_btn">×</div>
   <div class="loginForm">
             <p><input type="text"  placeholder="输入手机号码" name="mobile" id="mobile"></p>
             <p id="error_info"></p>
             <p><img  alt="100%中奖" id="registerBtn" src="<%=basePath%>/active/nationalDay/image/loginBtn.png"/></p>
             <p class="goLogin" onclick="toLogin();">已有账户,<span>点击登录</span></p>
   </div> 
</div>

 <!-- 错误提示框-->
 <div class="dialog lotteryNumError">
  <div class="close_btn">×</div>
            <p id="errorInfo"></p>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/shumei/ishumei.js"></script> 
<script src="${pageContext.request.contextPath}/active/nationalDay/js/main.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/active/nationalDay/js/weixin_share.js" type="text/javascript"></script>
<script>
  //安卓
  jsb.addJavascriptMethod('appShareSuccessCallBack', function(params){

	  addlotterynum ();


    });

</script>
</body> 
</html>
