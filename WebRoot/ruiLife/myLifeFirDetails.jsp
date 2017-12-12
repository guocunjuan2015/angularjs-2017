<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="UTF-8"%>
<%@ include file="/ruiLife/config.jsp" %>
<%
	HttpSession hs = request.getSession();
    String user = "";//用户名
    String userId = "";//用户userId
    
    String from = request.getParameter("from");
    if (from == null || !("app".equals(from))) {
        from = "";
    }
    System.out.println("aft:" + from);
    String userApp = request.getParameter("user");
    if (from != null && "app".equals(from) && userApp != null
            && userApp != "") {
        user = userApp;
        hs.setAttribute("loginUser", user);
    } else if (hs != null) {
        user = (String) hs.getAttribute("loginUser");
        if (user == null) {
            user = "";
        }
    }
    String userAppId = request.getParameter("userId");
    if (from != null && "app".equals(from) && userId != null
            && userId != "") {
        userId = userAppId;
        hs.setAttribute("userId", userId);
    } else if (hs != null) {
        userId = (String) hs.getAttribute("userId");
        if (userId == null) {
            userId = "";
        }
    }
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,target-densitydpi= device-dpi,user-scalable=no">
		<title></title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/ruiLife/css/all.css"/>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/ruiLife/css/index.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/ruiLife/framework/jquery.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/ruiLife/js/public.js" ></script>
		<script type="text/javascript">
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
			$(function() {
				$.ajax({
					url : '<%=basePath %>/appRlifeGoods/rLifeGood.do',
					type : 'post',
					dataType : 'json',
					data : {
						goodId : ${param.goodId}
					},
					success : function (data) {
						console.log(data);
						$(".serName").html(data.name);
						$(".startTime").html(data.dateStart);
						$(".endTime").html(data.dateEnd);
						$(".service_img").html(data.details);
						$(".address").html(data.provider);
					},
					error : function (data) {
						alert("服务器错误,请稍候重试");
					}
				});
				
				// 参与人数
				$.ajax({
					url : '<%=basePath %>/appRlifeOrder/getPartInCount.do',
					type : 'post',
					dataType : 'json',
					data : {
						goodId : ${param.goodId}
					},
					success : function (data) {
						$(".PartInCount").html(data);
					},
					error : function (data) {
						alert("服务器错误,请稍候重试");
					}
				});
			})
		</script>
	</head>
	<body>
		<!--图片展示-->
		<section class="pic-show">
			<p class="oPicImg"><img src="img/sleep.png"/></p>
			<p>
				<b class="serName">北京撑宝宾馆(大床房)</b>
				<span style="float: right;">
					<tt class="PartInCount">10</tt>人&nbsp;&nbsp;已兑换
				</span>
			</p>
		</section>
		<!--价格详情-->
		<section class="price">
			<ul>
				<li>活动地址 : <b class="address"></b></li>
				<li>活动时间 : <b class="startTime">2016年01月01日</b>&nbsp;--&nbsp;<b class="endTime"></b></li>
			</ul>
		</section>
	
		<!--服务详情-->
		<section class=" serviceDetails">
			<p class="service">服务详情</p>
			<div class="service_img">
				
			</div>
		</section>
		
		<a class="free_btn1" href="javascript:;">已兑换</a>
	</body>
</html>
