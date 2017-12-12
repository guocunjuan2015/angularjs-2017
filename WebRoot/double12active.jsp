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
    <link href="css/more.css" rel="stylesheet"/>
    <script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script src="js/jweixin-1.0.0.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/weixin_share.js"></script>
    <script type="text/javascript" src="js/frame/ios_js.js"></script>
    <%@ include file="config/header.jsp" %>
    <script type="text/javascript" >
    $(function(){
    	//initApp();
        var myimgUrl = '<%=localPath%>/images/dfs3000.jpg'; // 200*200大小
        var mylink = '<%=localPath%>/double12active.jsp';//当前用户为推荐人
        var mydesc = '瑞钱宝3000万大放送，全场加息1%-3.5%，最高年化收益22%，还能免费抽Macbook pro、iphone6s、ipad、iWatch，更多惊喜，等你来拿！';
        var mytitle ='点一下，12月多赚2万！';
    	weixinShare(mytitle,mydesc,myimgUrl,mylink,'<%=localPath%>');
    });
    
   <%--  function initApp(){
    	var fm = '<%=from%>';
    	if(fm){
    	}else{
    		 
    	}
    } --%>
    
    function toProject(){
    	if(isAndroidOrIos()){
    		toIosInvest();
    		appFunction('invest');
    	}else{
    		window.location.href = "project.jsp";
    	}
    }
    function toLottery(){
    	window.location.href = "lottery.jsp";
    }
    
    </script>
    <title>双十二3000万大放送</title>
    <style type="text/css">body{background:#c70013}</style>
</head>
<body>
   <img src="images/double12banner.jpg" width="100%"/>
   <section class="surprise">
       <h2></h2>
       <p>活动期间所有标的最高加息5%,最高年化收益22%,喜欢就都拿下吧!</p>
       <img src="images/lixi.jpg"/>
       <p class="surprise-p"><button   class="btn-invests"  onclick="toProject()"></button></p>
       <h3></h3>
       <p>更有激动人心的抽奖环节，Macbook pro、iphone6s、ipad年度回馈大礼，全民疯抢啦! 错过等一年!</p>
       <img src="images/lottery.jpg"/>
       <p class="surprise-p"><button   class="btn-invests1" id="lottery" onclick="toLottery()"></button></p>
       <div class="surprise-tips">
       <p style="margin:13% auto 8%;">温馨提示：</p>
       <p>1、活动时间：送完为止</p>
       <p>2、参与资格：</p>
       <p>惊喜一：活动期间在瑞钱宝投资的所有用户都可享受加息</p>
       <p>惊喜二：活动期间注册瑞钱宝平台的用户每天一次免费抽奖机会，自己投资或推荐好友注册、投资均可增加抽奖机会</p>
       <p>3、参与抽奖的用户获得的奖励（除实物外）可在个人中心 > 我的优惠中查看</p>
       <p>4、参与抽奖的用户获得的实物奖励将在活动结束后7个工作日内发放</p>
       <p>5、本活动最终解释权归北京瑞钱宝资产管理服务有限公司所有，若有疑问请拨打客服电<br/>话：<font style="color: #fff"><u>400-919-8555</u></font></p>
       </div>
   </section>
</body>
<script type="text/javascript" src="js/frame/rqbaoappshare.js"></script>
</html>