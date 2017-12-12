<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*,java.net.URLDecoder"
    pageEncoding="UTF-8"%>
<%
    HttpSession hs = request.getSession();
    String user = "";//用户名
    String userId = "";//用户userId
    String userHex = "";//hex编码的用户名，分享出去用到，app转进来需要解码

    //String localPath = "http://www.rqbao.com/"; 
    //String basePath = "http://www.rqbao.com/rqb"; 
  	String localPath = "http://test.rqbao.com/rqt";
  String basePath = "http://test.rqbao.com/rqb";
    //boolean flag=false;
    //String basePath = "http://www.rqbao.com";
   // String rqtPath="http://www.rqbao.com/static_3 /active/facetoface";
   //String testPath="http://123.57.77.184/rqt/static_3/active/facetoface";
    
    String from = request.getParameter("from");
    if (from == null || !("app".equals(from))) {
        from = "";
    }
    System.out.println("aft:" + from);
    String referHex = request.getParameter("referrer");//获得的推荐人是Hex编码
    String refer = "";
    if (referHex == null) {
        refer = "";
    } else {
        //refer需要Hex解码
        if (referHex != null) {
            byte[] bs = Hex.decodeHex(referHex.toCharArray());
            refer = new String(bs);
        }
    }
    String userApp = request.getParameter("user");
    if (from != null && "app".equals(from) && userApp != null
            && userApp != "") {
        user = userApp;
        hs.setAttribute("loginUser", user);
        //app上无分享功能
    } else if (hs != null) {
        user = (String) hs.getAttribute("loginUser");
        if (user == null) {
            user = "";
        }
        if (user != null && user != "") {
            userHex = Hex.encodeHexString(user.getBytes());//将用户Hex编码，用于分享
            
        } else {
            userHex = "";
        }
    }
    String userAppId = request.getParameter("userId");
    if (from != null && "app".equals(from) && userId != null
            && userId != "") {
        userId = userAppId;
        hs.setAttribute("userId", userId);
        //app上无分享功能
    } else if (hs != null) {
        userId = (String) hs.getAttribute("userId");
        if (userId == null) {
            userId = "";
        }
    }
    
    String phone = request.getParameter("phone");
    String lotteryId = request.getParameter("lotteryId");
%>  

