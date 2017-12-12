<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/config/global.jsp" %>
<%@ include file="/config/config.jsp" %>
<%
	HttpSession hs = request.getSession();
	String tel = "" ;
	String userId = "" ;
	tel = (String) hs.getAttribute("tel");
	userId = (String) hs.getAttribute("userId");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <title></title>
  <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
  <link href="css/rqbao_index.css" rel="stylesheet"/>
  <link href="css/zqzrstyle.css" rel="stylesheet" />
</head>
<body>
<input type="hidden" id="localPath" name="localPath" value="<%=basePath%>"/>
<input type="hidden" id="userId" name="userId" value="<%=userId%>"/>
 <script>
        var userId = $("#userId").val();
        var localPath = $("#localPath").val();
  </script>
  <script src="js/personalInfo.js" type="text/javascript"></script>
   <!-- 主题内容显示区 -->
  <header class="index-header1">
     <p>个人信息认证</p>
  </header>
  <!--第一步-->
  <div class="first-flow">
		  <div class="investmentNews personalTab">
		       <ul class="ranking1">
		           <li class="selectedli">2.运营商认证</li>
		      </ul><div class="clear"></div>
		  </div>
      <form method="post" class="group-box" id="GroupServicePassword" action="">
          <div class="form-group personalList">
             <ul>
	              <li>
			             <label for="phonePassword" style="width:24%;">手机号码:</label>
			             <span class="phone_txt_box" ><span class="number" id="phonePassword" data-phone=""><%=tel%></span></span>                           
	              </li>
             </ul>
          </div>
          <div class="form-group personalList">
              <ul>
                 <li>
			              <label for="servicePassword" style="width:24%;">服务密码:</label>
			              <input style="padding-left:0;width:76%;" id="servicePassword" type="password" name="servicePassword" placeholder="请输入手机服务密码"/>
                </li>
              </ul>  
              <div class="error-info service-info">您的服务密码有误，请重新填写</div>
          </div>
           <section class="servicePasBox">
                      <p class="servicePas" onclick="showMask1()"><span>!</span>服务密码</p>
           </section>

          <div class="form-group checkPassward" style="display:none;">
              <div class="personalList">
			           <ul>
			               <li>
					              <label for="checkPassword" style="width:24%;">查询密码:</label>
					              <input  style="padding-left:0;width:76%;" id="checkPassword" type="password" name="checkPassword" placeholder="请输入你的查询密码"/>
			              </li>
			           </ul> 
		          </div>   
              <div class="error-info password-info">您的查询密码有误，请重新填写</div>
              <div class="servicePasBox">
                   <p class="servicePas" onclick="showMask2()"><span>!</span>网站密码 </p>
               </div>
          </div>
          <div class="error-info error-server-info" style="margin-top:2rem;text-align:center;" id="errorServer"></div>
          <div class="globalFooter1">
                <div>
                    <p style="text-align:center;"> <button id="submitBtn1" class="btn btn-logon btn-default">认证</button></p>
                 </div>
          </div>
      </form>
  </div>
  <!--第二步-->
  <div class="chargechoose-tab chargechoose-tab1 second-flow">
		   <div class="investmentNews personalTab">
		           <ul class="ranking1">
		              <li class="selectedli">1.联系人信息认证</li>
		          </ul><div class="clear"></div>
		      </div>
        <section class="personalList">
           <ul>
                <li>＊第一联系人</li>
                <li style="margin-left:1rem;" id="family1_type">父母</li>
                <li><input type="text" placeholder="姓名"  name="family1_name" id="family1_name"></li>
                <li><input type="text" placeholder="手机号" name="family1_phone" id="family1_phone"></li>
           </ul><div class="clear"></div>
        </section>
        <section class="personalList ">  
           <ul>
                <li>＊第二联系人</li>
                <li style="margin-left:1rem;" id="family2_type">朋友
                  <!--  <span style="float:left;width:10rem;">直系亲属</span> -->
                  <!--  <div class="select-day secondContact">
                        <span class="text"  id="family2_type" data-value=""></span>
                        <div class="bank_btn" id="family2_btn">
                            <span class="btn-top"></span>
                        </div>
                        <ul class="daylist" id="family2_select">
                            <li data-value="0">配偶</li>
                            <li data-value="1">父母</li>
                            <li data-value="2">兄弟姐妹</li>
                            <li data-value="3">子女</li>
                            <li data-value="4">同事</li>
                            <li data-value="5">同学</li>
                            <li data-value="6">朋友</li>
                        </ul>
                    </div> -->
                </li>
                <li><input type="text" placeholder="姓名" name="family2_name" id="family2_name"></li>
                <li><input type="text" placeholder="手机号" name="family2_phone" id="family2_phone"></li>
           </ul><div class="clear"></div>
         </section>
        <!--  <section class="personalList">     
           <ul>
                <li>＊第三联系人</li>
                <li style="margin-left:1rem;">
                   <span style="float:left;width:10rem;">直系亲属</span>
                      <div class="select-day secondContact"><span class="text"  id="family3_type" data-value="">请选择联系人</span>
                                <div class="bank_btn " id="family3_btn">
                                    <span class="btn-top"></span>
                                </div>
                                <ul class="daylist " id="family3_select">
                                    <li data-value="0">配偶</li>
                                    <li data-value="1">父母</li>
                                    <li data-value="2">兄弟姐妹</li>
                                    <li data-value="3">子女</li>
                                    <li data-value="4">同事</li>
                                    <li data-value="5">同学</li>
                                    <li data-value="6">朋友</li>
                                </ul>
                     </div>
                </li>
                <li><input type="text" placeholder="姓名" name="family3_name" id="family3_name"></li>
                <li><input type="text" placeholder="手机号" name="family3_phone" id="family3_phone"></li>
           </ul><div class="clear"></div>
        </section> -->
         <div class="writeInfo"><p class="error-info"></p></div>
          <div class="globalFooter1">
                    <p style="text-align:center;"><button  id="submitBtn2">下一步</button></p>
          </div>
       <div class="clear"></div>
   </div>
 
   <div id="bg"></div>
   <!--服务密码弹框start-->
      <section class="ays" id="ays1">
          <div class="ays_h5">
              <h5 style="color: #333;">服务密码</h5>
              <img src="images/input_clear.png" onclick="dismissAys1()" />
          </div>
         
          <p style="margin:0 2rem 0 2rem;line-height:3rem;text-align:center;color: #333;">请拨打您的运营商（如：移动10086，联通10010，电信10000）的人工客服来咨询或修改服务密码</p>
      </section>
      <!--服务密码弹框end-->
  <!--服务密码弹框start-->
      <section class="ays" id="ays2">
          <div class="ays_h5">
              <h5 style="color: #333;">网站密码</h5>
              <img src="images/input_clear.png" onclick="dismissAys2()" />
          </div>
         
          <p style="margin:0 2rem 0 2rem;line-height:3rem;text-align:center;color: #333;">网站密码是您登陆移动网上营业厅时的登陆密码，如您忘记密码，可到
                http://www.10086.cn中重置密码</p>
      </section>
      <!--服务密码弹框end--> 
      <!-- 动态密码 -->
       <section class="ays" id="ays3" style="display:none;">
			          <div class="ays_h5">
			              <h5 style="color: #333;">输入动态密码</h5>
			              <img src="images/input_clear.png" onclick="dismissAys3()" />
			          </div>
			          <div class="dynamic_password">
			             <p><input class="input form-control" type="text" id="dongtaimima" placeholder="输入手机动态密码"></p>
			             <p><div class="error-info" style="background:none;" id="yd-errorInfo">输入动态密码</div></p>
			             <p><button type="button" class="btn btn-danger btn-close" id="toDynamic" style="width:13rem;"><span>确认</span></button></p>
			          </div>
         
      </section>   
</body>
</html>