<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
 <%@ include file="/config/config.jsp" %>
<%@ include file="/config/global.jsp" %>
<!DOCTYPE html>
<html ng-app="indexApp">
<head>
    <meta charset="UTF-8">  
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <title>关于我们</title>
    <link href="css/font-awesome.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="css/swiper.min.css">
    <link href="css/rqbao_index.css" rel="stylesheet"/>
    <link href="css/more.css" rel="stylesheet"/>
    <script src="controllers/app.js" type="text/javascript"></script>
    <%@ include file="config/header.jsp" %>
</head>
<body>
 <%@ include file="/config/globalHead.jsp" %>
 <!--公司简介 start -->
 <div class="swiper-container swiper-container-horizontal" style="width:100%;">
   <section class="aboutNav">
 			<ul class="swiper-pagination">
 			</ul>
 			<div class="clear"></div>
 	</section>
 	<div class="swiper-wrapper">
 		<section class="swiper-slide" id="companyProfile"> 
 			<div class="activetyBannner">
 				<img  src="images/aboutUs.png"/>
 			</div> 
 			<div class="companyList" ng-controller="announceController">
 				<ul>
 					<li><span><img style="width:4rem;max-width:none;" src="images/aboutUs/aboutIcon1.png"/></span>成立于2014年</li>	
 					<li><span><img style="width:3rem;max-width:none;" src="images/aboutUs/aboutIcon2.png"/></span>总部位于北京</li>
 					<li><span><img style="width:3rem;max-width:none;" src="images/aboutUs/aboutIcon3.png"/></span>注册<font id="numPeople">{{userNumber}}</font>人</li>
 				</ul><div class="clear"></div>
 			</div>
 			<article class="introduce_info">
 				<p>
 					北京瑞钱宝资产管理服务有限公司（简称“瑞钱宝”），是央企华融天泽旗下的综合金融服务平台 ，成立于2014年8月。 </p>
 				<p>瑞钱宝致力于为个人、企业及其他金融机构提供金融资产交易信息服务，打造综合性互联网金融资产交易平台。为广大用户提供多元化的理财产品和信息咨询服务，为中小微企业提供高效、快捷的融资通道，为推动实体经济发展、践行普惠金融、提高金融资产流，企业及其他金融机构提供金融资产交易信息服务，打造综合性互联网金融资产交易平台。为广大用户提供多元化的理财产品和信息咨询服务，为中小微企业提供高效、快捷的融资通道。
 				</p>
 			</article>
 		</section>
 		<!--公司简介 end -->
 		<!--团队管理 start -->
 		<section class="swiper-slide" id="mangeTeam"> 
 			<div class="mangeTeamList"> 
 				<img src="images/aboutUs/photo1.png"/>
 				<article>
 					<h4>杜学忍<span>瑞钱宝CEO</span></h4>
 					<p>
 						曾任中国光大银行总行办公室副总经理、总行巡视员。20余年金融从业背景，深谙资本运作、项目投融资及金融风险管理。
 					</p>
 				</article><div class="clear"></div>
 			</div>

 			<div class="mangeTeamList"> 
 				<img src="images/aboutUs/photo2.png"/>
 				<article>
 					<h4>刘洋<span>瑞钱宝执行总裁</span></h4>
 					<p>
 						连续创业者，先后参与多个商业项目的创办退出，对互联网及实体产业投资运营拥有丰富的管理经验，风险 投资、典当、小额贷款、基金并购重组均有涉及经历
 					</p>
 				</article><div class="clear"></div>
 			</div>

 			<!-- <div class="mangeTeamList"> 
 				<img src="images/aboutUs/photo3.png"/>
 				<article>
 					<h4>付楚雄<span>首席风险官</span></h4>
 					<p>
 						金融学硕士，曾任职于上市公司--湖北迈亚董事会秘书、董事。组织参与公司改制、重组、上市及资本市场运作；曾任某知名担保集团公司副总裁兼风控总监及执行总裁。有十多年信审风控工作经验，熟悉资本市场运作，对民间借贷 及证券投资都有较深入了解。
 					</p>
 				</article><div class="clear"></div>
 			</div> -->

 			<div class="mangeTeamList"> 
 				<img src="images/aboutUs/photo4.png"/>
 				<article>
 					<h4>高顺生<span>技术总监</span></h4>
 					<p>
 						拥有在线教育、O2O以及互联网金融等多个行业研发和管理经验，擅长互联网、移动互联网领域的技术研发工作，擅长使用前沿技术解决业务问题，对互联网金融行业技术发展有自己的见解和思考。
 					</p>
 				</article><div class="clear"></div>
 			</div>

 		</section>
 		<!--团队管理 end -->
 		<!--企业荣誉 start -->
 		<section class="swiper-slide" id="enterprise_honor">
 			<div class="enterprise_honor_list">
 				<ul>
 					<li class="col-lg-6 col-ms-6 col-sm-6 col-xs-6"><img src="images/aboutUs/honor_list1.png"/></li>
 					<li class="col-lg-6 col-ms-6 col-sm-6 col-xs-6"><img src="images/aboutUs/honor_list2.png"/></li>
 				</ul>
 				<ul>
 					<li class="col-lg-6 col-ms-6 col-sm-6 col-xs-6"><img src="images/aboutUs/honor_list3.png"/></li>
 					<li class="col-lg-6 col-ms-6 col-sm-6 col-xs-6"><img src="images/aboutUs/honor_list4.png"/></li>
 				</ul> 
 				<ul>
 					<li class="col-lg-6 col-ms-6 col-sm-6 col-xs-6">
 						<img src="images/aboutUs/honor_list5.png"/> 
 					</li>
 					<li class="col-lg-6 col-ms-6 col-sm-6 col-xs-6">
 						<img src="images/aboutUs/honor_list6.png"/></li>
 					</ul>   
 				</div>
 			</section>
 			<!--企业荣誉 end-->
 			<!--分支机构 start -->
 			<section class="swiper-slide" id="branch_office">
 				<div class="introduce_map">
 					<p>
 						<img src="images/map.png"/>
 					</p>
 				</div>

 				<div class="introduce_address">
 					<p style="color:#9B9B9B;">期望</p>
 					<p>
 						根据瑞钱宝全国业务布局策略和发展需要,瑞钱宝计划在五年内设立100多家财富运营中心,目前 已在广东设有广东顺德财富中心,以及广西桂林财富中心和山东济南财富中心。
 					</p>
 				</div>

 				<div class="introduce_address">
 					<p style="color:#9B9B9B;">分部地址</p>
 					<p>
 						北京总部：北京市西城区阜外大街22号外经贸大厦五层<br/>
 						广西桂林阳朔客户服务中心<br/>
 						重庆客户服务中心<br/>
 						广东顺德客户服务中心<br/>
 						江苏泰兴客户服务中心
 					</p>
 				</div>

 			</section>
 			<!--分支机构 end-->

 			<!--合作伙伴 start -->
 			<section class="swiper-slide" id="partner">
 				<div class="partner_li">
 					<ul>
 						<li class="col-lg-6 col-ms-6 col-sm-6 col-xs-6"><img src="images/aboutUs/partner1.png"/></li>
 						<li class="col-lg-6 col-ms-6 col-sm-6 col-xs-6"><img src="images/aboutUs/partner2.png"/></li>
 					</ul>
 					<ul>
 						<li class="col-lg-6 col-ms-6 col-sm-6 col-xs-6"><img src="images/aboutUs/partner3.png"/></li>
 						<li class="col-lg-6 col-ms-6 col-sm-6 col-xs-6"><img src="images/aboutUs/partner4.png"/></li>
 					</ul> 
 					<ul>
 						<li class="col-lg-6 col-ms-6 col-sm-6 col-xs-6">
 							<img src="images/aboutUs/partner5.png"/> 
 						</li>
 						<li class="col-lg-6 col-ms-6 col-sm-6 col-xs-6">
 							<img src="images/aboutUs/partner6.png"/></li>
 						</ul>   
 					</div>
 				</section>
 				<!--合作伙伴 end-->

 				<!--联系我们 start -->
 				<section class="swiper-slide" id="contact_us">
 					<div class="contact_us_list" style="padding-bottom:2rem;margin:3rem 2rem 0 2rem;border-bottom:2px dashed #B9B7B7;">
 						<p class="contact_title">
 							<font>联系客服</font>
 						</p>
 						<p class="contact_phone">
 							<font class="fa fa-headphones"></font>在线客服：400－919－8555
 						</p>
 						<p class="contact_qq" STYLE="padding-right:2.3rem;">
 							<font class="fa fa-qq"></font>官方群：136696037
 						</p>

 						<p class="contact_qq">
 							QQ群：481590175
 						</p>

 						<p class="contact_mail">
 							<font class="fa fa-envelope"></font>客服邮箱：kefu@rqbao.com
 						</p>
 					</div>

 					<div class="contact_us_list">
 						<p class="contact_title">
 							<font>合作联系方式</font>
 						</p>
 						<p class="contact_phone">
 							合作邮箱：rqt@rqbao.com
 						</p>
 						<p class="contact_qq">
 							合作致电：010-52684961
 						</p>
 						
 					</div>

 				</section>
 				<!--联系我们 end-->
 			</div>
 		</div>

<script src="js/swiper.min.js"></script>
<script>
		var swiper = new Swiper('.swiper-container', {
		    pagination: '.swiper-pagination',
		    paginationClickable: true,
		    //continuous: true,
		    //direction: 'horizontal',
		    //loop : true,
		    // 如果需要前进后退按钮
		    //nextButton: '.swiper-button-next',
		    //keyboardControl : true,
		   // mousewheelControl : true,
		    //direction:'horizontal',
		    //mousewheelForceToAxis : true,
		    speed:800,
		});
  </script>

 
</body>
</html>