<%@ include file="config/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
	<title></title>
    <meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
    <meta name="description" content="瑞钱宝互联网金融平台投资越多惊喜越多,年收化率7%-13.5%，
    	活动期间你可以选择适合您的理财产品，活动期间设置自动幸运抽奖区，投资理财奖品主要有三星电视、九阳榨汁机、iphone 6s 等，活动时间6月6日-6月24日。" />
 	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
 	<link href="css/common2.css" rel="stylesheet"/>
	<link rel="stylesheet" type="text/css" href="css/wechat2.css">
    <link href="active/66active/66active.css" rel="stylesheet">
  	<link href="css/animate.min.css" rel="stylesheet" />
 	  <script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
		<script src="js/jweixin-1.0.0.js" type="text/javascript"></script>
		<script src="js/frame/ios_js.js" type="text/javascript"></script>
    <script src="js/weixin_share.js" type="text/javascript"></script>
    <script type="text/javascript" src="active/66active/js/awardRotate.js"></script>
    <script type="text/javascript" src="active/66active/js/jquery.qrcode.min.js"></script>
    <script type="text/javascript" src="js/json2.js"></script>
	<style>
		ul{padding-left:0;}
		h3{margin-top:0;}
	</style>
 	<script type="text/javascript" src="js/clipboard.min.js"></script>
	<script>
		/*标题 */
		function showShare(){
			  IOSModel.changeWebTitle("感恩六月,从心出发");
			}
		/*分享好友*/
		$(function(){
		    title = "感恩六月,从心出发";
		    content = "感恩六月,从心出发豪礼送家人大奖谢知音!";
		    icon = "http://www.rqbao.com/rqb/images/logo/lotteryLogo.png";
		    url  = 'http://www.rqbao.com/rqb/66active.jsp';
		   // getReferenceRank();
		    weixinShare(title,content,icon,url,'<%=basePath%>');
		});
	
	</script>
	<script type="text/javascript">
		//手机号码输入校验
		$(function(){
			var message=$("#message").val();
		    if(message!="" && message!=null ){
		    	alert(message);
		    } 
		    $("#closeWindow").click(function(){
		    	$("#divshows").css("display","none");
		    	window.location.reload();
		    })
		    $.ajax({
		         url:'<%=localPath %>/lotteryAward/activeResp66',
		         type:'POST',
		         data : {userId: "<%=userAppId%>", 
		        	 	 phone : "<%=phone%>",
		        	 	 lotteryId: "<%=lotteryId%>",
		        	 	 loginName: "<%=userApp %>"},
		         dataType:'json',
		         async : false,
		         beforeSend: function(XMLHttpRequest) {  
		             XMLHttpRequest.setRequestHeader("Accept", "text/plain");  
		         },
		         success:function(data){
		        	// 判断活动是否到期
		         	if (!data.isPeriod) {
		         		$("#turntableNum").val(data.turntableNum);
		         		var str = "";
		         		var strImg = "";
		         		var dangwei = "";
		         		if (data.user != null && data.user != "") {
		         			$("#loginName").val(data.user.loginName);
		         			if (data.lotteryNumber != null) {
		         				if (data.lotteryNumber.lotteryNumber4 > 0) {
		         					str += '<div class="pointer" style="top:27%">';
                                    str += '	<b style="left:15%;top:45%;font-size:1.6rem">可抽奖<font class="values">';
                                    str += data.lotteryNumber.lotteryNumber4 + '</font>次</b>';
                             		str += '</div>';
                             		$(".turntable-bg").append(str);
                             		strImg += '<img id="rotate" src="<%=basePath%>/active/66active/image/turntable1.png" alt="turntable"/>';
		         					$(".turntable-bg .rotate").append(strImg);
		         					dangwei += '<p class="noInfor"><span><a href="#aFile">A档</a></span></p>';
		         					dangwei += '<p class="noInfor">您当前投资总额：' + data.investTotal + ' 元</p>';
		         					$(".turntableBox .centerdiv .investInfo").append(dangwei);
		         				} else if (data.lotteryNumber.lotteryNumber3 > 0) {
		         					str += '<div class="pointer" style="top:27%">';
                                    str += '	<b style="left:14%;top:45%;font-size:1.6rem">可抽奖<font class="values">';
                                    str += data.lotteryNumber.lotteryNumber3 + '</font>次</b>';
                             		str += '</div>';
                             		$(".turntable-bg").append(str);
                             		strImg += '<img id="rotate" src="<%=basePath%>/active/66active/image/turntable2.png" alt="turntable"/>';
		         					$(".turntable-bg .rotate").append(strImg);
		         					dangwei += '<p class="noInfor"><span><a href="#bFile">B档</a></span></p>';
		         					dangwei += '<p class="noInfor">您当前投资总额：' + data.investTotal + '  元</p>';
		         					$(".turntableBox .centerdiv .investInfo").append(dangwei);
		         				} else if (data.lotteryNumber.lotteryNumber2 > 0) {
		         					str += '<div class="pointer" style="top:27%">'; 
                                    str += '	<b style="left:14%;top:45%;font-size:1.6rem">可抽奖<font class="values">';
                                    str += data.lotteryNumber.lotteryNumber2 + '</font>次</b>';
                             		str += '</div>';
                             		$(".turntable-bg").append(str);
                             		strImg += '<img id="rotate" src="<%=basePath%>/active/66active/image/turntable3.png" alt="turntable"/>';
		         					$(".turntable-bg .rotate").append(strImg);
		         					dangwei += '<p class="noInfor"><span><a href="#cFile">C档</a></span></p>';
		         					dangwei += '<p class="noInfor">您当前投资总额：' + data.investTotal + '  元</p>';
		         					$(".turntableBox .centerdiv .investInfo").append(dangwei);
		         				} else if (data.lotteryNumber.lotteryNumber1 > 0) {
		         					str += '<div class="pointer" style="top:27%">';
                                    str += '	<b style="left:14%;top:45%;font-size:1.6rem">可抽奖<font class="values">';
                                    str += data.lotteryNumber.lotteryNumber1 + '</font>次</b>';
                             		str += '</div>';
                             		$(".turntable-bg").append(str);
                             		strImg += '<img id="rotate" src="<%=basePath%>/active/66active/image/turntable4.png" alt="turntable"/>';
		         					$(".turntable-bg .rotate").append(strImg);
		         					dangwei += '<p class="noInfor"><span><a href="#dFile">D档</a></span></p>';
		         					dangwei += '<p class="noInfor">您当前投资总额：' + data.investTotal + '  元</p>';
		         					$(".turntableBox .centerdiv .investInfo").append(dangwei);
		         				} else {
		         					str += '<div class="pointer1" style="background:none;top:18%;left:28%;">';
		                            str += '<b><a style="margin-top:0;margin-left:8%;" href="<%=basePath %>/project.jsp"><img  src="<%=basePath%>/active/66active/image/pointer2.png" alt="turntable"/></a></b>';
		                          	str += '</div>';
		                          	$(".turntable-bg").append(str);
		                          	strImg += '<img id="rotate" src="<%=basePath%>/active/66active/image/turntable1.png" alt="turntable"/>';
		                          	$(".turntable-bg .rotate").append(strImg);
		                          	dangwei += '<p class="noInfor"><span><a href="#aFile">A档</a></span></p>';
		         					dangwei += '<p class="noInfor">您当前投资总额：' + data.investTotal + ' 元</p>';
		         					$(".turntableBox .centerdiv .investInfo").append(dangwei);
		         				}
		         			} else {
		         				//alert("data.lotteryNumber----------为空");
		         				str += '<div class="pointer1">';
	                            str += '<b><a style="margin-top:10%;margin-left:14%;" href="<%=basePath%>/project.jsp"><img  src="<%=basePath%>/active/66active/image/pointer2.png" alt="turntable"/></a></b>';
	                          	str += '</div>';
	                          	$(".turntable-bg").append(str);
		         				strImg += '<img id="rotate" src="<%=basePath%>/active/66active/image/turntable1.png" alt="turntable"/>';
	         					$(".turntable-bg .rotate").append(strImg);
	         					dangwei += '<p class="noInfor"><span><a href="#aFile">A档</a></span></p>';
	         					dangwei += '<p class="noInfor">您当前投资总额：' + data.investTotal + ' 元</p>';
	         					$(".turntableBox .centerdiv .investInfo").append(dangwei);
		         			}
		         		} else {
		         			//alert("user---为空");
		         			var str = "";
		         			str += '<div class="pointer1" style="background:none;top:15%;left:28%;">';
			              	str += '	<b><a style="margin-top:10%;margin-left:14%;font-size:2rem;" href="<%=basePath %>/login.jsp?active=66"><img  src="<%=basePath%>/active/66active/image/pointer1.png" alt="turntable"/></a></b>'; 
			              	str += '</div>';
		         			$(".turntable-bg").append(str);
		         			strImg += '<img id="rotate" src="<%=basePath%>/active/66active/image/turntable1.png" alt="turntable"/>';
         					$(".turntable-bg .rotate").append(strImg);
		         			dangwei += '<p class="noInfor">您当前投资额：暂无信息</p>';
         					$(".turntableBox .centerdiv .noInfor").append(dangwei);
		         		}
		         		showDialog(data.LotteryRecord, data.userName);
		         	}
		         },
		         error:function(data){
		           alert("服务器错误，请找管理员！");
		         }
	        });
		    
		    function showDialog(lotteryRecord, userName) {
		    	if (lotteryRecord != null && lotteryRecord != undefined) {
		    		var str = "";
		    		if (lotteryRecord.type == "2") {
		    			if (lotteryRecord.lottery_id== '13' || 
		    					lotteryRecord.lottery_id== '23'|| 
		    					lotteryRecord.lottery_id== '34'|| 
		    					lotteryRecord.lottery_id== '44') {
			    			str += '<img src="<%=basePath%>/active/66active/image/reward4.png"/>';
				            str += '  <br>足疗机';
		    			} else if (lotteryRecord.lottery_id== '12' || lotteryRecord.lottery_id== '22') {
		    				str += '<img src="<%=basePath%>/active/66active/image/reward24.png"/>';
			                str += '  <br>帕森偏光太阳镜';
		    			} else if (lotteryRecord.lottery_id== '11' || 
		    					lotteryRecord.lottery_id== '36' || 
		    					lotteryRecord.lottery_id== '45') {
		    				str += '<img src="<%=basePath%>/active/66active/image/reward23.png"/>';
			                str += '  <br>56头景德镇骨瓷餐具套装';
		    			} else if (lotteryRecord.lottery_id== '14') {
		    				str += '<img src="<%=basePath%>/active/66active/image/reward25.png"/>';
			                str += '  <br>扫地机器人';
		    			} else if (lotteryRecord.lottery_id== '15'){
		                 	str += '<img src="<%=basePath%>/active/66active/image/reward27.png"/>';
		                  	str += '<br>多功能防水登山包';
		    			} else if (lotteryRecord.lottery_id== '16') {
		                 	str += '<img src="<%=basePath%>/active/66active/image/reward28.png"/>';
		                  	str += '<br>水杯';
		    			} else if (lotteryRecord.lottery_id== '17') {
		                 	str += '<img src="<%=basePath%>/active/66active/image/reward9.png"/>';
		                  	str += '<br>公益捐助20';
		    			} else if (lotteryRecord.lottery_id== '18' || 
		    					lotteryRecord.lottery_id== '28' || 
		    					lotteryRecord.lottery_id== '37' || 
		    					lotteryRecord.lottery_id== '47') {
		                 	str += '<img src="<%=basePath%>/active/66active/image/reward29.png"/>';
		                  	str += '<br>公益捐助30';
		    			} else if (lotteryRecord.lottery_id== '21' || 
		    					lotteryRecord.lottery_id== '35' || 
		    					lotteryRecord.lottery_id== '46' || 
		    					lotteryRecord.lottery_id== '47') {
		                 	str += '<img src="<%=basePath%>/active/66active/image/reward14.png"/>';
		                  	str += '<br>户外蓝牙音箱';
		    			} else if (lotteryRecord.lottery_id== '24') {
		                 	str += '<img src="<%=basePath%>/active/66active/image/reward18.png"/>';
		                  	str += '<br>上海迪士尼门票';
		    			} else if (lotteryRecord.lottery_id== '25') {
		                 	str += '<img src="<%=basePath%>/active/66active/image/reward20.png"/>';
		                  	str += '<br>飞利浦耳机（SHM7110）';
		    			} else if (lotteryRecord.lottery_id== '26') {
		                 	str += '<img src="<%=basePath%>/active/66active/image/reward21.png"/>';
		                  	str += '<br>LED星空投影灯(蓝牙版)';
		    			} else if (lotteryRecord.lottery_id== '27' || 
		    					lotteryRecord.lottery_id== '38' || 
		    					lotteryRecord.lottery_id== '48') {
		    				str += '<img src="<%=basePath%>/active/66active/image/reward29.png"/>';
				            str += '<br>公益捐助56';		    			
				        } else if (lotteryRecord.lottery_id== '31' || 
				        		lotteryRecord.lottery_id== '43') {
				        	str += '<img src="<%=basePath%>/active/66active/image/reward9.png"/>';
				            str += '<br>脊椎护腰坐垫';
				        } else if (lotteryRecord.lottery_id== '32') {
				        	str += '<img src="<%=basePath%>/active/66active/image/reward10.png"/>';
				            str += '<br>Kindle电子书';
				        } else if (lotteryRecord.lottery_id== '33') {
				        	str += '<img src="<%=basePath%>/active/66active/image/reward11.png"/>';
		                    str += '<br>坚果投影仪'
				        } else if (lotteryRecord.lottery_id== '41') {
				        	str += '<img src="<%=basePath%>/active/66active/image/reward1.png"/>';
				            str += '<br>三星75寸4K高清平板电视';
				        } else if (lotteryRecord.lottery_id== '42') {
				        	str += '<img src="<%=basePath%>/active/66active/image/reward2.png"/>';
				            str += '<br>6s  64G';
				        }
		    			$("#divshows1 #light .modal-content .starImage").append(str);
		    			$("#divshows1 #light .modal-content .telNum").html(userName + " 给您送礼啦！");
		    			$("#receiveSave").attr("action", "<%=localPath %>/lotteryAward/giving?lotteryId=" + lotteryRecord.user_id+lotteryRecord.id);
		    			$("#divshows1").css("display", "block");
		    		}
		    	}
		    }
		    
		    // 投资排行榜
		    if(typeof(EventSource) != "undefined"){
		        var source = new EventSource("<%=localPath%>/lotteryAward/investHistoryResp66");
		        source.onmessage = function(event){
		            // console.log("event.data--投资排行榜-- "+event.data);
		            var items = eval(event.data);
		            var ele = "";
		            for(var i = 0;i < items.length;i++){
		            	if (items[i].amount > 0) {
			                // var name = items[i].name;
			                var amount = items[i].amount;
			                ele += '<li>';
				            ele += '<font style="float:left;width:20%;">' + items[i].name + '</font>';
				            ele += '<span style="float:left;width:40%;text-align:left;">投资￥&nbsp;'+amount+'</span>'; 
			                ele += '<font style="float:right;width:35%;text-overflow:ellipsis;white-space:nowrap;overflow: hidden;">抽奖' +items[i].lottery+ '</font>'; 
		            		ele += '</li>';
		            	}
		            }
		           $(".chargechoose-tab1 .investList").html(ele);
		           $("#scroll_begin").html(ele);
		        }
		        
		     	// 邀请投资排行榜
		        var source1 = new EventSource("<%=localPath%>/lotteryAward/getInviteActiveResp66");
		        source1.onmessage = function(event){
		            // console.log("event.data --邀请排行榜-- "+event.data);
		            var items = eval(event.data);
		            var ele = "";
		            for(var i = 0;i < items.length;i++) {
		            	if (items[i].amount > 0) {
			                // var name = items[i].name;
			                var amount = items[i].amount;
			                ele += '<li>';
				            ele += '<font style="float:left;width:30%;">' + items[i].name + '</font>';
				            ele += '<span style="float:left;width:50%;text-align:left;">投资￥&nbsp;'+amount+'</span>'; 
		            		ele += '</li>';
		            	}
		            }
		           console.log("event.data --邀请排行榜-- "+ele);
		           $(".chargechoose-tab2 .investList").html(ele);
		        }
		        
		     	// 公益榜
		        var source2 = new EventSource("<%=localPath%>/lotteryAward/getWelfareactiveResp66");
		        source2.onmessage = function(event){
		            // console.log("event.data --公益榜--- "+event.data);
		            var items = eval(event.data);
		            var ele = "";
		            for(var i = 0;i < items.length;i++){
		            	if (items[i].amount > 0) {
			                // var name = items[i].name;
			                var amount = items[i].amount;
			                ele += '<li>';
				            ele += '<font style="float:left;width:20%;">' + items[i].name + '</font>';
				            ele += '<span style="float:left;width:30%;text-align:left;">投资￥&nbsp;'+amount+'</span>'; 
			                ele += '<font style="float:right;width:40%;text-overflow:ellipsis;white-space:nowrap;overflow: hidden;">中奖' +items[i].lottery+ '</font>'; 
		            		ele += '</li>';
		            	}
		            }
		           $(".chargechoose-tab3 .investList").html(ele);
		        }
		    }else{
		        alert("浏览器不支持EventSource");
		    }
		    
		    
		    
		    $("#getValidateSMS").click(function(){
		       var phoneNumber = $("#mobile").val();
		       if(phoneNumber==''|| phoneNumber==null){
		            $("#mobile_info").text("手机号码不能为空");
		            return;
		       } else {
		          	$("#mobile_info").text("");
	           }
		       $.ajax({
		         url:'<%=localPath %>/lotteryAward/genCode2?phoneNumber='+phoneNumber,
		         type:'POST',
		         contentType:'application/json',
		         dataType:'json',
		         beforeSend: function(XMLHttpRequest){  
		             XMLHttpRequest.setRequestHeader("Accept", "text/plain");  
		         },
		         success:function(data){
		           alert("发送成功");
		         },
		         error:function(data){
		           alert("发送失败");
		         }
		       });
		     })
		     
			/*关闭获奖遮罩层 */
			$("#sureBtn").click(function(){
			   $("#divshows").css("display","none");
			   window.location.reload();
			})
			
			var rotateTimeOut = function (){
			  	$('#rotate').rotate({
				    angle:0,
				    animateTo:2160,
				    duration:8000,
				    callback:function (){
				      alert('网络超时，请检查您的网络设置！');
				    }
			  	});
			};
			var bRotate = false;
			var rotateFn = function (awards, angles, txt) {
			  bRotate = !bRotate;
			  $('#rotate').stopRotate();
			  $('#rotate').rotate({
		      	angle:0,
		    	animateTo:angles+1800,
		    	duration:8000,
		    	callback:function (){
		        	$("#divshows").css("display","block");
			      	$(".masks").css("display","none");
			      	$("#priceValue").text(txt);
			      	bRotate = !bRotate;
			    }
			  }) 
			};
			
			$('.pointer').click(function (){
				  $(".masks").css("display","block");
				  $('#rotate').rotate({
				      angle:0,
				      animateTo:100000,
				      duration:8000,
			      })
				  $.ajax({
				       url:"<%=localPath %>/lotteryAward/lottery66",
				       dataType:"json",
				       data:{"level": $("#turntableNum").val(),
				    	   	 "loginName": $("#loginName").val(),
				    	   	 "from": "app"},
				       success:function(response){
				           var code = response.status;
				           if(code == "003"){
					           var lotteryId = response.lotteryId;
					           var lotteryName = response.lotteryName;
					           var type = response.type;
					           var category = response.category;
					           var id = response.id;
					           var amount = response.amount; 
					           var remainNumber=response.remainNumber;
					           var lotterynumber1=response.lotterynumber1;
					           var lotterynumber2=response.lotterynumber2;
					           var lotterynumber3=response.lotterynumber3;
					           var lotterynumber4=response.lotterynumber4;
					           var level=response.level;
					           var rootpath=getRootPath();
					           // TODO: USERID 
					           var url="<%=basePath %>/66active.jsp?lotteryId=<%=userAppId %>"+id+"&userId=<%=userAppId %>";
					           if(category=="A"){
					        	   $(".toMyself").css("display","block");
					               $(".toFamily").css("display","none");
					               $("#priceValue").text(lotteryName);
					               $("#lottery_Images img").attr("src","<%=localPath %>/static_3/active/66active/image/rewards"+level+lotteryId+".png");
					           }else if(category=="B"){
					        	   $(".toFamily").css("display","block");
					               $(".toMyself").css("display","none");
					               $(".tofamilyBtn").css("display","block");
					               $(".tofriends").css("display","none");
					               $(".affection").css("display","block");
					               $(".friendship").css("display","none");
					               $("#priceValue2").text(lotteryName);
					           }else if(category=="C"){
					        	   $("#priceValue2").text(lotteryName);
					               $(".tofamilyBtn").css("display","none");
					               $(".toFamily").css("display","block");
					               $(".friendship").css("display","block");
					               $(".affection").css("display","none");
					               $(".tofriends").css("display","block");
					               $(".tofamilyBtn").css("display","none");
				               } else if(category=="D") {
				            	   $(".toMyself").css("display","block");
				              	   $(".toFamily").css("display","none");
				                   $("#priceValue").text(lotteryName);
				                   $("#lottery_Images img").attr("src",rootpath+"/static_3/active/66active/image/rewards"+level+lotteryId+".png");
			                   } else {
			                	   $(".toMyself").css("display","none");
			                       $(".toFamily").css("display","none");
			                       $(".tofamilyBtn").css("display","none");
			                       $(".affection").css("display","none");
			                       $(".friendship").css("display","none");
			                       $(".tofriends").css("display","none");
				               }
					           document.getElementById("copyLink").value=url;
				               if(bRotate)return;
				               var item =lotteryId;
					  		   switch (item) {
							  		 case 1:
							  	        //var angle = [26, 88, 137, 185, 235, 287, 337];
							  	        rotateFn(1,435,getJP(item, $("#turntableNum").val()));
							  	        break;
							  	      
							  	      case 2:
							  	        //var angle = [137, 185, 235, 287];
							  	        rotateFn(2,30,getJP(item, $("#turntableNum").val()));
							  	        break;
							  	      case 3:
							  	        //var angle = [137, 185, 235, 287];
							  	        rotateFn(3,-20,getJP(item, $("#turntableNum").val()));
							  	        break;
							  	      case 4:
							  	        //var angle = [185, 235, 287];
							  	        rotateFn(4, 120,getJP(item, $("#turntableNum").val()));
							  	        break;
							  	      case 5:
							  	        //var angle = [235, 287];
							  	        rotateFn(5,160,getJP(item, $("#turntableNum").val()));
							  	        break;
							  	      case 6:
							  	        //var angle = [287];
							  	        rotateFn(6, 300,getJP(item, $("#turntableNum").val()));
							  	        break;
							  	      case 7:
							  	          //var angle = [287];
							  	          rotateFn(7, 200,getJP(item, $("#turntableNum").val()));
							  	          break;
							  	          
							  	      case 8:
							  	          //var angle = [287];
							  	          rotateFn(8, 250,getJP(item, $("#turntableNum").val()));
							  	          break;
				  				}
					        }else if(code == "001"){
						        alert("您当前抽奖次数为0！");
					        } else if(code == "004"){
						        alert("系统繁忙,请稍后再试！");
					        }
		       			}
		     		});
				});
			})
	
	/**
	* item 第几个奖品
	* truntable 第几个转盘
	*/
	function getJP(item, turntable) {
		  if (turntable == 4) {
		    if (item == 1) {
		        return '三星75寸4K高清平板电视';
		    } else if (item == 2) {
		      return '6s  64G';
		    } else if (item == 3) {
		      return '脊椎护腰坐垫';
		    } else if (item == 4) {
		      return '足疗机';
		    } else if (item == 5) {
		      return '56头景德镇骨瓷餐具套装';
		    } else if (item == 6) {
		      return '户外蓝牙音箱';
		    }else if (item == 7) {
		        return '公益捐助30元';
		      }
		    else if (item == 8) {
		        return '公益捐助56元';
		      }
		    
		  } else if (turntable == 3) {
		    if (item == 1) {
		      return '脊椎护腰坐垫';
		      } else if (item == 2) {
		        return 'Kindle电子书';
		      } else if (item == 3) {
		          return '坚果投影仪';
		      } else if (item == 4) {
		         return '足疗机';
		      } else if (item == 5) {
		         return '户外蓝牙音箱';
		      } else if (item == 6) {
		         return '56头景德镇骨瓷餐具套装';
		      }
		      else if (item == 7) {
		          return '公益捐助30元';
		        }
		      else if (item == 8) {
		          return '公益捐助56元';
		        }
		  } else if (turntable == 2) {
		    if (item == 1) {
		          return '户外蓝牙音箱';
		      } else if (item == 2) {
		         return '帕森偏光太阳镜';
		      } else if (item == 3) {
		         return '足疗机';
		      } else if (item == 4) {
		         return '上海迪士尼门票';
		      } else if (item == 5) {
		         return '飞利浦耳机（SHM7110）';
		      } else if (item == 6) {
		         return 'LED星空投影灯(蓝牙版)';
		      }
		      else if (item == 7) {
		          return '公益捐助56元';
		        }
		      else if (item == 8) {
		          return '公益捐助30元';
		        }
		    
		  } else if (turntable == 1) {
		     if (item == 1) {
		          return '56头景德镇骨瓷餐具套装';
		      } else if (item == 2) {
		        return '帕森偏光太阳镜';
		      } else if (item == 3) {
		        return '足疗机';
		      } else if (item == 4) {
		        return '扫地机器人';
		      } else if (item == 5) {
		        return '多功能防水登山包';
		      } else if (item == 6) {
		        return '加厚野餐垫防潮垫';
		      }else if (item == 7) {
		          return '公益捐助20元';
		        }
		      else if (item == 8) {
		          return '公益捐助30元';
		        }
		  }
		}
	/*获取项目根路径*/
	function getRootPath(){
		var path = "<%=localPath %>";
	    return path;  
	}  
	
	function ScrollImgLeft(){ 
	  var speed=50; 
	  var scroll_begin = document.getElementById("scroll_begin"); 
	  var scroll_end = document.getElementById("scroll_end"); 
	  var scroll_div = document.getElementById("scroll_div"); 
	  scroll_end.innerHTML=scroll_begin.innerHTML; 
	  function Marquee(){ 
		  if(scroll_end.offsetWidth-scroll_div.scrollLeft<=0) 
		  	scroll_div.scrollLeft-=scroll_begin.offsetWidth; 
		  else 
		  	scroll_div.scrollLeft++; 
	  }
	  var MyMar=setInterval(Marquee,speed); 
	  scroll_div.onmouseover=function() {clearInterval(MyMar);} 
	  scroll_div.onmouseout=function() {MyMar=setInterval(Marquee,speed);} 
	  }
	
	
	/*送亲人朋友复制链接 */ 
	$(function(){
		var clipboard = new Clipboard('.sure');
	    clipboard.on('success', function(e) {
	  		var copyLink=$("#copyLink").val();
	  		alert("复制成功");
	    	//console.log(e);
	  	});
	})
	
	/*分享 */
	function shareClick() {
    var uu = '<%=user%>';
    if(!uu){
      showAys3("您还没有登录，需要登录后才可以分享，现在去登录？");
    }else{ 
      if (isAndroidOrIos()) {
    	  //alert(title);
              IOSModel.noticeShare({
                  "url" : url,
                  "title" : title,
                  "content" : content,
                  "icon" : icon
              });
              iosShare(title, content, icon, url);
              appFunction('share');
          } else {
            /*   showShareBox(); */
          }
    }
  }
	  function showShare() {
	    IOSModel.showShareBtn();
	  }
	  function shareWithType() {
	    IOSModel.noticeShare({
	      "url" : url,
	      "title" : title,
	      "content" : content,
	      "icon" : icon
	    });
	  }
	
