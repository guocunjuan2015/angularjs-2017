      <%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="UTF-8"%>
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
    String referrer = request.getParameter("referrer");//获得的推荐人是Hex编码
/*     String referrer = "";
    if (referHex == null) {
      referrer = "";
    } else {
        //refer需要Hex解码
        if (referHex != null) {
            byte[] bs = Hex.decodeHex(referHex.toCharArray());
            referrer = new String(bs);
        }
    } */
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
    String utm_source = request.getParameter("utm_source");//渠道
   // String phoneHex = Hex.encodeHexString(phone.getBytes());//将手机号Hex编码，用于分享

%>  

<%@ include file="../../config/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport"
  content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
   <title>了解瑞钱宝</title>
    <meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
    <meta name="description" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/bootstrap.min.css">
    <link href="<%=basePath%>/css/common2.css" rel="stylesheet"/>
    <link href="<%=basePath%>/active/noviceGuide/noviceGuide.css" rel="stylesheet">
    <link href="<%=basePath%>/css/utils.css" rel="stylesheet" />
    <script src="<%=basePath%>/js/jquery-1.11.2.min.js" type="text/javascript"></script>
	<script src="<%=basePath%>/js/jweixin-1.0.0.js" type="text/javascript"></script>
	<script src="<%=basePath%>/js/frame/ios_js.js" type="text/javascript"></script>
    <script src="<%=basePath%>/js/weixin_share.js" type="text/javascript"></script>
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
      }
  })
    /*标题 */
    function showShare(){
        IOSModel.changeWebTitle("了解瑞钱宝");
      }
    $(function(){
      title = "了解瑞钱宝";
      content = "瑞钱宝—大型国企参股，多种优质项目，让您轻松理财！";
      icon = "<%=basePath %>/images/logo/noviceGuide.png";
      url  = "<%=basePath %>/active/noviceGuide/noviceGuide.jsp?from=app&utm_source=<%=utm_source %>";
       // getReferenceRank();
      /*分享好友*/
        weixinShare(title,content,icon,url,'<%=basePath%>');
        
        if("<%=userApp %>" != null && 
            "<%=userApp%>" != "" && 
            "<%=userApp%>" != "null") {
          $.ajax({
            url : "<%=localPath %>/lotteryAward/checkUserValidity",
          type : "post",
          dataType : "json",
          async : false,
          data : {
            loginName : "<%=userApp%>",
            from : $("#from").val()
          },
          success : function(data) {
            // 如果用户有效，则判断此用户有没有抽奖的机会
            if (data.success) {
              $("#m").val("<%=userApp%>");
              // 如果用户校验成功，则把注册 框隐藏掉
              $(".registerForm").hide();
                  $(".slotMachine1").addClass("receipts");
                  $(".firstMachine").css("margin","65% 0px 0px;");
                  $(".invite_friends").show();
                  if (data.lotteryCount <= 0) {
                    $("#slotMachineButtonShuffle").attr("disabled", true);
                  }else{
                    //$("#slotMachineButtonShuffle").attr("disabled","false");
                          $("#slotMachineButtonShuffle").css({"background":"#F8BD00",
                    "color":"#7F4506","box-shadow":"0px 5px 2px rgba(245,168,0,1)","border-color":"#F8BD00"});
                  }
                  $("#slotMachineButtonShuffle").html("可抽奖" + data.lotteryCount + "次");
            }
          }, 
          error : function(data) {
            alert("服务器错误，请联系管理员！")
          }
          })
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
        
        function login(){
            window.location.href = "<%=basePath%>/login.jsp?active=redEnvelope"
          }
          
          function dismissAys3(){
              $("#bg")[0].style.display = "none";
              $("#ays3")[0].style.display = "none";
          }
          function showAys3(value){
              $("#ays_content3")[0].innerHTML = value;
              $("#bg").css("height", document.body.scrollHeight);
              $("#bg")[0].style.display = "block";
              $("#ays3")[0].style.display = "block";
          }
    </script>
</head>
<body style="background:#fff;">
<%@ include file="../../config/show_share.jsp" %>
  <div class="topNoviceGuide">
    <div class="centerdiv">
        <img style="float:right;margin:3rem 1rem 1rem 0;" src="<%=basePath%>/active/noviceGuide/image/bannerBg2.png"/>
	      <div class="bannerBg">
			      <p class="nTitle1"><img src="<%=basePath%>/active/noviceGuide/image/title1.png"/></p>
			      <p class="nTitle2" style="padding-top:1rem;margin:0 10rem 4rem 10rem;"><img src="<%=basePath%>/active/noviceGuide/image/title2.png"/></p>
	      </div>
      <div class="nIntroduction">
         <img src="<%=basePath%>/active/noviceGuide/image/nTraggle.png"/>
         <h4>什么是瑞钱宝？</h4>
         <p>瑞钱宝是一家大型国企中国华融全资子公司华融天泽投资参股的综合金融资产交易
                          平台，2014年8月正式上线。瑞钱宝致力于为广大投资用户打造一个安全、快捷、
				        透明的在线理财平台，帮助中小企业解决融资难、融资贵问题，实现普惠金融的社
				        会价值，为经济发展和社会和谐贡献一份力量。</p>
      </div>  
    </div>
  </div><!--topLantern end-->
  <div class="top1NoviceGuide">
    <div class="centerdiv">
      <img src="<%=basePath%>/active/noviceGuide/image/nImage2.png"/>
    </div>
  </div><!--topLantern end-->
  <!-- 瑞钱宝有什么优势start -->
   <div class="centerdiv">
       <div class="nTitle3"><p><span>瑞钱宝有什么优势</span></p></div>
       <div class="nGuidelist">
        <img src="<%=basePath%>/active/noviceGuide/image/newlLists.png"/>
       </div>  
    </div>
     <!-- 瑞钱宝有什么优势end -->
     <!-- 你可以投哪个？start -->
     <div class="top2NoviceGuide">
        <div class="centerdiv">
           <div class="nTitle3"><p><span>你可以投哪个？</span></p></div>
           <div class="nGuidelist">
             <ul>
                 <li class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                   <img src="<%=basePath%>/active/noviceGuide/image/nImage7.png"/><br/>
                 </li>
                 <li class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                   <img src="<%=basePath%>/active/noviceGuide/image/nImage8.png"/><br/>
                 </li>
                   <li class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                   <img src="<%=basePath%>/active/noviceGuide/image/nImage9.png"/><br/>
                 </li>
             </ul><div class="clear"></div>
       </div>  
        </div>
  </div><!--top2NoviceGuide end-->
  <!-- 你可以投哪个？end -->
   <!-- 如何投资start -->
     <div class="centerdiv">
        <div class="nTitle3"><p><span>如何投资</span></p></div>
         <img src="<%=basePath%>/active/noviceGuide/image/nImage10.png"/>
      </div>
     <!-- 常见问题start -->
     <div class="top2NoviceGuide">
        <div class="centerdiv">
           <div class="nTitle3"><p><span>常见问题</span></p></div>
           <div class="nProblem">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <p class="blueStyle"><span>Q</span>如何成为瑞钱宝的用户？</p>
                    <p class="grayStyle"><span>A</span>用户通过手机号码在瑞钱宝官网或者瑞钱宝APP以及瑞钱宝微信公众号“瑞钱宝财富街”上进行注册。 </p>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <p class="blueStyle"><span>Q</span>如何修改登录密码？</p>
                    <p class="grayStyle"><span>A</span>APP：个人中心＞个人信息＞登陆密码修改PC端：我的账户＞账户信息＞安全信息＞密码管理＞登陆密码＞修改。 </p>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <p class="blueStyle"><span>Q</span>提现有限额吗？</p>
                    <p class="grayStyle"><span>A</span>答：提现大于100元没有限额。提现低于100元，每日有一次机会。 </p>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <p class="blueStyle"><span>Q</span>绑定的银行卡有什么要求？</p>
                    <p class="grayStyle"><span>A</span>答:绑定的银行卡仅支持单一储蓄卡、借记卡，不支持信用卡、理财卡、多币种卡。</p>
                </div>
                 <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <p class="blueStyle"><span>Q</span>充值收费吗？</p>
                    <p class="grayStyle"><span>A</span>充值目前不收费，由平台垫付。</p>
                </div>
                <!-- <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <p class="blueStyle"><span>Q</span>忘记支付密码怎么办？</p>
                    <p class="grayStyle"><span>A</span>编辑短信“CSMM#身份证后四位”发送10690569687进行重置密码。</p>
                </div> -->
                <div class="clear"></div>
           </div>
        </div>
     </div><!--top2NoviceGuide end-->
  <!-- 常见问题 end -->
<script type="text/javascript" src="<%=basePath%>/js/frame/rqbaoappshare.js"></script>
  </body>
</html>
