<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String from = request.getParameter("from");
    if(from == null || !("app".equals(from))){
        from = "";
    }
    String user = "";
    String userId = "";
    if (from != null && "app".equals(from)) {
        user = request.getParameter("user");
        userId = request.getParameter("userId");
        if (user != null && user != "" && userId != null && userId != "") {
            HttpSession s = request.getSession();
            s.setAttribute("loginUser", user);
            s.setAttribute("userId", userId);
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<title>签到</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
    content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="js/utils.js"></script>
<link rel="stylesheet" type="text/css" href="css/calendar_sign.css"/>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/common2.css"/>
<link href="css/utils.css" rel="stylesheet" />
<script type="text/javascript" src="js/shake_sign.js"></script>
<script type="text/javascript">
$(function(){
   var arr = [];
   calUtil.init(arr);
   daySignIn();
   var user = '<%=user%>';
   var userId = '<%=userId%>';
 /*   alert(user+","+userId); */
   
});
function refresh(){
	location.reload();
}
</script>
</head>
<body style="background: #fff">
<div id="bg"></div>
	<section class="ays" id="ays2">
		<div class="ays_h5">
			<h5 style="color: #333;">提示信息</h5>
			<img src="images/input_clear.png" onclick="dismissAys()" />
		</div>
		<p style="padding: 5% 5% 8% 5%; color: #333; font-size: 1.6rem;"
			id="ays_content2"></p>
		<ul class="ays_ul">
			<li><button class="btn btn-primary" style="width: 30%"
					onclick="dismissAys()">取消</button></li>
			<li><button class="btn btn-danger" id="checkCP"
					style="width: 30%;" onclick="realSaveSign()">&nbsp;确定&nbsp;</button></li>
		</ul>
	</section>
	<section class="ays">
        <div class="ays_h5">
            <h5 style="color: #333;">提示信息</h5>
            <img src="images/input_clear.png" onclick="dismissAys3()" />
        </div>
        <p style="padding: 5% 5% 8% 5%; color: #333; font-size: 1.6rem;"
            ></p>
        <ul class="ays_ul">
            <li><button class="btn btn-primary" style="width: 30%"
                    onclick="dismissAys3()">取消</button></li>
            <li><button class="btn btn-danger"  
                    style="width: 30%;" onclick="dismissAys3()">&nbsp;确定&nbsp;</button></li>
        </ul>
    </section>
    
    <section class="alert-dialog" id="ays3"  >
        <h5 class="alert-dialog-title">提示信息</h5>
        <div class="alert-dialog-content" id="ays_content3"></div>
        <ul class="alert-dialog-button">
            <li><button onclick="dismissAys3()">取消</button></li>
            <li><button onclick="dismissAys3()">确定</button></li>
        </ul>
    </section>
	<section class="sign_top">
<img src="images/sign/day_sign_bg.png" class="sign_top_bg"/>
<div class="sign_top_content">
本月连续签到 <span id="totalSign"></span> 天
</div>
<span class="sign_rule" onclick="linkTo('calendar_sign_illus.jsp')">规则</span>
<div class="tips">
<div>
<p id="suc_text"></p>
<p id="suc_points"></p>
</div></div>
</section>
<div class="calendar" id="calendar"></div>
<footer>
<div><!-- <i></i> -->点击日期进行补签，每次消耗 <span>500</span> 积分</div>
</footer>
<div id="error_info" class="error_info"></div>
</body>
</html>