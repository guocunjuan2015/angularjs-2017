<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "1";
    }
    String tab1 = "";
    String tab2 = "";
    String title = "";
    int tabNum = Integer.parseInt(tab);
    switch (tabNum) {
    case 1:
        tab1 = " tabactive";
        break;
    case 2:
    case 3:
    case 4:
    case 5:
        tab2 = " tabactive";
        break;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>我的投资</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/common.css">
<link href="css/utils.css" rel="stylesheet" />
<link href="css/touzistyle.css" rel="stylesheet" />
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/bootstrap.min3.0.3.js"></script>
<script src="js/personal_invest.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function() {
        /*获取各元素*/
        var oBox = document.getElementById("box");
        if (oBox != null) {
            var oLi = oBox.children;
            var oLiLen = oLi.length;
            var iDocWidth = document.documentElement.offsetWidth;

            /*给ul设置宽度*/
            if (oLiLen == 0) {
                oBox.style.display = 'none';
            } else {
                for (var i = 0; i < oLiLen; i++) {
                    oBox.style.width = ((Math.floor(oLi[0].offsetWidth) * oLiLen)+20)
                            + 'px';
                    //+20为margin
                }
            }

            var disX = null;
            /*  oBox宽度大于网页宽度 */
            if (oBox.offsetWidth > iDocWidth) {
                oBox.addEventListener('touchstart', touchStart, false);
            }
        }
        /*开始运动*/
        function touchStart(e) {
            var oTouch = e.touches[0];
            disX = oTouch.clientX - oBox.offsetLeft;
            oBox.addEventListener('touchmove', touchMove, false);
            oBox.addEventListener('touchend', touchEnd, false);
        }

        function touchMove(e) {
            e.preventDefault();
            var oTouch = e.touches[0];
            var oLeft = oTouch.clientX - disX;
            if (oLeft >= 0) {
                oLeft = 0;
            }
            if (oLeft <= (iDocWidth - oBox.offsetWidth)) {
                oLeft = iDocWidth - oBox.offsetWidth;
            }
            oBox.style.left = oLeft + 'px';
        }
        function touchEnd(e) {
            oBox.removeEventListener('touchmove', touchMove, false);
            oBox.removeEventListener('touchend', touchEnd, false);
        }
        /*店铺优品效果 end*/
    });
</script>
<style>
.box_span {
    width: 100%;
    display: inline-block;
    height: 50px;
    line-height: 50px;
    background: #fff;
    text-align: center;
    border: 1px solid #f64840;
    color: #f64840;
    font-size: 15px;
}

.no_border_left {
    border-left: none;
}

.box_span_active {
    width: 100%;
    display: inline-block;
    height: 50px;
    line-height: 50px;
    background: #f64840;
    text-align: center;
    border: 1px solid #f64840;
    color: #fff;
    font-size: 15px;
}
</style>
<%@ include file="config/header.jsp" %>
</head>
<body>
	<!-- <header>
		<div class="home_title red_bg">
			<a class="icon-back" href="#"></a>瑞钱宝-投资项目
			<div class="btn-group sp_titile_left">
				<div onclick="ToToggle()" style="display:none">
					筛选<span class="caret"></span>
				</div>
			</div>
		</div>
	</header> -->
	<div class="horizontal_list">
        <ul id="box">
            <li>
                <div class="box">
                     <span id="tab1" onclick="changeType(1, this)" class="box_span_active" >回款中</span>
                </div>
            </li>
            <li>
                <div class="box">
                     <span id="tab2" onclick="changeType(2, this)" class="box_span no_border_left">可转让</span>
                </div>
            </li>
            <li>
                <div class="box">
                    <span id="tab3" onclick="changeType(3, this)" class="box_span no_border_left"> 投标中</span>
                </div>
            </li>
            <li>
                <div class="box">
                     <span id="tab4" onclick="changeType(4, this)" class="box_span no_border_left">已结清</span>
                </div>
            </li>
            <li>
                <div class="box">
                     <span id="tab5" onclick="changeType(5, this)" class="box_span no_border_left">转让中</span>
                </div>
            </li>
            <li>
                <div class="box">
                    <span id="tab6" onclick="changeType(6, this)" class="box_span no_border_left"> 转让完成</span>
                </div>
            </li>
        </ul>
    </div>
	 
		<div class="licai-box mt10" id="invest_1" style="display: none">
			<table class="table">
				<tbody id="invest_table_1"></tbody>
			</table>
		</div>
		<div class="licai-box mt10" id="invest_2" style="display: none">
			<table class="table">
				<tbody id="invest_table_2"></tbody>
			</table>
		</div>
		<div class="licai-box mt10" id="invest_3" style="display: none">
			<table class="table">
				<tbody id="invest_table_3"></tbody>
			</table>
		</div>
		<div class="licai-box mt10" id="invest_4" style="display: none">
            <table class="table">
                <tbody id="invest_table_4"></tbody>
            </table>
        </div>
        <div class="licai-box mt10" id="invest_5" style="display: none">
            <table class="table">
                <tbody id="invest_table_5"></tbody>
            </table>
        </div>
        <div class="licai-box mt10" id="invest_6" style="display: none">
            <table class="table">
                <tbody id="invest_table_6"></tbody>
            </table>
        </div>
		<div id="no_data_div" style="display: none;margin-bottom: 80px;margin-left:2%;margin-right:2%  ">没有记录 !</div>
		<div id="space_div" style="display: none"></div>
	<div id="loading_anim" style="display: none">
		<div class="spinner">
			<div class="rect1"></div>
			<div class="rect2"></div>
			<div class="rect3"></div>
			<div class="rect4"></div>
			<div class="rect5"></div>
		</div>
		<div id="loading_text">数据加载中...</div>
	</div>
	<div id="error_info" class="error_info"></div>
</body>
</html>