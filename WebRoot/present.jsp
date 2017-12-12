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

    String localPath = "http:/www.rqbao.com/rqb";
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
%>  
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/common2.css" rel="stylesheet"/>
    <link href="css/activity/present.css" rel="stylesheet">
       <script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
   <script src="js/jweixin-1.0.0.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/weixin_share.js"></script>
    <script src="js/frame/ios_js.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/frame/ScrollText.js"></script>
<body style="background:#ffbbbb;">
 <img src="images/activity/present/banner.png" width="100%"/>
 <div class="present">
     <div class="presents">
         <img src="images/activity/present/present_01.png"/>
         <a class="btn_reward" onclick="toProject()">立即领奖</a>
     </div>
     <div class="presents">
         <img src="images/activity/present/present_02.png"/>
         <a class="btn_reward" onclick="toProject()">立即领奖</a>
     </div>
     <div class="presents">
         <img src="images/activity/present/present_03.png"/>
         <a class="btn_reward" onclick="toProject()">立即领奖</a>
     </div>
     <div class="presents">
         <img src="images/activity/present/present_04.png"/>
         <a class="btn_reward" onclick="toProject()">立即领奖</a>
     </div>
     <div class="presents">
         <img src="images/activity/present/present_05.png"/>
         <a class="btn_reward" onclick="toProject()">立即领奖</a>
     </div>
     <div class="presents">
         <img src="images/activity/present/present_06.png"/>
         <a class="btn_reward" onclick="toProject()">立即领奖</a>
     </div>
     <img src="images/activity/present/header.png" width="50%">
     <img src="images/activity/present/present_07.png"/>
     <div class="investlist centerdiv">
         <p style="color:#fff;text-align:left;font-size:12px;margin-top:60px;">在活动期间，年化投资金额在前三名且≥100万的用户还可获得以下奖励</p>
         <table>
             <tr>
                 <th>用户名</th>
                 <th>实际投资金额</th>
                 <th>年化投资金额</th>
             </tr>
             <!-- <tr class="tr1">
                 <td>152***2365</td>
                 <td>￥ &nbsp;30,000</td>
                 <td>￥ &nbsp;30,000</td>
             </tr>
             <tr class="tr2">
                 <td>152***2365</td>
                 <td>￥ &nbsp;30,000</td>
                 <td>￥ &nbsp;30,000</td>
             </tr>
             <tr class="tr2">
                 <td>152***2365</td>
                 <td>￥ &nbsp;30,000</td>
                 <td>￥ &nbsp;30,000</td>
             </tr> -->
         </table>

         <div class="invest_table2" style="border:1px solid #ff555d;border-top:0">

             <ol id="breakNewsList" class="invest_list">
                <!--  <li>
                     <span>152***2365</span>
                     <span>￥ &nbsp;30,000</span>
                     <span>￥ &nbsp;30,000</span>
                 </li>
                 <li>
                     <span>152***2365</span>
                     <span>￥ &nbsp;30,000</span>
                     <span>￥ &nbsp;30,000</span>
                 </li>
                 <li>
                     <span>152***2365</span>
                     <span>￥ &nbsp;30,000</span>
                     <span>￥ &nbsp;30,000</span>
                 </li>
                 <li>
                     <span>152***2365</span>
                     <span>￥ &nbsp;30,000</span>
                     <span>￥ &nbsp;30,000</span>
                 </li>
                 <li>
                     <span>152***2365</span>
                     <span>￥ &nbsp;30,000</span>
                     <span>￥ &nbsp;30,000</span>
                 </li>
                 <li>
                     <span>152***2365</span>
                     <span>￥ &nbsp;30,000</span>
                     <span>￥ &nbsp;30,000</span>
                 </li>
                 <li>
                 <span>152***2365</span>
                 <span>￥ &nbsp;30,000</span>
                 <span>￥ &nbsp;30,000</span>
                 </li>
                 <li>
                     <span>152***2365</span>
                     <span>￥ &nbsp;30,000</span>
                     <span>￥ &nbsp;30,000</span>
                 </li> -->


                 <!-- <tr>
                   <td>152***2365</td>
                   <td>￥ &nbsp;30,000</td>
                   <td>￥ &nbsp;30,000</td>
                 </tr>
                 <tr>
                   <td>152***2365</td>
                   <td>￥ &nbsp;30,000</td>
                   <td>￥ &nbsp;30,000</td>
                 </tr>
                 <tr>
                   <td>152***2365</td>
                   <td>￥ &nbsp;30,000</td>
                   <td>￥ &nbsp;30,000</td>
                 </tr>
                 <tr>
                   <td>152***2365</td>
                   <td>￥ &nbsp;30,000</td>
                   <td>￥ &nbsp;30,000</td>
                 </tr>
                 <tr>
                   <td>152***2365</td>
                   <td>￥ &nbsp;30,000</td>
                   <td>￥ &nbsp;30,000</td>
                 </tr>  -->
             </ol>
         </div>
         <p style="color:#fff;text-align:left;font-size:12px;margin:10px 0 30px;">年化投资额=投资金额*项目周期/12。如小A投资6月项目10000元，其年化投资额为5000元</p>
     </div>
 </div>
 <div   class="presenttip">
 <div class="presenttip centerdiv" style="background: #ffd68f;">
    <img src="images/activity/present/header_01.png" width="50%"/>
    <p style="margin-top:40px;">1.每个奖品数量限50份；</p>
    <p>2.投资送好礼和金榜题名的奖品可重复获得；</p>
    <p>3.投资金额较大的用户，其奖品及数量可由用户自由组合</p>
      <p style="color:#8f8f8f">（如小瑞瑞投资32万12月项目，用户可领取2台12 英寸 MacBook 256GB或1台12 英寸
