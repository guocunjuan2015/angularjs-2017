<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/common2.css" rel="stylesheet"/>
    <script src="js/jquery-1.11.2.min.js"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/frame/ios_js.js" type="text/javascript"></script>
<script type="text/javascript">
function toProject(){
	IOSModel.toIosInvest();
    if(isAndroidOrIos()){
        toIosInvest();
        appFunction('invest');
    }else{
    	toIosInvest();
        window.location.href = "project.jsp";
    }
}

 function showShare(){
	IOSModel.changeWebTitle("迎新年");
} 
</script>
<%@ include file="config/header.jsp"%>
    <title>迎新年</title>
</head>
<body>
   <div>
       <img src="images/newyear/newyear_02.png"/>
       <img src="images/newyear/newyear_03_01.png"/>
       <img src="images/newyear/newyear_03_02.png" onclick="toProject()" />
       <img src="images/newyear/newyear_04.png"/>
       <img src="images/newyear/newyear_05.png"/>
       <img src="images/newyear/newyear_06_01.png"/>
       <img src="images/newyear/newyear_06_02.png"/>
       <img src="images/newyear/newyear_06_03.png"/>
       <img src="images/newyear/newyear_07.png"/>
   </div>
</body>
<script type="text/javascript" src="js/frame/rqbaoappshare.js"></script>
</html>