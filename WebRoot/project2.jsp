<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>瑞钱宝</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/wechat2.css" />
<link rel="stylesheet" type="text/css" href="css/project.css" />
<link href="css/top_menu.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/YJHDetailsstyle.css" />
<link rel="stylesheet" type="text/css" href="css/main.css" />
<link rel="stylesheet" type="text/css" href="css/common2.css" />
<link href="css/bottom_munu.css" rel="stylesheet" type="text/css" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<script src="js/jquery-1.8.3.min.js"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/project.js" type="text/javascript"></script>
<script src="js/bootstrap.min3.0.3.js"></script>
<%@ include file="config/header.jsp"%>
</head>
<body onload="addScrollEvent()" style="background: none;">
 
 <section class="top_menu">
  <header>
    <div onclick="toNoticeDetails()" class="to-share-details-div" id="notice_title_div" style="display:none">
      <span class="to-share-left-bg" id="notice_title"></span>
    </div>
  </header>
  <div class="container" style="background: #fff;padding-bottom:2px;;max-width: 750px;">
    <div class="row tab" id="row_tab_div">
      <div id="sanbiao_div" style="width:100%;" class="col-xs-6 col-sm-6 col-md-6  col-lg-6 tab1 tab-bod">
              <span id="span_toggle" onclick="changePage(2)">理财项目<span></span>
              </span>
          </div>
      <!-- <div id="ugrow_div" class="col-xs-4 col-md-4 tab1 tab-bod " onclick="changePage(1)">优计划</div> -->
     <!--  <div id="transfer_div" style="width:50%;" class="col-loading_animxs-6 col-sm-6 col-md-6  col-lg-6 tab1 tab-bod">
              <span id="span_toggle" onclick="changePage(3)">债权转让<span></span>
              </span>
          </div> -->
    </div>
  </div>
  </section>
  <div class="top_space"></div>
  <img src="" id="float" class="float" style="display:none" />
  <!-- 控制按钮 -->
  <div style="text-align: center; display: none">
    <input type="button" class="btn start-slide" value="Start">
  </div>
  <div id="row_container"></div>
  <div id="load_data" class="add-more">
    <div class="spinner" style="height: 40px;margin: 10px auto;">
      <div class="rect1"></div>
      <div class="rect2"></div>
      <div class="rect3"></div>
      <div class="rect4"></div>
      <div class="rect5"></div>
    </div>
  </div>
  <div id="click_load" class="add-more" onclick="addMore()">点击加载更多</div>
  <div id="no_data" class="add-more">暂无项目,敬请期待</div>
  <div id="no_more" class="add-more">已无更多项目，敬请期待</div>
  <div style="height: 45px"></div>
  <%@ include file="config/loading_anim.jsp" %>
  <div id="footpanel">
  <div id="download" class="download_app_outer">
  <div class="download_app" onclick="toDownloadApp()">
  <img src ="images/download_app.png" />
  <img id="cancel_download" src="images/cancel_download.png"  onclick="cancelDownload(event)"/></div></div>
    <table>
      <tr>
        <td class="bg_img_list_focus" id="finc_td" onclick="refresh()">去理财</td>
        <td class="bg_img_center" id="accout_td" onclick="toAccountCenter()">个人中心</td>
      </tr>
    </table>
  </div>
  <div id="error_info" class="error_info"></div>
</body>
</html>