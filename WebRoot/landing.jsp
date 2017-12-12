<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/common2.css" rel="stylesheet"/>
     <link href="css/activity/landing.css" rel="stylesheet"/>
     <script src="js/jquery-1.11.2.min.js"></script>
      <script src="js/utils.js"></script>
      <script src="js/frame/ios_js.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js"></script>
 <script>
 $(function(){
	 getWapData();
	 getProjectList();
 });
 function getWapData() {
	    $.ajax({
	        type : "POST",
	        url : "project/wap/data/get.do",
	        data : {
	        },
	        success : function(response) {
	            if (response.success) {
	                var info = $.parseJSON(response.result);
	                if (info.result) {
	                     $("#user_totle")[0].innerHTML = info.resultObject.turnover+"元";
	                } else {
	                    errorMsg(info.errInfo);
	                }
	            } else {
	                if (isEmpty(response.result)) {
	                    errorMsg(response.msg);
	                } else {
	                    window.location.href = response.result;
	                }
	            }
	        },
	        dataType : "json"
	    });
	}
function openUmp(){
	IOSModel.openUmp();
    if(isAndroidOrIos()){
        appFunction('oepnUmp');
    }else{
        window.location.href = "ump_real_register.jsp";
    }
}
function bindCard(){
	IOSModel.toBindCard();
    if(isAndroidOrIos()){
        appFunction('bindCard');
    }else{
    linkTo('ump_bind_card.jsp');
    }
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

 function toRegister() {
     //IOSModel.iosRegist();
     /* if (isAndroidOrIos()) {
         iosRegist();
         appFunction('regist');
     } else { */
         window.location.href = "ump_register.jsp";
     //}
 }

 /* function showShare() {
     IOSModel.changeWebTitle("新手三重礼");
 } */
 function getProjectList() {
     var url = "";
     url = "project/newget.do";
     $
             .ajax({
                 type : "POST",
                 url : url,
                 data : {
                     type : 2,
                     childType : "",
                     status : "",
                     order : "",
                     orderType : "",
                     index : 1,
                     size : 10,
                     from : ""
                 },
                 success : function(response) {
                     if (response.success) {
                         var info = $.parseJSON(response.result);
                         if (info.result) {
                             var projects = info.resultObject.list == undefined ? info.resultObject
                                     : info.resultObject.list;
                             if (projects.length == 0) {
                             } else {
                                 for(var i = 0;i<projects.length;i++){
                                     if(projects[i].projectType == "111"){
                                         addDataToPage(projects[i]);
                                         return;
                                     }
                                 }
                             }

                         } else {
                             errorMsg(info.errInfo);
                         }
                     } else {
                         errorMsg(response.msg);
                     }
                 },
                 dataType : "json"
             });
 }
 
 function addDataToPage(data){
         //$("#rate")[0].innerHTML = data.loanRate;
         $("#period")[0].innerHTML = data.loanPeriod;
         //$("#unit")[0].innerHTML = data.unit;
         $("#total")[0].innerHTML = data.loanAmount;
         $("#progress")[0].innerHTML = data.projectPercent+"%";
         //$("#progressBar").css("width", data.projectPercent+"%");
         $("#buyBtn").click(function(){
             window.location.href = "project_other_content.jsp?id=" + data.projectID;
        });
 }
 </script>
    <title>瑞钱宝p2p</title>
</head>
<body class="landingAll">
 <header class="landingHead">
 <div><a href="http://www.rqbao.com/"> <img  src="images/activity/landing/logo.jpg"/></a></div>
  <div> <img src="images/activity/landing/hotLine.jpg"/></div>
 </header>
 <section class="landingBanner">
     <a href="http://www.rqbao.com/"> <img src="images/activity/landing/landingBanner.jpg" width="100%"/></a>
 </section>
<section class="grandTotal">
<span>累计成交金额</span><font class="numberRun" id="user_totle"></font>
</section>

<section class="newsList">
<ul > 
            <li style="text-align:center; ">
            <p><a href="javascript:;"><img src="images/activity/landing/iconHouse.png"/></a></p>
              <p><span >国企参股</span></p>
              <p>瑞钱宝是由国瑞泰控股发起,由中国大型央企中国华融全资子公司华融天泽参股的专业互联网家庭理财</p>
            </li>
            <li>
             <p><a href="javascript:;"><img src="images/activity/landing/iconDollar.png"/></a></p>
               <p><span>中信银行存管</span></p>
               <p>资金交易通道全部切换至联动优势，资金存管在中信银行，资金用途透明化，全方位保障用户资金</p>
            </li>
            </ul>
            <ul> 
            <li>
             <p><a href="javascript:;"><img src="images/activity/landing/iconWood.png"/></a></p>
               <p><span >PICC承保</span></p>
               <p>资金交易通道全部切换至联动优势，资金存管在中信银行，资金用途透明化，全方位保障用户资金</p>
            </li>
            <li style="margin-right:0px;">
                 <p><a href="javascript:;"><img src="images/activity/landing/imprest.jpg"/></a></p>
               <p><span>风险备付金</span></p>
              <p>资金交易通道全部切换至联动优势，资金存管在中信银行，资金用途透明化，全方位保障用户资金</p>
            </li>

        </ul>

</section>
<img class="landing_title" src="images/activity/landing/landing_title.jpg"/>
<img class="ritesImg.jpg" src="images/activity/landing/ritesImg.jpg"/>
<section class="newhand" id="newHand" style="cursor:pointer;">

     <div class="landingRound" id="buyBtn">
     <h2 style="">新手体验标</h2>
            <div class="xmggdiv">
                <div class="percentList">
      <span><a href="#" id="progress"><font></font> </a></span> 
                      <span >年化收益率</span>
                 </div>
                 <div class="endlist">
                    <ul>
                      <li>
                        <span>期限:</span>
                        <span style="font-size:1.5em;" id="period"></span><font style="color:#666666;">天</font>
                      </li>
                      <li>
                        <span>总额:</span>
                        <span style="font-size:1.5em;" id="total"></span><font style="color:#666666;"></font>
                      </li>
                    </ul>
                  
                </div> 
                <div style="clear:both"></div>
                </div>
     </section>   
<img class="ritesImg1.jpg" src="images/activity/landing/ritesImg1.jpg"/>

<section class="registerMe">
<ul>
      <li onclick="linkTo('ump_register.jsp')">
       <a> <img src="images/activity/landing/pro_01.png"/></a>
      </li>
      <li onclick="openUmp()">
        <a>  <img src="images/activity/landing/pro_02.png"/></a>
  
      </li>
      </ul>
      <ul>
      <li onclick="bindCard()">
        <a>  <img src="images/activity/landing/pro_03.png"/></a>
 
      </li>
      <li onclick="toProject()">
       <a>   <img src="images/activity/landing/pro_04.png"/></a>
      </li>
    </ul>
</section>
<img class="ritesImg1" src="images/activity/landing/ritesImg2.jpg"/>
  <section class="coupons">
      <p> <img src="images/activity/landing/coupons.jpg" align="left"/></p>
       <div  id="landContent">
        <p style="padding: 0 5%">1、使用以上任意红包，即可得到 1%加息券（有且仅有1次机会哦）</p>
           <p style="padding: 0 5%">2、使用规则：除新手体验标外，其他任意标可用，对投资期限无要求</p>
        <p style="padding: 0 5%">3、使用加息券投资，投资金额无上限</p>
       </div>
     </section>
<img class="register02" src="images/activity/landing/register02.jpg"/>
<img class="mediaBg" src="images/activity/landing/mediaBg.jpg"/>
<section class="mediaSaying">
       <a href="#"><img src="images/activity/landing/actionImages.jpg"></a>
       <p>
      <b><a href="${article.url}">【中国联合商报】互金模式创新不断 国资布局资...</a></b><br/>
 华融天泽投资有限公司（简称“华融天泽”）是经中国证监会批准，由华融证券股份有限公司（简称“华融证券”）于2012 年11月设立，专门从事直接投资业务的... ...
华融天泽依托中国华融资产管理股份有限公司（中国华融）和华融证券强大的品牌和资源优势，一方面，努力为具有良好成 长潜力的企业提供资金支持及全方位的金融服务，深入发掘企业成长潜在价
值，帮助企业实现价值提升；另一方面，针对投资 者风险承受能力和收益期望设计提供有针对性的投资方案，努力满足投资者多样化投资需求
       </p>
   </section>   
          <div class="mediaLists">
          <ul>
          <li><a href="http://www.sina.com.cn/"><img src="images/activity/landing/sinaIcon.jpg" /></a></li>
            <li><a href="http://www.cet.com.cn/"><img src="images/activity/landing/newsIcon.jpg" /></a></li>
            <li><a href="http://www.cs.com.cn/"><img src="images/activity/landing/middleIcon.jpg" /></a></li>
             <li><a href="http://www.china.com"><img src="images/activity/landing/chinaIcon.jpg" /></a></li>
             <li><a href="http://www.3news.cn/"><img src="images/activity/landing/3nccwIcon.jpg" /></a></li> 
          </ul><div class="clear"></div>
          </div> <!-- -mediaLists end -->
          <img class="friendBg" src="images/activity/landing/friendBg.jpg"/>
  <section class="marquee">
        <ul>
          <li><a href="http://www.umpay.com/umpay_cms/" target="_blank"><img src="images/activity/landing/ump.jpg"/></a></li>
          <li><a href="http://www.p2peye.com/" target="_blank"><img src="images/activity/landing/wdty.jpg"/></a></li>
          <li><a href="http://www.itrus.com.cn/" target="_blank"><img src="images/activity/landing/twcx.jpg"/></a></li>
          <li><a href="http://www.gdyingteng.com/" target="_blank"><img src="images/activity/landing/yteng.jpg"/></a></li>
          <li><a href="http://www.focusmedia.cn/" target="_blank"><img src="images/activity/landing/fzcm.jpg"/></a></li>
    </ul>
    <ul style="float:left;">
     <li><a href="http://www.wangdaizhijia.com/" target="_blank"><img src="images/activity/landing/wdzj.jpg"/></a></li>
          <li><a href="http://www.epicc.com.cn/renbao/gsgkrb/gongsijianjie/" target="_blank"><img  src="images/activity/landing/picc.jpg"/></a></li>
          <li><a href="http://t.hrsec.com.cn/main/gyhr/ywjs/hrtztz/index.shtml" target="_blank"><img src="images/activity/landing/huarong.jpg"/></a></li>
          <li><a href="http://bank.ecitic.com/" target="_blank"><img src="images/activity/landing/zhongxin.jpg"/></a></li>  
    </ul>
    <div style="clear:both"></div>
    <div id="error_info" class="error_info"></div>
      </section>
       <section class="landingFooter">
        <p> <img class="hotLiness" src="images/activity/landing/hotLiness.png"/></p>
       <P> Copyright © 2014-2016  瑞钱宝资产管理服务有限公司</p>  
            <P>京ICP备14024431号</P>
       </section>         
</body>
<script src="js/frame/rqbaoappshare.js" type="text/javascript"></script>
</html>