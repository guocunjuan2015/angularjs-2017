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
		<script type="text/javascript">
			var url = '';
			var title = '';
		</script>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width,target-densitydpi= device-dpi,user-scalable=no">
		<title></title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/ruiLife/css/all.css"/>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/ruiLife/css/index.css" />		
		<script type="text/javascript" src="${pageContext.request.contextPath}/ruiLife/framework/jquery.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/ruiLife/js/public.js" ></script>
		<script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
    	<script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
    	<script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
		<script type="text/javascript">
			$(function() {
				var arr = new Array();
				arr[0] = '00'; // 瑞服务
				arr[1] = '01'; // 瑞友汇
				arr[2] = '02'; // VIP
				arr[3] = '03'; // 积分
				$.each(arr, function(i, type) {
					$.ajax({
						url : '<%=basePath %>/appRlifeOrder/getUserROrderList.do',
						type : 'post',
						dataType : 'json',
						async : false,
						data : {
							userId : '<%=userAppId %>',
							orderType : type
						},
						success : function (data) {
							console.log(data);
							$(".myView ul").eq(i).html('');
							$.each(data, function(index, order) {
								var str = '';
								str += '<li>';
								str += '	<p class="vip8">';
								str += '		<a href="javascript:;" onclick="toNextPage(this,'+order.rgoods.id+', '+type+')">';
								str += '			<img src=\"' + order.rgoods.imgUrl + '\" alt="" />';
								str += '		</a>';
								str += '	</p>';
								str += '	<p class="txt_p">'+ order.rgoods.name + '</p>';
								str += '	<p class="change">已兑换</p>';
								str += '</li>'
								$(".myView ul").eq(i).append(str);
							})
						},
						error : function (data) {
							alert("服务器错误,请联系管理员");
						}
					})
				});
			});
			
			function toNextPage(obj, goodId, type) {
				<!-- type 00:瑞服务，01:瑞友汇，02:VIP，03:积分 -->
				if (type == '00') {
					title = "瑞服务详情";
					url ='<%=basePath %>/ruiLife/mySerDetails.jsp?goodId='+goodId;
				} else if (type == '01') {
					title = "瑞友汇详情";
					url ='<%=basePath %>/ruiLife/myLifeFirDetails.jsp?goodId='+goodId;
				} else if (type == '02') {
					title = "VIP详情";
					url ='<%=basePath %>/ruiLife/myVipDetails.jsp?goodId='+goodId;
				} else if (type == '03') {
					title = "积分详情";
					url ='<%=basePath %>/ruiLife/myPointDetails.jsp?goodId='+goodId;
				}
				IOSModel.toNextPage({
					"url":url,
					"title":title
				});
				if (isAndroidOrIos()) {
					appFunction('toNextPage');
				}
			};
		</script>
	</head>
	<body style="background: #F5F4F4;">
		<!--导航-->
		<section class="sec_nav">
			<ul class="nav_myLife">
		       	<li class="active_li">瑞服务</li>
		       	<li>瑞友汇</li>
		       	<li>VIP专享</li>
		       	<li>积分兑换</li>
	    </ul>
		</section>
	    <!--展示-->
	    <section>
	    	<div class="noStr" style="display: block;">
	    		<p>精彩尽在瑞生活</p>
	    	</div>
	    	<div class="myView" style="display: none;">
		      	<!--瑞服务-->
			  	<ul class="show"></ul>
				<!--瑞友汇-->
			  	<ul>
					<li>
						<p class="vip8"><a href="myLifeFirDetails.html"><img src="img/3.png" alt="" /></a></p>
						<p class="txt_p">一起去旅游</p>
						<p class="change">已兑换</p>
					</li>
				</ul>
				<!--VIP专享-->
			  	<ul>
					<li>
						<p class="vip8"><a href="friDetails.html"><img src="img/3.png" alt="" /></a></p>
						<p class="txt_p">一起去旅游</p>
						<p class="change">已兑换</p><!--默认为隐藏状态-->
					</li>
					<li>
						<p class="vip8"><img src="img/3.png" alt="" /></p>
						<p class="txt_p">一起去旅游</p>
						<p class="change">已兑换</p><!--默认为隐藏状态-->
					</li>
				</ul>
				<!--积分兑换-->
			  	<ul class="show_gift">
					<li>
						<p class="show_img"><a href="friDetails.html"><img src="img/card.png" alt=""/></a></p>
						<p class="show_car">50元京东购物卡</p>
						<p class="show_coin"><strong>597900&nbsp;&nbsp;</strong>积分</p>
						<p class="change">已兑换</p><!--默认为隐藏状态-->
					</li>
					<li>
						<p class="show_img"><img src="img/card.png" alt=""/></p>
						<p class="show_car">50元京东购物卡</p>
						<p class="show_coin"><strong>597900&nbsp;&nbsp;</strong>积分</p>
						<p class="change">已兑换</p><!--默认为隐藏状态-->
					</li>
					<li>
						<p class="show_img"><img src="img/card.png" alt=""/></p>
						<p class="show_car">50元京东购物卡</p>
						<p class="show_coin"><strong>597900&nbsp;&nbsp;</strong>积分</p>
						<p class="change">已兑换</p><!--默认为隐藏状态-->
					</li>
				</ul>
			</div>
	    </section>
	</body>
</html>
