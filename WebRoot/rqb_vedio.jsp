<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>瑞钱宝-视频</title>
<script src="js/jquery.js"></script>
<script src="js/frame/mediaelement-and-player.min.js"></script>
<link rel="stylesheet" href="css/frame/mediaelementplayer.min.css" />
<link rel="stylesheet" href="css/frame/mejs-skins.css" />
</head>
<body>
<section style="width: 100%;text-align: center">
<video width="100%" height="210" src="images/vedio/rqb.mp4" type="video/mp4" 
    id="player1"   
    controls="controls" preload="none"></video>
</section>
 

<script>
$('audio,video').mediaelementplayer({
    success: function(player, node) {
        $('#' + node.id + '-mode').html('mode: ' + player.pluginType);
    }
});

</script>


</body>
</html>
