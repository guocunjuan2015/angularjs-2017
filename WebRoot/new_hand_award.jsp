<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String localPath = "http://test.rqbao.com/rqb";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
    content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <title>瑞钱宝20年金融团队经验，安全靠谱的理财产品，100元起投，6.5%-13.3%高收益，快来跟我一起赚钱吧</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/common2.css" rel="stylesheet"/>
    <link href="css/activity/picc.css" rel="stylesheet"/>
  <script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
  <script src="js/jweixin-1.0.0.js" type="text/javascript"></script>
  <script src="js/frame/ios_js.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/weixin_share.js"></script>
    <%@ include file="config/header.jsp" %>
    <script type="text/javascript">
    $(function(){
    	 var myimgUrl = '<%=localPath%>/images/logo/why_choose.jpg'; // 200*200大小
         var mylink =  window.location.href;//当前用户为推荐人
         var mydesc = '瑞钱宝20年金融团队经验，安全靠谱的理财产品，100元起投，6.5%-13.3%高收益，快来跟我一起赚钱吧';
         var mytitle ='我为什么选择瑞钱宝';
         weixinShare(mytitle,mydesc,myimgUrl,mylink,'<%=localPath%>');;//设置微信分享
    });
    
    function toRegister(){
        if(isAndroidOrIos()){
        	IOSModel.iosRegist();
            appFunction('regist');
        }else{
        	IOSModel.iosRegist();
            window.location.href = "ump_register.jsp";
        }
    }
    </script>
</head>
<body>
    <section class="picc">
        <img src="images/new_hand/picc_01.png"/>

        <img src="images/new_hand/picc_02.png"/>
        <div class="picc1">
          <ul>
              <li><img src="images/new_hand/picc_11.png"/></li>
              <li>
                  瑞钱宝是由国瑞泰控股发起，由中国大型
                  央企中国华融全资子公司华融天泽参股的
                  专业互联网家庭理财平台。
              </li>
          </ul>
        </div>
        <img src="images/new_hand/picc_08.png"/>
        <div class="picc3">
            <ul>
                <li><img src="images/new_hand/picc_12.png"/></li>
                <li>
                    资金交易通道全部切换至联动优势，资金存
                    管在中信银行，资金用途透明化，全方位保
                    障用户资金安全。
                </li>
            </ul>
        </div>
        <img src="images/new_hand/picc_10_01.png" style="display: block;"/>
        <div class="picc4">
            <ul>
                <li><img src="images/new_hand/picc_13.png"/></li>
                <li>
                    凭借国瑞泰丰富的风控经验，多重安全保障
                    推出个性化、安全的理财产品，把风险关进
                    笼子里。
                </li>
            </ul>
        </div>
        <img src="images/new_hand/picc_04.png"/>
        <a onclick="toRegister()"><img src="images/new_hand/picc_16.png"/></a>
        <img src="images/new_hand/picc_07.png"/>
    </section>
</body>
<script type="text/javascript" src="js/frame/rqbaoappshare.js"></script>
</html> 