</script>

</head>
<body style="background:#EB4343;">
			<input type="hidden" value="" name="types" id="types">
			<input type="hidden" value="" id="turntableNum">
			<input type="hidden" value="${message}" id="message">
			<input type="hidden" value="${message}" id="url">
			<input type="hidden" id="loginName"/>
			<div style="position:relative;background:#fff;top:-40px;width:80px;z-index:10;">
		  <input type="text" style="position:absolute;border:none;width:1px;z-index:8;" id="copyLink"  value="">
	     </div>	
<div class="lotteryBanner">
	  			<div class="centerdiv0">
	        		<div class="headeImage">
	                 <img   src="<%=basePath%>/active/66active/image/banner.png" alt="turntable"/>
	              </div>
			</div> 
		</div>
		<div  class="lotteryBg">
			<%-- <div class="textScroll">
		        <div id="gongao"> 
					<div style="width:100%;height:150px;margin:0 auto;white-space: nowrap;overflow:hidden;" id="scroll_div" class="scroll_div"> 
						<div id="scroll_begin">
							
                        	<c:forEach items="${fnl:getTop10active51()}" var="invest_toplist" varStatus="sz">
                                <c:if test="${invest_toplist.get('nh')>0}">
                                    <SPAN> ${fnl:maskUserName(fns:getUserById(invest_toplist.get("user_id")).getLoginName())} &nbsp;&nbsp;投资￥&nbsp;${fns:formatMoney3(invest_toplist.get("nh"),"###,###,##0")}
                                                           &nbsp;&nbsp;中奖${invest_toplist.get("lottery")}
                                    </SPAN>
                               	</c:if>
                          	</c:forEach>
                          	
						</div> 
						<div id="scroll_end"> <script type="text/javascript">ScrollImgLeft();</script> </div> 
					</div> 
				</div> 
	  		</div> --%>
			<div  class="centerdiv123">
				<div style="position:relative;">
				    <div class="topic1 otherTopic">
				    	   <p><img alt=""  src="<%=basePath%>/active/66active/image/top1.png"></p>
			    	</div>
				    <div class="turntable-bg">
					        <div class="masks"></div>
					        <div class="rotate"></div>
				    </div>
				    <img alt="" id="bottomBg" src="<%=basePath%>/active/21active/image/bottomBg.png">
				</div>
		 	</div>
 		</div>
 		<div class="turntableBox">
   			<div class="centerdiv">
   				<!-- 用户投资信息 start  -->
  				<div class="investInfo"></div>
  				<!-- 用户投资信息 end  -->
		   <div class="centerdiv2">
		      <div class="topic2"><img src="<%=basePath%>/active/66active/image/top3.png"/></div>
		      <div style="position:relative;">
		        <!-- <div class="bgImage2"></div> -->
		        <div class="investmentNews">
		             <ul class="ranking1">
		                <li class="selectedli">投资排行榜</li>
		                <li>邀请排行榜</li>
		                <li>公益排行榜</li>
		             </ul> 
		          <div class="chargechoose-tab chargechoose-tab1">
		               <div id="investTop">
		                   <ul  id="breakNewsList" class="investList">
		                  </ul>
		             </div> 
		       </div>
		       
		          <div class="chargechoose-tab chargechoose-tab2" style="display:none">
		               <div id="investTop">
		                  <ul id="breakNewsList" class="investList">
		                  </ul>
		             </div> 
		       </div>
		       
		             <div class="chargechoose-tab chargechoose-tab3" style="display:none">
		               <div id="investTop">
		                  <ul id="breakNewsList" class="investList">
		                  </ul>
		             </div> 
		       </div>
		       
		</div>  
		      <!-- <div class="bgImage3"></div> -->
		    </div>
		   </div><!--centerDiv end -->
 
		   <!--A档start  -->   
		<div class="dialDetails">
		      <a name="aFile"></a>
		      <div class="topic1"><p><img alt=""  src="<%=basePath%>/active/66active/image/top2.png"></p></div>
		      <div class="aZone">
		       <p><span>A</span></p>
		        <p><img alt=""  src="<%=basePath%>/active/66active/image/aZoneBg.png"></p>
		       
		      </div>
		      <div class="zone_list zone_list1">
				      <ul>
							<li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-left', delay: 100}">
							      <img class="he_slideCaptionDown_img" src="<%=basePath%>/active/66active/image/reward1.png" alt="Image 01">
							      <div class="he_slideCaptionDown_caption">
							        <h3>三星电视</h3>
		                </div>
		           </li>
					     <li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-top', delay: 100}">
					      <img src="<%=basePath%>/active/66active/image/reward2.png"/>
					           <div class="he_slideCaptionDown_caption">
		                  <h3>ip 6s 64g</h3>
		                </div>
					      </li>
					     <li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-left', delay: 100}">
					      <img src="<%=basePath%>/active/66active/image/reward3.png"/>
					           <div class="he_slideCaptionDown_caption">
		                  <h3>脊椎护腰坐垫</h3>
		                </div>
					      </li>
			          <li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-right', delay: 100}">
			          <img src="<%=basePath%>/active/66active/image/reward4.png"/>
			               <div class="he_slideCaptionDown_caption">
		                  <h3>足疗机</h3>
		                </div>
			                   <li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-right', delay: 100}">
			           <img src="<%=basePath%>/active/66active/image/reward5.png"/>
			               <div class="he_slideCaptionDown_caption">
		                  <h3>56头景德镇骨瓷套装</h3>
		                </div>
			           </li>
			         <li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-top', delay: 100}">
			             <img style="margin-top:-10px;" src="<%=basePath%>/active/66active/image/reward6.png"/>
			               <div class="he_slideCaptionDown_caption">
		                  <h3>户外蓝牙音箱</h3>
		                </div>
			          </li>
			          <li   class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-bottom', delay: 100}">
			          <img src="<%=basePath%>/active/66active/image/reward7.png"/>
			              <div class="he_slideCaptionDown_caption">
		                  <h3>公益捐助¥30元</h3>
		                </div>
			          </li>
			          <li class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-left', delay: 100}"><img src="<%=basePath%>/active/66active/image/reward8.png"/>
			             <div class="he_slideCaptionDown_caption">
		                  <h3>公益捐助¥56元</h3>
		                </div>
			          </li>
				      </ul>
				      <div class="clear"></div>
		      </div>
		      <p style="margin:3% 0 0 2%;line-height:22px" class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-right', delay: 100}">注：100000≤单笔年化投资：单笔年化投资每100000元有一次抽奖机会</p>
		</div>
		<!--A档end  --> 
			<!--B档start  --> 
			<div class="dialDetails">
			<a name="bFile"></a>
			      <div class="bZone">
					       <p><span>B</span></p>
					        <p><img alt=""  src="<%=basePath%>/active/66active/image/bZoneBg.png"></p>
			      </div>
			      <div class="zone_list zone_list2">
			         <ul>
				          <li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-left', delay: 100}">
				                <img class="he_slideCaptionDown_img" src="<%=basePath%>/active/66active/image/reward9.png" alt="Image 01">
				                <div class="he_slideCaptionDown_caption">
				                  <h3>脊椎护腰坐垫</h3>
				                </div>
				           </li>
			           <li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-top', delay: 100}">
			            <img src="<%=basePath%>/active/66active/image/reward10.png"/>
			                 <div class="he_slideCaptionDown_caption">
			                  <h3>Kindle电子书</h3>
			                </div>
			            </li>
			           <li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-left', delay: 100}">
			            <img style="margin-top:18px;" src="<%=basePath%>/active/66active/image/reward11.png"/>
			                 <div class="he_slideCaptionDown_caption">
			                  <h3>坚果投影仪</h3>
			                </div>
			            </li>
			            <li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-right', delay: 100}">
			            <img src="<%=basePath%>/active/66active/image/reward12.png"/>
			                 <div class="he_slideCaptionDown_caption">
			                  <h3>足疗机</h3>
			                </div>
			                     <li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-right', delay: 100}">
			             <img src="<%=basePath%>/active/66active/image/reward13.png"/>
			                 <div class="he_slideCaptionDown_caption">
			                  <h3>56头景德镇骨瓷套装</h3>
			                </div>
			             </li>
			           <li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-top', delay: 100}">
			             <img style="margin-top:-10px;" src="<%=basePath%>/active/66active/image/reward6.png"/>
			                 <div class="he_slideCaptionDown_caption">
			                  <h3>户外蓝牙音箱</h3>
			                </div>
			            </li>
			            <li   class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-bottom', delay: 100}">
			            <img src="<%=basePath%>/active/66active/image/reward15.png"/>
			                <div class="he_slideCaptionDown_caption">
			                  <h3>公益捐助¥30元</h3>
			                </div>
			            </li>
			            <li class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-left', delay: 100}"><img src="<%=basePath%>/active/66active/image/reward15.png"/>
			               <div class="he_slideCaptionDown_caption">
			                  <h3>公益捐助¥56元</h3>
			                </div>
			            </li>
			          </ul>
			          <div class="clear"></div>
			      </div>
			        <p style="margin:3% 0 0 2%;line-height:22px" class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-right', delay: 100}">注：12000元≤单笔年化投资＜100000元：单笔年化投资每12000元有一次抽奖机会</p>
			</div>
			 <!--B档start  --> 
 
			 <!--C档start  --> 
			<div class="dialDetails">
			         <a name="cFile"></a>
			      <div class="cZone">
			       <p><span>C</span></p>
			       <p><img alt=""  src="<%=basePath%>/active/66active/image/cZoneBg.png"></p>
			      </div>
			      <div class="zone_list zone_list3">
			          <ul>
			          <li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-left', delay: 100}">
			                <img class="he_slideCaptionDown_img" src="<%=basePath%>/active/66active/image/reward16.png" alt="Image 01">
			                <div class="he_slideCaptionDown_caption">
			                  <h3>户外蓝牙音箱</h3>
			                </div>
			           </li>
			           <li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-top', delay: 100}">
			            <img style="margin-top:48px;" src="<%=basePath%>/active/66active/image/reward17.png"/>
			                 <div class="he_slideCaptionDown_caption">
			                  <h3>帕森偏光太阳镜</h3>
			                </div>
			            </li>
			           <li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-left', delay: 100}">
			            <img style="margin-top:28px;" src="<%=basePath%>/active/66active/image/reward18.png"/>
			                 <div class="he_slideCaptionDown_caption">
			                  <h3>上海迪士尼门票</h3>
			                </div>
			            </li>
			            <li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-right', delay: 100}">
			            <img  style="margin-top:15px" src="<%=basePath%>/active/66active/image/reward19.png"/>
			                 <div class="he_slideCaptionDown_caption">
			                  <h3>足疗机</h3>
			                </div>
			                     <li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-right', delay: 100}">
			             <img src="<%=basePath%>/active/66active/image/reward20.png"/>
			                 <div class="he_slideCaptionDown_caption">
			                  <h3>飞利浦耳机</h3>
			                </div>
			             </li>
			           <li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-top', delay: 100}"><img src="<%=basePath%>/active/66active/image/reward21.png"/>
			                 <div class="he_slideCaptionDown_caption">
			                  <h3>LED星空投影灯(蓝牙版)</h3>
			                </div>
			            </li>
			            <li   class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-bottom', delay: 100}">
			            <img src="<%=basePath%>/active/66active/image/reward22.png"/>
			                <div class="he_slideCaptionDown_caption">
			                  <h3>公益捐助¥30元</h3>
			                </div>
			            </li>
			            <li class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-left', delay: 100}"><img src="<%=basePath%>/active/66active/image/reward22.png"/>
			               <div class="he_slideCaptionDown_caption">
			                  <h3>公益捐助¥56元</h3>
			                </div>
			            </li>
			          </ul>
			          <div class="clear"></div>
			      </div>
			      <p style="margin:3% 0 0 2%;line-height:22px" class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-left', delay: 100}">注：5000元≤单笔年化投资＜12000元：单笔年化投资每5000元有一次抽奖机会</p>
			</div>
			 <!--C档start  --> 
 
		 <!--D档start  --> 
		<div class="dialDetails">
		  <a name="dFile"></a>
		      <div class="dZone">
		       <p><span>D</span></p>
		       <p><img alt=""  src="<%=basePath%>/active/66active/image/dZoneBg.png"></p>
		      </div>
		      <div class="zone_list zone_list4">
		          <ul>
		          <li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-left', delay: 100}">
		                <img class="he_slideCaptionDown_img" src="<%=basePath%>/active/66active/image/reward23.png" alt="Image 01">
		                <div class="he_slideCaptionDown_caption">
		                  <h3>56头景德镇骨瓷餐具套装</h3>
		                </div>
		           </li>
		           <li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-top', delay: 100}">
		            <img style="margin-top:49px" src="<%=basePath%>/active/66active/image/reward24.png"/>
		                 <div class="he_slideCaptionDown_caption">
		                  <h3>帕森偏光太阳镜</h3>
		                </div>
		            </li>
		           <li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-left', delay: 100}">
		            <img style="margin-top:5px" src="<%=basePath%>/active/66active/image/reward25.png"/>
		                 <div class="he_slideCaptionDown_caption">
		                  <h3>扫地机器人</h3>
		                </div>
		            </li>
		            <li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-right', delay: 100}">
		            <img src="<%=basePath%>/active/66active/image/reward26.png"/>
		                 <div class="he_slideCaptionDown_caption">
		                  <h3>足疗机</h3>
		                </div>
		                     <li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-right', delay: 100}">
		             <img src="<%=basePath%>/active/66active/image/reward27.png"/>
		                 <div class="he_slideCaptionDown_caption">
		                  <h3>多功能防水登山包</h3>
		                </div>
		             </li>
		           <li  class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-top', delay: 100}"><img src="<%=basePath%>/active/66active/image/reward28.png"/>
		                 <div class="he_slideCaptionDown_caption">
		                  <h3>水杯</h3>
		                </div>
		            </li>
		            <li   class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-bottom', delay: 100}">
		            <img src="<%=basePath%>/active/66active/image/reward29.png"/>
		                <div class="he_slideCaptionDown_caption">
		                  <h3>公益捐助¥30元</h3>
		                </div>
		            </li>
		            <li class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-left', delay: 100}"><img src="<%=basePath%>/active/66active/image/reward29.png"/>
		               <div class="he_slideCaptionDown_caption">
		                  <h3>公益捐助¥20元</h3>
		                </div>
		            </li>
		          </ul>
		          <div class="clear"></div>
		      </div>
		        <p style="margin:3% 0 0 2%;line-height:22px" class="am-slider-title am-scrollspy-init" data-am-scrollspy="{animation: 'slide-right', delay: 100}">注：单笔年化投资＜5000元：单笔年化投资每2000元有一次抽奖机会</p>
		</div>
		 <!--D档start  --> 
 </div>
 <div class="centerdiv3"> 
        <div class="topic2"><img src="<%=basePath%>/active/66active/image/top4.png"/></div>
		    <div class="tips am-scrollspy-init am-scrollspy-inview am-animation-scale-up" data-am-scrollspy="{animation: 'scale-up', repeat: false}">
		    <p>1、实物奖品将于抽奖成功后的七个工作日内发放。</p>
		    <p>2、用户抽到奖品后，实物奖品（除水杯外）可八折折现，折现金额保留整数位。</p>
		    <p>3、中奖用户需在PC端“<font><a href="account_info.jsp" >我的账户>账户信息>安全信息>收货地址</a>”填写/修改收货地址等相关信息。
		    </p>
		    <p>4、邀请人福利：活动期间内邀请他人注册投资且满足抽奖条件时，邀请人增加一次抽奖机会，抽奖等级和被邀请人的抽奖等级相同。</p>
		    <p>5、所有“公益金”将由瑞钱宝于活动结束后十个工作日内统一捐赠给通州区人工耳蜗培训学校。</p>      
		    <p>6、除债权转让、一月标和新手标外，其他标的都参与活动中的年化投资计算。</p>
		    <p>7、若用户抽到“送给家人/送给朋友”的奖品，每个朋友/家人只能送一次。若用户抽到可直接领取的奖品，不限其领取次数。</p>
		    <p>8、用户抽到“送给家人/送给朋友”的奖品时，需在七日内送出，逾期视为放弃奖品。</p>
		    <p>9、用户抽到直接领取的奖品后若未填写收货地址，最迟需在活动结束后三个工作日内填写收货地址或致电瑞钱宝官方客服（400-9198-555）确认奖品信息，逾期视为自动放弃奖品。</p>
		    <p><b></b>最终解释权归瑞钱宝资产管理服务有限公司所有</p>
		    </div>
		    <p style="margin-top:5%;color:#7D0208;text-align:center; font-size:14px;">Copyright ©2015年版权所有 京ICP备14024431号</p>
		    </div>
