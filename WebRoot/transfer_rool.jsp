<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>瑞钱宝</title>
<meta name="viewport" content="width=device-width,initial-scale=1" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/points.css">
<link rel="stylesheet" type="text/css" href="css/common.css">
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
</head>
<body id="vip_apply_body" huaban_collector_injected="true" style="background: #fff;">
	<header>
		<div class="home_title">
			<a class="icon-back" href="#"></a>债权转让规则
		</div>
	</header>
	
    <div class="container bg-color">
    <div id="test_div">
    <p style="font-size: larger;margin-top: 10px;">尊敬的瑞钱宝用户：</p>
    <p class="text-index-p">您好!</p>
    <p class="text-index-p">瑞钱宝平台自6月12日起恢复债权转让功能，项目投资满一个月即可进行债券转让。具体规则如下：</p>
    <p class="text-index-p font-weight">债权转出规则</p>
    <p class="text-index-p">1、所有类型产品均为持有一个月后可转让，且在产品到期前可向多人转让，但付息日当天不可转让;</p>
    <p class="text-index-p">2、支持全部转让，转让过程中未成交部分可随时取消转让;</p>
    <p class="text-index-p">3、转让有效期为提出申请起的3个自然日内(遇付息日终止)，被全部/部分认购的债权即时成交;</p>
    <p class="text-index-p">4、对于在转让期内做部分转让中的债权，该转让有效期内不能转让原始债权的剩余部分;</p>
    <p class="text-index-p">5、转让人通过折让金设置转让价格，可加价也可打折，手续费为成交份额的0.5%;</p>
    <p class="text-index-p">6、折让金定价区间：付的本债权转让份额未收的利息 <= 折让金 <=本债权转让份额已收到的利息;</p>
    <p class="text-index-p">7、若不设置折让金，则系统默认上次付息日到申请日的利息归转让人所有。</p>
    <p class="text-index-p font-weight">债权收购规则</p>
    <p class="text-index-p">1、可全部或部分认购债权，认购成功并持有一个月可再次转让;</p>
    <p class="text-index-p">2、认购债权转让的项目即时生效(包括全部或部分认购)，认购成功当日计息;</p>
    <p class="text-index-p">3、认购债权市场里的项目无认购费用，投资收益以“认购后年化收益”为准(若持有到期)。</p>
    <p class="text-index-p hign-light-p">注明：所有使用优惠券的项目不可进行债权转让;所有产品期限为1个月的项目不可以进行债权转让。</p>
    <p class="text-index-p">感谢您对瑞钱宝平台的支持!祝您生活愉快 !</p>
    <p class="align-right-p" style="margin-top: 20px;">瑞钱宝团队</p>
    <p class="align-right-p">2015年6月12日</p>
    </div>
	</div>
	<div id="error_info" class="error_info"></div>
	
</body>
</html>