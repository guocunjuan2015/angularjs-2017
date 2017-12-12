<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%
		String localPath = "http://www.rqbao.com/"; 
	    String basePath = "http://www.rqbao.com/rqb"; 
	%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<title>Insert title here</title>
	<link href="css/bootstrap.min.css" rel="stylesheet" />
	<link href="http://v3.bootcss.com/assets/css/docs.min.css" rel="stylesheet" />
	<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
	<script src="js/utils.js" type="text/javascript"></script>
	<script src="js/frame/ios_js.js" type="text/javascript"></script>
<script type="text/javascript" src="js/frame/rqbaoappshare.js"></script>
	<script type="text/javascript">
	
		/*标题 */
		function showShare(){
			  IOSModel.changeWebTitle("一亿红包送惊喜");
			}
		$(function(){
		    title = "一亿红包送惊喜";
		    content = "感恩六月,从心出发豪礼送家人大奖谢知音!";
			icon = "<%=basePath %>/images/logo/redEnvelope.png";
			url  = "<%=basePath %>/active/redEnvelope/red_envelope.jsp?from=app&utm_source=offline";
			/*分享好友*/
		    weixinShare(title,content,icon,url,'<%=basePath%>');
		})
	
		function toProject() {
			if (isAndroidOrIos()) {
				IOSModel.toIosInvest();
				toIosInvest();
				appFunction('invest');
			} else {
				toIosInvest();
				window.location.href = "project.jsp";
			}
		}
	
		function toRegister() {
			IOSModel.iosRegist();
			 if (isAndroidOrIos()) {
				iosRegist();
				appFunction('regist');
			} else { 
				window.location.href = "ump_register.jsp";
			}
		}
		
		function toLogin() {
			if (isAndroidOrIos()) {
				IOSModel.login();
				appFunction('login');
			} else {
				window.location.href = "login.jsp";
			}
		}
		
		// 分享推荐
		function toRefer() {
			 if (isAndroidOrIos()) {
				appFunction('toRefer');
			}
		}
		
		// 去开户
		function openUmp() {
			IOSModel.openUmp();
			if (isAndroidOrIos()) {
				appFunction('openUmp');
			}
		}
		
		// 去绑卡
		function bindCard() {
			IOSModel.toBindCard();
			if (isAndroidOrIos()) {
				appFunction('bindCard');
			}
		}
		
		// 去提现
		function moneyCash() {
			IOSModel.moneyCash();
			if (isAndroidOrIos()) {
				appFunction('moneyCash');
			}
		}
		
		// 去个人中心
		function toAccountCenter() {
			IOSModel.toAccountCenter();
			if (isAndroidOrIos()) {
				appFunction('toAccountCenter');
			}
		}
		
		function toShare() {
			var shareUrl=url;
		      if (isAndroidOrIos()) {
	              IOSModel.noticeShare({
	                  "url" : shareUrl,
	                  "title" : title,
	                  "content" : content,
	                  "icon" : icon
	              });
	              iosShare(title, content, icon, shareUrl);
	              appFunction('share');
	           } else {
	              showShareBox();
	           }
		}
	    function showShare() {
		    IOSModel.showShareBtn();
	    }
	      
	    function shareWithType() {
    	    var shareUrl=url;
	        IOSModel.noticeShare({
		        "url" : shareUrl,
		        "title" : title,
		        "content" : content,
		        "icon" : icon
	        });
	    }
	</script>
</head>
<body>
	<div class="container-fluid center-block" style = "margin-top:20px;">
		<p>H5页面与移动端进行交互的DEMO</p>
		<div class="row responsive-utilities-test">
			<div class='col-xs-1'>
				<button type="button" class="btn btn-default" onclick="toLogin()">去登录</button>
			</div>
		</div>
		<div class="row responsive-utilities-test">
			<div class='col-xs-1'>
				<button type="button" class="btn btn-primary" onclick="toRegister()">去注册</button>
			</div>
		</div>
		<div class="row responsive-utilities-test">
			<div class='col-xs-1'>
				<button type="button" class="btn btn-success" onclick="toProject()">去投资</button>
			</div>
		</div>
		<div class="row responsive-utilities-test" >
			<div class='col-xs-1'>
				<button type="button" class="btn btn-info" onclick="toShare()">去分享</button>
			</div>
		</div>
		<div class="row responsive-utilities-test" >
			<div class='col-xs-1'>
				<button type="button" class="btn btn-primary" onclick="moneyCash()">去提现</button>
			</div>
		</div>
		<div class="row responsive-utilities-test" >
			<div class='col-xs-1'>
				<button type="button" class="btn btn-info" onclick="toAccountCenter()">去个人中心</button>
			</div>
		</div>
		<div class="row responsive-utilities-test" >
			<div class='col-xs-1'>
				<button type="button" class="btn btn-warning" onclick="toRefer()">分享推荐(只有android有这个方法)</button>
			</div>
		</div>
		<div class="row responsive-utilities-test" >
			<div class='col-xs-1'>
				<button type="button" class="btn btn-danger" onclick="openUmp()">去开户</button>
			</div>
		</div>
		<div class="row responsive-utilities-test" >
			<div class='col-xs-1'>
				<button type="button" class="btn btn-default" onclick="bindCard()">去绑卡</button>
			</div>
		</div>
	</div>
</body>
</html>