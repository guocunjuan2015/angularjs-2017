<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<title>运营报告</title>
<%@ include file="/config/config.jsp" %>
<style>
*{
padding:0;
margin:0;
font-family:"微软雅黑";}
html,body{
font-size:62.5%;
}
body{
	padding-left:10px;
	padding-right:10px;
	box-sizing:border-box;
	background:#fff;
}
.w100{
	width:100%;
	margin:0 auto;
}
.w100 img{
	display:block;
	margin:0;
	width:100%;
}
.report1{
	width:100%;
	background:#0189ea;
}
.report2{
	width:100%;
	min-width:1100px;
	background:#fff;
}
.reportdiv{
	display:block;
}
.reportdiv a{
	display:block;
	text-decoration: blink;
}
h3.reporth3{
	width:50%;
	height:6rem;
	margin:0 auto;
font-size: 1.8rem;
    color: #4a4a4a;
    text-align: center;
    position:relative;
}
h3.reporth3 span{
	position:absolute;
	left:0;
	top:3rem;
	height:1px;
	background:#333;
	width:100%;
	z-index:1;
}
h3.reporth3 b{
	display:block;
	position:absolute;
	width:50%;
	height:2rem;
	line-height:2rem;
	background:#fff;
	left:25%;
	top:2rem;
	z-index:9;
}
.txtp{
	padding-bottom:1.5rem;
}
.txtp p{
	font-size: 1.4rem;
    color: #4a4a4a;
    line-height:2rem;
    text-indent:2.4rem;
    
}
p.reportp{
	font-size:1.6rem;
    color: #4a4a4a;
    padding-top: 1rem;
    padding-bottom: 2.5rem;
    
}
</style>
</head>
<body>
 <div class="w100">
 	<div class="w100">
 		<h3 class="reporth3"><span></span><b>运营报告</b></h3>
 		<div class="txtp">
 			<p> 瑞钱宝是一家大型国企中国华融全资子公司华融天泽投资参股的综合金融资产交易平台，2014年8月正式上线。瑞钱宝致力于为广大投资用户打造一个安全、快捷、透明的在线理财平台，帮助中小企业解决融资难、融资贵问题，实现普惠金融的社会价值，为经济发展和社会和谐贡献一份力量。</p>
 		</div>
 		 <div class="reportdiv">
        <a href="<%=basePath%>/operation_report7.jsp">
          <img src="images/report3.png" title="2017年第三季度运营报告"/>
          <p class="reportp">2017年第三季度运营报告</p>
        </a>
    </div>
 		<div class="reportdiv">
		 		<a href="<%=basePath%>/operation_report6.jsp">
		      <img src="images/report2.png" title="2017年第二季度运营报告"/>
		      <p class="reportp">2017年第二季度运营报告</p>
		    </a>
    </div>  
 		<div class="reportdiv"><a href="<%=basePath%>/operation_report5.jsp">
	 		<img src="images/rs.png" title="2017年第一季度运营报告"/>
	 		<p class="reportp">2017年第一季度运营报告</p>
 		</a></div>
 		<div class="reportdiv"><a href="<%=basePath%>/operation_report4.jsp">
	 		<img src="images/rf.png" title="2016年第四季度运营报告"/>
	 		<p class="reportp">2016年第四季度运营报告</p>
 		</a></div>
 		<div class="reportdiv"><a href="<%=basePath%>/operation_report3.jsp">
	 		<img src="images/r1.png" title="2016年第三季度运营报告"/>
	 		<p class="reportp">2016年第三季度运营报告</p>
 		</a></div>
 		<div class="reportdiv"><a href="<%=basePath%>/operation_report2.jsp">
 			<img src="images/r2.png" title="2016年第二季度运营报告"/>
 			<p class="reportp">2016年第二季度运营报告</p>
 		</a></div>
 		
 	</div>
 </div>
</body>
</html>