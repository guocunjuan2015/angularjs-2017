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

    String localPath = "http://www.rqbao.com/rqb";
    String basePath = "http://www.rqbao.com";

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
    if (from != null && "app".equals(from) && userApp != null) {
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
%>  
<%
    Date serviceDate = new Date();
    String startDate = "2016-04-14";
    String overDate = "2016-04-30";
    boolean flag = false;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String date = sdf.format(serviceDate);
    if (date.compareTo(startDate) > 0 && date.compareTo(overDate) < 0) {
        flag = true;
    }
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
	<link href="css/bootstrap.min.css" rel="stylesheet">
	
	<link href="css/common2.css" rel="stylesheet"/>
    <link href="css/utils.css" rel="stylesheet" />
	<link href="css/lottery.css" rel="stylesheet"/>
   <script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
   <script src="js/jweixin-1.0.0.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/weixin_share.js"></script>
    <script src="js/frame/ios_js.js" type="text/javascript"></script>
<title>瑞钱宝抽奖赢豪礼</title>
<style type="text/css">
/* box */
.bottom ul{height:28px;}
 .bottoms img{margin-top:10px;} 
 #object2{z-index:99999;}
.nav_list a{font-size:16px;}
</style>
</head>
<body style="background:#ffedb4;">
<%@ include file="config/show_share.jsp" %>
<div class="lotterys">
  <div class="lotterytops">
  <img src="images/lottery/lottery_banner.png" width="100%"/>
    
  </div>
  <div id="lotterys" class="centerdiv">
  <h3 class="lotterytop">&nbsp;</h3> 
   <div class="lottery">
    <div class="lottery1">
	  <table border="0" cellpadding="0" cellspacing="2">
		<tr class="topbotomtr">
			<td class="lottery-unit lottery-unit-0">
			    <img src="images/lottery/reward_01.png">
			</td>
			<td class="lottery-unit lottery-unit-1"><img src="images/lottery/reward_02.png"></td>
			<td class="lottery-unit lottery-unit-2"><img src="images/lottery/reward_03.png"></td>
            <td class="lottery-unit lottery-unit-3"><img src="images/lottery/reward_04.png"></td>
            <td class="lottery-unit lottery-unit-4"><img src="images/lottery/reward_05.png"></td>
		</tr>
		<tr>
			<td class="lottery-unit lottery-unit-15 centerlefttd"><strong>2500<br/>积分</strong></td>
			<td colspan="3" rowspan="3" style="background:none;box-shadow:none;">
			<p class="lottery_change">抽奖机会：1次</p>
			<p style="text-align:center;"><a class="lottery_img"  >请登录</a></p>
			 <input type="hidden" id="loginName" value="<%=user%>" /> <input
								type="hidden" id="userId" value="<%=userId%>" /> <input
								type="hidden" value="0" id="lotteryCount">
							</td>
			<td class="lottery-unit lottery-unit-5 centerrighttd "><img src="images/lottery/reward_06.png"></td>
		</tr>
		<tr>
			<td class="lottery-unit lottery-unit-14 centerlefttd"><img src="images/lottery/reward_12.png"></td>
			<td class="lottery-unit lottery-unit-6 centerrighttd"><img src="images/lottery/reward_07.png"></td>
		</tr>
		<tr>
			<td class="lottery-unit lottery-unit-13 centerlefttd"><strong>500<br/>积分</strong></td>
			<td class="lottery-unit lottery-unit-7 centerrighttd"><strong>3000<br/>积分</strong></td>
		</tr>
        <tr class="topbotomtr">
			<td class="lottery-unit lottery-unit-12"><img src="images/lottery/reward_11.png"></td>
			<td class="lottery-unit lottery-unit-11"><img src="images/lottery/reward_10.png"></td>
			<td class="lottery-unit lottery-unit-10"><img src="images/lottery/reward_09.png"></td>
            <td class="lottery-unit lottery-unit-9"><img src="images/lottery/reward_08.png"></td>
            <td class="lottery-unit lottery-unit-8"><strong>5000<br/>积分</strong></td>
		</tr>
	  </table>
	 </div>
	 <!-- 抽奖机会用完-->
<div class="box" id="object2" >
    <h2 class="closes"><a href="javascript:;"  onclick="windowClose('')">&nbsp;</a></h2>
	<div class="invest">
		<div class="lotteryconfirms">
			<p class="lotteryagin">每投资2000元，<br/>获得1次抽奖机会。</p>
			<p class="lottery_btn" style="margin-top:86%;"><a class="btninvest" onclick="toProject()">去投资</a></p>
		</div>
		<div class="lotteryconfirms">
			<p>1.每邀请一位好友注册投资，获得1次抽奖机会。</p>
			<p>2.每位好友单笔投资满4000元，推荐人再获得1次抽奖机会。</p>
			<p class="lottery_btn" style="margin-top: 27%;"><a class="btninvites" onclick="showShareBox()">邀请好友</a></p>
		</div>
		<div class="lotteryconfirms">
			<p class="lotteryagin">消耗2000积分，获得1次抽奖机会。</p>
			<p class="lottery_btn" style="margin-top:86%;"><a class="btninvites" href="javascript:exchange()">兑换机会</a></p>
		</div>
	</div>
	<div class="rewards">
		<h3>&nbsp;</h3>
		 <div class="rewardss" >
			<img class="pic" src="images/lottery/jp_07.png"/>
			<!-- <p class="category"></p> -->
		</div>
		<div class="rewards_vistual">
			<p class="category"> </p>
		</div>
	</div>
   </div>
	</div>
	<div class="lotteryinfos">
	  <h3>&nbsp;</h3>
	  <div class="lotterylists">
	   <MARQUEE onmouseover=this.stop() onmouseout=this.start() scrollAmount=1 scrollDelay=100 direction=up height="99%">
	   <ul style="max-height: 200px;">
	     <!-- <li>
	       <span>151***2001</span>
	       <span>获得了10元红包</span>
	     </li>
	     <li>
	       <span>151***2001</span>
	       <span>获得了10元红包</span>
	     </li>
	     <li>
	       <span>151***2001</span>
	       <span>获得了10元红包</span>
	     </li> -->
	   </ul>
	    </MARQUEE>
	  </div>
	</div>
</div>
</div>
<div style="clear:both;"></div>
<div class="lotteryrules centerdiv">
      <h3>&nbsp;</h3>
        <p>1.每个账户每天一次免费抽奖,；</p>
        <p>2.抽到的加息券不能与其他优惠券叠加使用，且不能用于投资新手标；</p>
        <p>3.加息券和投资红包使用期限为4月16日—4月30日;</p>
        <p>4.债权转让项目不参加本次活动；</p>
        <p>5.现金红包将自动存入账户；实物礼包将在活动结束后7个工作日内发放；（实物奖品颜色随机发放）</p>
        <p>6.请务必确保信息正确，以便发放奖品。如因信息提交不正确，导致活动结束后7个工作日内仍不能发出奖品的视为弃奖；</p>
        <p>7.用户可通过以下方式获得抽奖机会：</p>
        <p>A．每投资2000元，获得1次抽奖机会；</p>
        <p>B．每邀请一位好友注册投资，获得1次抽奖机会；</p>
        <p>C．好友投资满4000元，推荐人再获得1次抽奖机会；</p>
        <p>D．消耗2000积分，获得1次抽奖机会；</p>
        <p>8.本次活动最终解释权归瑞钱宝所有。</p>

</div>

<div><img src="images/lottery/lottery_bottom.png" width="100%"/></div>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript">
  $(function(){
	  var myimgUrl = '<%=localPath%>/images/lottery/lottery_logo.png'; // 200*200大小
      var mylink =  window.location.href;//当前用户为推荐人
      var mydesc = '瑞钱宝幸运大转盘，百分百中奖，快来试试手气，邀请好友注册，增加抽奖机会';
      var mytitle ='抽奖赢豪礼';
      weixinShare(mytitle,mydesc,myimgUrl,mylink,'<%=localPath%>');//设置微信分享
	  
	  if(<%=!flag%>){
			alert("活动开放时间段为2016-04-16~2016-04-30");
			return;
	  }
	  lottery.init('lotterys');
	  loginInfo();
	  setInterval(lotteryInfo,5000);
  });
  
  function exchange(){
	  $.ajax({
			url:"<%=basePath%>/lotteryAward/exchange",
			data : {from:"app",
                loginName:$("#loginName").val()},
			type:"post",
			dataType:"json",
			success:function(response){ 
				loginInfo();
				alert(response.message);
		 	}
		});
  }
  
  function loginInfo(){
	  var userId = $("#loginName").val();
	  if(userId == ""){
		  $(".lottery_change").css("display","none");
		  $(".lottery_img").click(function(){
			  login();
		  });
		  $(".lottery_img").text("请登录");
	  }else{
		  $(".lottery_change").css("display","block");
		  $(".lottery_img").attr("href","javascript:doLottery()");
		  $(".lottery_img").text("开始抽奖");
		  lotteryCount();
	  }
  }
<%--   function lotteryInfo(){
	 if(typeof(EventSource) != "undefined"){
		var source = new EventSource("<%=basePath%>/lotteryAward/history");
		source.onmessage = function(event){
			console.log("event.data"+event.data);
			var items = eval(event.data);
			console.log("items"+items.length);
			var ele = "";
			for(var i = 0;i < items.length;i++){
				var mobile = items[i].mobile;
				var lotteryName = items[i].lotteryName;
				ele = ele + "<li><span class='lotterylist-span'>"+mobile
				+"</span><span class='lotterylist-span'>"+lotteryName+"</span></li>"
			}
			$(".lotterylists ul").html(ele);
		}
	}else{
		alert("浏览器不支持EventSource");
	} 
} --%>
function lotteryInfo(){
    $.ajax({
        url:"<%=basePath%>/lotteryAward/history2",
        data : {from:"app",
            loginName:$("#loginName").val()},
        type:"post",
        dataType:"json",
        success:function(response){ 
            var ele = "";
            for(var i = 0;i < response.length;i++){
                var mobile = response[i].mobile;
                var lotteryName = response[i].lotteryName;
                ele = ele + "<li><span class='lotterylist-span'>"+mobile
                +"</span><span class='lotterylist-span'>"+lotteryName+"</span></li>"
            }
            $(".lotterylists ul").html(ele); 
        }
        });
}

  function lotteryCount(){
		$.ajax({
			url:"<%=basePath%>/lotteryAward/lotteryCount",
			 data : {from:"app",
                 loginName:$("#loginName").val()},
			type:"post",
			dataType:"json",
			success:function(response){ 
				 
				 if(response.message == "登录之后才可以抽奖哦"){
	                  $("#loginName").val("");
	                  loginInfo();
	                  return;
	                } 
				$(".lottery_change").text("抽奖机会："+response.message+"次");
				 if(response.message <= 0){
                     $(".lottery_img").attr("href","javascript:btnclick2('#object2');");
                     $(".lottery_img").text("获取抽奖次数");
                }
				 
					 /* $(".lottery_change").css("display","none");
			          $(".lottery_img").click(function(){
			              login();
			          });
			          $(".lottery_img").text("请登录"); */
				
		 	}
		});
  }
</script>
<script type="text/javascript">
function btnclick2(){
	$(".invest").css("display","block");
	$(".rewards").css("display","none");
	btnclick("#object2");
}
function windowClose(index){
    $("#bg,.box,.bgbox").css("display", "none");
    if(index == "jfdhcg"){
      location.reload();
    }
  }
function btnclick(index) {
	    $(".box").css("display","block");
	  }

var lottery={
	lotteryId:0,
	lotteryName:"",
	type:0,
	category:"",
	amount:0,
	index:-1,	//当前转动到哪个位置，起点位置
	count:0,	//总共有多少个位置
	timer:0,	//setTimeout的ID，用clearTimeout清除
	speed:20,	//初始转动速度
	times:0,	//转动次数
	cycle:20,	//转动基本次数：即至少需要转动多少次再进入抽奖环节
	prize:-1,	//中奖位置
	init:function(id){
		//debugger;
		if ($("#"+id).find(".lottery-unit").length>0) {
			$lottery = $("#"+id);
			$units = $lottery.find(".lottery-unit");
			this.obj = $lottery;
			this.count = $units.length;
			$lottery.find(".lottery-unit-"+this.index).addClass("active");
		};
	},
	roll:function(){
		var index = this.index;
		var count = this.count;
		var lottery = this.obj;
		$(lottery).find(".lottery-unit-"+index).removeClass("active");
		index += 1;
		if (index > count-1) {
			index = 0;
		};
		$(lottery).find(".lottery-unit-"+index).addClass("active");
		this.index = index;
		return false;
	},
	stop:function(){
		if(this.type == 0){
			switch(this.category){
			 
			case "point":
				$(".category").html("恭喜你获得<strong>"+this.amount+"</strong>积分");
				$(".pic").css("display","none");
				break;
			case "redPacket":
				$(".category").html("恭喜你获得<strong>"+this.amount+"</strong>红包");
				$(".pic").css("display","block");
				$(".pic").attr("src","images/lottery/jp_01.png");
				break;
			case "morerate":
				$(".category").html("恭喜你获得<strong>"+this.amount+"</strong>加息劵");
				$(".pic").css("display","block");
				$(".pic").attr("src","images/lottery/jp_05.png");
				break;
			case "cash":
				$(".category").html("恭喜你获得<strong>"+this.amount+"</strong>现金");
				$(".pic").css("display","block");
				$(".pic").attr("src","images/lottery/jp_04.png");
				break;
			}
			$(".invest").css("display","none");
			$(".rewards").css("display","block");
			//$(".rewardss").css("display","none");
			$(".rewards_vistual").css("display","block");
			btnclick("#object2");
		}else if(this.type == 1){
			//$(".pic2").css("display","none");
			$(".pic").css("display","block");
			$(".pic").attr("src","images/lottery/" + this.category + ".png");
			$(".category").text("恭喜你获得"+this.lotteryName+"一个");
			$(".invest").css("display","none");
			$(".rewards").css("display","block");
			//$(".rewardss").css("display","block");
			$(".rewards_vistual").css("display","block");
			btnclick('#object2');
		}
		$(".lottery_img").css("background","url('images/lottery/btn_bg.png') no-repeat");
	  $(".lottery_img").attr("href","javascript:doLottery()");
	  lotteryCount();
		return false;
	}
};

function roll(){
	lottery.times += 1;
	lottery.roll();
	if (lottery.times > lottery.cycle + 10 && lottery.prize == lottery.index) {
		clearTimeout(lottery.timer);
		lottery.prize = -1;
		lottery.times = 0;
		click = false;
		lottery.stop();
	}else{
		if (lottery.times < lottery.cycle) {
			lottery.speed -= 10;
		}else if(lottery.times == lottery.cycle) {
		}else{
			if (lottery.times > lottery.cycle+10 && ((lottery.prize == 0 && lottery.index == 7) || lottery.prize==lottery.index+1)) {
				lottery.speed += 110;
			}else{
				lottery.speed += 20;
			}
		}
		if (lottery.speed < 40) {
			lottery.speed = 40;
		};
		lottery.timer = setTimeout(roll,lottery.speed);
	}
	return false;
}

var click=false;

function doLottery(){
	if (click) {
		return;
	}else{
		if(<%=!flag%>){
			alert("活动开放时间段为2016-04-16~2016-04-30");
			return;
		}
		$.ajax({
			url:"<%=basePath%>/lotteryAward/lottery",
			 data : {from:"app",
                 loginName:$("#loginName").val()},
			dataType:"json",
			success:function(response){ 
				var code = response.status;
					if(code == "003"){
						$(".lottery_img").attr("color","#d1d1d1");
				    $(".lottery_img").css("background","url('images/lottery/btn_bg2.png') no-repeat");
				    $(".lottery_img").attr("href","javascript:;");
					lotteryCount();
					var lotteryId = response.lotteryId;
					var lotteryName = response.lotteryName;
					var type = response.type;
					var category = response.category;
					var amount = response.amount; 
					lottery.speed=100;
					lottery.prize = lotteryId - 1;
					lottery.lotteryId = lotteryId;
					lottery.lotteryName = lotteryName;
					lottery.type = type;
					lottery.category = category,
					lottery.amount = amount,
					roll();
					click=true;
				}
					else if(code == "004"){
	                    alert("系统繁忙,请稍后再试！");
	                }
		 	}
		});
	}
}


function dismissAys3(){
    $("#bg")[0].style.display = "none";
    $("#ays3")[0].style.display = "none";
}
function showAys3(value){
    $("#ays_content3")[0].innerHTML = value;
    $("#bg").css("height", document.body.scrollHeight);
    $("#bg")[0].style.display = "block";
    $("#ays3")[0].style.display = "block";
}
function dismissAys(){
    $("#bg")[0].style.display = "none";
    $("#login")[0].style.display = "none";
}
function showAys(value){
    $("#login_content")[0].innerHTML = value;
    $("#bg").css("height", document.body.scrollHeight);
    $("#bg")[0].style.display = "block";
    $("#login")[0].style.display = "block";
}
function login(){
	  /* if (isAndroidOrIos()) {
		IOSModel.login();
        appFunction('login');
    } else { */  
    	var rf = "<%=refer%>";
        window.location.href = "login.jsp?reflect_url=lottery.jsp&?from=<%=from%>&referrer=" + rf;
    //}
}
function toProject() {
	IOSModel.toIosInvest();
	if (isAndroidOrIos()) {
		toIosInvest();
		appFunction('invest');
	} else {
		toIosInvest();
		window.location.href = "project.jsp";
	}
}
</script>
</body>
<script type="text/javascript" src="js/frame/rqbaoappshare.js"></script>
</html>