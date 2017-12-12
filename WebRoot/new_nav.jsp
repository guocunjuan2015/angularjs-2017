<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/common2.css" rel="stylesheet"/>
    <link href="css/index.css" rel="stylesheet"/>
    <title>新手起航</title>
    <style type="text/css">
        .news_nav img{margin-top:2.5%;
        width: 100%;
        }
    </style>
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/zhuge_ini.js" type="text/javascript"></script>
<script>
    function gotoPage(index){
    	switch (index) {
		case 1:
			window.location.href = "signintroduce.jsp";
			break;
		case 2:
            window.location.href = "business_model.jsp";
            break;
		case 3:
            window.location.href = "new_hand.jsp";
            break;
		case 4:
            window.location.href = "coupons_step.jsp";
            break;
		case 5:
            window.location.href = "rqb_vedio.jsp";
            break;
		}
    }
</script>
</head>
<body>
   <div class="news_nav">
     <a onclick="gotoPage(1)"><img src="images/app/news_icon_01.png" style="margin-top:1.5%;"/></a>
     <a onclick="gotoPage(2)"><img src="images/app/news_icon_02.png" /></a>
     <a onclick="gotoPage(3)"><img src="images/app/news_icon_03.png" /></a>
      <!--  <a onclick="gotoPage(4)"><img src="images/app/news_icon_04.png" /></a> -->
       <a onclick="gotoPage(5)"><img src="images/app/news_icon_05.png" /></a>
   </div>
</body>
</html>