MacBook 256GB+1部iPhone6s Plus（64G）+1个松下智能马桶盖DL-1130CWS）；</p>
    <p>4.活动期间，相同类型的标的，投资金额可累加</p>
     <p style="color:#8f8f8f;background: ">（如活动期间小瑞瑞投资2个3月项目，2个3月项目的投资金额可累加，并获相应奖品）；</p>
    <p>5.约标用户可参加此活动，债权转让项目将不参与本次活动，使用优惠券（任意种类）的投资不能参加本次活动；</p>
    <p>6.本次活动结束后， 10个工作日内发送实物奖品。（实物奖品颜色随机发放）；</p>
    <p>7.如您不需要所获奖品，可按折现价返现；</p>
    <p style="padding-bottom: 20px;">8.本活动最终解释权在法律允许范围内归瑞钱宝所有。</p>
   </div>
   </div>
 <script src="ScrollText/ScrollText.js"></script>
<script type="text/javascript">
  var scroll2 = new ScrollText("breakNewsList","","",true,50,true);
   scroll2.LineHeight = 63; 
</script>
 <script type="text/javascript">
     $(function(){
    	 var myimgUrl = '<%=localPath%>/images/activity/present/present_logo.png'; // 200*200大小
         var mylink = window.location.href;//当前用户为推荐人
         var mydesc = '180万豪礼大放送，越投资越富有，享好礼，无上限';
         var mytitle ='豪礼大放送';
         weixinShare(mytitle,mydesc,myimgUrl,mylink,'<%=localPath%>');//设置微信分享
    	 
    	 
    	 
    	 
	   if(typeof(EventSource) != "undefined"){
			var source = new EventSource("<%=basePath%>/lotteryAward/investHistory2");
			source.onmessage = function(event){
				console.log("event.data"+event.data);
				var items = eval(event.data);
				//console.log("items"+items.length);
				var ele = "<tr><th>用户名</th><th>实际投资金额</th><th>年化投资金额</th></tr>";
				var ele1="";
				for(var i = 0;i < items.length;i++){
					var name = items[i].name;
					var amount = items[i].amount;
					var invest_amount = items[i].invest_amount;
					if(i>=0 && i<3){
						//alert(i);
						if(i==0){
							ele = ele + "<tr class='tr1'><td>"+name+"</td><td>￥ &nbsp;"+invest_amount+"</td><td>￥ &nbsp;"+amount+"</td></tr>"
						}
						else{
							ele = ele + "<tr class='tr2'><td>"+name+"</td><td>￥ &nbsp;"+invest_amount+"</td><td>￥ &nbsp;"+amount+"</td></tr>"
						}
					}
					else{
						ele1 = ele1 + "<li><span>"+name+"</span><span>￥ &nbsp;"+invest_amount+"</span><span>￥ &nbsp;"+amount+"</span></li>"
					}
				}
				 $(".investlist table").html(ele);
				$(".invest_table2 ol").html(ele1);
			}
		}else{
			alert("浏览器不支持EventSource");
		}  
   })  
   
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
