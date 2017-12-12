<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<title>2016年第二季度运营报告</title>
<link rel="stylesheet" href="css/swiper.min.css">
<link rel="stylesheet" href="css/common2.css">
<style>
html,body{position:relative;height:100%;}
body{background:#eee;font-family:Helvetica Neue,Helvetica,Arial,sans-serif;font-size:14px;color:#000;margin:0;padding:0;}
input[type="text"], input[type="password"], input[type="button"], textarea { outline-style:none; -webkit-appearance:none;}
.swiper-container{width:100%;height:100%;}
.swiper-slide{text-align:center;font-size:18px;background:#ebebeb;display:-webkit-box;display:-ms-flexbox;display:-webkit-flex;display:flex;-webkit-box-pack:center;-ms-flex-pack:center;-webkit-justify-content:center;justify-content:center;-webkit-box-align:center;-ms-flex-align:center;-webkit-align-items:center;align-items:center;}
.swiper-wrapper{ width:100%;height:100%;overflow:visible;transition:transform 1s cubic-bezier(0.86,0,0.03,1);-webkit-transition:-webkit-transform 1s cubic-bezier(0.86,0,0.03,1);}

/*section-1底部导航*/
#s1 .bt-nav{position:absolute; text-align:center; display:inline;}
#s1 .bt-nav ul{ margin:0 auto; text-align:center; display:block;}
#s1 .bt-nav ul li{ float:left; margin:0 10px; display:block; text-align:center;}


/* #s1{ background-image:url(images/safe_01.png); }
#s2{ background-image:url(images/safe_02.png);  }
#s3{ background-image:url(images/safe_03.png);  } */

/*底部按钮*/
.swiper-button-next {width: 32px; height: 47px; position: fixed; top: 98%; left: 48%; z-index: 500; border: 0; cursor:pointer; }
.next-but-arraw { margin: 0 auto; animation: up-fade 1s ease 0s infinite; -moz-animation: up-fade 1s ease 0s infinite; -ms-animation: up-fade 1s ease 0s infinite; -o-animation: up-fade 1s ease 0s infinite; -webkit-animation: up-fade 1s ease 0s infinite;}
@keyframes up-fade {
    0% { opacity: 1 }
    100% { -webkit-transform: translate3d(0px, -6px, 0); opacity: 0.6 }
}
@-ms-keyframes up-fade {
    0% { opacity: 1 }
    100% { -webkit-transform: translate3d(0px, -6px, 0); opacity: 0.6 }
}
@-o-keyframes up-fade {
    0% { opacity: 1 }
    100% { -webkit-transform: translate3d(0px, -6px, 0); opacity: 0.6 }
}
@-moz-keyframes up-fade {
    0% { opacity: 1 }
    100% { -webkit-transform: translate3d(0px, -6px, 0); opacity: 0.6 }
}
@-webkit-keyframes up-fade {
    0% { opacity: 1 }
    100% { -webkit-transform: translate3d(0px, -6px, 0); opacity: 0.6 }
}
</style>
</head>
<body style="width: 100%;margin: 0 auto;">
 
<div class="swiper-container">
    <div class="swiper-wrapper">
        <div class="swiper-slide" id="s1">
             <img src="images/app/1.png" style="width:100%;height:100%;" />
            <div class="bt-nav">
            </div>
        </div>
        <div class="swiper-slide" id="s2">
        <img src="images/app/2.png" style="width:100%;height:100%;" /> </div>
        <div class="swiper-slide" id="s3">
        <img src="images/app/3.png" style="width:100%;height:100%;" /> </div>
        <div class="swiper-slide" id="s4">
        <img src="images/app/4.png" style="width:100%;height:100%;" /> </div>
        <div class="swiper-slide" id="s5">
        <img src="images/app/5.png" style="width:100%;height:100%;" /> </div>
        <div class="swiper-slide" id="s6">
        <img src="images/app/6.png" style="width:100%;height:100%;" /> </div>
        <div class="swiper-slide" id="s7">
        <img src="images/app/7.png" style="width:100%;height:100%;" /> </div>
       
    </div>
    <div style="position: fixed;bottom: 0px;text-align: center;width: 100%;z-index: 99"><img class="next-but-arraw" src="images/app/btn-next.png"  /></div>
    <!--右侧按钮-->
    <!-- <div class="swiper-pagination"></div> -->
</div>
   <!--  <!--底部按钮
    <div class="swiper-button-next">
        <div class="next-but-arraw"><img src="images/btn-next.png"></div>
    </div> -->
 
<script src="js/swiper.min.js"></script>

<script>
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        paginationClickable: true,
        direction: 'horizontal',
        // 如果需要前进后退按钮
        nextButton: '.swiper-button-next',
        keyboardControl : true,
        mousewheelControl : true,
        direction:'vertical',
        mousewheelForceToAxis : true,
        //autoplay:1000
    });
</script>
</body>
</html>