</div>
<div id="divshows" style="display:none;">
      <div id="light">
           <div  class="modal-content" style="width:100%;top:30%;padding:20px;">
  				  <!-- 送自己 -->
	              <div class="toMyself" style="display:none">
	                 <p id="lottery_Images">
	                 	<img src="<%=basePath%>/active/66active/image/reward23.png"/>
                 	 </p>
		              <p style="margin:30px 0 20px 0;text-align:center;font-size:1.6rem;">恭喜您获得<font id="priceValue"></font></p>
<%-- 		              <p style="text-align:center;"><a href="${ctx}/lotteryAward/lotteryDetail" target="_blank" id="gift">在我的奖品中查看</a></p> --%>
		              <p style="text-align:center;"><button type="button" class="btn btn-danger" id="sureBtn">确定</button></p>
	              </div>
	              <!-- 送自己 end -->
           		  <div class="toFamily" style="display:none"><!-- 礼物代表友谊送朋友start -->
		                 <a  href="javascript:;"  id="closeWindow">×</a>
		                 <h3 class="affection">礼物传递亲情</h3>
		                  <h3 class="friendship">礼物代表友谊</h3>
			               <p style="margin:14px 0 14px 0;text-align:center;font-size:1.6rem;">恭喜您获得<font id="priceValue2"></font></p>
