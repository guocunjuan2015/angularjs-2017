<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style type="text/css">/* shadow box */
#bg {
        background-color: #282727;
        position: absolute;
        z-index: 1004;
        display:none;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        opacity: 0.9;
        filter: alpha(opacity = 90);
        -moz-opacity: 0.9;
    }
/* box */
    .bgbox {
        position: fixed;
         width:100%; 
        height:100%;
      /*  left: 50%;*/
        z-index: 100;
        /*background-color: #fff;*/
        /*  border: 1px #ddd solid; */
        padding: 0;
        margin: 0 auto;
        z-index:1004;
        
    }
.lottery-share{margin:0 auto;width:96%;} 
.lottery-share img{width:40%;margin-bottom:5%;} 
.lottery-share p{text-align:center;margin:0 auto;clear:both;font-size:16px;color:#f1f1f1;padding:0 5%;}
</style>
<script type="text/javascript" >
function closeShareBox(){
    $("#bg,#show_share").css("display", "none");
}
function showShareBox(){
	$("#bg").css("height", document.body.scrollHeight);
	$("#bg,#show_share").css("display", "block");
}
</script>
<div id="bg" ></div>
<div class="bgbox" id="show_share" style="display:none;padding-top:2%"> 
   <div class="lottery-share"> 
       <img src="http://www.rqbao.com/rqb/images/lottery/share-arrow.png" align="right"/> 
       <p>点击右上角分享按钮，分享给你的好友 ！</p> 
   </div> 
   <div style="text-align: center;margin-top:8px;width:40%;margin:1rem auto;"><img src="http://www.rqbao.com/rqb/images/lottery/not_share.png" onclick="closeShareBox()" /></div>
</div>