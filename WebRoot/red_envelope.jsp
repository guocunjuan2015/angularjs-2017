<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*,java.net.URLDecoder"
    pageEncoding="UTF-8"%>
<%
    HttpSession hs = request.getSession();
    String user = "";//用户名
    String userId = "";//用户userId
    String userHex = "";//hex编码的用户名，分享出去用到，app转进来需要解码

  /*  String localPath = "http://www.rqbao.com/"; 
    String basePath = "http://www.rqbao.com/rqb";  */ 
    String localPath = "http://test.rqbao.com/rqt";
    String basePath = "http://test.rqbao.com/rqb"; 
    //boolean flag=false;
    //String basePath = "http://www.rqbao.com";
   // String rqtPath="http://www.rqbao.com/static_3 /active/facetoface";
   //String testPath="http://123.57.77.184/rqt/static_3/active/facetoface";
    
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
        //refer需要Hex解码
        if (referHex != null) {
            byte[] bs = Hex.decodeHex(referHex.toCharArray());
            refer = new String(bs);
        }
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
%>  

<%-- <%@ include file="./config/header.jsp" %> --%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
	 <title></title>
    <meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
    <meta name="description" content="瑞钱宝互联网金融平台投资越多惊喜越多,年收化率7%-13.5%，
    	活动期间你可以选择适合您的理财产品，活动期间设置自动幸运抽奖区，投资理财奖品主要有三星电视、九阳榨汁机、iphone 6s 等，活动时间6月6日-6月24日。" />
 	  <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
  	<link href="css/common2.css" rel="stylesheet"/>
    <link href="active/redEnvelope/redEnvelope.css" rel="stylesheet">
    <script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
		<script src="js/jweixin-1.0.0.js" type="text/javascript"></script>
		<script src="js/frame/ios_js.js" type="text/javascript"></script>
    <script src="js/weixin_share.js" type="text/javascript"></script>
        <script type="text/javascript" src="active/redEnvelope/js/index.js"></script>
    <script type="text/javascript" src="active/redEnvelope/js/jquery.slotmachine.js"></script>
	<script>
		/*标题 */
		function showShare(){
			  IOSModel.changeWebTitle("感恩六月,从心出发");
			}
		/*分享好友*/
		$(function(){
		    title = "感恩六月,从心出发";
		    content = "感恩六月,从心出发豪礼送家人大奖谢知音!";
		    icon = "http://www.rqbao.com/rqb/images/logo/lotteryLogo.png";
		    url  = 'http://www.rqbao.com/rqb/66active.jsp';
		   // getReferenceRank();
		    weixinShare(title,content,icon,url,'<%=basePath%>');
		});
	
		/*分享 */
		  function shareClick() {
		    var uu = '<%=user%>';
		    if(!uu){
		      showAys3("您还没有登录，需要登录后才可以分享，现在去登录？");
		    }else{ 
		      if (isAndroidOrIos()) {
		        //alert(title);
		              IOSModel.noticeShare({
		                  "url" : url,
		                  "title" : title,
		                  "content" : content,
		                  "icon" : icon
		              });
		              iosShare(title, content, icon, url);
		              appFunction('share');
		          } else {
		            /*   showShareBox(); */
		          }
		    }
		  }
		    function showShare() {
		      IOSModel.showShareBtn();
		    }
		    function shareWithType() {
		      IOSModel.noticeShare({
		        "url" : url,
		        "title" : title,
		        "content" : content,
		        "icon" : icon
		      });
		    }
		  
		</script>
</head>
<body id="red_envelope" style="background:#F12058;margin:auto;">
<input type="hidden" value="" name="types" id="types">
<input type="hidden" value="<%=basePath%>"  id="basePath">
<div class="lotteryBanner">
    <div class="slotMachineBox">  
			      <div class="content slotMachine1">
					        <div style="clear:both;">
							          <div id="machine1" class="slotMachine" style="margin:72% 0 0 0;">
													            <div class="slot slot1"></div>
													            <div class="slot slot2"></div>
													            <div class="slot slot3"></div>
													            <div class="slot slot4"></div>
													            <div class="slot slot5"></div>
													            <div class="slot slot6"></div>
							                        <div class="slot slot7"></div>
							                        <div class="slot slot8"></div>
							                        <div class="slot slot9"></div>
							                       
							          </div>
					          
					          <div id="machine2" class="slotMachine" style="margin-left:70px;">
											            <div class="slot slot2"></div>
											            <div class="slot slot1"></div>
											            <div class="slot slot3"></div>
											            <div class="slot slot4"></div>
											            <div class="slot slot5"></div>
											            <div class="slot slot6"></div>
					                        <div class="slot slot7"></div>
					                        <div class="slot slot8"></div>
					                        <div class="slot slot9"></div>        
					          </div>
					        </div>
					        <div class="clear">
						      <div id="machine1Result" class="slotMachine noBorder" style="text-align:left;display: none"></div>
						      <div id="machine2Result" class="slotMachine noBorder" style="text-align:left;display: none"></div>
    </div>
				           <div class="registerForm">
				               <ul>
				                      <li>
                                 <input type="text" class="form-control" id="m" name="m"
                                    placeholder="请输入手机号"  onkeyup="this.value=this.value.replace(/\D/g,'')"
                onafterpaste="this.value=this.value.replace(/\D/g,'')"></td>
                                </li>
                                <li>
                                 <input type="text" class="form-control" id="vc" name="vc"
                                    placeholder="请输入验证码">
                                    <button type="button" class="btn btn-danger" id="getc">获取验证码</button>
                                </li>
                                <li style="text-align:left;clear:both;padding:10px 0 0 40px;"><span id="showMess"></span></li>
				                </ul>
				       </div>
			      </div>
      
			      <div class="content slotMachine2">
							        <div id="slotMachineButtonShuffle" class="slotMachineButton" style="font-size: 25px">注册</div>
			      </div>
      </div>
</div>
<p class="invite_friends"><a href="javascript:;" onclick="shareClick()">邀请好友还能抽奖>></a></p>
<div class="rules">
		<p>活动规则：</p>
		<p>1、用户注册即可参与首次抽奖，首次抽奖得到的现金红包，一半可直接提现，另一半攒够100元方可提现。</p>
		<p>2、您抽到的红包可在微信或APP端的“个人中心>我的优惠>红包”里查看。</p>
		<p>3、用户每天可免费抽奖一次，成功邀请一位新用户可增加一次免费抽奖机会。</p>
		<p>4、如有任何问题请拨打客服电话400-919-8555。</p>
</div>
<div class="bottomImage">
      <img   src="<%=basePath%>/active/redEnvelope/image/footerBg.png" alt="turntable"/>
</div>
<div class="downLoad">
      <p>下载APP领取每日惊喜大礼</p>
</div>
		<script type="text/javascript" src="js/frame/rqbaoappshare.js"></script>
	</body>
</html>
