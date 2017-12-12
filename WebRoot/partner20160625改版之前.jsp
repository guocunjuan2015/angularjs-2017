<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% 
String basePath = "http://www.rqbao.com/rqb";
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
<title>邀请好友投资赚大钱</title>
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
		window.location.href = "login.jsp?reflect_url=partner.jsp"
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
<body>
<div id="bg"></div>
<section class="alert-dialog" id="ays3">
        <h5 class="alert-dialog-title">提示信息</h5>
        <div class="alert-dialog-content" id="ays_content3"></div>
        <ul class="alert-dialog-button">
            <li onclick="dismissAys3()">取消</li>
            <li onclick="login()">确定</li>
        </ul>
    </section>
<div class="partner">
 <%@ include file="config/show_share.jsp" %>
     <!-- <i class="icon_yun">&nbsp;</i>-->
      <img src="images/activity/partner/partner_01.png" width="100%"/>
       <img src="images/activity/partner/partner_02.png" width="100%"/>
       <img src="images/activity/partner/partner_03.png" width="100%"/>
       <img src="images/activity/partner/partner_04.png" width="100%"/>
       <img src="images/activity/partner/partner_05.png" width="100%"/>
       <img src="images/activity/partner/partner_06.png" width="100%"/>
       <img src="images/activity/partner/partner_07.png" width="100%"/>
       <img src="images/activity/partner/partner_08.png" width="100%"/>
       <img src="images/activity/partner/partner_09.png" width="100%"/>
       <img src="images/activity/partner/partner_10.png" width="100%"/>
       <img src="images/activity/partner/partner_11.png" width="100%"/>
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
          <!-- <tr>
            <td>li***n</td>
            <td>139860.04</td>
          </tr> -->
        </table>
        </MARQUEE>
        <p style="width:80%;margin:0 auto;border-bottom:2px dashed #c98541;"></p>
        </div>
        </div>
      </div>
      <p style="margin:0 auto;width:90%;padding:5% 0 20%;color:#592d05;font-size:1.2rem;text-align:center;">以上活动最终解释权归瑞钱宝所有，如有疑问请致电官方客服电话：400-9198-555</p>

    <p style="text-align:center;width:50%;margin:0 auto;"><a class="partner_share" onclick="shareClick()">分享</a></p>
   </div>
</body>
<script type="text/javascript" src="js/frame/rqbaoappshare.js"></script>
</html>
