<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*,java.net.URLDecoder"
	pageEncoding="UTF-8"%>
<%
    //response.sendRedirect("http://www.rqbao.com/rqb/notice_details.jsp?detailId=2aca22cae4154084addd868321e4a648");
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName()
            + path + "/";
    basePath = "http://www.rqbao.com/rqb";
    //basePath = "http://test.rqbao.com/rqb";
    Logger log = Logger.getLogger(this.getClass());
    log.info(request.getQueryString());
    String referrer = request.getParameter("referrer");
    String from = request.getParameter("from");
    String refer2 = null;
    if("weixin".equals(from)){
        byte[] bs = Hex.decodeHex(referrer.toCharArray());
        refer2 = new String(bs);
    }else{
        refer2 = referrer;
        if(from == null ){
            from = "others";
        }
    }
    request.setAttribute("refer2", refer2);
    request.setAttribute("referrer", referrer);
    log.info(referrer);
    
    
    log.info(refer2);
    //referrer = new String(referrer.getBytes("ISO8859-1"),"UTF-8");
    // String referrer = new String(request.getParameter("referrer"));
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="UTF-8">
<title>瑞钱宝注册分享</title>
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="pragma" content="no-cache">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common2.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/intro-friend.css">
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/jweixin-1.0.0.js" type="text/javascript"></script>
<!-- <script src="js/share_redirect.js" type="text/javascript"></script> -->
<script src="js/frame/ios_js.js" type="text/javascript"></script>
<script src="js/weixin_share.js" type="text/javascript"></script>
<script src="js/jsb.js" type="text/javascript"></script>
<%@ include file="config/header.jsp"%>

<script type="text/javascript">
    var from = '<%=from%>';
    $(function(){
    	//setDisplay('share-btn');
    	if("app" == from){
    		$("#app")[0].style.display = "block";
    	}else{
    		$("#wechat")[0].style.display = "block";
    	}
    	icon = '<%=basePath%>/images/getheadimg.jpg'; // 200*200大小
        url = '<%=basePath%>/register_referrer.jsp?referrer=<c:out value="${refer2}" escapeXml="true"></c:out>';
        content = '20年金融团队经验，安全靠谱的理财产品，100元起投，7%-22%高收益，快来跟我一起赚钱吧！';
        title ='理财就选瑞钱宝';
        weixinShare(title,content,icon,url,'<%=basePath%>');
    });
    function toShare(){
        IOSModel.noticeShare({"title":title,"content":content,"icon":icon,"url":url});
        appFunction('share');
    }
    
    function showShare(){
         IOSModel.showShareBtn();
    }
     function shareWithType(){
    	IOSModel.shareRecomend();
    } 
    </script>
</head>
<body>
	<%-- <section class="share_img" id="wx_share" style="display:none">
	<img src="images/friends_001.png" /> <img src="images/friends_02.png" />
	<img src="images/friends_03.png" /> <img src="images/friends_002.png" />
	<p class="ew-code">
		<img id="img_ewcode"
			src="share/encoderQRCoder.do?content=http://www.rqbao.com/rqb/register_referrer.jsp?referrer=<c:out value="${refer2}" escapeXml="true"></c:out>&'+new Date().getTime())" />
	</p>
	<img src="images/friends_003.png" border="0" usemap="#Map" /> <map
		name="Map">
		<area shape="rect" coords="3,200,748,314" href="#">
	</map> </section> --%>
	<section class="share_img" id="wechat" style="display:none">
	<img src="images/refer/share_01.jpg" />
	<img src="images/refer/share_02.jpg" />
	<img src="images/refer/share_03.jpg" />
	</section>
	<section class="share_img" id="app"  style="display:none">
    <img src="images/refer/invest_02.png" />
    <img src="images/refer/invest_03.png" />
    <img onclick="toShare()" src="images/refer/invest_04.png" />
    <img src="images/refer/invest_05.png" />
    </section>
	
</body>
<script src="js/frame/rqbaoappshare.js" type="text/javascript"></script>
</html>
