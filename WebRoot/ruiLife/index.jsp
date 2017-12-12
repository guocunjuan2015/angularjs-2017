<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="UTF-8"%>
<%@ include file="/ruiLife/config.jsp" %>
<!DOCTYPE html>
<html ng-app="rqb">
	<head> 
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/ruiLife/framework/jquery.hiSlider.min.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/ruiLife/css/all.css"/>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/ruiLife/css/index.css" />	
		<script type="text/javascript" src="${pageContext.request.contextPath}/ruiLife/framework/jquery.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/ruiLife/framework/angular.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/ruiLife/framework/angular-route.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/ruiLife/framework/jquery.hiSlider.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/json2.js" ></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/ruiLife/js/public.js" ></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/ruiLife/js/app.js" ></script>
		<script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
    	<script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
		<script type="text/javascript">
			var appObject = {
				getUserInfo : function(userId, userName, isRealName, isBindCard) {
					var storage = window.sessionStorage;
					storage.setItem("userId", userId);
					storage.setItem("userName", userName);
					storage.setItem("isRealName", isRealName);
					storage.setItem("isBindCard", isBindCard);
				}
			}
		</script>
	</head>
	<body>
		
       		<div id="navigation"  class="nav" style="padding-top:0;border-top:none;">
       	 		<!-- <a href="#service">
	              <dl>
	            <dt class="before0"></dt>
	            <dd>瑞服务</dd>
	          </dl>
	            </a>
      		
				<a href="#friend">
					<dl>
						<dt class="before1"></dt>
						<dd>瑞友汇</dd>
					</dl>
				</a> 
				<a href="#vip">
					<dl>
						<dt class="before2"></dt>
						<dd>VIP专享</dd>
					</dl>
				</a>  -->
				<a href="#points">
					<dl>
						<dt class="before2"></dt>
						<dd>积分兑换</dd>
					</dl>
				</a>
	      </div>	      
	      <div ng-view=""></div>
	</body>
</html>
