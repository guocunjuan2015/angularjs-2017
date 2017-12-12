<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="UTF-8"%>
<%@ include file="/ruiLife/config.jsp" %>
<!DOCTYPE html>
<html ng-app="pointDetailsApp">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,target-densitydpi= device-dpi,user-scalable=no">
		<title>详情</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/ruiLife/css/all.css"/>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/ruiLife/css/index.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/ruiLife/framework/jquery.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/ruiLife/framework/angular.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/ruiLife/js/public.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/json2.js" ></script>
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
			
			angular.module('pointDetailsApp', [])
			
			//详情
			.controller('pointDetailCtrl', ["$scope","$http",function ($scope,$http) {
				var data = {
					"goodId" : ${param.goodId}
				},
				transFn = function(data) {
	                return $.param(data);
	            },
	            postCfg = {
	                headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
	                transformRequest: transFn
	            };
	            $http.post('<%=basePath %>/appRlifeGoods/rLifeGood.do',data, postCfg)
 				.success(function(response) {
 					console.log(JSON.stringify(response));
 					$scope.data = response;
					$scope.pic1 = response.imgUrl;
					$scope.name=response.name;
					$scope.priceMarket = response.priceMarket;
					$scope.priceInvest = response.priceInvest;
					$scope.dataimg = response.details;
 				}).error(function(response) {
					alert("服务器错误，请联系管理员");
				});
				
				$http({
					method:'post',
					url :'<%=basePath %>/appRlifeOrder/getPartInCount.do',
					data :{
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
	<body ng-controller="pointDetailCtrl">
		<!--图片展示-->
		<section class="pic-show">
			<p class="oPicImg"></p>
			<p><b class="name"></b><span style="float: right;"><tt class="PartInCount">10</tt>人&nbsp;&nbsp;已兑换</span></p>
		</section>
		<!--价格详情-->
		<section class="price">
			<ul>
				<li>市场价 : <del class="priceMarket">{{priceMarket}}元</del></li>
				<li>所需积分 : <span class="pointSpan">{{data.point}}</span>积分&nbsp;&nbsp;&nbsp;可兑换</li>
			</ul>
		</section>
	
		<!--服务详情-->
		<section class=" serviceDetails">
			<p class="service">商品详情</p>
			<div class="service_img">
			</div>
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
						$(".oPicImg").append('<img src="'+response.imgUrl+'" />');
						$(".name").html(response.name);
						$(".priceMarket").html(response.priceMarket + "元");
						$(".pointSpan").html(response.point);
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
