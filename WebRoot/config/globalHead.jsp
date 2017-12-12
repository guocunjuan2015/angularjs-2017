<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
HttpSession hs = request.getSession(); 
String user = ""; 
String userId = "";//用户userId
String userHex = "";//hex编码的用户名，分享出去用到，app转进来需要解码
user = (String) hs.getAttribute("loginUser");
String userAppId = request.getParameter("userId");
String from = request.getParameter("from");

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
//         userHex = Hex.encodeHexString(user.getBytes());//将用户Hex编码，用于分享
        
    } else {
        userHex = "";
    }
}
if (from == null || !("app".equals(from))) {
    from = "";
}
if (from != null && "app".equals(from)) {
    userId = userAppId;
} else if (hs != null) {
    userId = (String) hs.getAttribute("userId");
}
   
%>
<script>
$(function(){
  /*点击导航展开效果*/
  $("#myToggle").click(function(){
    $(".nav_toggle").toggle();
  })
  
  /*判断user是否为空 */
  if("<%=user%>" == "" || "<%=user%>" == null || "<%=user%>" == "null"){
    $(".logout").hide();
    $(".loginDivs").show();
    
  } 
})

/*点击退出*/
function logout() {
    $.ajax({
      type : "POST",
      url : "register/logout.do",
      data : {},
      success : function(response) {
        if (response.success) {
          window.location.href = "login.jsp";
        } else {
          errorMsg(response.msg);
        }
      },
      dataType : "json"
    });
  }

/*跳转页面*/
 function jumpPage(index) {
  switch (index) {
  case 0:
    window.location.href = '<%=basePath%>/login.jsp';/*登录*/
    break;
  case 1:
    window.location.href = '<%=basePath%>/ump_register.jsp';/*注册*/
    break;
  case 2:
    window.location.href = '<%=basePath%>/project.jsp';/*我的投资*/
    break;
  case 3:
    window.location.href = '<%=basePath%>/download_app.jsp';/*下载app*/
    break;
  case 4:
    window.location.href = '<%=basePath%>/signintroduce.jsp';/*公司介绍*/
    break;
  case 5:
    window.location.href = '<%=basePath%>/news.jsp';/*活动列表*/
    break;
  case 6:
    window.location.href = '<%=basePath%>/share_code.jsp';/*扫描二维码*/
    break;
  case 7:
      window.location.href = '<%=basePath%>/active/noviceGuide/noviceGuide.jsp';/*新手指引*/
      break;
  case 8:
      window.location.href = '<%=basePath%>/active/huarongTopic/huarongTopic.jsp';/*国企背景*/
      break;
  case 9:
      window.location.href = '<%=basePath%>/active/safe/safe.jsp';/*安全保障*/
      break;
  case 10:
      window.location.href = '<%=basePath%>/active/inviting/inviting.jsp';/*推荐有礼*/
      break;              
  case 11:
      window.location.href = '<%=basePath%>/personal_center.jsp';/*个人中心*/
      break;
  case 12:
      window.location.href = '<%=basePath%>/index.jsp';/*首页*/
      break;
  case 13:
      window.location.href = '<%=basePath%>/loan.jsp';/*我要借款 */
      break;  
  case 14:
      window.location.href = '<%=basePath%>/ump_real_register.jsp';/*实名 */
      break;
  case 15:
      window.location.href = '<%=basePath%>/ump_bind_card.jsp';/*绑卡 */
      break;
  }

} 

</script>
<style>
.index-header1{position:relative;height:6rem;background:#fff;border-bottom:2px solid #F5F4F4;}
.index-header1 p{padding-left:40px;padding-top:1.5rem;text-align:center;}
.index-header1 button{margin-top:1.8rem;width:14%;border:1px solid  transparent;background-color:transparent;}
.index-header1 button:hover,.index-header button:active{border:1px solid  transparent;background-color:transparent;}
.index-header1 .icon-bar{margin-top:4px;width:16px;height:2px;background:#4A4A4A;display:block;border-radius:1px;}
.nav_toggle{position:absolute;top:5rem;width:14rem;right:0;z-index:9999;}
.nav_toggle .showDropdown{
position:absolute;top:0.4rem;
width:16rem;
 -webkit-box-shadow: #666 0px 0px 6px;  
 -moz-box-shadow: #666 0px 0px 6px;  
box-shadow: #666 0px 0px 6px;  
background:rgba(255, 255,255, 1);

}
.nav_toggle .caret{
  position:absolute;  
  top:-1.2rem;
  right:2rem;
  border-bottom:1.6rem dashed #F5F4F4;border-top:none;
  border-right:1.6rem solid transparent;
  border-left:1.6rem solid transparent;
}
.index-header1  li{line-height:5rem;color:#4A4A4A;text-align:center;font-size:1.2rem;border-top:1px solid #F5F4F4;}
.index-header1  li:last-child{margin-right:0;} 
</style>
<header class="index-header1">
       <p class="col-lg-10 col-ms-10 col-sm-10 col-xs-10" style="padding-right:0;"><img style="max-width:none;width:20rem;" src="<%=basePath%>/images/globalLogo.png"/></p>
       <button type="button" id="myToggle" class="col-lg-2 col-ms-2 col-sm-2 col-xs-2" style="padding-right:14px;">
         <span class="icon-bar"></span>
         <span class="icon-bar"></span>
         <span class="icon-bar"></span>
       </button>
       <div class="nav_toggle"  style="display:none;">
           <span class="caret"></span>
           <div class="showDropdown">
               <ul>
                   <li onclick="jumpPage(12)">首页</li>
                   <li onclick="jumpPage(2)">我要投资</li>
                   <li onclick="jumpPage(11)">我的账户</li>
                  <!--  <li onclick="gotoPage(13)">我要借款</li> -->
                   <div class="loginDivs" style="display:none;">
                       <li onclick="jumpPage(0)">登录</li>
                       <li onclick="jumpPage(1)">注册</li>
                   </div>
                    <div class="logout">
                       <li onclick="logout()" style="color:#ff5555;">安全退出</li>
                   </div>
                  
               </ul>
              </div>
           <div class="clear"></div>
       </div>
   </header>

 
