<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/config/config.jsp" %>
<%@ include file="/config/global.jsp" %>
<%
String path = request.getContextPath();
String utm_source = request.getParameter("utm_source");//渠道
%>
    <!DOCTYPE html>
    <html style="font-size:62.5%;">
    <head>
       <meta charset="utf-8">
       <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
       <title>YY直播合作</title>
       <link href="css/font-awesome.min.css" rel="stylesheet"/>
       <link href="css/register.css" rel="stylesheet"/>
       <script src="js/yy_live_register.js" type="text/javascript"></script>
       <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.min.js"></script>
       <script src="${pageContext.request.contextPath}/js/jweixin-1.0.0.js" type="text/javascript"></script>
       <script src="${pageContext.request.contextPath}/js/frame/ios_js.js" type="text/javascript"></script>
       <script src="${pageContext.request.contextPath}/js/weixin_share.js" type="text/javascript"></script>
      <script src="js/zhuge_ini.js" type="text/javascript"></script>
    <!--  <script  type="text/javascript" src="js/frame/vertical_prevent.js"> </script> -->
      <script>
  /*标题 */
     function showShare(){
         IOSModel.changeWebTitle("YY直播合作");
       }
    $(function() {
      var _referrer = getURLParam('referrer');
      if (_referrer && _referrer != 'null') {
        
         $('#referrer').val(_referrer);
      }

      title = "YY直播合作";
      content = "瑞钱宝—大型国企参股，多种优质项目，让您轻松理财！";
      icon = "<%=basePath %>/images/logo/newHand.png";
      url  = "<%=basePath %>/ump_register.jsp?from=app&utm_source=<%=utm_source %>";
         // getReferenceRank();
        /*分享好友*/
          weixinShare(title,content,icon,url,'<%=basePath%>');
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
       
       function gotoActive(){
         window.location.href = "<%=basePath%>/new_hand.jsp";
       }
  </script>
    </head>
    <body>
      <header class="register_top">
        <img style="max-width:none;width:20rem;" src="images/globalLogo.png"/>
        <span onclick="gotoPage()">登录</span>
        <div class="clear"></div>
      </header>
      <section class="activetyBannner">
        <img onclick="gotoActive();" src="images/activetyBannner.png"/>
      </section>
      <section class="registerBg" style="padding:0.6rem 0 1rem 0;">
        <div id="showMess" style="clear:both;color:#ff5555; text-align: center;">&nbsp;</div>
        <div class="login" style="margin-top:2%;">
          <font class="fa fa-mobile-phone" style="margin-top:0.7rem;font-size:2.8rem;"></font>
          <input type="text" style="height:3rem;line-height:3rem; "  id="m" placeholder="您的手机号码" 
          onkeyup="inputKeyUp(this.value,this.id,1,'clear_phone')"/>
          <img class="input-clear" src="images/input_clear.png" id="clear_phone" onclick="clearInput('m',this.id)"/>
        </div>
        <div class="login">
          <font class="fa fa-lock" style="margin-top:0.9rem;font-size:2.4rem;"></font>
          <input data-role='none' style="height:3rem;line-height:3rem; " id="p" name="p"
          onkeyup="inputKeyUp(this.value,this.id,2,'clear_psw')"
          type="password" placeholder="请输入登录密码"/>
          <img class="input-clear" src="images/input_clear.png" id="clear_psw" onclick="clearInput('p',this.id)"/>
        </div>
        <div class="login">
          <input type="text" id="referrer" maxlength="10"  name="referrer"
          placeholder="推荐人">
        </div>
        <div class="login" style="border:none;">
          <input data-role='none'  id="vc" name="vc" type="text" placeholder="图片验证码"
           style="float:left;width:60%;border:1px solid #B3B2B3;border-radius:30px; "/>
              <span class="vcode" style="float:left;margin-left: 3%;width:30%;"><img id="imgObj" alt="换一张"
                title="点击图片换一张" src="<%=localPath%>/servlet/validateCodeServlet?'+new Date().getTime()" 
                onclick="changeVCode()" />
            </span>
            <div class="clear"></div>
          </div>
          <div class="login" style="border:none;">
            <input type="text"  id="c" style="width:50%;" placeholder="手机验证码"  IME-MODE: disabled"
            onkeyup="this.value=this.value.replace(/\D/g,'')">
            <button class="btn-pin get_code" id="getc">获取验证码</button>
            <div class="clear"></div>
          </div>
          <!-- <button class="btn-no-pin" onclick="showGetRadioCode()">没有收到验证码</button> -->
          <div class="agreement">
              <input type="checkbox" checked="checked" id="agreeBox" onclick="onBoxClicked()"/>
              <span>我同意并接受</span>
              <a onclick="toProxy()">《瑞钱宝服务协议》</a>
          </div>
          <p style="margin:6%  6%;text-align:center;">
               <button class="btn btn-lg btn-danger btn-block btn-red btn-next" id="step" >注册领红包</button>
          </p>
          <input type="hidden" id="local" name="localPath" value="<%=localPath%>"/>
          <input type="hidden" id="channel" name="channel" value="<%=utm_source%>"/>
        </section>
        <section class="registerBg" style="padding:0 0 2rem 0;">
            <p class="activetyTitle" style="text-align:center;"> <img style="max-width:none;width:20rem;" src="images/activetyTitle1.png"/></p>
            <div class="financeProject" onclick="toProject()">
                <p class="activetyTitle3">理财项目</p>
                <p class="financeProject1">6.5<font style="font-size:2rem;">%</font>~12<font style="font-size:2rem;">%</font><br/><span>预期年化收益</span></p>
                <p class="financeProject2"><span>预期年化收益不等于实际收益</span></p>
            </div>
        </section>
         <section class="registerBg">
            <p class="activetyTitle" style="text-align:center"> <img  style="max-width:none;width:15rem;" src="images/activetyTitle2.png"/></p>
                  <div class="war inner">
                        <ul class="appdownList">
                          <li class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <div class="backg1"><img  src="images/icon1.png"/></div>
                            <br/> <strong>国企参股</strong>
                            <p> 国企华融天泽旗下<br />综合金融服务平台
                            </p>
                          </li>
                          <li class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <div class="backg2"><img  src="images/icon2.png"/></div>
                            <br /> <strong>项目安全保障</strong>
                            <p>
                              专业的金融人才队伍精心挑选优质项目
                            </p>
                          </li>
                          </ul>
                        <ul class="appdownList">
                          <li class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <div class="backg3"><img  src="images/icon3.png"/></div>
                            <br /> <strong>千万备付金</strong>
                            <p>
                                                                                 瑞钱宝建立千万备付金逾期发生，备付金先行垫付
                            </p>
                          </li>
                          <li class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <div class="backg4"><img  src="images/icon4.png"/></div>
                            <br /> <strong>用户信息安全保障</strong>
                            <p>数据安全、交易安全、网络安全</p>
                          </li>
                        </ul> 
                    <div class="clear"></div>
                  </div>
  </section>
  <footer class="copyRights">
     <p><img style="max-width:none;width:7rem;" src="images/smallLogo.png"/></p>
     <p>&copy2015年版权所有</p>
     <p>京ICP备14024431号  京ICP证160571号</p>
     <p>联系我们 ：400-919-8555</p>
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
      <%@ include file="config/header.jsp" %>
      <script>
 //换一张图片验证码
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/frame/rqbaoappshare.js"></script> 
</body>
</html>