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
    //String basePath = "http://test.rqbao.com/rqb";
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
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/common2.css" rel="stylesheet"/>
    <link href="css/activity/summit.css" rel="stylesheet"/>
    <script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
     <script type="text/javascript" src="js/bootstrap.min.js"></script>
    
</head>
<body style="background:#fff;">

<div>
  <img src="images/activity/summit/summit_01.png" width="100%"/>
  <div class="summit1" >
  <div>
    <div>
      <div class="summit1_left summit1_left_border">
        <h4>2016互联网金融峰会</h4>
        <p>2016年，随着监管政策的落地，互金行业发展进入了分化期。<p>
        <p>颇受业内认可、投资人欢迎的“融资中国2016互联网金融峰会”再次出发：峰会以“专业、实战”为出发点，
            邀请监管层；互联网金融、传统金融；VC/PE、上市公司；行业协会、第三方研究机构及互金投资人，
            从行业监管、一级市场投融资及平台资产端、资金端等方面展开探讨……</p>
      </div>
      <div class="summit1_left">
        <div id="myCarousel" class="carousel slide" data-ride="carousel" >
      <!-- 轮播（Carousel）指标 -->
        <ol class="carousel-indicators">
          <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
          <li data-target="#myCarousel" data-slide-to="1"></li>
          <li data-target="#myCarousel" data-slide-to="2"></li>
        </ol> 
          <div class="carousel-inner">
           <div class="item active">
              <img src="images/activity/summit/summit_img1/1.jpg"/>
            </div>
            <div class="item">
             <img src="images/activity/summit/summit_img1/2.jpg"/>
            </div>
            <div class="item" >
            <img src="images/activity/summit/summit_img1/3.jpg"/>
            </div>
          </div>
        </div><!-- banner end -->
      </div>
    </div>
  </div>
  </div>
  <div class="summit2">
    <h4>现场展台</h4>
    <div id="myCarousel1" style="margin-top:20px;border:none" class="carousel slide carousel1" data-ride="carousel" >
        <ol class="carousel-indicators">
            <li data-target="#myCarousel1" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel1" data-slide-to="1"></li>
            <li data-target="#myCarousel1" data-slide-to="2"></li>
            <li data-target="#myCarousel1" data-slide-to="3"></li>
            <li data-target="#myCarousel1" data-slide-to="4"></li>
            <li data-target="#myCarousel1" data-slide-to="5"></li>
            <li data-target="#myCarousel1" data-slide-to="6"></li>
            <li data-target="#myCarousel1" data-slide-to="7"></li>
            <li data-target="#myCarousel1" data-slide-to="8"></li>
        </ol>
        <div class="carousel-inner">
            <div class="item active">
                <img src="images/activity/summit/summit_img2/1.jpg"/>
            </div>
            <div class="item">
                <img src="images/activity/summit/summit_img2/2.jpg"/>
            </div>
            <div class="item" >
                <img src="images/activity/summit/summit_img2/3.jpg"/>
            </div>
            <div class="item" >
                <img src="images/activity/summit/summit_img2/4.jpg"/>
            </div>
            <div class="item" >
                <img src="images/activity/summit/summit_img2/5.jpg"/>
            </div>
            <div class="item" >
                <img src="images/activity/summit/summit_img2/6.jpg"/>
            </div>
            <div class="item" >
                <img src="images/activity/summit/summit_img2/7.jpg"/>
            </div>
            <div class="item" >
                <img src="images/activity/summit/summit_img2/8.jpg"/>
            </div>
            <div class="item" >
                <img src="images/activity/summit/summit_img2/9.jpg"/>
            </div>
        </div>
       </div>
  </div>
  <div class="summit1" >
  <div>
    <div>
        <div class="summit1_left summit1_left_border">
            <h4>圆桌论坛<br/>在创新中求发展</h4>
            <p>互联网金融最大的特点是以用户的资源为核心要素，新兴的互金企业在初期并不注重盈利，做大用户规模之后，通过用户这样一个精准化的需求挖掘，进而创新业务。<p>
            <p>今后，瑞钱宝将不再是单独的理财平台，还会带动其他产业的关联发展。但是互金创新的同时也要正视风险的存在，在创新的同时如何平衡好与风险的关系才是关键。</p>
        </div>
      <div class="summit1_left">
        <div id="myCarousel2" class="carousel slide" data-ride="carousel" >
      <!-- 轮播（Carousel）指标 -->
        <ol class="carousel-indicators">
          <li data-target="#myCarousel2" data-slide-to="0" class="active"></li>
          <li data-target="#myCarousel2" data-slide-to="1"></li>
          <li data-target="#myCarousel2" data-slide-to="2"></li>
        </ol> 
          <div class="carousel-inner">
           <div class="item active">
              <img src="images/activity/summit/summit_img3/1.jpg"/>
            </div>
            <div class="item">
             <img src="images/activity/summit/summit_img3/2.jpg"/>
            </div>
            <div class="item" >
            <img src="images/activity/summit/summit_img3/3.jpg"/>
            </div>
          </div>
        </div><!-- banner end -->
      </div>

    </div>
  </div>
  </div>
  <div class="summit3">
    <h4>瑞钱宝荣获“2015互联网金融年度最佳投资机构”</h4>
    <div class="centerdiv summit4">
      <ul>
        <li><img src="images/activity/summit/summit_img4/1.jpg"/></li>
        <li><img src="images/activity/summit/summit_img4/2.jpg"/></li>
        <li><img src="images/activity/summit/summit_img4/3.jpg"/></li>
      </ul>
    </div>
  </div>
</div>
</body>
</html>
