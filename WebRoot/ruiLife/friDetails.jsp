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
<html ng-app="friDetailsApp">
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
			url       = '<%=basePath %>/ruiLife/friDetails.jsp?s=share&goodId=' + ${param.goodId};
			icon      = '<%=basePath %>/images/logo.png';
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
								// 已经报名
								$(".free_btn").html("已报名");
								$(".free_btn").attr("onclick" , "");
								$(".free_btn").css("background" , "#ccc");
							} else if (data.status == '4') {
								// 商品已兑完
								$(".free_btn").html("报名已结束");
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
			
			// 去报名
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

				// 报名
				$.ajax({
					url : '<%=basePath %>/appRlifeOrder/exchange.do',
					type : 'post',
					dataType : 'json',
					data : {
						goodId : ${param.goodId},
						userId : window.sessionStorage.getItem("userId"),
						type : "01"
					},
					success : function(data) {
						if (data.status == "2") {
							//商品不存在
							alert(data.msg);
						} else if (data.status == "0") {
							alert(data.msg);
						} else if (data.status == "1") {
							$(".PartInCount").html(data.partInCount);
							$("#divshows").css("display","block");
							$(".free_btn").html("已报名");
							$(".free_btn").attr("onclick" , "");
							$(".free_btn").css("background" , "#ccc");
						}
					},
					error : function (data) {
						alert("服务器错误,请联系管理员");
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
				
				$(".yes_btn").click(function(){
					$("#divshows").css("display","none");
				})
				
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
	<body ng-controller="friDetailCtrl">
		<!--图片展示-->
		<section class="pic-show">
			<p class="pic1">
				<!-- <img ng-src="{{pic1}}"/> -->
			</p>
			<p><b class="name"></b><span style="float: right;"><tt class="PartInCount"></tt>人&nbsp;&nbsp;已报名</span></p>
		</section>
		<!--价格详情-->
		<section class="price">
			<ul>
				<li>活动地址 : <b class="address"></b></li>
				<li>活动时间 : <b class="start"></b>&nbsp;--&nbsp;<b class="end"></b></li>
			</ul>
		</section>
	
		<!--服务详情-->
		<section class=" serviceDetails">
			<p class="service">活动详情</p>
			<div class="service_img"></div>
		</section>
		
		<a style="color:#fff !important;border:none;" class="free_btn" href="javascript:;" onclick="toExchange();">立即报名</a>
		
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
				<p>请在"<a class="a-service" href="javascript:;">我的瑞生活-瑞友汇</a>"中查看</p>
				<a class="yes_btn">确定</a>
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
						$(".pic1").append('<img src="'+response.imgUrl+'" />');
						$(".name").html(response.name);
						$(".priceMarket").html(response.priceMarket + "元");
						$(".priceInvest").html(response.priceInvest);
						$(".service_img").html(response.details);
						$(".start").html(response.dateStart);
						$(".end").html(response.dateEnd);
						$(".address").html(response.provider);
						
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
