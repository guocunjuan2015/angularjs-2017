<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>瑞钱宝大转盘抽奖活动</title>

<link rel="stylesheet" href="css/rotate.css" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/common.css">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/awardRotate.js"></script>
<script type="text/javascript">
$(function (){

	var rotateTimeOut = function (){
		$('#rotate').rotate({
			angle:0,
			animateTo:2160,
			duration:8000,
			callback:function (){
				alert('网络超时，请检查您的网络设置！');
			}
		});
	};
	var bRotate = false;

	var rotateFn = function (awards, angles, txt){
		bRotate = !bRotate;
		$('#rotate').stopRotate();
		$('#rotate').rotate({
			angle:0,
			animateTo:angles+1800,
			duration:8000,
			callback:function (){
				alert(txt);
				bRotate = !bRotate;
			}
		})
	};

	$('.pointer').click(function (){

		if(bRotate)return;
		var item = rnd(0,7);

		switch (item) {
			case 0:
				//var angle = [26, 88, 137, 185, 235, 287, 337];
				rotateFn(0, 337, '未中奖');
				break;
			case 1:
				//var angle = [88, 137, 185, 235, 287];
				rotateFn(1, 26, '免单4999元');
				break;
			case 2:
				//var angle = [137, 185, 235, 287];
				rotateFn(2, 88, '免单50元');
				break;
			case 3:
				//var angle = [137, 185, 235, 287];
				rotateFn(3, 137, '免单10元');
				break;
			case 4:
				//var angle = [185, 235, 287];
				rotateFn(4, 185, '免单5元');
				break;
			case 5:
				//var angle = [185, 235, 287];
				rotateFn(5, 185, '免单5元');
				break;
			case 6:
				//var angle = [235, 287];
				rotateFn(6, 235, '免分期服务费');
				break;
			case 7:
				//var angle = [287];
				rotateFn(7, 287, '提高白条额度');
				break;
		}

		console.log(item);
	});
});
function rnd(n, m){
	return Math.floor(Math.random()*(m-n+1)+n)
}
</script>

</head>
<body huaban_collector_injected="true"
	style="background: #fff;">
    <div class="container-outter">
    <div class="turntable-bg">
        <div class="pointer"><img src="images/pointer.png" alt="pointer"/></div>
        <div class="rotate" ><img id="rotate" src="images/turntable.png" alt="turntable"/></div>
    </div>
	<div style="text-align:center;">
</div>
</div>
</body>
</html>