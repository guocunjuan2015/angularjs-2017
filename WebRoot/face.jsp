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
    String basePath = "http://test.rqbao.com/rqb";
    //String basePath = "http://www.rqbao.com";
    String rqtPath="http://www.rqbao.com/static_3/active/facetoface";
    //String testPath="http://123.57.77.184/rqt/static_3/active/facetoface";
    
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
   <script type="text/javascript" src="js/bootstrap.min.js"></script>
   <script type="text/javascript">
  
     $(function(){
       var DEFAULT_VERSION = "8.0";
       var ua = navigator.userAgent.toLowerCase();
       var isIE = ua.indexOf("msie")>-1;
       var safariVersion;
       if(isIE){
         $('.face_addr ul li:nth-child(5)').css("margin-right","0");
         $(".face_addr ul li:last-child").css("margin-right","0");
       }
     })
  </script>
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
        <p><span>上海</span><a href="javascript:thumbUp(1)"><i></i></a><span class="addr_1">0</span></p>
      </li>
      <li>
        <img src="images/activity/meeting/addr_02.png"/>
        <p><span>广州</span><a href="javascript:thumbUp(2)"><i></i></a><span class="addr_2">0</span></p>
      </li>
      <li>
        <img src="images/activity/meeting/addr_03.png"/>
        <p><span>北京</span><a href="javascript:thumbUp(3)"><i></i></a><span class="addr_3">0</span></p>
      </li>
      <li>
        <img src="images/activity/meeting/addr_04.png"/>
        <p><span>重庆</span><a href="javascript:thumbUp(4)"><i></i></a><span class="addr_4">0</span></p>
      </li>
      <li>
        <img src="images/activity/meeting/addr_05.png"/>
        <p><span>太原</span><a href="javascript:thumbUp(5)"><i></i></a><span class="addr_5">0</span></p>
      </li>
      <li>
        <img src="images/activity/meeting/addr_06.png"/>
        <p><span>武汉</span><a href="javascript:thumbUp(6)"><i></i></a><span class="addr_6">0</span></p>
      </li>
      <li>
        <img src="images/activity/meeting/addr_07.png"/>
        <p><span>青岛</span><a href="javascript:thumbUp(7)"><i></i></a><span class="addr_7">0</span></p>
      </li>
      <li>
        <img src="images/activity/meeting/addr_08.png"/>
        <p><span>仁怀</span><a href="javascript:thumbUp(8)"><i></i></a><span class="addr_8">0</span></p>
      </li>
      <li>
        <img src="images/activity/meeting/addr_09.png"/>
        <p><span>杭州</span><a href="javascript:thumbUp(9)"><i></i></a><span class="addr_9">0</span></p>
      </li>
      <li>
        <img src="images/activity/meeting/addr_10.png"/>
        <p><span>大连</span><a href="javascript:thumbUp(10)"><i></i></a><span class="addr_10">0</span></p>
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
          <form action="<%=localPath%>/face.jsp" method="post" id="form">
             <input type="hidden" name="token" value=""/>
            <input type="text" class="form-control" placeholder="姓名" name="name"/>
            <input type="text" class="form-control" placeholder="手机号" name="mobile"/>
            <p id="mobile_info" style="margin-bottom:10px;"></p>
            <input type="text" class="form-control" placeholder="地址" name="address" value=""/>
            <input type="text" class="form-control" placeholder="用户名" name="userName" value=""/>
            <textarea class="form-control" placeholder="为什么选我" cols='50' rows='3' name="remarks"></textarea>
            <p>＊姓名、手机号为必填项</p>
            <p style="text-align:center;"><button type="button" class="btn btn_save" id="btn_save">提交</button></p>     
         </form>
         </div>
      </div><!-- /.modal-content -->
</div><!-- /.modal -->
</div>
  </div>
  <script>
  function thumbUp(no){
	    $.ajax({
	      url:"<%=rqtPath%>/faceVaildate.jsp?opr=thumbUp",
	      type:"post",
	      dataType:"json",
	      data:{
	        "areaId":no
	      },
	      success:function(res){
	       var data = eval(res);
	       alert(data.status);
	       if(data.status=="点赞成功！"){
	         $(".face_addr li i").eq(no-1).css("background","url(<%=localPath%>/images/activity/meeting/heart_02.png) no-repeat");
	       }
	       $(".addr_"+no).text(data.count);
	      }
	    });
	  }

  function init(){
	    $.ajax({
	      url:"<%=rqtPath%>/faceVaildate.jsp?opr=init",  
	      type:"post",
	      dataType:"json",
	      data:{},
	      success:function(res){
	        var ele = "";
	        for(var i = 0;i < res.length;i++){
	          var id = res[i].id;
	          var count = res[i].count;
	          $(".addr_"+id).text(count);
	        }
	      }
	    });
	  }
	  $(function(){
	   init();  
	    $("input[name='mobile']").blur(function(){
	      var mobile = $(this).val().trim();
	      var pattern = /^0?(13[0-9]|15[0-9]|18[0-9]|14[0-9]|17[0-9])[0-9]{8}$/;
	      if($(this).val() && pattern.test($(this).val())){
	        $("#mobile_info").text("");
	      }else{
	        $("#mobile_info").text("手机格式不正确");
	        $(".btn_save").css("background","#cdcbcb");                 
	         $(".btn_save").attr("disabled","false");
	        return;
	        }
	      if($("input[name='name']").val()!="" && $("input[name='mobile']").val()!="")  
	       {                                                               
	         $(".btn_save").css("background","#f64840");                 
	         $(".btn_save").removeAttr("disabled");                      
	       }                                                               
	       else{                                                           
	         $(".btn_save").css("background","#cdcbcb");                 
	         $(".btn_save").attr("disabled","false");                    
	       }  
	      $.ajax({
	        url:"<%=rqtPath%>/faceVaildate.jsp?opr=validate",
	        type:"post",
	        dataType:"json",
	        data:{
	          "mobile":mobile
	        },
	        success:function(res){
	         var data = eval(res);
	         if(data.status == 0){
	           alert("手机号被占用");
	           $("input[name='mobile']").focus();
	         }
	        }
	      });
	    });  
	   $("#btn_save").click(function(){
	      var name = $("input[name='name']").val();
	      var mobile = $("input[name='mobile']").val();
	      var address = $("input[name='address']").val();
	      var userName = $("input[name='userName']").val();
	      var remarks = $("input[name='remarks']").val();
	      if(name == ""){
	        alert("姓名不能为空");
	        return;
	      }
	      if(mobile == ""){
	        alert("手机号不能为空");
	        return;
	      }
	       $.ajax({
	        url: "<%=rqtPath%>/faceVaildate.jsp?opr=add",
	        type:"post",
	        dataType:"json",
	        data:{
	          name:name,
	          mobile:mobile,
	          address:address,
	          userName:userName,
	          remarks:remarks
	        },
	        success:function(res){
	          var data = eval(res);
	          if(data.status == 0){
	            alert("提交成功！由于名额有限，平台将最终选取10名线上报名的用户参会。成功报名的用户，客服将在5月1日-5月3日联系您，请保持您的手机畅通。");
	          }else{
	            alert("提交失败");
	          }
	          location.href="<%=localPath%>/face.jsp";
	        }
	      });  
	    }); 
	  }); 
  </script>
</body>
</html>