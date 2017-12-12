<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<title></title>
<link rel="stylesheet" href="css/swiper.min.css">
<link rel="stylesheet" href="css/common2.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/common.css">
<link href="css/touzistyle.css" rel="stylesheet" />
 
<script src="js/jquery-1.11.2.min.js"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/repayment_plan.js" type="text/javascript"></script>
<script type="text/javascript">
    function setTabWidth() {
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
        /*店铺优品效果 end*/}
</script>
<style>
 .box_span {
    width: 100%;
    display: inline-block;
    height: 120px;
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
    height: 120px;
    background: #f1f1f1;
    text-align: center;
    border: 1px solid #f64840;
    color: #fff;
    font-size: 15px;
}
.mg2{
margin: 0 auto;
width: 94%;
}
.card_list {
    margin: 10px 10px 3% 10px;
    height: 128px;
    overflow: hidden;
    position: relative;
    
}
.card_list ul {
    padding: 0 0;
    position: absolute;
    top: 0;
    left: 0;
}

.card_list ul li {
    width: 200px;
    margin-bottom: 10px;
    float: left;
}
.box{
background: #fff;
height: 120px;
border: 1px solid #f1f1f1;
margin:2% 1%;
}
.box h5{
   text-align: center;
   color: #f64840;
   font-size: 1.6rem;
    height: 30px;
    line-height:36px;
    margin:0;
}
.box table{
margin:2% 0;
width: 100%}
.box table tr{
height:30px;
text-align: center;
color: #333;
}
.box table tr:FIRST-CHILD {
    color: #959595;
}
.active{
/* border: 1px solid #f64840; */
box-shadow:0px 2px 0px #f64840;
}
</style>
</head>
<body style="margin: 0 auto;max-width: 750px;background: #f2f1f1;">
    <section>
        <h1 class="home_title red_bg" style="margin: 0 0 3% 0">
            回款计划 
        </h1>
    </section>
    <div class="card_list" id="cardList">
        <ul id="box">
             
        </ul>
    </div>
    <!--右侧按钮-->
    <!-- <div class="swiper-pagination"></div> -->
</div>
   <!--  <!--底部按钮
    <div class="swiper-button-next">
        <div class="next-but-arraw"><img src="images/btn-next.png"></div>
    </div> -->
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
    <div id="no_data_div" style="display: none;margin:0 2% 2% 2%;text-align: center;
    background: #fff;height: 45px;line-height: 45px;-moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    border-radius: 5px;  ">暂无记录 !</div>
        <div id="space_div" style="display: none"></div>
        
    <div id="listContainer">
         
    </div>     
    <div id="error_info" class="error_info"></div>
<script src="js/swiper.min.js"></script>
<script>
     
    
</script>
</body>
</html>