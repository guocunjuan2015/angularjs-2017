<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>html5 jquery插件cropbox.js实现上传头像拖动图片裁剪效果jquery图片上传裁剪插件_特效网</title>

<meta name="keywords" content="js特效,网页特效代码,jquery特效 ,flash特效 ,html5特效,html特效,html代码,js代码 ,js广告代码 ,js网页特效代码 ,广告代码 ,特效代码,代码大全,javascript特效,特效网,特效网站"/>
<meta name="description" content="特效网专注于提供最全面、最新的jquery特效,js特效,flash特效 html5特效,js广告代码,找特效就来特效网,IT工程师的最佳选择"/>
<link rel="shortcut icon" href="http://www.zhaotexiao.com/favicon.ico" type="image/x-icon"/>

<link rel="stylesheet" href="css/upload_image.css" type="text/css" />

</head>
<body>

<script type="text/javascript" src="http://www.zhaotexiao.com/common/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/cropbox.js"></script>

<div class="container">
    <div class="imageBox">
        <div class="thumbBox"></div>
        <div class="spinner" style="display: none">Loading...</div>
    </div>
    
    <div class="action">
        <input type="file" id="file" style="float:left; width: 250px">
        <input type="button" id="btnCrop" value="Crop" style="float: right">
        <input type="button" id="btnZoomIn" value="+" style="float: right">
        <input type="button" id="btnZoomOut" value="-" style="float: right">
    </div>
    
    <div class="cropped"></div>
    
</div>

<script type="text/javascript">
$(window).load(function() {
    var options =
    {
        thumbBox: '.thumbBox',
        spinner: '.spinner',
        imgSrc: 'images/avatar.png'
    }
    var cropper = $('.imageBox').cropbox(options);
    $('#file').on('change', function(){
        var reader = new FileReader();
        reader.onload = function(e) {
            options.imgSrc = e.target.result;
            cropper = $('.imageBox').cropbox(options);
        }
        reader.readAsDataURL(this.files[0]);
        this.files = [];
    })
    $('#btnCrop').on('click', function(){
        var img = cropper.getDataURL();
        $('.cropped').append('<img src="'+img+'">');
    })
    $('#btnZoomIn').on('click', function(){
        cropper.zoomIn();
    })
    $('#btnZoomOut').on('click', function(){
        cropper.zoomOut();
    })
});
</script>
<!-- 统计代码 start -->
<script type="text/javascript">
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F96790c81142777e7724407f030936c10' type='text/javascript'%3E%3C/script%3E"));
</script> 
<!-- 统计代码 end -->


</body>
</html>