<%-- 			               <p style="text-align:center;"><a href="${ctx}/lotteryAward/lotteryDetail" target="_blank" id="gift">在我的奖品中查看</a></p> --%>
			               <p class="tofriends" style="text-align:center;"><button type="button" class="btn btn-danger sure" onclick="shareClick()">送给朋友</button></p>
			               <p class="tofamilyBtn" style="text-align:center;"><button type="button" class="btn btn-danger sure" onclick="shareClick()">送给家人</button></p>
			               
			              <!--  <p>ps:点击按钮，即可发送链接送出奖品</p><p style="margin:14px 0 14px 0;text-align:center;font-size:1.6rem;">
			               	<b style="color:#F5473F;font-weight: normal;">方法二</b>：传递二维码送礼品
		               	   </p>
		               	   
			               <p>
			               		<div id="qrcodeTable"></div>
			               </p> -->
	               </div>   
               </p>
              </div><!-- 礼物代表友谊送朋友end -->
          </div>
      </div>

	<%-- <c:if test="${LotteryRecord.type=='2' }"> --%>
	<div id="divshows1"  style=" display:none">
	      <div id="light">
	           <div  class="modal-content" style="top:10%;width:100%;padding:20px;">
	           			  <!-- TODO: 需加用户名 -->
			              <p class="telNum"></p>
			              <p class="starImage">
			              </p>
	                  <form action="" method="post" id="receiveSave">
	                      <p><input type="text" required="required"  id="mobile" name="mobile" class="form-control" placeholder="手机号码"></p> 
	                       <p>
	                       <input required="required" type="text" class="code form-control " placeholder="验证码" id="code"  name="code" onkeyup="value=value.replace(/[ ]/g,'')" />
	                         <a href="javascript:;" class="get-code btn btn-danger"  id="getValidateSMS" >获取验证码</a>
	                     </p>
	                     <p style="padding:14px 0 0 98px;clear:both;text-align:left;"><span id="mobile_info"></span></p>
	                      <p class="directions">这个奖品你来抢！领到记得在“我的账户>账户信息>安全信息”填写收货地址哦！</p>
	                      <button type="submit" id="receiveBtn"  class="btn btn-danger">领取奖励</button>
	                  </form>
	          </div>
	      </div>
	</div>
		<script src="js/ScrollText/ScrollText.js"></script>
		<script type="text/javascript">
			 var scroll1 = new ScrollText("breakNewsList","","",true,60,true);
			 scroll2.LineHeight = 63; 
		</script>
		<script src="js/member_common.js"></script>
		<script type="text/javascript" src="js/frame/rqbaoappshare.js"></script>
	</body>
</html>
