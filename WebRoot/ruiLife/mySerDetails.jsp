<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="UTF-8"%>
<%@ include file="/ruiLife/config.jsp" %>
<!DOCTYPE html>
<html ng-app="serDetailApp">
	<head>
		<script>
			var amount    = '';
			var projectId = '';
			var projectName = '';
			var period = '';
			var orderId = '';
			var projectType = '';
		</script>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,target-densitydpi= device-dpi,user-scalable=no">
		<title>详情</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/ruiLife/css/all.css"/>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/ruiLife/css/index.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/ruiLife/framework/jquery.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/ruiLife/framework/angular.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/ruiLife/js/public.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/json2.js" ></script>
		<script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
    	<script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
    	<script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
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
			var appObject = {
				getUserInfo : function(userId, userName, isRealName, isBindCard) {
					var storage = window.sessionStorage;
					storage.setItem("userId", userId);
					storage.setItem("userName", userName);
					storage.setItem("isRealName", isRealName);
					storage.setItem("isBindCard", isBindCard);
					isJoin(userId);
				},
				investSuccess : function (orderId) {
					if (orderId) {
						$.ajax({
							url : '<%=basePath %>/appRlifeOrder/updateROrder.do',
							type : 'post',
							dataType : 'json',
							data : {
								orderId : orderId
							},
							success : function(data) {
								if (data.status == '1') {
									$(".free_btn").html("已参与服务");
									$(".free_btn").attr("onclick" , "");
									//alert("恭喜您获得服务");
									$("#divshows").css("display","block");
									$(".free_btn").css("background" , "#ccc");
								} else {
									alert(data.msg);
								}
							},
							error : function (data) {}
						})
					}
				}
			}
			
			angular.module('serDetailApp', [])
			//详情
			.controller('detailCtrl', ["$scope","$http",function ($scope,$http) {
				$http({
					method:'post',
					url :'<%=basePath %>/appRlifeOrder/getPartInCount.do',
					data : {
						goodId : ${param.goodId}
					}
				}).success(function(data,header,config,status){
					$(".PartInCount").html(data);
				}).error(function(data) {
					alert("服务器错误，请联系管理员");
				});
			}]);
		</script>
	</head>
	<body ng-controller="detailCtrl">
		<input type="hidden" id="projectName"/>
		<input type="hidden" id="projectId"/>
		<input type="hidden" id="period"/>
		<input type="hidden" id="investAmount"/>
		<!--图片展示-->
		<section class="pic-show">
			<p class="pic1"></p>
			<p id="goodName">
				<label class="name"></label> 
				<span style="float: right;"><tt class="PartInCount"></tt>人&nbsp;&nbsp;已兑换</span>
			</p>
		</section>
		<!--价格详情-->
		<section class="price">
			<ul>
				<li>市场价 : <del class="priceMarket">元</del></li>
				<li>年化投资 : <span class="priceInvest"></span>元&nbsp;&nbsp;&nbsp;可兑换</li>
<!-- 				<div id="aaa"> -->
<!-- 					<p class="p1">投资推荐:</p> -->
<!-- 					<div class="period"></div> -->
<!-- 					<p class="prompt">提示:瑞服务投资类型，不可参与债权转让</p> -->
<!-- 				</div> -->
			</ul>
		</section>
	
		<!--服务详情-->
		<section class=" serviceDetails">
			<p class="service">服务详情</p>
			<ul class="service_img"></ul>
		</section>
		
		<a class="free_btn1" href="javascript:;">已兑换</a>
		
		<script type="text/javascript">
			$(document).ready(function() {
				$.ajax({
					url : '<%=basePath %>/appRlifeGoods/rLifeGood.do',
					type : 'post',
					dataType : 'json',
					data : {
						"goodId" : ${param.goodId}
					},
					async : false,
					success : function (response) {
						$(".pic1").append('<img src="'+response.imgUrl+'" />');
						$(".name").html(response.name);
						$(".priceMarket").html(response.priceMarket + "元");
						$(".priceInvest").html(response.priceInvest);
						$(".service_img").html(response.details);
					},
					error : function (data) {
						alert("服务器错误,请联系管理员");
					}
				});
			})
		</script>	
	</body>
</html>
