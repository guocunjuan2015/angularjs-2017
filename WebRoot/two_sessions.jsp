<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String localPath = "http://www.rqbao.com/rqb";
    String from = request.getParameter("from");
    if(from == null || !("app".equals(from))){
        from = "";
    }
    if (from != null && "app".equals(from)) {
        String user = request.getParameter("user");
        if (user != null && user != "") {
            HttpSession s = request.getSession();
            s.setAttribute("loginUser", user);
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
        <link href="css/activity/twosessions.css" rel="stylesheet"/>
         <script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
           <script type="text/javascript" src="js/utils.js"></script>
            <script src="js/jweixin-1.0.0.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/weixin_share.js"></script>
    <title>瑞钱宝p2p</title>
 <script type="text/javascript">
 $(function(){
     //initApp();
     var myimgUrl = ''; // 200*200大小
     var mylink = '<%=localPath%>/two_sessions.jsp';// 
     var mydesc = '瑞钱宝3000万大放送，全场加息1%-3.5%，最高年化收益22%，还能免费抽Macbook pro、iphone6s、ipad、iWatch，更多惊喜，等你来拿！';
     var mytitle ='点一下，12月多赚2万！';
     weixinShare(mytitle,mydesc,myimgUrl,mylink,'<%=localPath%>');
 });</script>
</head>
<body>

 <section class="sessionsBanner">
     <a href="http://www.rqbao.com/"> <img src="images/activity/twosessions/sessionsBanner.jpg" width="100%"/></a>
 </section>

 <section class="sessionsWord">
          <p>政府倡导：<br/>地下金融<font>阳光化</font>，线下金融<font>透明化</font>——故此诞生了<font>互联网金融</font>,联网金融已是一个行业、一个产业！
   广大中小民营企业为社会提供了<font>80%的就业岗位</font>。国家需要互联网金融为资金缺口达<font>23</font>万亿以上的广大中小民营企业解决<font>融资难</font>、<font>融资贵</font>的问题。
      互联网金融能满足老百姓不同风险偏好，不同层次的多元化的金融服务需求，<font>有利于</font>降低金融行业的运行成本和提升运行效率，<font>有利于</font>促进社会经济发展，
         <font>有利于</font>促进就业！有利于社会稳定和谐！
</p>
 </section>
 <section>
    <img src="images/activity/twosessions/sessionTopic.jpg"/>
 </section>
 
 <section class="centerdiv">
<img  style="margin-top:1em;" src="images/activity/twosessions/newsRight.jpg"/>
  </section>
  <section class="policy">  
  <img  src="images/activity/twosessions/policyTopic.jpg"/>
  <p class="internetImage" ><a href="http://finance.people.com.cn/n/2015/0518/c1004-27017598.html" title="国务院印发《关于加快构建大众创业万众创新支撑平台的指导意见 "><img src="images/activity/twosessions/internetImage.jpg"/></a></p> 
  </section>
   <!-- <h1 class="yearsFive">2015</h1>-->
    <section class="timeLineNew">
    <img  src="images/activity/twosessions/years.jpg"/>
<!--  <ul>
  <li class="activeNew">9月26日</li>
 <li>7月4日 </li>
  <li>6月16日</li>
  </ul>
  <div></div>-->
  </section>
<!--    <div class="moreNews">
  <ul>
  <li> 国务院印发《关于加快构建大众创业万众创新支撑平台的指导意见 </li>
 <li>国务院发布《国务院关于积极推进“互联网+”行动的指导意..</li>
  <li>国务院发布《关于大力推进大众创业万众创新若干政策措施的意见》</li>
 <!-- <li>国务院批转了发改委《发改委关于2015年深化经济体制改革重点.....</li>  
 <li> 国务院正式发布《国务院关于进一步做好新形势下就业创业工作的意见.....</ul><div style="clear:both"></div>
  </div>.</li>  -->


      <!--<section class="timeLineNew"> 
   <ul>
  <li>5月8日 </li>  
 <li> 5月1日</li>  
  </ul>
  <div></div>
  </section>-->
  <!--<div class="moreNews">
  <ul>
 <li>国务院批转了发改委《发改委关于2015年深化经济体制改革重点.....</li>  
 <li> 国务院正式发布《国务院关于进一步做好新形势下就业创业工作..</li> 
  </ul><div style="clear:both"></div>
  </div>-->
  
  <img class="internetimages/activity/twosessions" style="margin-top:1em;" src="images/activity/twosessions/internetimages/activity/twosessions.jpg"/>
  <div class="leaderList" >
  <p class="leaderLeft">
  <a href="http://politics.people.com.cn/n1/2015/1216/c1001-27937787.html"> <img src="images/activity/twosessions/leaderImage.jpg"/></a>
  </p>
  <div class="leaderRight">
  <ul>
  <li>
  <p>12月16日</p>
  <p>乌镇第二届世界互联网大会。</p>
  <p>国家主席习近平出席开幕式并发表主旨演讲。</p>
  <p></p>
  </li>
  
  <li>
  <p>10月16日</p>
  <p>国务院总理李克强主持召开金融企业座谈会。</p>
  <p>总理在会议上提出，融依托实体经济规范有序发展......</p>
  <p></p>
  </li>
  
   <li>
  <p>9月16日</p>
  <p>李克强总理主持召开国务院常务会议。</p>
  <p>李克强总理在会议上指出，要加快发展融资租赁和金融...</p>
  <p></p>
  </li>
  
  </ul>
  </div>
</div><!-- leaderList end -->

  <section class="centerdiv">
   <img class="financial" src="images/activity/twosessions/financial.jpg"/>
    <div class="leaderList">
  <div class=" hallLeft">
  <a href="#" title="的建议》"><img class="hallImage" src="images/activity/twosessions/hallImage.jpg"/></a> 
  </div>
  <div class="hallRight">
  <p>2015年11月3日，《中共中央关于制定国民经济和社会发展第十三个五年规划的建议》正式发布。
该文件在阐述第三节......</p>
  </div>
</div><!-- leaderList end -->
   </section>
   
     <img class="directionImage" src="images/activity/twosessions/directionImage.jpg"/>
<div class="leaderList">
  <div class="hallLeft">
   <a href="#"><img class="chinaPeople" src="images/activity/twosessions/chinaPeople.jpg"/></a>
  </div>
  <div class="hallRight" style="pdding-right:0">
  <p>2015年7月18日，央行联合十部委正式发布了《关于促进互联
网金融健康发展的指导意见》。该意见不仅正式承认了P2P的合
法地位....</p>

  </div>
</div><!-- leaderList end -->
  
    <div class="centerdiv">
  <img style="margin-top:1em;"  src="images/activity/twosessions/develop.jpg"/>
  <div class="leaderList">
  <div class="hallLeft">
  <a href="#" title="2》"><img class="lawImage" src="images/activity/twosessions/lawImage.png"/></a>
  </div>
  <div class="hallRight" >
  <p><b>2015年8月6日，最高法出台了《最高人民法院关于审理民间借贷案件适用法律若干问题的规定》。</b>规定中在划定了
24%的民间借贷利率红线的同时....</p>
  </div>
</div><!-- leaderList end -->
  
  </div>
</body>
</html>