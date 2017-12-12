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
       <title>瑞钱宝新手注册</title>
       <link href="css/font-awesome.min.css" rel="stylesheet"/>
       <link href="css/register.css" rel="stylesheet"/>
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
	<body class="toRight">
				<input type="hidden" value="<%=basePath%>"  id="basePath">
			  <input type="hidden" value="<%=localPath%>"  id="localPath">
      	<input type="hidden" id="utm_source" value="<%=utm_source %>">
      	<section class="activetyBannner">
        	<img src="images/activetyBannner.png"/>
      	</section>
      	<section class="registerBg toRight" style="padding:0.6rem 0 1.5rem 0;">
        	<div id="showMess" style="clear:both;color:#ff5555; text-align: center;">&nbsp;</div>
        	<div class="login">
	          	<input type="text"  id="m" placeholder="您的手机号码" onkeyup="inputKeyUp(this.value,this.id,1,'clear_phone')"/>
	          	<img class="input-clear" src="images/input_clear.png" id="clear_phone" onclick="clearInput('m',this.id)"/>
	        </div>
        	<div class="login">
          		<input data-role='none' id="p" name="p" onkeyup="inputKeyUp(this.value,this.id,2,'clear_psw')"
          		type="password" placeholder="请输入登录密码"/>
          		<img class="input-clear" src="images/input_clear.png" id="clear_psw" onclick="clearInput('p',this.id)"/>
        	</div>
        	<div class="login">
          		<input type="text" style="width:100%;" id="referrer" name="referrer" placeholder="推荐手机号（可不填）">
        	</div>
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
          	<div class="agreement">
          		<div class="squaredTwo bg" onclick="onBoxClicked()">
			      <input type="checkbox" id="agreeBox" value="None" name="check" checked>
			      <label for="squaredTwo"></label>
			    </div>
              	<span>我同意并接受</span>
              	<a onclick="toProxy()">《瑞钱宝服务协议》</a>
          	</div>
          	<p>
               	<button class="btn btn-next" id="step" ></button>
          	</p>
          	<input type="hidden" id="local" name="localPath" value="<%=localPath%>"/>
          	<input type="hidden" id="channel" name="channel" value="<%=utm_source%>"/>
		</section>
	    <img class="" src="images/activetyTitle1.png" alt="产品优势"/>
        <section class="productAdvantage">
        	<div class="regbg">
        		<div class="regbgRepeat clearfix">
        			<div class="fl toper">
        				<p>5天</p>
                <p><b>12</b>%<!-- +0.7% --></p>
                <p style="margin-bottom: 2.5rem;">预期年化收益</p>
        			</div>
        			<div class="fl toper">
        				<p>30天</p>
                <p><b>7</b>%<!-- +0.4% --></p>
                <p style="margin-bottom: 2.5rem;">预期年化收益</p>
        			</div>
        			<div class="fl toper">
        				<p>60天</p>
                <p><b>7</b>%+2%</p>
                <p style="margin-bottom: 2.5rem;">预期年化收益</p>
        			</div>
        			<div class="fl toper">
        				<p>90天</p>
                <p><b>8</b>%<!-- +0.5% --></p>
                <p style="margin-bottom: 2.5rem;">预期年化收益</p>
        			</div>
        			<div class="fl toper" style="border-top:1px dashed #fee4c3;">
                <p>180天</p>
                <p><b>9</b>%<!-- +0.7% --></p>
                <p style="margin-bottom: 2.5rem;">预期年化收益</p>
              </div>
              <div class="fl toper" style="border-top:1px dashed #fee4c3;">
                <p>360天</p>
                <p><b>11</b><!-- %+1% --></p>
                <p style="margin-bottom: 2.5rem;">预期年化收益</p>
              </div>
        		</div>
        </section>
        <img class="" src="images/activetyTitle2.png" alt="平台优势"/>
        <section class="productAdvantage">
        	<div class="regbg">
        		<div class="regbgRepeat clearfix">
        			<div class="ptys">
        				<h3>银行存管</h3>
        				<p>海口联合农商银行资金存管已上线</p>
        			</div>
        			<div class="ptys">
        				<h3>严格风控</h3>
        				<p>等保三级 电子签章 项目考察</p>
        			</div>
        			<div class="ptys">
        				<h3>企业价值观</h3>
        				<p>厚德诚信 凝聚创新 追求卓越</p>
        			</div>
        		</div>
        	</div>
        </section>
        <!-- <img class="" src="images/activetyTitle3.png" alt="活动规则"/>
        <section class="productAdvantage">
        	<div class="regbg">
        		<div class="regbgRepeat clearfix">
        			<p><span>1</span>活动时间：7月03日10：00-7月20日17：00</p>
        			<p><span>2</span>所获加息券自领取之日至7月20日23:59:59之前有效</p>
        			<p><span>3</span>现金奖励于项目满标后7个工作日内发至瑞钱宝账户余额，可提现</p>
        			<p><span>4</span>投资金额≥10000元享返现，返现和加息同享，与特约标加息不同享</p>
        			<p><span>5</span>如需帮助请联系瑞钱宝官方客服热线:400-919-8555（工作日9:00-18:00）</p>
        		</div>
        	</div>
        </section> -->
        <footer>
        	<div class="regtel">瑞钱宝客服热线：<a href="tel:400-919-8555">400-919-8555</a></div>
        	<p>瑞钱宝资产管理服务有限公司  版权所有</p>
        	<p><span>京ICP备14024431号</span><span>京ICP证160571号</span></p>
        	<p>市场有风险  投资需谨慎</p>
        </footer>
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
            <h4 class="text-success text-center" id="body_content_h4">注册成功!</h4>
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
 <script src="js/ump_register.js" type="text/javascript"></script>     
<script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script>
</body>
</html>
