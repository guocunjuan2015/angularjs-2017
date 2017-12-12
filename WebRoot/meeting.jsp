<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*,java.net.URLDecoder"
    pageEncoding="UTF-8"%>
    
<%
    HttpSession hs = request.getSession();
    String user = "";//用户名
    String userId = "";//用户userId
    String userHex = "";//hex编码的用户名，分享出去用到，app转进来需要解码

    String localPath = "http:/www.rqbao.com/rqb";
    String basePath = "http://www.rqbao.com";

    String from = request.getParameter("from");
    if (from == null || !("app".equals(from))) {
        from = "";
    }
    System.out.println("aft:" + from);
    String referHex = request.getParameter("referrer");//获得的推荐人是Hex编码
    String refer = "";
    if (referHex == null) {
        refer = "";
    } else {
        //refer需要Hex解码
        if (referHex != null) {
            byte[] bs = Hex.decodeHex(referHex.toCharArray());
            refer = new String(bs);
        }
    }
    String userApp = request.getParameter("user");
    if (from != null && "app".equals(from) && userApp != null
            && userApp != "") {
        user = userApp;
        hs.setAttribute("loginUser", user);
        //app上无分享功能
    } else if (hs != null) {
        user = (String) hs.getAttribute("loginUser");
        if (user == null) {
            user = "";
        }
        if (user != null && user != "") {
            userHex = Hex.encodeHexString(user.getBytes());//将用户Hex编码，用于分享
        } else {
            userHex = "";
        }
    }
    String userAppId = request.getParameter("userId");
    if (from != null && "app".equals(from) && userId != null
            && userId != "") {
        userId = userAppId;
        hs.setAttribute("userId", userId);
        //app上无分享功能
    } else if (hs != null) {
        userId = (String) hs.getAttribute("userId");
        if (userId == null) {
            userId = "";
        }
    }
%>  
<%
    Date serviceDate = new Date();
    String startDate = "2016-04-14";
    String overDate = "2016-04-30";
    boolean flag = false;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String date = sdf.format(serviceDate);
    if (date.compareTo(startDate) > 0 && date.compareTo(overDate) < 0) {
        flag = true;
    }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <title>瑞钱宝-投资见面会</title>
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <link href="css/common2.css" rel="stylesheet"/>
  <link href="css/utils.css" rel="stylesheet" />
  <link href="css/activity/meeting.css" rel="stylesheet" />
   <script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
   <script src="js/frame/ios_js.js" type="text/javascript"></script>
   <script src="js/meeting.js" type="text/javascript"></script>
   <script type="text/javascript" src="js/bootstrap.min.js"></script>
</head>
<body>
<%@ include file="config/header.jsp" %>
<div>
    <img src="images/activity/meeting/face_01.png"/>
    <section class="face_flow centerdiv">
       <h4>会议流程</h4>
       <h6>活动当日还有惊喜</h6>
       <ul>
       <li>
         <video src="images/activity/meeting/axeFile.mp4" controls>您的浏览器不支持 video 标签。</video>
       </li>
         <li>
            <p>2016年5月21日</p>
            <p style="margin-top:10px;">北京海淀区北四环西路吴海楼旁—— 京东 智能奶茶馆</p>
            <p style="margin-top:5%;font-size:1.4rem;color:#666;">PS:平台报销往返路费（仅报销机票经济舱、火车票二等座）及活动当日食宿费</p>
         </li>

       </ul>
    </section>
    <img src="images/activity/meeting/face_02.png"/>
    <section class="face_addr centerdiv">
      <h4>下一次  你想去哪</h4>
      <h6>世界那么大，小瑞带你去看看第二届瑞钱宝投资者见面会地点由你定！<br/>
您的投票决定我们何去何从马上去投票，开启相约之旅</h6>
    <ul>
      <li>
        <img src="images/activity/meeting/addr_01.png"/>
        <p><span>上海</span><i></i><span>1857</span></p>
      </li>
      <li>
        <img src="images/activity/meeting/addr_02.png"/>
        <p><span>广州</span><i></i><span>1857</span></p>
      </li>
      <li>
        <img src="images/activity/meeting/addr_03.png"/>
        <p><span>北京</span><i></i><span>1857</span></p>
      </li>
      <li>
        <img src="images/activity/meeting/addr_04.png"/>
        <p><span>重庆</span><i></i><span>1857</span></p>
      </li>
      <li>
        <img src="images/activity/meeting/addr_05.png"/>
        <p><span>太原</span><i></i><span>1857</span></p>
      </li>
      <li>
        <img src="images/activity/meeting/addr_06.png"/>
        <p><span>武汉</span><i></i><span>1857</span></p>
      </li>
      <li>
        <img src="images/activity/meeting/addr_07.png"/>
        <p><span>青岛</span><i></i><span>1857</span></p>
      </li>
      <li>
        <img src="images/activity/meeting/addr_08.png"/>
        <p><span>仁怀</span><i></i><span>1857</span></p>
      </li>
      <li>
        <img src="images/activity/meeting/addr_09.png"/>
        <p><span>杭州</span><i></i><span>1857</span></p>
      </li>
      <li>
        <img src="images/activity/meeting/addr_10.png"/>
        <p><span>大连</span><i></i><span>1857</span></p>
      </li>
    </ul>
    </section>
    <div class="signs">
      <p><a href="#myModal" data-toggle="modal"  data-target="#myModal">立即报名</a></p>
    </div>
    <!-- 点击立即报名弹框-->
  <div class="modal fade" id="myModal" style="z-index:999999" tabindex="-1" role="dialog"
   aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog" style="margin:20% auto 0;width:94%;">
      <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close"
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">

            </h4>
         </div>
         <div class="modal-body">
            <input id="sign_relname" name="sign_relname" type="text" class="form-control" placeholder="姓名"/>
            <input id="m" name="m"  type="text" class="form-control"   onkeyup="this.value=this.value.replace(/\D/g,'')"
                onafterpaste="this.value=this.value.replace(/\D/g,'')"  placeholder="手机号"/>
            <input id="sign_addr" name="sign_addr" type="text" class="form-control" placeholder="地址"/>
            <input id="sign_name" name="sign_name" type="text" class="form-control" placeholder="用户名"/>
            <textarea id="sign_beizhu" class="form-control" placeholder="为什么选我" cols='50' rows='3'></textarea>
            <p>＊姓名、手机号为必填项</p>
            <p id="showMess" style="color: red;font-weight: bold;"></p>
            <p style="text-align:center;"><button type="submit" class="btn btn_save" onclick="submitBtn()" disabled="disabled">提交</button></p>     
         </div>
      </div><!-- /.modal-content -->
</div><!-- /.modal -->
</div>
  </div>
</body>
</html>