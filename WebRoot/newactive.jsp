<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/common2.css" rel="stylesheet"/>
    <link href="css/more.css" rel="stylesheet"/>
    <script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
    <script src="js/frame/ios_js.js" type="text/javascript"></script>
    <title>新用户注册</title>
    <%@ include file="config/header.jsp" %>
    <script type="text/javascript">
    function toRegister(){
    	IOSModel.iosRegist();
    	if(isAndroidOrIos()){
    		iosRegist();
    		appFunction('regist');
    	}else{
    		window.location.href = "ump_register.jsp";
    	}
    }
    </script>
</head>
<body>
   <img src="images/reg-banner04.jpg"/>
   <section class="user-active">
       <div class="user-actives">
       <h5>
           <span class="span1"></span><i class="star"></i>体验券使用流程<i class="star"></i><span class="span2">&nbsp;</span>
       </h5>
      <img src="images/step.png" style="padding-bottom:2%;"/>
       <h5>
           <span class="span1"></span><i class="star"></i>体验券使用规则<i class="star"></i><span class="span2">&nbsp;</span>
       </h5>
       <ul>
           <li>·体验券自到账起，使用期限为一个月</li>
           <li>·体验券只可投资一个月的项目</li>
          <!--  <li>·新手注册获得的体验劵还可投资新手标</li> -->
           <li>·体验劵不能直接投资，需搭配最低100元现金才可使用</li>
       </ul>
       <h5 style="padding-bottom:4%;display:none">
           <span class="span1" style="width:30%;"></span><i class="star"></i>活动日期<i class="star"></i><span class="span2" style="width:30%;">&nbsp;</span>
       </h5>
       <p style="display:none">2015年10月16日00:00—2015年12月31日24:00</p>
       <p style="padding:15% 0 3%;font-size:1.2rem;text-align:center;">本活动最终解释权归北京瑞钱宝资产管理服务有限公司所有，若有疑问请拨打客服电话：400-919-8555</p>
       </div>
       <div style="text-align: center;margin-top: 10px;"><button type="button" style="text-align: center;margin-bottom: 15px;" 
    class="btn btn-default mt10 mb20" onclick="toRegister()">&nbsp;&nbsp;&nbsp;去注册&nbsp;&nbsp;&nbsp;</button></div>
   </section>
</body>
<script src="js/frame/rqbaoappshare.js" type="text/javascript"></script>
</html>