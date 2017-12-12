<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String basePath = "http://www.rqbao.com/rqb";
    String from = request.getParameter("from");
    if (from == null || !("app".equals(from))) {
        from = "";
    }
    if (from != null && "app".equals(from)) {
        String user = request.getParameter("user");
        String userId = request.getParameter("userId");
        if (user != null && user != "" && userId != null
                && userId != "") {
            HttpSession s = request.getSession();
            s.setAttribute("loginUser", user);
            s.setAttribute("userId", userId);
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common2.css" rel="stylesheet" />
<link href="css/points_game.css" rel="stylesheet" />
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/points_game.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/frame/ios_js.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
<script type="text/javascript">
$(function(){
	icon = '<%=basePath%>/images/getheadimg.jpg'; // 200*200大小
	url = '<%=basePath%>/register_referrer.jsp?referrer=<c:out value="${refer2}" escapeXml="true"></c:out>';
	content = '20年金融团队经验，安全靠谱的理财产品，100元起投，7%-22%高收益，快来跟我一起赚钱吧！';
	title ='理财就选瑞钱宝';
});

function showShare(){
    IOSModel.showShareBtn2('分享有礼');
}
function  shareWithType(){
    IOSModel.shareAward({"url":url,"title":title,"content":content,"icon":icon});
}
</script>
<title>赚积分</title>
</head>
<body>
<button style="display: none" id="myModal" type="button"
        class="btn btn-danger mt20 ml20" data-toggle="modal"
        data-target=".bs-example-modal-lg">提示信息</button>
    <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog"
        aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">温馨提示</h4>
                </div>
                <div class="modal-body">
                    <h4 class="text-success text-center" id="return_message"></h4>
                </div>
				<div class="modal-footer">
					<button type="button" style="display: none" onclick="openUmp()"
						id="msg_btn_0" class="btn btn-primary btn-block">立即开通</button>
					<button type="button" style="display: none" onclick="umnpBind()"
						id="msg_btn_1" class="btn btn-primary btn-block">立即绑卡</button>
				</div>
			</div>
        </div>
    </div>
	<section>
		<img src="images/winjf_banner.png" width="100%" />
		<div class="user-level">
			<i id="user-level"><img id="level_img" src="images/vip_level/v1.png" /></i>
			<dl>
				<dt>我的等级：<span id="level_name"></span></dt>
				<dd>
					当前积分：<span id="cur_points"></span>
				</dd>
			</dl>
		</div>
	</section>
	<section class="new-task">
		<dl>
			<dt>新手任务</dt>
			<dd class="new-task-details">
				<i class="icon-ump">&nbsp;</i>
				<dl>
					<dt>开通联动支付</dt>
					<dd>
						开通联动支付得<span>200</span>红包
					</dd>
				</dl>
				<input id="open" type="button" class="btn-circle-red" value="开通" onclick="goToPage(1)" />
			</dd>
			<dd class="new-task-details" style="clear: both;">
				<i class="icon-charge">&nbsp;</i>
				<dl>
					<dt>绑卡</dt>
					<dd>
						绑卡成功得<span>300元</span>红包
					</dd>
				</dl>
				<input id="to_reacharge" type="button" class="btn-border-red" value="去绑卡" onclick="goToPage(2)"/>
			</dd>
			<dd class="new-task-details" style="clear: both;">
				<i class="icon-reflect">&nbsp;</i>
				<dl>
					<dt>提现</dt>
					<dd>
						首次提现得<span>100</span>积分
					</dd>
				</dl>
				<input type="button" class="btn-border-red" value="去提现" onclick="goToPage(3)" />
			</dd>
		</dl>

	</section>
	<section class="new-task">
		<dl>
			<dt>每日任务</dt>
			<dd class="new-task-details">
				<i class="icon-qian">&nbsp;</i>
				<dl>
					<dt>
						签到得<span>100</span>积分
					</dt>
					<dd>
						每日签到得<span>100</span>积分，连续签到更有红包相送
					</dd>
				</dl>
				<input type="button" id="daySignIn" class="btn-border-red" value="签到" onclick="goToPage(4)"/>
			</dd>
			<dd class="new-task-details" style="clear: both;">
				<i class="icon-tou">&nbsp;</i>
				<dl>
					<dt>年化投资投多少得多少</dt>
					<dd>
						首次投资额外得<span>100</span>积分
					</dd>
				</dl>
				<input type="button" class="btn-border-red" value="去投资" onclick="goToPage(5)" />
			</dd>
			<dd class="new-task-details" style="clear: both;display:none">
				<i class="icon-add">&nbsp;</i>
				<dl>
					<dt>
						分享有礼最多得<span>20</span>积分
					</dt>
					<dd>寻找app内带有分享有礼的页面分享，每天三次积分奖励机会</dd>
				</dl>
				<input type="button" class="btn-border-red" value="去分享" onclick="goToPage(6)" />
			</dd>
		</dl>
	</section>
	<section class="user-tips">
		<p>本活动最终解释权归瑞钱宝所有</p>
		<p>
			如有问题拨打客服热线：<span>400-919-8555</span>
		</p>
	</section>
	<div id="error_info" class="error_info"></div>
</body>
<script src="js/frame/rqbaoappshare.js" type="text/javascript"></script>
</html>