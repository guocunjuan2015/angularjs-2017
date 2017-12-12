<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="UTF-8"%>
<%@ include file="/ruiLife/config.jsp" %>
<%
	String s = request.getParameter("s");
%>
<!DOCTYPE html>
<html ng-app="vipDetailApp">
	<head>
		<script>
			var title     = 'VIP详情';
			var content   = 'VIP详情';
			var url       = '';
			var icon      = '';
		</script>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,target-densitydpi= device-dpi,user-scalable=no">
		<title></title>
		<title></title>
		<style type="text/css">
		.pic-show .oPicImg{position: relative;}
		.pic-show .oPicImg .vipImg{position: absolute;right:0;bottom:0.2rem;;width:60px;height:30px;line-height:30px;color:#fff;font-size:12px;background: #000;opacity: 0.5;text-align:center;}
		</style>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/ruiLife/css/all.css"/>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/ruiLife/css/index.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/ruiLife/framework/jquery.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/json2.js" ></script>
		<script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
    	<script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
    	<script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
		<script type="text/javascript">
			title     = 'VIP详情';
			content   = 'VIP详情';
			url       = '<%=basePath %>/ruiLife/vipDetails.jsp?s=share&goodId=' + ${param.goodId};
			icon      = '<%=basePath %>/images/logo/float.png';
			var appObject = {
				getUserInfo : function(userId, userName, isRealName, isBindCard) {
					var storage = window.sessionStorage;
					storage.setItem("userId", userId);
					storage.setItem("userName", userName);
					storage.setItem("isRealName", isRealName);
					storage.setItem("isBindCard", isBindCard);
					isJoin(userId);
					toShare();
				}
			}
			
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

			// 判断用户是否已参加此次活动
			function isJoin(userId) {
				if(userId) {
					// 判断用户是否已参加此次活动
					$.ajax({
						url : '<%=basePath %>/appRlifeOrder/isAttendedActive.do',
						type : 'post',
						dataType : 'json',
						data : {
							goodId : ${param.goodId},
							userId : window.sessionStorage.getItem("userId")
						},
						async : false,
						success : function (data) {
							if (data.status == '3') {
								if (data.kind == '02' && data.remainCount >　0) return;
								$(".free_btn").html("已兑换");
								$(".free_btn").attr("onclick" , "");
								$(".free_btn").css("background" , "#ccc");
							}
						},
						error : function (data) {
							alert('服务器内部错误,请联系管理员');
						}
					});
				}
			}
			
			function toShare() {
				IOSModel.setShareContent({
					"url" : url,
                  	"title" : title,
                  	"content" : content,
                  	"icon" : icon
				});
				if (isAndroidOrIos()) {
					appFunction('setShareContent');
				}
			}
			
			// 去兑换
			function toExchange() {
				if (!window.sessionStorage.getItem("userId")) {
					if(confirm("您还没有登录,点击确定去登录")) {
						IOSModel.login();
						if (isAndroidOrIos()) {
							appFunction('login');
						}
					}
					return;
				}
				if (window.sessionStorage.getItem("isRealName") == "0") {
					if(confirm("您还没有进行实名认证,点击确定去实名认证")) {
						// 去开户
						IOSModel.openUmp();
						if (isAndroidOrIos()) {
							appFunction('openUmp');
						}
					}
					return;
				}
				if (window.sessionStorage.getItem("isBindCard") == "0") {
					if(confirm("您还没有绑卡,点击确定去绑卡")) {
						// 去绑卡
						IOSModel.toBindCard();
						if (isAndroidOrIos()) {
							appFunction('bindCard');
						}
					}
					return;
				}
				
				// 进行兑换
				$.ajax({
					url : '<%=basePath %>/appRlifeOrder/exchange.do',
					type : 'post',
					dataType : 'json',
					data : {
						goodId : ${param.goodId},
						userId : window.sessionStorage.getItem("userId"),
						type : '02'
					},
					async : false,
					success : function (data) {
						if (data.status == '0') {
							$("#divshows1").css("display","block");
							$(".free_btn").html("立即兑换");
							$(".free_btn").css("background" , "#ff5555");
							//alert(data.msg);
						} else if (data.status == '1') {
							$(".vipNum").html(data.count);
							$(".PartInCount").html(data.partInCount);
							$("#divshows2").css("display","block");
							if(data.count==0){
								$(".free_btn").html("已兑换");
								$(".free_btn").attr("onclick" , "");
								$(".free_btn").css("background" , "#ccc");
							}
						} else if (data.status == '2') {
							// 商品已下架，不能进行兑换
							alert(data.msg);
						}
					},
					error : function (data) {
						alert('服务器内部错误,请联系管理员');
					}
				});
			}
			$(function(){
				
				// 获取已参与人数
				$.ajax({
					url : '<%=basePath %>/appRlifeOrder/getPartInCount.do',
					type : 'post',
					dataType : 'json',
					data : {
						goodId : ${param.goodId}
					},
					success : function(data) {
						$(".PartInCount").html(data);						
					},
					error : function (data) {
						alert('服务器内部错误,请联系管理员');
					}
				})
				
				$(".yes_btn1").on("touchend", function(){
					$("#divshows1").css("display","none");
					if ($(".yes_btn1").html() == '去投资提升等级') {
						IOSModel.toIosInvest();
						appFunction('invest');
					}
				})
				
				$(".yes_btn2").on("touchend", function(){
					$("#divshows2").css("display","none");
				})
				
				if ("<%=s %>" == 'share') {
					$(".free_btn").hide();
					$(".det").show();
				} else {
					$(".free_btn").show();
					$(".det").hide();
				}
				$(".closeWin").click(function(){
					$("#divshows1").css("display","none");
				});
			})
			
		</script>
	</head>
	<body ng-controller="vipDetailCtrl">
		<!--图片展示-->
		<section class="pic-show">
			<div class="oPicImg">
				<!-- <img ng-src="{{pic1}}"/>
				<div class="vipImg">VIP<span>{{data.level}}</span>专享</div> -->
			</div>
			<p><b class="name"></b><span style="float: right;"><tt class="PartInCount">10</tt>人&nbsp;&nbsp;已兑换</span></p>
		</section>
		<!--价格详情-->
		<section class="price">
			<ul>
				<li>VIP等级 : VIP<b class="level"></b>以上&nbsp;&nbsp;&nbsp;可兑换</li>
			</ul>
		</section>
	
		<!--服务详情-->
		<section class=" serviceDetails">
			<p class="service">VIP专享详情</p>
			<ul class="service_img">
				<!-- {{dataimg}} -->
			</ul>
		</section>
		
		<!--详情页面底部按钮-->
		<a style="color:#fff !important;border:none;" class="free_btn" href="javascript:;" onclick="toExchange()">立即兑换</a>
	
		<!-- 分享 -->
		<div class="det" style="height: 5rem;position:fixed;width: 100%;bottom: 0;">
			<ul class="download">
				<li><a id="downs" href="">下载瑞钱宝App</a></li>
				<li>赢取每日惊喜</li>
			</ul>
		</div>
		
		<div id="divshows1" style="display: none;">
			<!-- 没有中奖 -->
		    <div class="pop_serbox1">
				<p class="closeWin"></p>
				<p>抱歉，您当前等级不符合兑换要求</p>
				<a class="yes_btn1">去投资提升等级</a>
			</div>
		</div>	
		<div id="divshows2" style="display: none;">
			<!-- 没有中奖 -->
		    <div class="pop_serbox1">
				<p>您可享受当前服务<span class="vipNum">3</span>次</p>
				<a class="yes_btn2 yesNum">确定</a>
			</div>
		</div>	
		
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
						var ele ="";
						ele += '<img src="'+response.imgUrl+'" alt="" />';
						ele += '<div class="vipImg">VIP<span>'+response.level+'</span>专享</div>';
						$(".oPicImg").html(ele);
						$(".name").html(response.name);
						$(".priceMarket").html(response.priceMarket + "元");
						$(".priceInvest").html(response.priceInvest);
						$(".service_img").html(response.details);
						$(".price .level").html(response.level);
						
						/** 张金玉 2016-08-22 分享对应 下  */
						title = response.name;
						if (title.indexOf('&ldquo;') > -1) {
							var _start = title.indexOf('&ldquo;');
							if (_start > 0) {
								title = title.substring(0, _start) + '“' + title.substring(_start + 7);
							} else {
								title = '“' + title.substring(7);
							}
						}
						if (title.indexOf('&rdquo;') > -1) {
							var _start = title.indexOf('&rdquo;');
							if (_start > 0) {
								title = title.substring(0, _start) + '”' + title.substring(_start + 7);
							} else {
								title = title.substring(7) + '”';
							}
						}
						content = title;
						/** 张金玉 2016-08-22 分享对应 上 */
					},
					error : function (data) {
						alert("服务器错误,请联系管理员");
					}
				});
			})
		</script>	
	</body>
</html>
