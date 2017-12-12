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
<html ng-app="pointDetailsApp">
	<head>
		<script>
		var title     = '积分详情';
		var content   = '积分详情';
		var url       = '';
		var icon      = '';
		</script>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,target-densitydpi= device-dpi,user-scalable=no">
		<title>详情</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/ruiLife/css/all.css"/>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/ruiLife/css/index.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/ruiLife/framework/jquery.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/json2.js" ></script>
		<script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
    	<script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
    	<script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
		<script type="text/javascript">
			title     = '积分详情';
			content   = '积分详情';
			url       = '<%=basePath %>/ruiLife/pointDetails.jsp?s=share&goodId=' + ${param.goodId};
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
							userId : userId
						},
						async : false,
						success : function (data) {
							/* if (data.status == '3') {
								$(".free_btn").html("已兑换");
								$(".free_btn").attr("onclick" , "");
								$(".free_btn").css("background" , "#ccc");	
								
							} else  */
								if (data.status == '4') {
								// 商品已兑完
								$(".free_btn").html("商品已兑完");
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
						type : '03'
					},
					async : false,
					success : function (data) {
						if (data.status == '0') {
							$("#divshows1").css("display","block");
							//$("#divshows1 .vipSpan").html(data.points);
						} else if (data.status == '1') {
							$(".free_btn").html("已兑换");
							$(".free_btn").attr("onclick" , "");
							$(".free_btn").css("background" , "#ccc");
							$(".PartInCount").html(data.partInCount);
							$("#divshows").css("display","block");
							//alert(data.msg);	
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
				
				$(".yes_btn").on("touchend", function() {
					$("#divshows").css("display","none");
				})
				
				$(".yes_btn1").on("touchend", function() {
					$("#divshows1").css("display","none");
					if ($(".yes_btn1").html() == '去投资获得积分') {
						IOSModel.toIosInvest();
						appFunction('invest');
					}
				})
				
				$(".closeWin").on("touchend", function() {
					$("#divshows1").css("display","none");
				});
				
				if ("<%=s %>" == 'share') {
					$(".free_btn").hide();
					$(".det").show();
				} else {
					$(".free_btn").show();
					$(".det").hide();
				}
				
			})
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
				<li>市场价 : <del class="priceMarket"></del></li>
				<li>所需积分 : <span class="pointSpan"></span>积分&nbsp;&nbsp;&nbsp;可兑换</li>
			</ul>
		</section>
	
		<!--服务详情-->
		<section class=" serviceDetails">
			<p class="service">商品详情</p>
			<ul class="service_img">
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
		
		<div id="divshows" style="display: none;">
		    <div class="pop_serbox">
				<p>恭喜您兑换成功,</p>
				<p>请在"<a class="a-service" href="javascript:;">我的瑞生活-积分兑换</a>"中查看</p>
				<a class="yes_btn">确定</a>
			</div>
		</div>	
		<div id="divshows1" style="display: none;">
			<!-- 没有中奖 -->
		    <div class="pop_serbox1">
		    	<p class="closeWin"></p>
				<p class="pointNo">抱歉,您当前积分不足</p>
				<a class="yes_btn1">去投资获得积分</a>
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
						$(".oPicImg").append('<img src="'+response.imgUrl+'" />');
						$(".name").html(response.name);
						$(".priceMarket").html(response.priceMarket + "元");
						$(".pointSpan").html(response.point);
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
