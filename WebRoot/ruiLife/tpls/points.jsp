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
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width,target-densitydpi= device-dpi,user-scalable=no">
	    <script type="text/javascript" src="${pageContext.request.contextPath}/ruiLife/js/public.js" ></script>
		<script  type="text/javascript">
			$(document).ready(function(){
				// 判断是否登录
				isLogin(window.sessionStorage.getItem("userId"));
			})
			
			// 判断是否登录
			function isLogin(userId) {
				if (userId) {
					$.ajax({
						url : '<%=basePath %>/appPoint/getAvailablePoints.do',
						type : 'post',
						dataType : 'json',
						async : false,
						data : {
							userId : userId
						},
						success : function(data) {
							$("#userPoint").val(data.result);
							$(".coin_red").html(data.result);
							$(".coin_red").attr("onclick", "");
							$(".points li").css("margin-left", "38%");
						},
						error : function (data) {
							alert("温馨提示-服务器错误");	
						}
					})
				}
			}
			
			function toNextPage(obj) {
				url ='<%=basePath %>/ruiLife/pointDetails.jsp?userPoint=' + $("#userPoint").val() + '&goodId=';
				var rlifeid=$(obj).find(".rlifeGood").val();
				url += rlifeid;
				title = "积分详情";
				IOSModel.toNextPage({
					"url":url,
					"title":title
				});
				if (isAndroidOrIos()) {
					appFunction('toNextPage');
				}
			}
			
			function toLogin() {
				IOSModel.login();
				if (isAndroidOrIos()) {
					appFunction('login');
				}
			}
		</script>
	</head>
	<body>
		<div class="view" ng-controller="PointsCtrl">
			<input type="hidden" id="userPoint"/>
			<section style="clear: both;">
			    <p class="core_img">
					<a href="javascript:;" onclick="toNextPage(this);">
						<input type="hidden" class="rlifeGood" value="{{bannerGoods.id}}"/>
						<img style="display:none"  src="{{bannerGoods.imgUrl}}" alt="">
					</a>
			    </p>
				<ul class="points">
					<li style="margin-left: 41%;">
						<p class="coin_img"><img src="img/coin.png" alt=""/></p>
						<p class="coin_num coin_red" onclick="toLogin()">请登录</p>
					</li>
<!-- 					<li><img src="img/rr.png" alt=""/</li> -->
<!-- 					<li> -->
<!-- 						<p class="coin_img"></p> -->
<!-- 						<p class="coin_num">兑换记录</p> -->
<!-- 					</li> -->
				</ul>
			</section>
			<section class="_show">
				<ul class="show_gift">
					<li ng-repeat="rlifeGood in rLifeGoods">
					 <a href="javascript:;" onclick="toNextPage(this);">
						<p class="show_img">
								<input type="hidden" class="rlifeGood" value="{{rlifeGood.id}}"/>
								<img style="height:80px;" src="{{rlifeGood.imgUrl}}" alt=""/>
						</p>
						<p class="show_car">{{rlifeGood.name}}</p>
						<p class="show_coin"><strong>{{rlifeGood.point}}&nbsp;&nbsp;</strong>积分</p>
					  </a>
					</li>
				</ul>
			</section>
		</div>
	</body>
</html>
