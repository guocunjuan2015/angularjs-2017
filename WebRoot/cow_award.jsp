<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>瑞钱宝豪礼送不停</title>
<meta name="viewport"
    content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/common.css">
<link rel="stylesheet" type="text/css" href="css/common2.css">
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/frame/ios_js.js" type="text/javascript"></script>
<style>
body{
margin: 0 auto;
background: #f5f5f5;
max-width: 750px;
}
.error_info{
margin:0;
}
.my_table{
width: 100%;
font-size: 1.4rem;
background: #fff;
}
.my_table tr{
width: 100%;
text-align: center;
height: 50px;
line-height: 50px;
border-bottom: 1px solid #D9D9D9;
}
.my_table tr th{
text-align: center;
width: 33.33%;
background: #fff4eb;
}
.my_table tr td{
text-align: center;
width: 33.33%;
}
.font-light{
color: #ff7700;
}
.dt_title{
	width:94%;
	margin:0 auto;
	clear:both;
	font-size: 1.5rem;
	padding:0 3%;
	color: #f64840;
	background: url(images/pj_left_mark.png) no-repeat left center;
	background-size:0.9%;
	height: 50px;
	line-height: 50px;
}
.active-rule{
background: #fff;
padding-top: 10px;
padding: 0 1%;
font-size: 1.5rem;
}
.active-rule p{
padding: 2% 5% 0 5%;
color: #7f7f7f;
}
.p-div{
padding: 0 5% 0 5%;
color: #7f7f7f;
margin: 0 0;
display: none;
}
.active-rule img{
margin: 2% 5% 5% 5%;
width: 5%;
max-width: 20px;
}
footer{
background:rgba(0,0,0,0.5);
position: fixed;
bottom: 0px;
width: 100%;
max-width:750px;
}
footer div{
padding:2% 0;
width: 40%;
margin: 0 auto;
margin-top: 5px;
}
footer div button{
background: #ff7700;
color: #fff;
font-size: 1.6rem;
}
</style>



<script type="text/javascript">
var showRule = false;
function displayRule(index){
	switch (index) {
	case 1:
		$("#ruleMore").animate({
		    height:'toggle'
		  });
		  showRule = !showRule;
		  if(showRule){
			  document.getElementById('showRuleBtn').setAttribute("src", "images/activity/cow_award/hide_more.png");
		  }else{
			  document.getElementById('showRuleBtn').setAttribute("src", "images/activity/cow_award/show_more.png"); 
		  }
		break;
    case 2:
    	$("#introMore").animate({
		    height:'toggle'
		  });
		  showRule = !showRule;
		  if(showRule){
			  document.getElementById('showIntroBtn').setAttribute("src", "images/activity/cow_award/hide_more.png");
		  }else{
			  document.getElementById('showIntroBtn').setAttribute("src", "images/activity/cow_award/show_more.png"); 
		  }
		break;
	}
		  
}

function toRegist() {
		window.location.href = "http://www.rqbao.com/rqb/ump_register.jsp?utm_source=213";
}
</script>
</head>
<body>
 
<img style="width:100%;" src="images/activity/cow_award/cow_award.png" />

 <footer>
 <div><button class="btn btn-lg btn-block" onclick="toRegist()">立即注册</button></div>
 </footer>
	<div id="error_info" class="error_info"></div>
</body>
<script type="text/javascript" src="js/frame/rqbaoappshare.js"></script>
</html>
