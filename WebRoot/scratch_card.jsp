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
    String userApp = request.getParameter("user111");
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
<%
    Date serviceDate = new Date();
    String startDate = "2016-03-31";
    String overDate = "2016-04-15";
    boolean flag = false;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String date = sdf.format(serviceDate);
    if (date.compareTo(startDate) < 0 || date.compareTo(overDate) > 0) {
        flag = true;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width">
    <title>刮刮卡</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/common2.css" rel="stylesheet"/>
    <link href="css/utils.css" rel="stylesheet" />
    <link href="css/frame/lucky-card.css" rel="stylesheet"> 
     <link href="css/activity/scratch_card.css" rel="stylesheet"> 
    <script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
    <script src="js/frame/lucky-card.min.js"></script>
    <script src="js/jweixin-1.0.0.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/weixin_share.js"></script>
    <script type="text/javascript">
    $(function(){
        var myimgUrl = '<%=localPath%>/images/lottery/scratch_logo.png'; // 200*200大小
        var mylink = '<%=localPath%>/scratch_card.jsp?referrer=<%=userHex%>';//当前用户为推荐人
        var mydesc = '大家一起来刮刮卡，抽奖机会更多，领加息券再投资，注册就有大礼包';
        var mytitle ='邀请好友注册，增加抽奖机会';
        weixinShare(mytitle,mydesc,myimgUrl,mylink,'<%=localPath%>');//设置微信分享
    });
    
    function startLottery(lotteryId,lotteryName,price,investAmount,period){
        $(".scratch_one").css("display","none");
    $(".scratch_agin").css("display","block"); 
    $(".scratch1_left").css("position","static"); 
    $(".scratch_title1").html("<strong>"+lotteryName+"</strong>！");
    if(lotteryId == 13){
        $(".rule").css("display","none");
    }else{
        $(".rule").text("投资金额≥"+investAmount+"元、投资期限≥"+period+"个月可用");
    }
    LuckyCard.case({coverColor:"#ccc",
        ratio: .3//刮开面积
    }, function() {
        lotteryCount();
               $("#cover").remove();
        this.clearCover();//清除图层
    });
   }   
    function lottery(){
        
        <%-- if(<%=flag%>){
            alert("活动开放时间段为2016-04-01至2016-04-15");
            return;
        }   --%>
   var lotteryId = 13;
 var lotteryName = "";
 var price = "";
 var investAmount = "";
 var period = "";
 $.ajax({
                url:"<%=basePath%>/lotteryAward/lotteryV2",
                data : {from:"app",
                    loginName:$("#loginName").val()},
                type:"post",
                dataType:"json",
                success:function(response){ 
                    var status = response.status;
                    if(status == "001"){
                        //alert(response.message);
                    	 showAys(response.message);
                    }else if(status == "002"){
                        if(confirm("该次需要消耗1000积分,是否继续？")){
                             $.ajax({
                                url:"<%=basePath%>/lotteryAward/exchangeV2",
                                data : {from:"app",
                                    userId:$("#userId").val()},
                                type:"post",
                                dataType:"json",
                                success:function(response){
                                    lotteryCount();
                                    if(response.message == "您的可用积分不足!" ||
                                            response.message == "登录之后才可以抽奖哦"){
                                        alert(response.message);
                                    }else{
                                        lottery();
                                    }
                                    //alert(response.message);
                                }
                            }); 
                        };
                    }else if(status == "003"){
                        //lotteryCount();
                        $(".lotteryCount").text(parseInt($("._lotteryCount").val()) - 1);
                        lotteryId = parseInt(response.lotteryId);
                        lotteryName = response.lotteryName;
                        price = response.price;
                        investAmount = response.investAmount;
                        period = response.period;
                        startLottery(lotteryId,lotteryName,price,investAmount,period);
                        //console.log("lotteryId:"+lotteryId+",lotteryName:"+lotteryName);
                    }else if(status = "004"){
                        alert("系统繁忙,请稍后再试！");
                    }
                }
            });
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
        var rf = "<%=refer%>";
        window.location.href = "login.jsp?reflect_url=scratch_card.jsp&?from=<%=from%>&referrer=" + rf;
    }
</script>
</head>
<body>
<div id="bg"></div>
<section class="alert-dialog" id="login">
        <h5 class="alert-dialog-title">提示信息</h5>
        <div class="alert-dialog-content" id="login_content"></div>
        <ul class="alert-dialog-button">
            <li onclick="dismissAys()">取消</li>
            <li onclick="login()">确定</li>
        </ul>
    </section>
<section class="alert-dialog" id="ays3">
        <h5 class="alert-dialog-title">提示信息</h5>
        <div class="alert-dialog-content" id="ays_content3"></div>
        <ul class="alert-dialog-button">
            <li><button onclick="dismissAys3()">取消</button></li>
            <li><button onclick="dismissAys3()">确定</button></li>
        </ul>
    </section>
 <div style="background:#fffde6;">
   <img src="images/activity/scratch_card/scratch_banner.png" width="100%"/>
   <div class="centerdiv scratch1">
     <h3 class="scratch_h3"></h3>
     <div style="clear:both;">
       <div class="scratch1_left">
       <%-- <div class="scratchs" id="scratchs">
          <p class="scratch_title"><strong>90%</strong>中奖率，最高刮出<strong>6%</strong>加息券！</p>
          <p style="padding-top:18%;"><a href="javascript:void(0);" onClick="lottery()" class="btn_scratch">开始刮奖</a></p>
          <p id="scratch_tip" >刮开看看试试手气</p>
          </div>
          <canvas id="scratch_canvas"></canvas> --%>
          <div id="scratch"> 
       <div id="card"> 
       <!-- <div class="btn">button</div>--> 
           <div class="scratch_one" > 
             <p class="scratch_title"><strong>90%</strong>中奖率，最高刮出<strong>6%</strong>加息券！</p> 
             <p class="cards"><a href="javascript:void(0);" onClick="lottery();" class="btn_scratch">开始刮奖</a></p> 
          
         </div> 
         <div class="scratch_agin"> 
         <p class="scratch_title1"><strong>5</strong>%加息券！</p> 
         <p>投资金额≥30万元、投资期限≥12个月可用</p> 
         <p class="cards1"><a href="javascript:void(0);" onClick="lottery();" class="btn_scratch btn_scratch2">再来一次</a></p> 
        </div> 
       </div> 
     </div>
       </div>
       <div class="scratch1_right">
          <p>
                              你有  <strong class="lotteryCount"></strong>  次刮奖机会<br/>
                              已中奖   <strong class="winCount"></strong>  次 <a href="my_coupon_center.jsp" class="btn_bx"></a><br/>
            <span style="font-size:1.6rem;">活动说明：</span> <br/>
            1.活动每个用户有一次抽奖机会；<br/>
            2.除免费刮一次外，用户每刮一次刮刮卡自动扣除1000积分，邀请1位好友加一次刮刮卡机会，同时获得可优先消耗邀请好友的刮刮卡机会；<br/>
            3.刮到的优惠券于4月16日00:00过期，请用户在使用期限内使用；<br/>
            4.每笔投资可用一张加息券，加息券与其他优惠券不可同时使用。
          </p>
       </div>
     </div>
      <div style="clear:both;"></div>
     
   </div>
   <div class="centerdiv scratch2">
   <h3 class="scratch1_h3"></h3>
     <ul>
       <li>
         <img src="images/activity/scratch_card/macBook.png"/>
         <h4>第1名</h4>
         <p>MacBook(12英寸 512GB)<br/>(价值11288)</p>
       </li>
       <li>
         <img src="images/activity/scratch_card/iphone.png"/>
         <h4>第2名</h4>
         <p>iPhone6 Plus 64g<br/>(价值6888)</p>
       </li>
       <li>
         <img src="images/activity/scratch_card/ipad.png"/>
         <h4>第3-6名</h4>
         <p>iPad mini 4<br/>(价值3588)</p>
       </li>
       <li>
         <img src="images/activity/scratch_card/jd_card.png"/>
         <h4>第7-10名</h4>
         <p>京东E卡1000元<br/>(价值1000)</p>
       </li>
     </ul>
     <div style="clear:both;"></div>
     <table>
       <tr>
         <th>投资排名</th>
         <th>用户名</th>
         <th>年化投资金额</th>
       </tr>
        <tr>
         <td>1</td>
         <td>152***2365</td>
         <td>30,000,000元</td>
       </tr>
       <tr>
         <td>2</td>
         <td>zhang**</td>
         <td>30,000,000元</td>
       </tr>
       <tr>
         <td>3</td>
         <td>152***2365</td>
         <td>30,000元</td>
       </tr>
     </table>
     <p style="width:90%;margin:10px auto 0;font-size:1.4rem;color:#333;">年化投资额：投资金额*项目周期/12，如小A投资6月项目10000元，其年化投资额为5000元。</p>
   </div>
   <div class="centerdiv scratch3">
     <h3 class="scratch2_h3"></h3>
     <p>1、所有的数据在2016年4月1日-4月15日内有效；<br/>
                2、三、六、十二月标均参与投资额排名奖，债券转让、新手标、一月标不参与排名奖；<br/>
                3、活动期间，年化投资总额须达到20万以上，方可获得奖品；<br/>
                4、实物奖品将于活动结束后的10个工作日内发放；<br/>
                5、如有疑问请咨询瑞钱宝官方客服：400-919-8555；<br/>
                6、活动的最终解释权归瑞钱宝所有。</p>
   </div>
 </div>
 <input type="hidden" id="loginName" value="<%=user%>"/>
  <input type="hidden" id="userId" value="<%=userId%>"/>
  <input type="hidden" class="_lotteryCount" value=""/>
</body>
<script>
$(function(){
    lotteryCount();
    
    if(typeof(EventSource) != "undefined"){
        var source = new EventSource("${ctx}/lotteryAward/investHistory");
        source.onmessage = function(event){
            console.log("event.data"+event.data);
            var items = eval(event.data);
            //console.log("items"+items.length);
            var ele = "<tr><th>投资排名</th><th>用户名</th><th>年化投资金额</th></tr>";
            for(var i = 0;i < items.length;i++){
                var name = items[i].name;
                var amount = items[i].amount;
                ele = ele + "<tr><td>"+(i+1)+"</td><td>"+name+"</td><td>"+amount+"元</td></tr>"
            }
            $("table").html(ele);
        }
    }else{
        alert("浏览器不支持EventSource");
    }  
});
function lotteryCount(){
        $.ajax({
            url:"<%=basePath%>/lotteryAward/lotteryCountV2",
            data : {from:"app",
                loginName:$("#loginName").val()},
            type:"post",
            dataType:"json",
            success:function(response){ 
                $(".lotteryCount").text(response.remainLotteryCount);
                $(".winCount").text(response.winCount);
                $(".points").text(response.points);
                $("._lotteryCount").val(response.remainLotteryCount);
            }
        });
  }
</script>
</html>
