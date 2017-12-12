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
<script>
	var _url = "";
</script>

<%@ include file="../../config/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="maximum-scale=1.0,minimum-scale=1.0,user-scalable=0,width=device-width,initial-scale=1.0"/>
	  <title>约标加息</title>
    <meta name="keywords" content="" />
    <meta name="description" content="" />
 	  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
  	<link href="${pageContext.request.contextPath}/css/common2.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/active/yuebiao/yuebiao.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/utils.css" rel="stylesheet" />
    <script src="<%=basePath%>/js/jquery-1.11.2.min.js" type="text/javascript"></script> 
	 <script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
	 <script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
	 <script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/json2.js"></script>
	<script> 
		/*标题 */
		function showShare(){
			  IOSModel.changeWebTitle("约标加息 ");
			}
		$(function(){
		    title = "累积交易额破8亿，亿路有你！感恩加息！";
		    content = "瑞钱宝—大型国企参股，多种优质项目，让您轻松理财！ ";
			icon = "<%=basePath %>/images/logo/yuebiaoLogo.jpg";
			url  = "<%=basePath %>/active/yuebiao/yuebiao.jsp?from=app&utm_source=<%=utm_source %>";
			_url = "<%=basePath %>/active/yuebiao/yuebiao.jsp?from=app&utm_source=<%=utm_source %>";
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
<body id="yuebiaoBody" style="margin:auto;">
<%@ include file="../../config/show_share.jsp" %>
<input type="hidden" value="<%=referrer %>"  id="referrer">
<input type="hidden" value="<%=from%>"  id="from">
<input type="hidden" value="<%=utm_source %>" id="channel"/>
<input type="hidden" value="<%=userAppId %>" id="userId"/>
   <img src="<%=basePath%>/active/yuebiao/image/banner_yb.png"/> 
   <p class="title1"><img src="<%=basePath%>/active/yuebiao/image/title1.png"/></p>
    <p class="title2">约标快人一步赚收益，5万起约享加息！</p>
   <img class="title5" src="<%=basePath%>/active/yuebiao/image/title5.png"/>
 <!--   <div class="yuebiaoTable">
        <div class="table-row-group">
        	<ul class="table-row">
        		<li class="table-cell">期限</li>
        		<li class="table-cell">1月标</li>
        		<li class="table-cell">3月标</li>
        		<li class="table-cell">6月标</li>
        		<li class="table-cell">12月标</li>
        	</ul>
        	<ul class="table-row">
        		<li class="table-cell">加息</li>
        		<li class="table-cell">0.3%</li>
        		<li class="table-cell">0.3%</li>
        		<li class="table-cell">0.5%</li>
        		<li class="table-cell">0.8%</li>
        	</ul>
        	<ul class="table-row">
        		<li class="table-cell">起约额度</li>
        		<li class="table-cell">5万</li>
        		<li class="table-cell">5万</li>
        		<li class="table-cell">5万</li>
        		<li class="table-cell">5万</li>
        	</ul>
        </div>
   </div>  -->
     <%-- <img class="title6" src="<%=basePath%>/active/yuebiao/image/title6.png"/> --%>
    <p class="title2" style="margin-top:1rem;">例如：小瑞预约投资年化利率12%的12月标20万，预约投资成功后，将享受12%的年化利率+0.8%（加息），总收益25600元。</p>
   <p class="title1"><img src="<%=basePath%>/active/yuebiao/image/title2.png"/></p>
   <p class="title3"><img src="<%=basePath%>/active/yuebiao/image/title3.png"/></p>
    <div class="title4">
      <p><img src="<%=basePath%>/active/yuebiao/image/title4.jpg"/></p>
    </div>
    <div class="yuebiaoFooter"> 

    	<p><a style="color:#fff;" href="tel:400-919-8555">400-919-8555 马上约标</a></p>

    </div>
	</body>
</html>
