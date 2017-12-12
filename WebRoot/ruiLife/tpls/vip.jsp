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
		<script type="text/javascript">
			
			// 判断是否登录
			function isLogin(userId) {
				if (userId) {
					$.ajax({
						url : '<%=basePath %>/appPoint/getVipLevel.do',
						type : 'post',
						dataType : 'json',
						data : {
							userId : userId
						},
						success : function(data) {
							$("#vipLevel").val(data.result);
						},
						error : function (data) {
							alert("温馨提示-服务器错误");	
						}
					})
				}
			}
			
			function toNextPage(obj) {
				url ='<%=basePath %>/ruiLife/vipDetails.jsp?vipLevel=' + $("#vipLevel").val() + '&goodId=';
				var rlifeid=$(obj).find(".rlifeGood").val();
				url += rlifeid;
				title = "VIP详情";
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
	<body>
		<div class="view" ng-controller="VipCtrl">
			<input type="hidden" id="vipLevel"/>
			<section class="recommend">
				<p class="recom">推荐</p>
				<ul class="hiSlider">
					<li  class="hiSlider-item">
						<a href="javascript:;" onclick="toNextPage(this);">
							<input type="hidden" class="rlifeGood" value="{{bannerGoods.id}}"/>
							<img src="{{bannerGoods.imgUrl}}" alt="">
						</a>
					</li>
					<!-- <li  class="hiSlider-item">
						<a href="javascript:;" onclick="toNextPage(this);">
							<input type="hidden" class="rlifeGood" value="{{id1}}"/>
							<img src="{{imgUrl1}}" alt="">
						</a>
					</li>
					<li  class="hiSlider-item">
						<a href="javascript:;" onclick="toNextPage(this);">
							<input type="hidden" class="rlifeGood" value="{{id2}}"/>
							<img src="{{imgUrl2}}" alt="">
						</a>
					</li> -->
				</ul>
				<script>
// 					 $('.hiSlider').hiSlider();
				</script>
				<!-- banner end -->
			</section>
	 		<section>
				<p class="all">全部</p>
				<div class="oAll1">				
					<!-- <div class="oImg">
						<img src="img/2.png" />
						<p class="vipP">VIP<span>8</span>专享</p>
					</div> -->
					<ul>
						<li ng-repeat="rlifeGood in rLifeGoods">
						  <a href="javascript:;" onClick="toNextPage(this);">
							<p class="vip8">								
								<input type="hidden" class="rlifeGood" value="{{rlifeGood.id}}"/>
								<img src="{{rlifeGood.imgUrl}}" alt="" />
									<p class="vipP">VIP<span>{{rlifeGood.level}}</span>专享</p>
							</p>
							<p class="txt_p">{{rlifeGood.name}}</p>
						  </a>
						</li>
					</ul>
				</div>
			</section>
		</div>
	</body>
</html>
