<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% 
String basePath = "http://test.rqbao.com/rqb";
HttpSession s = request.getSession();
String from = request.getParameter("from");
String user = "";
String appUser = request.getParameter("user");
if("app".equals(from) && appUser != null && !("").equals(appUser)){
    user = request.getParameter("user");
}else if(s.getAttribute("loginUser") != null){
    user = (String)s.getAttribute("loginUser");
};
 
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common2.css" rel="stylesheet" />
<link href="css/activity/partner.css" rel="stylesheet">
<link href="css/utils.css" rel="stylesheet" />
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js"></script>
<script src="js/jweixin-1.0.0.js" type="text/javascript"></script>
<script src="js/frame/ios_js.js" type="text/javascript"></script>
<script src="js/weixin_share.js" type="text/javascript"></script>

<script type="text/javascript">
$(function(){
    title = "邀请好友投资赚大钱";
    content = "来瑞钱宝邀请好友投资奖励再升级，不光分钱分红包还有iphone6s，还等什么，快来加入";
    icon = "http://www.rqbao.com/rqb/images/logo/partner_logo.png";
    url  = 'http://www.rqbao.com/rqb/register_referrer.jsp?referrer=<%=user%>';
    getReferenceRank();
    weixinShare(title,content,icon,url,'<%=basePath%>');
});

	function copyCode(id) {
		var testCode = document.getElementById(id).value;
		if (copy2Clipboard(testCode) != false) {
			alert("生成的代码已经复制到粘贴板，你可以使用Ctrl+V 贴到需要的地方去了哦！ ");
		}
	}
	copy2Clipboard = function(txt) {
		if (window.clipboardData) {
			window.clipboardData.clearData();
			window.clipboardData.setData("Text", txt);
		} else if (navigator.userAgent.indexOf("Opera") != -1) {
			window.location = txt;
		} else if (window.netscape) {
			try {
				netscape.security.PrivilegeManager
						.enablePrivilege("UniversalXPConnect");
			} catch (e) {
				alert("您的firefox安全限制限制您进行剪贴板操作，请打开'about:config'将signed.applets.codebase_principal_support'设置为true'之后重试，相对路径为firefox根目录/greprefs/all.js");
				return false;
			}
			var clip = Components.classes['@mozilla.org/widget/clipboard;1']
					.createInstance(Components.interfaces.nsIClipboard);
			if (!clip)
				return;
			var trans = Components.classes['@mozilla.org/widget/transferable;1']
					.createInstance(Components.interfaces.nsITransferable);
			if (!trans)
				return;
			trans.addDataFlavor('text/unicode');
			var str = new Object();
			var len = new Object();
			var str = Components.classes["@mozilla.org/supports-string;1"]
					.createInstance(Components.interfaces.nsISupportsString);
			var copytext = txt;
			str.data = copytext;
			trans.setTransferData("text/unicode", str, copytext.length * 2);
			var clipid = Components.interfaces.nsIClipboard;
			if (!clip)
				return false;
			clip.setData(trans, null, clipid.kGlobalClipboard);
		}
	}

	function shareClick() {
		var uu = '<%=user%>';
		if(!uu){
			showAys3("您还没有登录，需要登录后才可以分享，现在去登录？");
		}else{
			if (isAndroidOrIos()) {
	            IOSModel.noticeShare({
	                "url" : url,
	                "title" : title,
	                "content" : content,
	                "icon" : icon
	            });
	            iosShare(title, content, icon, url);
	            appFunction('share');
	        } else {
	            showShareBox();
	        }
		}
	}
	function showShare() {
		IOSModel.showShareBtn();
	}
	function shareWithType() {
		IOSModel.noticeShare({
			"url" : url,
			"title" : title,
			"content" : content,
			"icon" : icon
		});
	}
	
	function getReferenceRank(){
		 $.ajax({
	         type : "POST",
	         url : "normal/reference/rank/list/get.do",
	         data : {
	         },
	         success : function(response) {
	             if (response.success) {
	                 var info = $.parseJSON(response.result);
	                 var data = info.resultObject;
	                 addDataToPage(data);
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
	
	function addDataToPage(data){
		var table = $("#table");
		table[0].innerHTML = "";
		//row+='<tr><td>用户名</td><td>累计获得返现 </td></tr>';
		for(var i = 0;i<data.length;i++){
			var row = '';
			row += '<tr><td>';
			row += data[i].referrer_name;
			row += '</td><td>';
			row += data[i].return_money;
			row += '</td></tr>';
			table.append(row);
		}
	}
	
	function login(){
		if (isAndroidOrIos()) {
			IOSModel.login();
			appFunction('login');
		} else {
			window.location.href = "login.jsp?reflect_url=partner.jsp"
		}
	}
	
	function dismissAys3(){
	    $("#bg")[0].style.display = "none";
	    $("#ays3")[0].style.display = "none";
	}
	function showAys3(value){
	    $("#ays_content3")[0].innerHTML = value;
	    $("#bg").css("height", document.body.scrollHeight);
	    $("#bg")[0].style.display = "block";
	    $("#ays3")[0].style.display = "block";
	}
</script>

</head>
<body style="background:#fff;">
<div id="bg"></div>
<section class="alert-dialog" id="ays3">
        <h5 class="alert-dialog-title">提示信息</h5>
        <div class="alert-dialog-content" id="ays_content3"></div>
        <ul class="alert-dialog-button">
            <li onclick="dismissAys3()">取消</li>
            <li onclick="login()">确定</li>
        </ul>
    </section>

 <%@ include file="config/show_share.jsp" %>
  <img src="images/activity/partner/banner.png" width="100%"/>
  <!-- 一重豪礼 -->
 <div class="friendBg" > 
      <div class="firstGift centerdiv">
        <p id="title1"> <img src="images/activity/partner/title1.png"/></p>
        <p style="text-align:center;padding-top:2%;padding-left:10px;padding-right:10px;"><img src="images/activity/partner/partner_01.png" /></p>
        <p class="cash1">奖励现金＝好友年化投资额 x 奖励利率(A)</p>
         <p class="cash1">奖励现金+红包=年化投资额(个人）×奖励利率(B)</p>
        <div class="calc1" style="">
          <p class="calcStyle"><img src="images/activity/partner/calc.png"/>&nbsp;&nbsp;奖励利率的计算方式</p>
          <table border="0" id="calcTable">
          <caption>特别提示：如累计年化投资（N）升级，当次投资奖励按照升级后的规则发放</caption>
            <tr>
              <th>活动期间你和你推荐的所有<br/>好友的累计年化投资额 N</th>
              <th>推荐人获得奖励利率A<br/><font>(以现金行式发放)</font></th>
            </tr>
          <tr>
             <td>0≤N﹤1万</td>
             <td>0.1%</td>
          </tr>
           <tr>
             <td>1万≤N﹤10万</td>
             <td>0.5%</td>
          </tr>
           <tr>
             <td>10万≤N﹤20万</td>
             <td>0.8%</td>
          </tr>
           <tr>
             <td>20万≤N﹤50万</td>
             <td>1.2%</td>
          </tr>
           <tr>
             <td>50万≤N﹤100万</td>
             <td>1.6%</td>
          </tr>
           <tr>
             <td>100万以上</td>
             <td>2.0%</td>
          </tr>
          </table>
           <p class="infors_li">＊N=年化投资额(自己)＋年化投资额(好友a)＋年化投资额(好友b)＋...年化投资额(好友x)</p>
           <p class="tipsLi">注：年化投资额＝投资金额x期限／12</p>
           
           <table border="0" id="calcTable" style="margin-top:20px;">
          <caption>特别提示：如累计年化投资（M）升级，当次投资奖励按照升级后的规则返</caption>
            <tr>
              <th>活动期间被推荐人的累计<br/>年化投资额M</th>
              <th>被推荐人获得奖励利率B<br/><font>(以50%现金50%红包形势发放)</font></th>
            </tr>
          <tr>
             <td>0≤M﹤1万</td>
             <td>0.1%</td>
          </tr>
           <tr>
             <td>1万≤M﹤10万</td>
             <td>0.15%</td>
          </tr>
           <tr>
             <td>10万≤M﹤20万</td>
             <td>0.2%</td>
          </tr>
           <tr>
             <td>20万≤M﹤50万</td>
             <td>0.25%</td>
          </tr>
           <tr>
             <td>50万≤M﹤100万</td>
             <td>0.3%</td>
          </tr>
           <tr>
             <td>100万以上</td>
             <td>0.4%</td>
          </tr>
          </table>
           <p class="infors_li">＊M=被推荐人第一次年化投资额+被推荐人第二次年化投资额＋...</p>
           <p class="tipsLi">注：年化投资额＝投资金额x期限／12</p>
        
        </div>
     </div><!--firstGift end  -->
 
       <!-- 一重豪礼 -->
     <div class="secondGift centerdiv" style="clear:both">
        <p class="title2"> <img src="images/activity/partner/title2.png"/></p>
        <div class="dishows">
            <img   src="images/activity/partner/mobile.png"/>
              <div>
              <b>额外奖励一部IPhone6s plus 64g</b>
              <p>活动期间内，你和你推荐的所有好友的年化投资额每达<font>80万</font>，平台奖励一部iPhone6s Plus 64G</p>
              </div>
        </div><div style="clear"></div>
     </div><!--firstGift end  --> 
     
        <!-- 一重豪礼 -->
     <div class="thirdGift centerdiv" style="clear:both">
        <p class="title2" > <img src="images/activity/partner/title3.png"/></p>
        <div class="dishows" style="clear:both">
            <img  src="images/activity/partner/redBage.png"/>
              <div>
              <b style="border:none;font-size:1.4rem">邀请好友注册送他现金红包：</b>
              <p style="font-size:1.2rem;margin-top:0;">使用您的专属入口注册的好友可获得高达20元现金<br/>只要他在注册1个月内首次投资成功满2000元（新手标除外）<br/>
                20元现金将自动存入其账户中</p>
              </div>
        </div>
     
        <div class="descRule" style="clear:both">
         <p class="calcStyle"><img src="images/activity/partner/infoBg.png"/>&nbsp; &nbsp;活动说明 </p>
            <p style="margin-top:2%">1. 年化投资额＝（投资金额x期限）／12</p>
             <p>2. 本次活动期限为2个月，活动结束后，累计年化投资额清零</p>
             <p>3. 推荐人及被推荐人获得的奖励在被推荐人投资成功后返</p>
             <p>4. 被推荐人奖励发放的红包使用规则为：仅限投资1月及以上项目，有效期1个月</p>
             <p>5. 2016.6.19 - 2016.8.31 内邀请好友注册投资享受奖励</p>
             <p>6. 第二季活动，6.19日之前的邀请金额清零，邀请关系不变，继续邀请瑞友投资还可获得奖励</p>
          </p> 
        
        </div>
     </div><!--firstGift end  -->
     
       <!-- 排行榜 -->
       
     <div class="centerdiv">
       <p class="title2"><img src="images/activity/partner/title4.png"/></p>
        <table class="userNames">
           <tr>
            <th>
                用户名
            </th>
            <th>累计获得返现</th>
          </tr>
        </table>
        <table id="table">
          <tr>
            <td>li***n</td>
            <td>139860.04</td>
          </tr>
        </table>
         <table style="width:100%;background:#FCEFEE;text-align:center;">
          <tr style="height:40px;line-height:40px">
            <td><font style="color:#F78300;">＊</font>以上数据截止到2016-6-20</td>
          </tr>
       </table> 
     </div><!--firstGift end  -->
     
      <div class="copyrightsBg"> 
      <div class="centerdiv copyrights">
         <p>以上活动最终解释权归瑞钱宝所有，如有疑问</p>
        <p>请致电官方客服电话：010-52684985</p>
     </div><!--firstGift end  -->
    </div> 
 
 </div><!--friendBg end  -->
  
  
  
  
  
<!-- 
   <div class="partner3">
        <h3>&nbsp;</h3>
        <div style="margin:40px auto;width:90%;border:1px solid #000;box-shadow:5px 7px 0 #83180f">
        <div style="position:relative;border:10px solid #fde3b1;border-bottom:0;background:#fff;padding:33px 0 5px;">

        <table>
          <tr>
            <th style="position:relative;">
                用户名
                <i class="icon_cup"></i>
            </th>
            <th>累计获得返现</th>
          </tr>
        </table>
        <MARQUEE onmouseover=this.stop() onmouseout=this.start() scrollAmount=1 scrollDelay=100 direction=up style="width:96%;height:200px" >
        <table id="table">
          <tr>
            <td>li***n</td>
            <td>139860.04</td>
          </tr>
        </table>
        </MARQUEE>
        <p style="width:80%;margin:0 auto;border-bottom:2px dashed #c98541;"></p>
        </div>
        </div>
      </div> -->
    <!--   <p style="margin:0 auto;width:90%;padding:5% 0 20%;color:#592d05;font-size:1.2rem;text-align:center;">以上活动最终解释权归瑞钱宝所有，如有疑问请致电官方客服电话：400-919-8555</p> -->

    <p style="padding-top:70px;text-align:center;width:50%;margin:0 auto;"><a class="partner_share" onclick="shareClick()">分享</a></p>
 
</body>
<script type="text/javascript" src="js/frame/rqbaoappshare.js"></script>
</html>
