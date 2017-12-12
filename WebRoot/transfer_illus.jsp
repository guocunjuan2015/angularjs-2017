<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>瑞钱宝</title>
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/main.css" rel="stylesheet" />
<link href="css/common2.css" rel="stylesheet" />
<link href="css/common.css" rel="stylesheet" />
<link href="css/couponstyle.css" rel="stylesheet" />
<link href="css/bottom_munu.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script   type="text/javascript">
 var from = getRequestParam("from");
 $(function(){
	 if("app" == from){
		 $(".illus").css("top","0px");
	 }else{
		 $("#rule_title")[0].style.display = "block";
	 }
 });

</script>
<%@ include file="config/header.jsp" %>
</head>
<body>
<section>
        <h1 class="home_title red_bg" id="rule_title" style="display:none">
              转让说明
        </h1>
    </section>
	 <div id="ticket_illus" class="illus" style="display:block">
        <p>1. 服务费为成交份额的1%(2016-03-24生效)</p>
        <p>2. 债权转让的有效期为提出申请起的3个自然日内（遇付息日终止）</p>
        <p>3. 若部分转出本债权，转让有效期内不能申请转让剩余部分</p>
        <p>4. 平台支持全部或部分转出，转让过程中未成交的部分可以随时取消</p>
        <p>5. 转出的债权全部或部分被认购即时成交，请谨慎转让</p>
    </div>
</body>
</html>