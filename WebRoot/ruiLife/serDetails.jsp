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
<html ng-app="serDetailApp">
	<head>
		<script>
			var amount    = '';
			var projectId = '';
			var projectName = '';
			var period = '';
			var orderId = '';
			var projectType = '';
			var title     = '服务详情';
			var content   = '服务详情';
			var url       = '';
			var icon      = '';
		</script>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,target-densitydpi= device-dpi,user-scalable=no">
		<title>详情</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/ruiLife/css/all.css"/>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/ruiLife/css/index.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/ruiLife/framework/jquery.js" ></script>
<%-- 		<script type="text/javascript" src="${pageContext.request.contextPath}/ruiLife/framework/angular.min.js" ></script> --%>
<%-- 		<script type="text/javascript" src="${pageContext.request.contextPath}/ruiLife/js/public.js" ></script> --%>
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
		
			title     = '服务详情';
			content   = '服务详情';
			url       = '<%=basePath %>/ruiLife/serDetails.jsp?s=share&goodId=' + ${param.goodId};
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
									$(".PartInCount").html(data.partInCount);
									$(".free_btn").html("已兑换");
									$(".free_btn").attr("onclick" , "");
									$("#divshows").css("display","block");
									$(".free_btn").css("background" , "#ccc");
									
								}								
							},
							error : function (data) {
								alert('服务器内部错误,请联系管理员');
							}
						})
					}
				}
			}
			
			function toInvest() {
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
					url : '<%=basePath %>/appRlifeOrder/signUp.do',
					type : 'post',
					dataType : 'json',
					data : {
						goodId : ${param.goodId},
						userId : window.sessionStorage.getItem("userId"),
						type : '00'
					},
					success : function(data) {
						if (data.status == "2") {
							$(".free_btn").css("background" , "#ccc");
							$(".free_btn").html("该产品已下架");
							//alert(data.msg);
						} else if (data.status == "0") {
							alert(data.msg);
						} else if (data.status == "1") {
							orderId = data.orderId;
							amount = $("#investAmount").val();
							projectId = $("#projectId").val();
							projectName = $("#projectName").val();
							period = $("#period").val();
							projectType = '1';
							IOSModel.toInvest({
								"amount" : amount,
								"projectId" : projectId,
								"projectName" : projectName,
								"projectType" : '1',
								"orderId" : orderId+"",
								"peroid" : period
							});
							if (isAndroidOrIos()) {
								appFunction('toInvest');
							}
						}
					},
					error : function (data) {
						alert("服务器错误,请联系管理员");
					}
				}); 
			}
			
			// 判断用户是否已参加此次活动
			function isJoin(userId) {
				if(userId) {
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
			
			function checkLoan(obj) {
				$("#projectName").val($(obj).parent().find(".projectName").val());
				$("#projectId").val($(obj).parent().find(".projectId").val());
				$("#period").val($(obj).parent().find(".period").val());
				$("#investAmount").val($(obj).parent().find(".investAmount").val());
			}
			$(function(){
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
			})
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
				<b class="name"></b> 
				<span style="float: right;"><tt class="PartInCount"></tt>人&nbsp;&nbsp;已兑换</span>
			</p>
		</section>
		<!--价格详情-->
		<section class="price">
			<ul>
				<li>市场价:<del class="priceMarket">元</del></li>
				<li>年化投资 : <span class="priceInvest"></span>元&nbsp;&nbsp;&nbsp;可兑换</li>
				<div id="aaa">
					<p class="p1">投资推荐:</p>
					<div class="period"></div>
					<p class="prompt">提示:瑞服务投资类型，不可参与债权转让</p>
				</div>
			</ul>
		</section>
	
		<!--服务详情-->
		<section class=" serviceDetails">
			<p class="service">服务详情</p>
			<div class="service_img">
				
			</div>
		</section>
		
		<!--详情页面底部按钮-->
		<a style="color:#fff !important;border:none;" class="free_btn" href="javascript:;" onclick="toInvest()">投资免费送</a>
		
		<!-- 分享 -->
		<div class="det" style="height: 5rem;position:fixed;width: 100%;bottom: 0;">
			<ul class="download">
				<li><a id="downs" href="">下载瑞钱宝App</a></li>
				<li>赢取每日惊喜</li>
			</ul>
		</div>
		
		<div id="divshows" style="display:none">
		    <div class="pop_serbox">
				<p>恭喜您兑换成功</p>
				<p>请在"<a class="a-service" href="javascript:;">我的瑞生活-瑞服务</a>"中查看</p>
				<a class="yes_btn" href="#" id="aaa">确定</a>
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
				
				$.ajax({
					url : '<%=localPath %>/loan/rYWelfare',
					type : 'post',
					dataType : 'json',
					data : {
						amount : $(".priceInvest").html(),
						count : "5"
					},
					success : function(data) {
						console.log(data.loanList);
						var ele="";
						$.each(data.loanList, function (index, items) {
							ele += '<div class="periodUl">';
							ele += '   <p class="month" onclick="checkLoan(this)" id="'+items.loanId+'">'+items.loanPeriod+'月期</p>';	
							ele += '   <input type="hidden" class="projectName" value="'+items.projectName+'"/>';
							ele += '   <input type="hidden" class="projectId" value = "'+items.loanId+'"/>';
							ele += '   <input type="hidden" class="period" value = "'+items.loanPeriod+'"/>';
							ele += '   <input type="hidden" class="investAmount" value = "'+items.investAmount+'"/>';
							ele += '</div>';
							if (index == 0) {
								$("#projectName").val(items.projectName);
								$("#projectId").val(items.loanId);
								$("#period").val(items.loanPeriod);
								$("#investAmount").val(items.investAmount);
							}
						});
						$("#aaa .period").append(ele);
						$("#aaa .period .periodUl").eq(0).addClass("periodUl-active");
						$("#aaa .period .periodUl").click(function(){
							$(this).addClass("periodUl-active").siblings().removeClass('periodUl-active');
					 	});
					},
					error : function (data) {
						alert("服务器错误,请联系管理员");
					}
				});
			})
		</script>	
	</body>
</html>
