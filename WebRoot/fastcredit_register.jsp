<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URLDecoder"%>
<%@ include file="/config/config.jsp" %>
<%@ include file="/config/global.jsp" %>
<%@ include file="/config/show_share.jsp" %>
<%  
		String path = request.getContextPath();
		String utm_source = request.getParameter("utm_source");//渠道
		String referrer = request.getParameter("referrer");
		referrer = (referrer == null ? "" : referrer);
		referrer = URLDecoder.decode(referrer, "UTF-8");  
%>
    <!DOCTYPE html>
    <html style="font-size:62.5%;">
    <head>
       <meta charset="utf-8">
       <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
       <title>小瑞快贷注册</title>
       <link href="css/font-awesome.min.css" rel="stylesheet"/>
       <link href="css/ump_register.css" rel="stylesheet"/>
       <script src="js/ump_register.js" type="text/javascript"></script>
       <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.min.js"></script>
       <script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
       <script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
       <script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
      <script src="js/zhuge_ini.js" type="text/javascript"></script>
    <!--  <script  type="text/javascript" src="js/frame/vertical_prevent.js"> </script> -->
      <script>
		  /*标题 */
		    function showShare(){
		         IOSModel.changeWebTitle("瑞钱宝新手注册");
		    }
		  
		    $(function() {
		      var _referrer = getURLParam('referrer');
		      if (_referrer && _referrer != 'null') {
		        
		         $('#referrer').val("<%=referrer%>");
		      }
		
		      title = "瑞钱宝新手注册";
		      content = "瑞钱宝—大型国企参股，多种优质项目，让您轻松理财！";
		      icon = "<%=basePath %>/images/logo/newHand.png";
		      url  = "<%=basePath %>/ump_register.jsp?from=app&utm_source=<%=utm_source %>";
		         // getReferenceRank();
		      /*分享好友*/
		      weixinShare(title,content,icon,url,'<%=basePath%>');
		      
		      /*判断是安卓或者是IOS*/
		      var browser = {
		        versions : function() {
		          var u = navigator.userAgent, app = navigator.appVersion;
		          return { //移动终端浏览器版本信息
		            ios : !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
		            android : u.indexOf('Android') > -1
		                || u.indexOf('Linux') > -1, //android终端或uc浏览器
		            weixin : u.indexOf('MicroMessenger') > -1, //是否微信 （2015-01-22新增）
		          };
		        }(),
		        language : (navigator.browserLanguage || navigator.language).toLowerCase()
		      }
		      })
		      /**
		       * 从URL中获取参数
		       * @param {Object} name
		       */
		       function getURLParam(name) {
		        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
		        var r = window.location.search.substr(1).match(reg);
		        if(r != null) return unescape(r[2]);
		        return null;
		       }
		       
		       /*进入我的理财页面 */
		        function toProject() {
		          if (isAndroidOrIos()) {
		            IOSModel.toIosInvest();
		            toIosInvest();
		            appFunction('invest');
		          } else {
		            window.location.href = "<%=basePath%>/project.jsp";
		          }
		        }
		       
		       /*活动页面 */
		       /*安卓下载页面  */
	          function goAndroid(){
	             window.location.href = "http://o7yy4xew2.bkt.clouddn.com/ruiqianbao_ruiqianbao_v3.7.5_release.apk";
	          }
	          /*IOS下载活动页面 */
	          function goIos(){
	             window.location.href = "http://a.app.qq.com/o/simple.jsp?pkgname=com.dyxd.rqt&g_f=991653";
	          }
  </script>
	</head>
	<body class="toRight fastcredit">
    
      	<input type="hidden" id="utm_source" value="<%=utm_source %>">
      	<section class="activetyBannner">
        	<img src="images/fastcredit_banner.png"/>
      	</section>
      <div class="fastcredit_bg">	
      	<section class="registerBg toRight" style="padding:0.6rem 0 1rem 0;">
        	<div id="showMess" style="clear:both;color:#ff5555; text-align: center;">&nbsp;</div>
        	<div class="login">
	          	<input type="text"  id="m" placeholder="您的手机号码" onkeyup="inputKeyUp(this.value,this.id,1,'clear_phone')"/>
	          	<img class="input-clear" src="images/input_clear.png" id="clear_phone" onclick="clearInput('m',this.id)"/>
	        </div>
        	<div class="login">
          		<input data-role='none' id="p" style="width:70%;font-size:1.4rem;" name="p" onkeyup="inputKeyUp(this.value,this.id,2,'clear_psw')"
          		type="password" placeholder="请输入登录密码"/>
          		<img class="input-clear" src="images/input_clear.png" id="clear_psw" onclick="clearInput('p',this.id)"/>
        	</div>
        <!-- 	<div class="login">
          		<input type="text" style="width:100%;" id="referrer" name="referrer" placeholder="推荐手机号（可不填）">
        	</div> -->
        	<div class="login" style="border:none;background:none;">
          		<input data-role='none'  id="vc" name="vc" type="text" placeholder="图片验证码" style="float:left;width:54%;"/>
              	<span class="vcode">
              		<img id="imgObj" alt="换一张" title="点击图片换一张" src="<%=localPath%>/servlet/validateCodeServlet?'+new Date().getTime()" 
                	onclick="changeVCode()" />
            	</span>
            	<div class="clear"></div>
          	</div>
          	<div class="login">
            	<input type="text"  id="c" style="width:50%;" placeholder="手机验证码"  IME-MODE: disabled"
            	onkeyup="this.value=this.value.replace(/\D/g,'')">
            	<button class="btn-pin get_code" id="getc">获取验证码</button>
            	<div class="clear"></div>
          	</div>
          	<!-- <button class="btn-no-pin" onclick="showGetRadioCode()">没有收到验证码</button> -->
          	<!-- <div class="agreement">
          		<div class="squaredTwo bg" onclick="onBoxClicked()">
			      <input type="checkbox" id="agreeBox" value="None" name="check" checked>
			      <label for="squaredTwo"></label>
			    </div>
              	<span>我同意并接受</span>
              	<a onclick="toProxy()">《瑞钱宝服务协议》</a>
          	</div> -->
          	<p>
               	<button class="btn btn-next otherBtn" id="step" >立即注册</button>
          	</p>
          	<input type="hidden" id="local" name="localPath" value="<%=localPath%>"/>
          	<input type="hidden" id="channel" name="channel" value="<%=utm_source%>"/>
		</section>
  </div>  
        <button style="display: none" id="myModal" type="button"
        class="btn btn-danger mt20 ml20" data-toggle="modal"
        data-target=".bs-example-modal-lg">提示信息</button>
        <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog"
        aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal"
              aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
            <h4 class="modal-title" id="myModalLabel">提示信息</h4>
          </div>
          <div class="modal-body">
            <h4 class="text-success text-center" id="body_content_h4">注册去借款</h4>
            <!-- <p>投资金额：<span class="text-danger" id="money_invest_modal">1000</span>元</p> -->
          </div>
          <div class="modal-footer" style="display:none">
            <button type="button" onclick="gotoPage()"
            class="btn btn-danger btn-block">登录</button>
          </div>
          <div class="modal-footer" id="phone_code_div" style="display: none">
            <table style="width:100%">
              <tr>
                <td align="center" valign="middle" width="50%">
                  <button type="button" data-dismiss="modal" 
                  id="bt_invite" class="btn btn-danger">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;取消&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
                </td>
                <td align="center" valign="middle" width="50%"><button type="button" data-dismiss="modal"
                  onclick="getRadioCode()" id="bt_to_invest"
                  class="btn btn-danger">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;接收&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button></td>
                </tr>
              </table>
            </div>
          </div>
        </div>
      </div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
<script type="text/javascript">
$(function (){
	var utm_source=$("#utm_source").val();
	$(".toper").click(function (){
		var $this = $(this);
		if(utm_source =='2017' || utm_source =='2018' || utm_source =='2019'){
			if (browser.versions.android == true) {
				goAndroid();
		        if(navigator.userAgent.indexOf('MicroMessenger') > -1){
		        	showShareBox();
		        }
		      }
		      else if (browser.versions.ios == true) {
		    	  goIos()
		      } 
		      else{
		    	  goAndroid();
		      }
		}else{
			toProject();
		}		
	})
})
</script>
</body>
</html>
