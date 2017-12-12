<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/common2.css" rel="stylesheet"/>
    <link href="css/more.css" rel="stylesheet"/>
    <script src="js/jquery-1.11.2.min.js"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/frame/ios_js.js" type="text/javascript"></script>
<script type="text/javascript">
function toProject(){
	toIosInvest();
    if(isAndroidOrIos()){
        appFunction('invest');
    }else{
        window.location.href = "project.jsp";
    }
}
</script>
<%@ include file="config/header.jsp"%>
    <title>新手赚钱攻略</title>
</head>
<body>
   <img src="images/news_money/money_banner.png"/>
   <section class="news-money">
       <div class="news-moneys">
          <img src="images/news_money/money_top.png"/>
          <i class="money-icon3">&nbsp;</i>
          <div class="news-money-center">
              <img src="images/news_money/money_01.png"/>
              <img src="images/news_money/money_02.png"/>
              <img src="images/news_money/money_03.png"/>
              <a onclick="toProject()"><img src="images/news_money/btn_invest.png"/></a>
          </div>
          <i class="money-icon1">&nbsp;</i>
          <i class="money-icon2">&nbsp;</i>
          <img src="images/news_money/money_bottom.png"/>
          <p style="width:96%;margin:10% auto 0;padding-bottom:2%;text-align:center;"><img src="images/news_money/money_04.png"/></p>
       </div>
       <div class="active-rule">
           <dl>
               <dt><i class="clock">&nbsp;</i>活动日期：</dt>
               <dd>2016.01.15-2016-02-18</dd>
           </dl>
           <dl>
               <dt><i class="rule-icon">&nbsp;</i>活动规则：</dt>
               <dd>活动期间新用户投资平台上（除债权转让外）任意标的，投满就送瑞钱币</dd>
           </dl>
           <dl>
               <dt><i class="reward-icon">&nbsp;</i>奖励说明：<i class="flower-icon">&nbsp;</i></dt>
               <dd>
                   <p>1.奖励以瑞钱币形式在用户投资成功后发放至用户账户中</p>
                   <p>2.本次获得瑞钱币仅限于投资3个月及以上项目，有效期为1个月</p>
                   <p>3.瑞钱币按个数使用，每投资100元可使用1个瑞钱币，投资成功后瑞钱币以现金形式返还到用户账户中</p>
                   <i class="flower-icon1">&nbsp;</i>
               </dd>
           </dl>
       </div>
       <p style="width:96%;margin:2% auto 0;padding-bottom:2%;text-align:center;"><img src="images/news_money/money_04.png"/></p>
       <p style="margin:5% auto 0;padding-bottom:3%;width:92%;text-align:center;font-size:1.2rem">本活动最终解释权归北京瑞钱宝资产管理服务有限公司所有，若有疑问请拨打客服电话：<span style="text-decoration: underline;">400-919-8555</span></p>

   </section>
</body>
<script type="text/javascript" src="js/frame/rqbaoappshare.js"></script>
</html>