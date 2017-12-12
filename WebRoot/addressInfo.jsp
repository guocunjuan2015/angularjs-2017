<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String real_name = request.getParameter("real_name");
    if (real_name == null) {
        real_name = "";
    }
    
%>

<%
    HttpSession hs = request.getSession();
    String user = "";//用户名
    String userId = "";//用户userId
    String userHex = "";//hex编码的用户名，分享出去用到，app转进来需要解码

   String localPath = "http://www.rqbao.com/";
   String basePath = "http://www.rqbao.com/rqb"; 
//    String localPath = "http://test.rqbao.com/";
//    String basePath = "http://test.rqbao.com/rqb";
// 	String localPath = "http://localhost/rqt/";
//     String basePath = "http://localhost/rqb";
   //boolean flag=false;
   //String basePath = "http://www.rqbao.com";
   // String rqtPath="http://www.rqbao.com/static_3 /active/facetoface";
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
    System.out.println("addressInfo-----------> " + userAppId);
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
	
	String phone = request.getParameter("phone");
%>  
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control"
  content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title></title>
<meta name="viewport"
  content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/wechat2.css">
<link href="css/accountcenterstyle.css" rel="stylesheet" />
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/json2.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>

<script src="js/json2.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
<script>
    $(document).ready(function () {
      $("#finish-btn").click(function(){
        var province=$("#provinceId").val();
        var city=$("#cityId").val();
        var area=$("#areaId").val();
        var address=$("#addressId").val();
        var userId= $("#userId").val();
        if(userId==null || userId=="" || userId=="null"){
        	window.location.href="<%=basePath%>/login.jsp";
        	return;
        } else if (province=='选择省'||province==''|| province== null ){
            $(".msg").text("请选择省！"); 
            return;
        } else if (city=='选择城市'||city==''|| city== null ){
            $(".msg").text("请选择市！"); 
            return;
        } else if (area=='选择县/乡'||area==''|| area== null){
            $(".msg").text("请选择县/乡！"); 
            return;
        } else if (address==''|| address== null || userId=="null"){
            $(".msg").text("请填写详细的地址！");
            return;
        } else {
    		$(".msg").text("");
    	}
         $.ajax({
                  type:"POST",
                  url:"<%=localPath%>userAddress/saveAddress",
                  data : {
                	  userId:$("#userId").val(),
                  	  province:$("#provinceId").val(),
                  	  city:$("#cityId").val(),
                  	  area:$("#areaId").val(),
                  	  address:$("#addressId").val()
                  },
                  dataType:"JSON",
                  success:function(data) {
                    var status=data.result;
					if(status=="1"){
						if(isIos()){
					    IOSModel.finish()
						//appFunction('finish');
						}
                        appFunction('finish');
					}else{
						alert(errInfo);
					}
                  }
              })  
      })
	  
        /*初始化省份*/
        <%-- $.ajax({ 
            type:"POST",
            url:"<%=localPath%>account/getProvinceList",
            data : {
            	from:"app",
            	userId:$("#userId").val()
           	},
           	async : false,
            dataType:"JSON",
            success:function(data){
                result="<option>选择城市</option>";
                $.each(data,function(n,value){
                    result +="<option value='"+value.code+"'>"+value.name+"</option>";
                });
                $("#provinceId").append(result);
            }
        }) --%>
        /*页面加载就开始执行js*/
        $("#provinceId").change(function () {
          $.ajax({
                type: "POST",
                url: "<%=localPath%>account/getCityByProvinceId/"+$("#provinceId").val(),
                data: {'id':$("#provinceId").val()},
                dataType: "json",
                async : false,
                success: function(data){
                    var result = "<option>选择城市</option>";
                    $.each(data,function(n,value){
                        result +="<option value='"+value.code+"'>"+value.name+"</option>";
                    });
                    $("#areaId").html('<option>选择县/乡</option>');
                    $("#cityId").html('');
                    $("#cityId").append(result);
                }
              });
        });
        $("#cityId").change(function () {
          $.ajax({
                type: "POST",
                url: "<%=localPath%>account/getAreaByCityId/"+$("#cityId").val(),
                data: {'id':$("#cityId").val()},
                dataType: "json",
                async : false,
                success: function(data){
                    var result = "<option>选择县/乡</option>";
                    $.each(data,function(n,value){
                        result +="<option value='"+value.code+"'>"+value.name+"</option>";
                    });
                    $("#areaId").html('');
                    $("#areaId").append(result);
                }
          });
    });
/*初始化用户地址*/
 var hidprovince;
var hidcityCode;
var hidareaCode;
	  $.ajax({ 
            type:"POST",
            url:"<%=localPath%>account/getUserAddressByuserId/"+$("#userId").val(),
            data : {from:"app",
				phone:"<%=phone%>"},
            dataType:"JSON",
            async : false,
            success:function(data){
                result="<option>选择城市</option>";
				if (data.success) {
					result="<option>选择省</option>";
					if (data.provinceList != null) {
						$.each(data.provinceList,function(n,value){
							if (data.provinceCode == value.code) {
								result +="<option value='"+value.code+"' selected>"+value.name+"</option>";
							} else {
								result +="<option value='"+value.code+"'>"+value.name+"</option>";
							}
						});
					}
					$("#provinceId").append(result);
					result = "<option>选择城市</option>";
					if (data.cityList != null) {
						$.each(data.cityList,function(n,value){
							if (data.cityCode == value.code) {
								result +="<option value='"+value.code+"' selected>"+value.name+"</option>";
							} else {
								result +="<option value='"+value.code+"'>"+value.name+"</option>";
							}
						});
					}
					$("#cityId").append(result);
					
					result = "<option>选择县/乡</option>";
					if (data.creasList != null) {
						$.each(data.creasList,function(n,value){
							if (data.areaCode == value.code) {
								result +="<option value='"+value.code+"' selected>"+value.name+"</option>";
							} else {
								result +="<option value='"+value.code+"'>"+value.name+"</option>";
							}
						});
					}
					$("#areaId").append(result);
					$("#addressId").val(data.addressDetail);
					$("#userId").val(data.userId);
				}
			}
        }) 
	
})

  </script>
  <style>
  .address .form-control{border:1px solid #ddd;padding:0 0 0 10px;}
  .msg{padding-left:2%;color:red;}
  #divshows{width:100%; height:100%; background-color:rgba(0,0,0,0.5); position:fixed; left:0px; top:0px; z-index:30000; display:none;" }
  #light{position:absolute;left:260px;width:20%;height:50%;}
  #light p{text-align:center;}
  </style>
</head>
<body>
  <header>
   <!-- <div class="home_title_red">
    <span onclick="history.go(-1)" style="left:-35%" class="glyphicon glyphicon-chevron-left"></span>
      收获信息
    </div>-->
  </header>
  <div class="bg-white">
  <!-- 收获地址start -->
            <input type="hidden" name="userId" value="<%=userAppId%>" id="userId">
            <input type="hidden" id="from" value="<%=from%>"/>
           <div class="address">
             <p>
                 <select id="provinceId" name="province" data-placeholder="省份" class="form-control address-width"></select> 
              </p>
              <p>
                <select  name="city" data-placeholder="地级市" id="cityId" class="form-control  address-width" data-rel="chosen">
                </select>
                </p>
                <p>
                <select  name="area" data-placeholder="市、县级市" id="areaId" class="form-control  address-width " data-rel="chosen">
                   
                </select>
             </p>
             <p>
             <textarea class="form-control" placeholder="具体地址" id="addressId"  name="address" rows="3" required="required" style="padding-top:6px" maxlength="50"></textarea>
             </p>
             <p class="msg"></p>
             <p style="text-align:center;"><INPUT class="btn btn-danger" type="button"  STYLE="BORDER:NONE;COLOR:#FFF;font-weight: bold;" id="finish-btn"
                        value="保存"/></p>
           </div>
           
        <!-- 收货地址End -->
  </div>
  <div id="error_info" class="error_info"></div>
  <!--<div class="container-fluid mt10" id="exit_bt_div">
    <button type="button" onclick="logout()"
      class="btn btn-lg btn-block btn-white">退出登录</button>
  </div>-->
  <script src="js/frame/rqbaoappshare.js" type="text/javascript"></script>
  <!--弹框遮罩层start  -->
		<div id="divShow" style="display: none">
		 	<div id="light">
		 		<p><b>保存成功</b></p>
			</div>
		</div>
<!--弹框遮罩层end  -->
</body>
</html>