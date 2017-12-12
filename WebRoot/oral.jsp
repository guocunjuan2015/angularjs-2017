<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% 
String basePath = "http://www.rqbao.com/rqb";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common2.css" rel="stylesheet" />
<link href="css/oral.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="css/wechat2.css" />
<link rel="stylesheet" type="text/css" href="css/YJHDetailsstyle.css" />
<script src="js/jquery-1.11.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/utils.js"></script>
<script src="js/jweixin-1.0.0.js" type="text/javascript"></script>
<script src="js/frame/ios_js.js" type="text/javascript"></script>
<script src="js/weixin_share.js" type="text/javascript"></script>
<script src="js/oral.js"></script>
<script type="text/javascript">
$(function(){
	title = "【女人节】 一大波福利来袭";
	content = "瑞钱宝联合欢乐口腔免费送福利啦，快来领洁牙套餐";
	icon = "http://www.rqbao.com/rqb/images/logo/oral_logo.png";
	url  = "http://www.rqbao.com/rqb/oral.jsp";
	weixinShare(title,content,icon,url,'<%=basePath%>');
});

function showShare(){
    IOSModel.showShareBtn();
}
function shareWithType(){
    IOSModel.noticeShare({"title":title,"content":content,"icon":icon,"url":url});
} 
</script>
<title>欢乐口腔</title>
</head>
<body style="background:#fff;">
<section>
<img src="images/oral/oral.png">
</section>
<div class="oralBg" style="background:#fff;">
 <div class="titleAll">
 <div class="titleDescr">
 <div id="row_container" style="margin-bottom: 6px;"></div>
<img alt="活动说明" src="images/oral/eventDesc.jpg"/>
 </div>
<div class="titleAll_l">
<p>1、2016年3月8日当天投资满1000元送价值800元的洁牙套餐；满足此活动的奖励条件时，洁牙套餐与收益可同时获取每个用户在活动期间限领一份洁牙套餐；</p>
<p>2、债券转让项目将不参与本次活动，使用优惠券(任意种类)的投资不能参加本次活动；</p>
<p>3、此活动仅针对3月8日的“健康爱齿标”；</p>
<p>4、凡累计投资符合以上对应金额就可获得相应奖励，相同标的投资金额可叠加,不同标的期限投资金额不可叠加；</p>
<p>5、投资成功后，瑞钱宝平台将以电子券的形式发送至用户的手机短信，用户可凭此电子券在北京的欢乐口腔店内免费洁牙；</p>
<p>6、自用户成功领取洁牙套餐起，三个月内有效（截止至6月8日前可使用）；</p>
<p>7、获得洁牙套餐的用户若不在北京，可转赠给北京的朋友；</p>
<p>8、若用户领取洁牙套餐后需要去欢乐口腔店内，需提前预约，预约成功后方可进店使用电子券预约电话肖冲：13522718722；</p>    
<p>9、若您在投资过程中产生疑问，可及时拨打官方客服：400-919-8555；</p>   
<p>10、本活动由瑞钱宝和欢乐口腔联合举办。</p> 
</div>
<div class="titleAll_r" >
<div class="oralTopic"><p>参与用户</p></div>
<div class="investTable" style="height: auto">
              <table>
                <tr >
                    <th>投资时间</th>
                    <th>投资人</th>
                    <th>投资金额</th>
                  </tr>
                </table>
                <MARQUEE  onmouseover=this.stop() onmouseout=this.start() scrollAmount=1 scrollDelay=100 direction=up style="height: 300px">
                <table id="table" >
                </table>
                </MARQUEE>
              </div><!--investTable  end -->
            </div><!--titleDescr end-->
            <div style="clear:both"></div>

</div><!--titleAll end-->
            
  <div class="titleAll">
                <div class="titleDescr" >
            <img alt="活动说明" src="images/oral/roalcontents.jpg"/>
            </div><!-- titleDescr end -->
             <p class="activeTime">仅限投资健康爱齿标的用户   活动时间：2016年3月8日（仅1天）</p>
            <div class="oralBorder">
             <img alt="活动说明" src="images/oral/toothPic.jpg"/>
              <div class="oralList">
             <img alt="仅限投资健康爱齿标的用户" src="images/oral/oralList.jpg"/>
             </div>
            </div><!-- oralBorder end -->
           </div><!-- titleAll end -->         
            <img alt="欢乐口腔介绍" class="intrImg" src="images/oral/oralIntrImg.jpg"/>       
</div><!--oralBg end -->
<div style="height: 40px;"></div>
 <p class="oralInvestBo">
            <a class="oralBtn" onclick="toProject()">马上投资</a></p>     
</body>
<script type="text/javascript" src="js/frame/rqbaoappshare.js"></script>
</html>