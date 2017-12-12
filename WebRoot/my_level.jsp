<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String from = request.getParameter("from");
    if(from == null || !("app".equals(from))){
        from = "";
    }
    if (from != null && "app".equals(from)) {
        String user = request.getParameter("user");
        String userId = request.getParameter("userId");
        if (user != null && user != "" && userId != null && userId != "") {
            HttpSession s = request.getSession();
            s.setAttribute("loginUser", user);
            s.setAttribute("userId", userId);
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width，initial-scale=1.0，maximum-scale=1.0，minimum-scale=1.0，user-scalable=no" />
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/common2.css" rel="stylesheet"/>
    <link href="css/mylevel.css" rel="stylesheet"/>
    <script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
    <script src="js/utils.js" type="text/javascript"></script>
    <script src="js/my_level.js" type="text/javascript"></script>
    <%@ include file="config/header.jsp" %>
    <title>会员等级</title>
    <style type="text/css">
        .progress{height:5px;}
        .progress-bar{border-radius:3px;-webkit-border-radius:3px;
            background: -webkit-linear-gradient(right， #fd7c53 ， #f74d42); /* Safari 5.1 - 6.0 */
            background: -o-linear-gradient(right， #fd7c53 ， #f74d42); /* Opera 11.1 - 12.0 */
            background: -moz-linear-gradient(right， #fd7c53 ， #f74d42); /* Firefox 3.6 - 15 */
            background: linear-gradient(to right， #fd7c53 ， #f74d42); /* 标准的语法（必须放在最后） */}
    </style>
</head>
<body>
   <section class="member-level">
       <div style="float:left;">
       <span style="font-size: 1rem">我的等级</span>
       <img id="level_img" src="" style="width:35%;"/>
       </div>
       <a class="btn-member-strategy "style="font-size: 0.8rem;margin-top: 7px;" onclick="toStrategy()" >会员攻略 &gt;</a>
       <div style="clear:both;"></div>
       <p class="member-coupons " style="margin-left: 0px;font-size: 1rem">新增积分：<strong id="points_of_month" style="font-size: 1rem"></strong></p>
       <p class="member-coupons " style="text-align: center;font-size: 1rem"><strong id="level_progress"></strong></p>
       <div class="progress" style="margin:1% 0;">
           <div id="level_progress" class="progress-bar progress-perc" role="progressbar" aria-valuenow="0"
                aria-valuemin="0" aria-valuemax="100" >

           </div>
       </div>
       <div  style="margin:0 auto;width:100%"><img src="images/vip_level/level.png"/></div>
   </section>
   <section class="my-special">
       <h3 style="font-size: 1.1rem;">我的特权</h3>
       <ul class="tq limit_mess">
           <li id="senior">
               <img src="images/vip_level/gao.png"/>
               <p>高级<br/>投资专场</p>
           </li>
           <li id="message">
               <img src="images/vip_level/message.png"/>
               <p>短信<br/>推荐项目</p>
           </li>
           <li id="phone" >
               <img src="images/vip_level/tel.png"/>
               <p>电话<br/>推荐项目</p>
           </li>
           <li id="repay">
               <img src="images/vip_level/bank.png"/>
               <p>回款<br/>电话提醒</p>
           </li>
           <li id="invest">
               <img src="images/vip_level/invest.png"/>
               <p>投资<br/>收益提高</p>
           </li>
           <li id="hotline">
               <img src="images/vip_level/400.png"/>
               <p>400热线</p>
           </li>
           <li id="lend">
               <img src="images/vip_level/jie.png"/>
               <p>借款优惠</p>
           </li>
           <li id="solve">
               <img src="images/vip_level/solute.png"/>
               <p>解决问题</p>
           </li>
           <li id="onetoone">
               <img src="images/vip_level/onebyone.png"/>
               <p>一对一<br/>专职服务</p>
           </li>
       </ul>
   </section>
<section class="my-ward">
    <h3 style="font-size: 1.1rem">我的福利</h3>
    <p style="font-size: 1rem">
       <!--  1.每日积分抽奖<br/>
        2.每月奖励 <strong id="month_award"></strong> 元瑞钱币<br/> -->
        生日奖励 <strong id="birth_award"></strong> 元红包<br/>
    </p>
    <!-- <button class="btn btn-lottery" style="font-size: 1rem">去抽奖</button> -->
</section>
   <section class="my-ward" style="margin-bottom:0;">
       <h3 style="font-size: 1.1rem">增值服务</h3>
       <p class="ward-add" id="vip1_4">
           暂无<br/>
       </p>
       <p class="ward-add" id="vip5">
           充值卡；代金券，一次/年<br/>
       </p>
       <p class="ward-add" id="vip6">
           代金券、充值卡；水果，礼品，一次/半年<br/>
       </p>
       <p class="ward-add" id="vip7">
           1.体检服务、足疗仪（保健设备）、螃蟹券，1次/半年；<br/>
           2.水果、礼品，1次/半年；<br/>
           3.高尔夫等，获邀参加贵宾沙龙活动等，1次/半年；<br/>
           4.年底礼品一份/年<br/>
       </p>
       <p class="ward-add" id="vip8">
           1.金条、纪念卡，1次/季度<br/>
           2.意外保险卡（1张/年），1次/季度<br/>
           3.汽车救援服务，1次/季度<br/>
           4.获邀参加贵宾沙龙活动，管家提醒服务，1次/季度<br/>
           5.年底礼品一份/年<br/>
       </p>
   </section>
</body>
</html>