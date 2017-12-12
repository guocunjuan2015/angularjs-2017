<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="UTF-8"%>
<%@ include file="/config/config.jsp" %>
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
    System.out.println("userApp:" + userApp);
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
    System.out.println("userAppId:" + userAppId);
    if (from != null && "app".equals(from) && userId != null
            && userId != "") {
        userId = userAppId;
        hs.setAttribute("userId", userId);
    } else if (hs != null) {
        userId = (String) hs.getAttribute("userId");
        if (userAppId == null || "null".equals(userAppId)) {
        	userAppId = userId;
        }
        if (userId == null) {
            userId = "";
        }
    }
    System.out.println("userId:" + userId);
    String lotteryName = request.getParameter("lotteryName");
    String type = request.getParameter("type");
%>  
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width,target-densitydpi= device-dpi,user-scalable=no">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/sys/user/award/css/all.css"/>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/sys/user/award/css/myGift.css" />		
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/clipboard.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.json.js" ></script>
		<script src="${pageContext.request.contextPath}/js/jquery.qrcode.min.js" type="text/javascript"></script>
		<script type="text/javascript">
			$(function(){
				$('title').html('我的礼物');
				$(".nav_myGift li").click(function(){
					var i = $(this).index();
					$(this).addClass("active_li").siblings().removeClass('active_li');
					$(".myView").eq(i).css("display","block").siblings().css('display',"none");
				});
				
				if("<%=lotteryName%>".indexOf("红包")>=0)
				{
				   $(".nav_myGift li:nth-child(2)").addClass("active_li").siblings().removeClass('active_li');
				   $(".myView2").css("display","block").siblings().css('display',"none");
				}else if("<%=lotteryName%>".indexOf("加息券")>=0){
					$(".nav_myGift li:nth-child(3)").addClass("active_li").siblings().removeClass('active_li')
					$(".myView3").css("display","block").siblings().css('display',"none");
				}else{
					$(".nav_myGift li:nth-child(1)").addClass("active_li").siblings().removeClass('active_li')
					$(".myView1").css("display","block").siblings().css('display',"none");
				}
				
				var code = "";
				var comment = {}; 
				comment.userId = '<%=userAppId%>';
				$.ajax({
					url : '<%=localPath%>/userAward/getUserAward',
					type : 'post',
					dataType : 'json',
					data : $.toJSON(comment),
					contentType: 'application/json;charset=utf-8', 
					success : function (data) {
						var _data = eval(data);
						var ele = "";
						$.each(_data.resultObject.giftList, function (index, items) {
				            if(items.type== "2"){
				            	ele += '<ul class="coupons">';
				            	ele += '  <li class="awardLi">';
				            	ele += '   <div class="giftShow clearfix">';
				            	ele += '     <div class="divLeft">';
				            	ele += '	    <p class="pImg"><img alt="" src="'+items.imgUrl+'"></p>';
				            	ele += '     </div>';
				            	ele += '     <div class="divRight">';
				            	ele += '        <p class="giftTxt">'+items.giftName+'</p>';
				            	ele += '	    <p class="getWay">'+items.source+'</p>';
				            	ele += '     </div>';	
				            	ele += '   </div>';
				            	ele += '	<div class="validity">'+items.validity+'</div>';
				            	ele += '  </li>';
				            	ele += '  <li class="couponNum">'+items.rule+' : <input class="foo" value="'+items.discount+'" data-clipboard-target=".foo" aria-label="复制成功"><a class="detail" href="'+items.targetUrl+'" style="margin-right:1.1rem;float: right;color: #63a5f6;">详情>></a></li>';
				            	ele += '</ul>';
				            }else if(items.type== "3"){
				            	ele += '<ul class="coupons">';
				            	ele += '  <li class="awardLi">';
				            	ele += '   <div class="giftShow clearfix">';
				            	ele += '     <div class="divLeft">';
				            	ele += '	    <p class="pImg"><img alt="" src="'+items.imgUrl+'"></p>';
				            	ele += '     </div>';
				            	ele += '     <div class="divRight">';
				            	ele += '        <p class="giftTxt">'+items.giftName+'</p>';
				            	ele += '	    <p class="getWay">'+items.source+'</p>';
				            	ele += '     </div>';	
				            	ele += '   </div>';
				            	ele += '	<div class="validity">'+items.validity+'</div>';
				            	ele += '  </li>';
				            	//ele += '  <li class="couponNum">'+items.rule+' : <input class="foo" value="'+items.discount+'" data-clipboard-target=".foo" aria-label="复制成功"></li>';
				            	if(items.urls!="" && items.urls!="undefined"){
				            	  ele += '  <li class="couponNum"><a style="color: #4d98f5;" href="'+items.urls+'">查看京东代金券</a></li>';
				            	}else{
				            		ele += '  <li class="couponNum">'+items.rule+' <span>'+items.discount+'</span></li>';
				            		//ele += '  <li class="couponNum"><a style="color: #4d98f5;" href="'+items.urls+'">查看京东代金券</a></li>';
				            	}
				            	ele += '</ul>';
				            	if("<%=type%>"=="water"){
				            	   ele += '<div id="code" style="margin: 0 auto; margin-top: 2rem; margin-bottom: 1rem; padding: 0; width: 200px;"></div>';
				            	}
				            	code = items.discount;
				            }else{
				            	ele += '<ul class="gift">';
				            	ele += '  <li class="awardLi">';
				            	ele += '    <div class="giftShow clearfix">';
				            	ele += '     <div class="divLeft">';
				            	ele += '	    <p class="pImg"><img alt="" src="'+items.imgUrl+'"></p>';
				            	ele += '     </div>';
				            	ele += '     <div class="divRight">';
				            	if(items.giftName.indexOf('投资送现金') > -1){
			                    ele += ' <p class="giftTxt">'+ items.giftName.substring(6) +' 元</p>';
			                } else {
			                    ele += ' <p class="giftTxt">'+items.giftName+'</p>';
			                 }
				            	ele += '	    <p class="getWay">'+items.source+'</p>';
				            	ele += '     </div>';	
				            	ele += '   </div>';
				            	ele += '	<div class="validity">'+items.validity+'</div>';
				            	ele += '  </li>';				            	
				            	ele += '  <li class="noGive">'+items.rule+'</li>';
				            	ele += '</ul>';
				            }				            
		        	 	});
						$(".myView1").append(ele);
						if("<%=type%>"=="water" && code != ""){
							$("#code").qrcode({
			     	            render: "canvas", //canvas方式 
			     	            width: 200, //宽度 
			     	            height:200, //高度 
			     	            text: code //任意内容 
			     	        });
						}
						for(var i= 0 ;i<_data.resultObject.giftList.length;i++){
							if(_data.resultObject.giftList[i].status=="expires"){
								$(".myView:nth-child(1) ul").eq(i).find(".validity").css("color","#fff");
								$(".myView:nth-child(1) ul").eq(i).find("li:nth-child(1)").css({"background":"#fff url(<%=basePath%>/sys/user/award/images/expires.png) no-repeat","background-size": "100% 100%","height":"116px"});
							}else if(_data.resultObject.giftList[i].status=="useds"){
								$(".myView:nth-child(1) ul").eq(i).find(".validity").css("color","#fff");
								$(".myView:nth-child(1) ul").eq(i).find("li:nth-child(1)").css({"background":"#fff url(<%=basePath%>/sys/user/award/images/useds.png) no-repeat","background-size": "100% 100%","height":"116px"});
							}else{
								$(".myView:nth-child(1) ul").eq(i).find("li:nth-child(1)").css({"background":"#fff url(<%=basePath%>/sys/user/award/images/gift.png) no-repeat","background-size": "100% 100%"});
							}
							if(_data.resultObject.giftList[i].rule == "已赠"){
								$(".myView:nth-child(1) ul").eq(i).find(".noGive").css({"text-decoration": "none","color":"#ccc"});
				            }
							if(_data.resultObject.giftList[i].rule==""||_data.resultObject.giftList[i].rule=="undefined"){
								$(".myView:nth-child(1) ul").eq(i).find(".noGive").css("display","none");
							}
						}
						
						var clipboard = new Clipboard('.foo');
						clipboard.on('success', function(e) {
							var msg = e.trigger.getAttribute('aria-label');
							alert(msg);
						    console.info('Action:', e.action);
						    console.info('Text:', e.text);
						    console.info('Trigger:', e.trigger);
						    e.clearSelection();
						});
						
					},
					error : function (data) {
						alert("服务器错误,请联系管理员");
					}
				})
				
				
				
				/* 红包 */
				$.ajax({
					url : '<%=localPath%>/couponRedEvp/getSuspend',
					type : 'post',
					dataType : 'json',
					data : $.toJSON(comment),
					contentType: 'application/json;charset=utf-8', 
					success : function (data) {
						var _data = eval(data);
						var ele = "";
						$.each(_data.resultObject.giftList, function (index, items) {	
				            ele += '<ul class="coupons">';
				            ele += '  <li class="redLi">';
				            ele += '   <div class="giftShow clearfix">';
				            ele += '     <div class="divLeft">';
				            ele += '	    <p class="money"><span>'+items.amount+'</span>'+items.unit+'</p>';
				            ele += '     </div>';
				            ele += '     <div class="divRight">';
				            ele += '        <p class="giftTxt">'+items.giftName+'</p>';
				           	ele += '	    <p class="getWay">'+items.source+'</p>';
				            ele += '     </div>';	
				            ele += '   </div>';
				            ele += '	<div class="validity">'+items.validity+'</div>';
				            ele += '  </li>';
				            ele += '  <div class="limitDiv">';
				            ele += '  	 <p class="start">'+items.startMoney+'</p>';	
				            ele += '     <p class="limit">'+items.rule+'</p>';
				            ele += '  </div>';
				            ele += '</ul>';
		        	 	});
						$(".myView2").append(ele);
						for(var i= 0 ;i<_data.resultObject.giftList.length;i++){
							if(_data.resultObject.giftList[i].status=="expires"){
								$(".myView:nth-child(2) ul").eq(i).find(".validity").css("color","#fff");
								$(".myView:nth-child(2) ul").eq(i).find("li:nth-child(1)").css({"background":"#fff url(<%=basePath%>/sys/user/award/images/expires.png) no-repeat","background-size": "100% 100%","height":"116px"});
							}else if(_data.resultObject.giftList[i].status=="useds"){
								$(".myView:nth-child(2) ul").eq(i).find(".validity").css("color","#fff");
								$(".myView:nth-child(2) ul").eq(i).find("li:nth-child(1)").css({"background":"#fff url(<%=basePath%>/sys/user/award/images/useds.png) no-repeat","background-size": "100% 100%","height":"116px"});
							}else{
								$(".myView:nth-child(2) ul").eq(i).find("li:nth-child(1)").css({"background":"#fff url(<%=basePath%>/sys/user/award/images/red.png) no-repeat","background-size": "100% 100%"});
							}
							if(_data.resultObject.giftList[i].startMoney==""||_data.resultObject.giftList[i].startMoney=="undefined"){
								$(".myView:nth-child(2) ul").eq(i).find(".start").css("display","none");
							}
							if(_data.resultObject.giftList[i].rule==""||_data.resultObject.giftList[i].rule=="undefined"){
								$(".myView:nth-child(2) ul").eq(i).find(".limit").css("display","none");
							}
						}
					},
					error : function (data) {
						alert("服务器错误,请联系管理员");
					}
				})
				
				
				/* 加息券 */
				$.ajax({
					url : '<%=localPath%>/appTicket/getTicketRecord',
					type : 'post',
					dataType : 'json',
					data : $.toJSON(comment),
					contentType: 'application/json;charset=utf-8', 
					success : function (data) {
						var _data = eval(data);
						var ele = "";
						$.each(_data.resultObject.giftList, function (index, items) {	
				            ele += '<ul class="coupons">';
				            ele += '  <li class="quanLi">';
				            ele += '   <div class="giftShow">';
				            ele += '     <div class="divLeft">';
				            ele += '	    <p class="money"><span>'+items.amount+'</span>'+items.unit+'</p>';
				            ele += '     </div>';
				            ele += '     <div class="divRight">';
				            ele += '        <p class="giftTxt">'+items.giftName+'</p>';
				           	ele += '	    <p class="getWay">'+items.source+'</p>';
				            ele += '     </div>';	
				            ele += '   </div>';
				            ele += '	<div class="validity">'+items.validity+'</div>';
				            ele += '  </li>';
				            ele += '  <div class="limitDiv">';
				            ele += '  	 <p class="start">'+items.startMoney+'</p>';	
				            ele += '     <p class="limit">'+items.rule+'</p>';
				            ele += '  </div>';
				            ele += '</ul>';
		        	 	});
						$(".myView3").append(ele);
						for(var i= 0 ;i<_data.resultObject.giftList.length;i++){
							if(_data.resultObject.giftList[i].status=="expires"){
								$(".myView:nth-child(3) ul").eq(i).find(".validity").css("color","#fff");
								$(".myView:nth-child(3) ul").eq(i).find("li:nth-child(1)").css({"background":"#fff url(<%=basePath%>/sys/user/award/images/expires.png) no-repeat","background-size": "100% 100%","height":"116px"});
							}else if(_data.resultObject.giftList[i].status=="useds"){
								$(".myView:nth-child(3) ul").eq(i).find(".validity").css("color","#fff");
								$(".myView:nth-child(3) ul").eq(i).find("li:nth-child(1)").css({"background":"#fff url(<%=basePath%>/sys/user/award/images/useds.png) no-repeat","background-size": "100% 100%","height":"116px"});
							}else{
								$(".myView:nth-child(3) ul").eq(i).find("li:nth-child(1)").css({"background":"#fff url(<%=basePath%>/sys/user/award/images/quan.png) no-repeat","background-size": "100% 100%"});
							}
							if(_data.resultObject.giftList[i].startMoney==""){
								$(".myView:nth-child(3) ul").eq(i).find(".start").css("display","none");
							}
							if(_data.resultObject.giftList[i].rule==""){
								$(".myView:nth-child(3) ul").eq(i).find(".limit").css("display","none");
							}
						}
					},
					error : function (data) {
						alert("服务器错误,请联系管理员");
					}
				})
			})			
		</script>
	</head>
	<body ng-app="ngRouteExample" class="ng-scope">
		<!--导航-->
		<section class="sec_nav">
			<ul class="nav_myGift">
		       	<li class="active_li">奖品</li>
		       	<li>红包</li>
		       	<li>加息券</li>
	    	</ul>
		</section>
	    <!--展示-->
	    <section>
	    	<div class="myView myView1" style="display: block;">
			</div>
			<div class="myView myView2">
			</div>
			<div class="myView myView3">
			</div>
	    </section>
	</body>
</html>
